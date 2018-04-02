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
                {$_modx->RunSnippet('!citySelector', [
                    'phoneTpl' => 'header.phone',
                    'cityTpl' => 'header.city',
                ])}
                {$_modx->getPlaceholder('cityselector.phone')}
                {$_modx->getPlaceholder('cityselector.cities')}
            </div>
        </div>
        <div class="float-right">
            {$_modx->runSnippet('!msFavorites.initialize', [])}
            <div class="toolbox"><a href="{101 | url}" class="btn-icon icon-heart-o" ></a><div class="toolbox-counter msfavorites-total" data-data-list="default">0</div></div>
            {$_modx->RunSnippet('!msMiniCart', ['tpl' => 'miniCart'])}
            <!--<div class="toolbox ml-2"><a href="" class="btn-icon icon-cart" ></a><div class="toolbox-counter ms2_total_numrows">2</div><span class="toolbox-label ml-1 ms2_total_cost">12&nbsp;798</span><span class="toolbox-label icon-rub"></span></div>-->
        </div>
        <div class="logo"><h1><a href="" class="no_underline"><img src="/assets/i/logo-w.png"></a></h1></div>
    </div>
    <!--<div class="container-fluid">-->
    <!--<div class="d-inline-block menu-btn-push mr-5"></div>-->
    <!--<div class="d-inline-block md-form">-->
    <!--<i class="fa fa-envelope prefix"></i>-->
    <!--<input type="text" id="form_search" class="form-control btn-right" placeholder="Поиск по сайту"><button class="btn  icon-search"></button>-->
    <!--</div>-->
    <!--</div>-->
    <div class="container-fluid no_mobile mt-4">


        <div class="row">
            <div class="col-lg-3 col-12 mt-4">
                {$_modx->runSnippet('!pdoResources@PropertySet', [
                'parents' => 43,
                'limit' => 3,
                'includeContent' => 1,
                'sortby' => 'menuindex',
                'sortdir' => 'asc',
                'tvPrefix' => '',
                'tpl' => '@INLINE <a href="#servicedesk/{$link_attributes}" class="btn-icon btn-icon-dvmk {if $link_attributes == "callback"}icon-phone{elseif $link_attributes == "measurement"}icon-measure{elseif $link_attributes == "service"}icon-tools{/if} smooth-scroll servicedesk-link"></a><a href="#servicedesk/{$link_attributes}" class="smooth-scroll servicedesk-link">{$pagetitle}</a><br>',
                ])}
                <!-- <a href="#servicedesk" class="btn-icon btn-icon-dvmk icon-phone smooth-scroll servicedesk-link"></a><a href="#servicedesk" class="smooth-scroll servicedesk-link">Заказать звонок</a><br>
                <a href="#servicedesk" class="btn-icon btn-icon-dvmk icon-measure smooth-scroll servicedesk-link"></a><a href="#servicedesk" class="smooth-scroll servicedesk-link">Вызвать замерщика</a><br>
                <a href="#servicedesk" class="btn-icon btn-icon-dvmk icon-tools smooth-scroll servicedesk-link"></a><a href="#servicedesk" class="smooth-scroll servicedesk-link">Вызвать сервисную службу</a><br> -->
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
            <!--
            <div class="col-lg-2 col-6 mt-4">
                <a href="" class="h5 no_underline--hover">Каталог</a><br>
                <a href="">Входные двери</a><br>
                <a href="">Межкомнатные двери</a><br>
                <a href="">Dariano</a><br>
            </div>
            <div class="col-lg-2 col-6 mt-4">
                <div class="h5">Покупателю</div>
                <a href="">Услуги и сервис</a><br>
                <a href="">Акции и скидки</a><br>
                <a href="">Ваше мнение</a><br>
            </div>
            <div class="col-lg-2 col-6 mt-4">
                <div class="h5">Про двери</div>
                <a href="">Советы ДВЕРИ МАРКЕТ</a><br>
                <a href="">Двери в интерьере</a><br>
                <a href="">Фабрика Dariano</a><br>
            </div>
            <div class="col-lg-2 col-6 mt-4">
                <a href="" class="h5 no_underline--hover">О компании</a><br>
                <a href="">Контакты</a><br>
                <a href="">Схема проезда</a><br>
                <a href="">Вакансии</a><br>
            </div>
            -->
        </div>


    </div>
</div>

<header class="header">
    <div class="container-fluid">
        <div class="float-left">
            <div class="d-inline-block menu-btn-push mr-2"></div>
            <!--<div class="d-inline-block ml-2">-->
            <!--<ul class="navbar-nav">-->
            <!--<li class="nav-item dropdown">-->
            <!--<a class="nav-link dropdown-toggle" href="http://example.com" id="select_city" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Кемерово</a>-->
            <!--<div class="dropdown-menu" aria-labelledby="select_city">-->
            <!--<a class="dropdown-item" href="#">Новосибирск</a>-->
            <!--<a class="dropdown-item" href="#">Новокузнецк</a>-->
            <!--</div>-->
            <!--</li>-->
            <!--</ul>-->
            <!--</div>-->
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
                <div class="toolbox"><a href="{101 | url}" class="btn-icon icon-heart-o" ></a><div class="toolbox-counter msfavorites-total" data-data-list="default">0</div></div>
                {$_modx->RunSnippet('!msMiniCart', ['tpl' => 'miniCart'])}
            </div>
        </div>
        <div class="logo"><h1><a href="{$_modx->config.site_url}" class="no_underline"><img src="{$_modx->config.assets_url}i/logo.png"></a></h1></div>
    </div>
</header>