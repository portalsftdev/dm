<div class="menu-btn-container">
    <button class="menu-btn cmn-toggle-switch cmn-toggle-switch__htx" data-caption="Меню" data-caption-active="Закрыть">
        <span></span><i>Меню</i>
    </button>
</div>
<div class="menu-container bg-inverse text-white" id="mainMenu">

    <div class="container-fluid hidden-md-down p-0">
        <div class="float-left">
            <div class="d-inline-block menu-btn-push mr-2"></div>
            <div class="d-inline-block ml-2 cities">
                {$_modx->RunSnippet('@FILE snippets/dmCities.php', [
                    'phoneTpl' => 'header.phone',
                    'cityTpl' => 'header.city',
                ])}
                {$_modx->getPlaceholder('cityselector.phone')}
                {$_modx->getPlaceholder('cityselector.cities')}
            </div>
        </div>
        <div class="float-right">
            {$_modx->runSnippet('!msFavorites.initialize', [])}
            <div class="toolbox"><a href="{$_modx->config.'resources.wishlist' | url}" class="btn-icon icon-heart-o" ></a><div class="toolbox-counter msfavorites-total" data-data-list="default">0</div></div>
            {$_modx->RunSnippet('!msMiniCart', ['tpl' => '@FILE chunks/miniCart.tpl'])}
        </div>
        <div class="logo"><a href="" class="no_underline"><img class="align-baseline" src="/assets/i/logo-w.png" alt="{$_modx->config.site_name | escape}" /></a></div>
    </div>
    <div class="container-fluid no_mobile mt-4">
        <div class="row">
            <div class="col-lg-3 col-12 mt-4">
                {$_modx->runSnippet('!pdoResources@PropertySet', [
                'parents' => $_modx->config.'resources.servicedesk',
                'limit' => 3,
                'includeContent' => 1,
                'sortby' => 'menuindex',
                'sortdir' => 'asc',
                'tvPrefix' => '',
                'tpl' => '@INLINE <a href="#servicedesk/{$link_attributes}" class="btn-icon btn-icon-dvmk {if $link_attributes == "callback"}icon-phone{elseif $link_attributes == "measurement"}icon-measure{elseif $link_attributes == "service"}icon-tools{/if} smooth-scroll servicedesk-link"></a><a href="#servicedesk/{$link_attributes}" class="smooth-scroll servicedesk-link">{$pagetitle}</a><br>',
                ])}
            </div>

            {$_modx->runSnippet('!pdoMenu@PropertySet', [
            'parents' => 1,
            'level' => 2,
            'tpl' => '@INLINE <a href="{$_pls["link"]}">{$_pls["menutitle"]}</a><br>',
            'firstClass' => '',
            'lastClass' => '',
            'hereClass' => 'active',
            'tplOuter' => '@INLINE {$_pls["wrapper"]}',
            'tplInner' => '@INLINE {$_pls["wrapper"]}',
            'tplParentRow' => '@INLINE <div class="col-lg-2 col-6 mt-4"><a href="{$_pls["link"]}" class="h5 no_underline--hover">{$_pls["menutitle"]}</a><br>{$_pls["wrapper"]}</div>',
            'countChildren' => 0,
            ])}
        </div>
    </div>
</div>

<header class="header">
    <div class="container-fluid">
        <div class="float-left">
            <div class="d-inline-block menu-btn-push mr-2"></div>
            <div class="d-inline-block ml-2 cities">
                {$_modx->getPlaceholder('cityselector.phone')}
                {$_modx->getPlaceholder('cityselector.cities')}
            </div>
        </div>
        <div class="float-right relative">
            {$_modx->getChunk('@FILE chunks/html.search.tpl', ['faded' => 1, 'absolute' => 1])}
            <div class="toolbox w-rem-3 mr-3"></div>
            <div class="toolbox">
                {$_modx->runSnippet('!msFavorites.initialize', [])}
                <div class="toolbox"><a href="{$_modx->config.'resources.wishlist' | url}" class="btn-icon icon-heart-o" ></a><div class="toolbox-counter msfavorites-total" data-data-list="default">0</div></div>
                {$_modx->RunSnippet('!msMiniCart', ['tpl' => '@FILE chunks/miniCart.tpl'])}
            </div>
        </div>
        <div class="logo"><a href="{$_modx->config.site_url}" class="no_underline"><img class="align-baseline" src="{$_modx->config.assets_url}i/logo.png" alt="{$_modx->config.site_name | escape}" /></a></div>
    </div>
</header>
