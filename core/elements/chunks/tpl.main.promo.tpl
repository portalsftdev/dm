<div class="promo-container {$alias}">
    <div class="promo-form hover-effect-control rtl">
        <div class="container-fluid ltr msearch2" id="mse2_mfilter">
            <div class="row">
                <div class="col-12">
                    <h3 class="card-title mb-0">{$introtext}</h3>
                    <!-- 6 => dvmk|primary, 7 => danger|red, 8 => dariano|green|success -->
                    <p class="text-{if $content == 6}primary{elseif $content == 7}primary{elseif $content == 8}primary{/if}">{$description}</p>
                </div>
            </div>
            {if $content==6}
                <form method="GET" action="{$content | url}" class="doorSelectionForm">
                {$_modx->RunSnippet('!mFilter2', [
                    'parents' => $content,
                    'element' => 'msProducts',
                    'class' => 'msProduct',
                    'toSeparatePlaceholders' => 'mFilter2.',
                    'tpl' => '@FILE chunks/tpl.products.row.tpl',
                    'tplOuter' => '@FILE chunks/tpl.productList.tpl',
                    'limit' => 20,
                    'filters' => '
                        msoc|steel_door_color~value~pattern,
                        msoc|shield_color~value~pattern,
                        msvendor|name:vendor,
                        msoption|metal_thickness:metal_thickness,
                    ',
                    'tplFilter.outer.msoc|steel_door_color' => '@FILE chunks/tpl.filter.outer.msoption.msColor.tpl',
                    'tplFilter.row.msoc|steel_door_color' => '@FILE chunks/tpl.filter.row.msoption.msColor.tpl',
                    'tplFilter.outer.msoc|shield_color' => '@FILE chunks/tpl.filter.outer.msoption.msColor.tpl',
                    'tplFilter.row.msoc|shield_color' => '@FILE chunks/tpl.filter.row.msoption.msColor.tpl',
                    'tplFilter.outer.msvendor|name' => '@FILE chunks/tpl.filter.outer.msvendor.name.tpl',
                    'tplFilter.row.msvendor|name' => '@FILE chunks/tpl.filter.row.vhod_msvendor.name.tpl',
                    'tplFilter.outer.msoption|metal_thickness' => '@FILE chunks/tpl.filter.outer.msoption.cover.tpl',
                    'tplFilter.row.msoption|metal_thickness' => '@FILE chunks/tpl.filter.row.msoption.cover.tpl',
                ])}
                {$_modx->getChunk('@FILE chunks/html.promo.form.vhod.tpl')}
            {elseif $content==7}
                <form method="GET" action="{$content | url}" class="doorSelectionForm">
                {$_modx->RunSnippet('!mFilter2', [
                    'parents' => $content,
                    'element' => 'msProducts',
                    'class' => 'msProduct',
                    'toSeparatePlaceholders' => 'mFilter2.',
                    'tpl' => '@FILE chunks/tpl.products.row.tpl',
                    'tplOuter' => '@FILE chunks/tpl.productList.tpl',
                    'limit' => 20,
                    'filters' => '
                        msoc|mscolor~value~pattern,
                        msvendor|name:vendor,
                        msoption|cover:cover,
                        msoption|width:width,
                        msoption|doorType:doorType,
                        msoc|glass~value~pattern,
                    ',
                    'tplFilter.outer.msoc|mscolor' => '@FILE chunks/tpl.filter.outer.msoption.msColor.tpl',
                    'tplFilter.row.msoc|mscolor' => '@FILE chunks/tpl.filter.row.msoption.msColor.tpl',
                    'tplFilter.outer.msvendor|name' => '@FILE chunks/tpl.filter.outer.msvendor.name.tpl',
                    'tplFilter.row.msvendor|name' => '@FILE chunks/tpl.filter.row.msvendor.name.tpl',
                    'tplFilter.outer.msoption|cover' => '@FILE chunks/tpl.filter.outer.msoption.cover.tpl',
                    'tplFilter.row.msoption|cover' => '@FILE chunks/tpl.filter.row.msoption.cover.tpl',
                    'tplFilter.outer.msoption|width' => '@FILE chunks/tpl.filter.outer.msoption.width.tpl',
                    'tplFilter.row.msoption|width' => '@FILE chunks/tpl.filter.row.msoption.width.tpl',
                    'tplFilter.outer.msoption|doorType' => '@FILE chunks/tpl.filter.outer.msoption.doorType.tpl',
                    'tplFilter.row.msoption|doorType' => '@FILE chunks/tpl.filter.row.msoption.doorType.tpl',
                    'tplFilter.outer.msoc|glass' => '@FILE chunks/tpl.filter.outer.msoption.glass.tpl',
                    'tplFilter.row.msoc|glass' => '@FILE chunks/tpl.filter.row.msoption.glass.tpl',
                ])}
                {$_modx->getChunk('@FILE chunks/html.promo.form.room.tpl')}
            {elseif $content==8}
                <form method="GET" action="{$content | url}" class="doorSelectionForm">
                {$_modx->RunSnippet('!mFilter2', [
                    'parents' => $content,
                    'element' => 'msProducts',
                    'class' => 'msProduct',
                    'toSeparatePlaceholders' => 'mFilter2.',
                    'tpl' => '@FILE chunks/tpl.products.row.tpl',
                    'tplOuter' => '@FILE chunks/tpl.productList.tpl',
                    'limit' => 20,
                    'filters' => '
                        msoc|mscolor~value~pattern,
                        msvendor|name:vendor,
                        msoption|furniture_type:furniture_type,
                    ',
                    'tplFilter.outer.msoc|mscolor' => '@FILE chunks/tpl.filter.outer.msoption.msColor.tpl',
                    'tplFilter.row.msoc|mscolor' => '@FILE chunks/tpl.filter.row.msoption.furniture_msColor.tpl',
                    'tplFilter.outer.msvendor|name' => '@FILE chunks/tpl.filter.outer.msvendor.name.tpl',
                    'tplFilter.row.msvendor|name' => '@FILE chunks/tpl.filter.row.furniture_msvendor.name.tpl',
                    'tplFilter.outer.msoption|furniture_type' => '@FILE chunks/tpl.filter.outer.msoption.cover.tpl',
                    'tplFilter.row.msoption|furniture_type' => '@FILE chunks/tpl.filter.row.msoption.cover.tpl',
                ])}
                {$_modx->getChunk('@FILE chunks/html.promo.form.furniture.tpl')}
            {/if}
                <div class="row mt-3">
                    <div class="col-12" style="padding-top:1.5rem;">
                        <!-- <h5 class="card-title">Мы нашли для вас <strong id="mse2_total">{$_modx->getPlaceholder('mFilter2.total')}</strong> дверь</h5> -->
                        <button type="submit" class="btn btn-{if $content == 6}dvmk{elseif $content == 7}dvmk{elseif $content == 8}dvmk{/if} hover-effect hover-effect--apollo waves-effect waves-light">Перейти в каталог</button>
                        <button type="button" class="btn btn-secondary waves-effect waves-light promo-switch" data-promo=".{$alias}">Закрыть</button>
                    </div>
                </div>
            </form>
        </div>


    </div>
    <div class="promo-door">
        <a href="" style="background-image: url({$content | pdoField : 'promo_door'})" class="promo-switch" data-promo=".{$alias}"></a>
    </div>
    <div class="promo-block hover-effect-control">
        <div class="promo-mask promo-mask--bg" style="background-image: url({$content | pdoField : 'promo_bg'})"></div>
        <div class="promo-mask promo-mask--white"></div>
        <div class="promo-mask promo-mask--{if $content == 6}dvmk{elseif $content == 7}dvmk{elseif $content == 8}dvmk{/if}"></div>
        <div class="promo-mask promo-mask--black"></div>
        <div class="promo-header"><!-- {$link_attributes?:'dvmk'} -->
            <a href="{$id | url}" class="h1 promo-title promo-title--dvmk">{$longtitle?:$pagetitle}</a> <!-- no_underline--hover -->
        </div>
        <div class="promo-text">
            <div class="h-rem-7 clearfix">
                <div class="promo-labels">
                    <div class="promo-label promo-label--{if $content == 6}primary{elseif $content == 7}primary{elseif $content == 8}primary{/if}">{$_modx->getPlaceholder('mFilter2.total')} в наличии</div>
                </div>
            </div>
            <div class="lead h-rem-12">
                <p>{$content | pdoField : 'introtext'}</p>
            </div>
            <div>
                {*<button type="button" class="btn btn-{if $content == 6}dvmk{elseif $content == 7}dvmk{elseif $content == 8}dvmk{/if} hover-effect hover-effect--apollo waves-effect waves-light promo-switch" data-promo=".{$alias}">Подобрать {if $content == 8}фурнитуру{else}дверь{/if}</button>*}
                <a href="{$content | url}" class="btn btn-{if $content == 6}dvmk{elseif $content == 7}dvmk{elseif $content == 8}dvmk{/if} hover-effect hover-effect--apollo waves-effect waves-light">Подобрать {if $content == 8}фурнитуру{else}дверь{/if}</a>
            </div>
        </div>
    </div>
</div>
