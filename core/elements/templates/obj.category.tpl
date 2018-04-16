{extends 'template:base'}
{block 'content'}
        <section>
            <div class="container-fluid card-overlay text-white" style="background-image: url({$_modx->resource.bg ?: '/assets/i/bg-catalog-room.jpg'})">
                <div class="row">
                    <div class="col-md-6 col-12 card-img-overlay gr-black-r"></div>
                    <div class="col-md-6 col-12 px-5 py-4">
                        <h1 class="promo-title h-rem-3">{$_modx->resource.pagetitle}</h1>
                    </div>
                    <div class="col-md-6 col-12 px-5 py-4">
                        <div class="d-inline-block float-md-right">
                            <div class="btn-group btn-group-sm" role="group">
                                {$_modx->runSnippet('!pdoResources', [
                                'parents' => $_modx->config.'resources.promo',
                                'limit' => 3,
                                'includeContent' => 1,
                                'where' => ['content:!=' => $_modx->resource.id],
                                'sortby' => 'id',
                                'sortdir' => 'asc',
                                'tpl' => '@INLINE <a type="button" href="{$_modx->makeUrl($content)}" class="btn btn-dvmk">{$pagetitle}</a>',
                                ])}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        {if $_modx->config.'resources.catalog' == $_modx->resource.id}
        {$_modx->RunSnippet('!mFilter2', [
            'parents' => $_modx->resource.id,
            'element' => 'msProducts',
            'class' => 'msProduct',
            'loadModels' => 'ms2gallery',
            'leftJoin' => '{
                "card0": {"class":"msProductFile","alias":"card0", "on": "card0.product_id = msProduct.id AND card0.path LIKE \'%/card/%\' AND card0.rank=0"}
                ,"card1": {"class":"msProductFile","alias":"card1", "on": "card1.product_id = msProduct.id AND card1.path LIKE \'%/card/%\' AND card1.rank=1"}
            }',
            'select' => '{
                "msProduct":"*"
                ,"card0":"card0.url as card0"
                ,"card1":"card1.url as card1"
        	}',
            'toSeparatePlaceholders' => 'mFilter2.',
            'tpl' => '@FILE chunks/tpl.products.row.tpl',
            'tplOuter' => '@FILE chunks/tpl.productList.tpl',
            'limit' => 20,
            'values_delimeter' => ';',
            'paginator' => 'pdoPage@pageNavVar=`page.nav`',
            'tplPageWrapper' => '@INLINE <ul class="pagination text-center">{$first}{$prev}{$pages}{$next}{$last}</ul></nav>',
            'tplPage' => '@INLINE <li class="page-item"><a class="page-link waves-effect waves-effect" href="{$href}">{$pageNo}</a></li>',
            'tplPageActive' => '@INLINE <li class="page-item active"><a class="page-link waves-effect waves-effect" href="{$href}">{$pageNo}</a></li>',
            'tplPagePrev' => '@INLINE <li class="page-item"><a class="page-link waves-effect waves-effect" aria-label="Previous" href="{$href}"><span aria-hidden="true">←</span><span class="sr-only">Предыдущая</span></a></li>',
            'tplPageNext' => '@INLINE <li class="page-item"><a class="page-link waves-effect waves-effect" aria-label="Next" href="{$href}"><span aria-hidden="true">→</span><span class="sr-only">Следующая</span></a></li>',
            'tplPageFirst' => '@INLINE',
            'tplPageLast' => '@INLINE',
            'tplPagePrevEmpty' => '@INLINE',
            'tplPageNextEmpty' => '@INLINE',
            'tplPageFirstEmpty' => '@INLINE',
            'tplPageLastEmpty' => '@INLINE',
        ])}
        {elseif $_modx->config.'resources.steel_doors' == $_modx->resource.id}
        {$_modx->RunSnippet('!mFilter2', [
            'parents' => $_modx->resource.id,
            'element' => 'msProducts',
            'class' => 'msProduct',
            'toSeparatePlaceholders' => 'mFilter2.',
            'tpl' => '@FILE chunks/tpl.products.row.tpl',
        	'loadModels' => 'ms2gallery',
        	'leftJoin' => '{
        		"card0": {"class":"msProductFile","alias":"card0", "on": "card0.product_id = msProduct.id AND card0.path LIKE \'%/card/%\' AND card0.rank=0"}
        		,"card1": {"class":"msProductFile","alias":"card1", "on": "card1.product_id = msProduct.id AND card1.path LIKE \'%/card/%\' AND card1.rank=1"}
        	}',
        	'select' => '{
        		"msProduct":"*"
        		,"card0":"card0.url as card0"
        		,"card1":"card1.url as card1"
        	}',
            'tplOuter' => '@FILE chunks/tpl.productList.tpl',
            'limit' => 20,
            'filters' => '
                msoc|steel_door_color~value~pattern,
                msoc|shield_color~value~pattern,
                msvendor|name:vendor,
                msoption|metal_thickness:metal_thickness,
                msoption|width:width,
                msoption|spontaneity:spontaneity,
                ms|favorite:favorite,
            ',
            'values_delimeter' => ';',
            'paginator' => 'pdoPage@pageNavVar=`page.nav`',
            'tplFilter.outer.msoc|steel_door_color' => '@FILE chunks/tpl.filter.outer.msoption.msColor.tpl',
            'tplFilter.row.msoc|steel_door_color' => '@FILE chunks/tpl.filter.row.msoption.msColor.tpl',
            'tplFilter.outer.msoc|shield_color' => '@FILE chunks/tpl.filter.outer.msoption.msColor.tpl',
            'tplFilter.row.msoc|shield_color' => '@FILE chunks/tpl.filter.row.msoption.msColor.tpl',
            'tplFilter.outer.msvendor|name' => '@FILE chunks/tpl.filter.outer.msvendor.name.tpl',
            'tplFilter.row.msvendor|name' => '@FILE chunks/tpl.filter.row.msvendor.name.tpl',
            'tplFilter.outer.msoption|metal_thickness' => '@FILE chunks/tpl.filter.outer.msoption.cover.tpl',
            'tplFilter.row.msoption|metal_thickness' => '@FILE chunks/tpl.filter.row.msoption.cover.tpl',
            'tplFilter.outer.msoption|width' => '@FILE chunks/tpl.filter.outer.msoption.width.tpl',
            'tplFilter.row.msoption|width' => '@FILE chunks/tpl.filter.row.msoption.width.tpl',
            'tplFilter.outer.msoption|spontaneity' => '@FILE chunks/tpl.filter.outer.msoption.width.tpl',
            'tplFilter.row.msoption|spontaneity' => '@FILE chunks/tpl.filter.row.msoption.width.tpl',
            'tplPageWrapper' => '@INLINE <ul class="pagination text-center">{$first}{$prev}{$pages}{$next}{$last}</ul></nav>',
            'tplPage' => '@INLINE <li class="page-item"><a class="page-link waves-effect waves-effect" href="{$href}">{$pageNo}</a></li>',
            'tplPageActive' => '@INLINE <li class="page-item active"><a class="page-link waves-effect waves-effect" href="{$href}">{$pageNo}</a></li>',
            'tplPagePrev' => '@INLINE <li class="page-item"><a class="page-link waves-effect waves-effect" aria-label="Previous" href="{$href}"><span aria-hidden="true">←</span><span class="sr-only">Предыдущая</span></a></li>',
            'tplPageNext' => '@INLINE <li class="page-item"><a class="page-link waves-effect waves-effect" aria-label="Next" href="{$href}"><span aria-hidden="true">→</span><span class="sr-only">Следующая</span></a></li>',
            'tplPageFirst' => '@INLINE',
            'tplPageLast' => '@INLINE',
            'tplPagePrevEmpty' => '@INLINE',
            'tplPageNextEmpty' => '@INLINE',
            'tplPageFirstEmpty' => '@INLINE',
            'tplPageLastEmpty' => '@INLINE',
        ])}
        {elseif $_modx->config.'resources.room_doors' == $_modx->resource.id}
        {$_modx->RunSnippet('!mFilter2', [
            'parents' => $_modx->resource.id,
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
                ms|favorite:favorite,
            ',
            'values_delimeter' => ';',
            'leftJoin' => '{
                "mscolor": {
                    "class": "msocColor",
                    "on": "mscolor.key = \'mscolor\' and mscolor.rid = msProduct.id"
                }
            }',
            'paginator' => 'pdoPage@pageNavVar=`page.nav`',
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
            'tplPageWrapper' => '@INLINE <ul class="pagination text-center">{$first}{$prev}{$pages}{$next}{$last}</ul></nav>',
            'tplPage' => '@INLINE <li class="page-item"><a class="page-link waves-effect waves-effect" href="{$href}">{$pageNo}</a></li>',
            'tplPageActive' => '@INLINE <li class="page-item active"><a class="page-link waves-effect waves-effect" href="{$href}">{$pageNo}</a></li>',
            'tplPagePrev' => '@INLINE <li class="page-item"><a class="page-link waves-effect waves-effect" aria-label="Previous" href="{$href}"><span aria-hidden="true">←</span><span class="sr-only">Предыдущая</span></a></li>',
            'tplPageNext' => '@INLINE <li class="page-item"><a class="page-link waves-effect waves-effect" aria-label="Next" href="{$href}"><span aria-hidden="true">→</span><span class="sr-only">Следующая</span></a></li>',
            'tplPageFirst' => '@INLINE',
            'tplPageLast' => '@INLINE',
            'tplPagePrevEmpty' => '@INLINE',
            'tplPageNextEmpty' => '@INLINE',
            'tplPageFirstEmpty' => '@INLINE',
            'tplPageLastEmpty' => '@INLINE',
        ])}
        {elseif $_modx->config.'resources.furniture' == $_modx->resource.id}
        {$_modx->RunSnippet('!mFilter2', [
            'parents' => $_modx->resource.id,
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
                ms|favorite:favorite,
            ',
            'values_delimeter' => ';',
            'paginator' => 'pdoPage@pageNavVar=`page.nav`',
            'tplFilter.outer.msoc|mscolor' => '@FILE chunks/tpl.filter.outer.msoption.msColor.tpl',
            'tplFilter.row.msoc|mscolor' => '@FILE chunks/tpl.filter.row.msoption.msColor.tpl',
            'tplFilter.outer.msvendor|name' => '@FILE chunks/tpl.filter.outer.msvendor.name.tpl',
            'tplFilter.row.msvendor|name' => '@FILE chunks/tpl.filter.row.furniture_msvendor.name.tpl',
            'tplFilter.outer.msoption|furniture_type' => '@FILE chunks/tpl.filter.outer.msoption.cover.tpl',
            'tplFilter.row.msoption|furniture_type' => '@FILE chunks/tpl.filter.row.msoption.cover.tpl',
            'tplPageWrapper' => '@INLINE <ul class="pagination text-center">{$first}{$prev}{$pages}{$next}{$last}</ul></nav>',
            'tplPage' => '@INLINE <li class="page-item"><a class="page-link waves-effect waves-effect" href="{$href}">{$pageNo}</a></li>',
            'tplPageActive' => '@INLINE <li class="page-item active"><a class="page-link waves-effect waves-effect" href="{$href}">{$pageNo}</a></li>',
            'tplPagePrev' => '@INLINE <!--Arrow left--> <li class="page-item"><a class="page-link waves-effect waves-effect" aria-label="Previous" href="{$href}"><span aria-hidden="true">←</span><span class="sr-only">Предыдущая</span></a></li>',
            'tplPageNext' => '@INLINE <!--Arrow right--> <li class="page-item"><a class="page-link waves-effect waves-effect" aria-label="Next" href="{$href}"><span aria-hidden="true">→</span><span class="sr-only">Следующая</span></a></li>',
            'tplPageFirst' => '@INLINE',
            'tplPageLast' => '@INLINE',
            'tplPagePrevEmpty' => '@INLINE',
            'tplPageNextEmpty' => '@INLINE',
            'tplPageFirstEmpty' => '@INLINE',
            'tplPageLastEmpty' => '@INLINE',
        ])}
        {/if}
        {$_modx->getChunk('@FILE chunks/tpl.productList.tpl')}

        <section>
            <div class="container-fluid">
                <div class="row mt-3">
                    <div class="col-lg-6 col-md-12 px-0 pr-lg-3 wow fadeIn" data-wow-delay="0.4s" style="visibility: visible; animation-delay: 0.4s; animation-name: fadeIn;">
                        {$_modx->getChunk('@FILE chunks/card.marketing.tpl')}
                    </div>
                    {$_modx->RunSnippet('!msProducts', [
                        'tpl' => 'product.discount.item',
                        'parents' => 0,
                        'where' => '{"Data.favorite": "1"}',
                        'sortby' => 'RAND()',
                        'limit' => 1,
                    ])}
                </div>
            </div>
        </section>
    {$_modx->getChunk('@FILE chunks/sect.360.tpl')}
{/block}
