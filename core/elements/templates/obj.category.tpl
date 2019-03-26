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
                "card0": {"class":"msProductFile","alias":"card0", "on": "card0.product_id = msProduct.id AND card0.path LIKE \'%/card/%\' AND card0.rank=0 AND card0.active = 1"}
                ,"card1": {"class":"msProductFile","alias":"card1", "on": "card1.product_id = msProduct.id AND card1.path LIKE \'%/card/%\' AND card1.rank=1 AND card1.active = 1"}
            }',
            'select' => '{
                "msProduct":"*"
                ,"card0":"card0.url as card0"
                ,"card1":"card1.url as card1"
                ,"availability":"CASE WHEN TV'~$.session.'cityselector.current_product_remain_tv'~'.value > 0 THEN 1 ELSE 0 END AS availability"
        	}',
            'toSeparatePlaceholders' => 'mFilter2.',
            'tpl' => '@FILE chunks/tpl.products.row.tpl',
            'tplOuter' => '@FILE chunks/tpl.productList.tpl',
            'sortby' => '{"msProduct.pagetitle":"ASC"}',
            'limit' => $_modx->config.products_per_page,
            'values_delimeter' => ';',
            'includeTVs' => $.session.'cityselector.current_product_remain_tv',
            'paginator' => 'pdoPage@pageNavVar=`page.nav`',
            'canonicalQueryString' => true,
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
        		"card0": {"class":"msProductFile","alias":"card0", "on": "card0.product_id = msProduct.id AND card0.path LIKE \'%/card/%\' AND card0.rank=0 AND card0.active = 1"}
        		,"card1": {"class":"msProductFile","alias":"card1", "on": "card1.product_id = msProduct.id AND card1.path LIKE \'%/card/%\' AND card1.rank=1 AND card1.active = 1"}
                ,"steelDoorModel": {
                    "class": "msProductOption",
                    "on": "steelDoorModel.product_id = msProduct.id AND steelDoorModel.key = \'model\'"
                },
                "steelDoorCoatingColor": {
                    "class": "msProductOption",
                    "on": "steelDoorCoatingColor.product_id = msProduct.id AND steelDoorCoatingColor.key = \'steel_door_color\'"
                },
                "steelDoorInnerPanelColor": {
                    "class": "msProductOption",
                    "on": "steelDoorInnerPanelColor.product_id = msProduct.id AND steelDoorInnerPanelColor.key = \'shield_color\'"
                },
                "steelDoorGlassColor": {
                    "class": "msProductOption",
                    "on": "steelDoorGlassColor.product_id = msProduct.id AND steelDoorGlassColor.key = \'glass\'"
                }
        	}',
        	'select' => '{
        		"msProduct":"*"
        		,"card0":"card0.url as card0"
        		,"card1":"card1.url as card1"
                ,"productModel":"steelDoorModel.value as productModel"
                ,"productGroupRemainSum": "SUM(CAST(TV'~$.session.'cityselector.current_product_remain_tv'~'.value AS SIGNED)) as productGroupRemainSum"
                ,"availability":"CASE WHEN SUM(CAST(TV'~$.session.'cityselector.current_product_remain_tv'~'.value AS SIGNED)) > 0 THEN 1 ELSE 0 END AS availability"
                ,"productGroupMaxPrice":"MAX(Data.price) AS productGroupMaxPrice"
                ,"productGroupPrices":"GROUP_CONCAT(msProduct.id, \':\', Data.price, \':\', Data.old_price) AS productGroupPrices"
        	}',
            'disableGroupByProductId' => true,
            'disableGroupingForPreparedResults' => true,
            'groupby' => '["steelDoorModel.value", "steelDoorCoatingColor.value", "steelDoorInnerPanelColor.value", "steelDoorGlassColor.value"]',
            'includeTVs' => $.session.'cityselector.current_product_remain_tv',
            'tplOuter' => '@FILE chunks/tpl.productList.tpl',
            'sortby' => '{"msProduct.pagetitle":"ASC"}',
            'limit' => $_modx->config.products_per_page,
            'filters' => '
                msoc|steel_door_color~value~pattern,
                msoc|shield_color~value~pattern,
                ms|vendor:vendors,
                msoption|metal_thickness:metal_thickness,
                msoption|width:width,
                msoption|spontaneity:spontaneity,
                msoption|doorType:doorType,
                msoc|glass~value~pattern,
                ms|favorite:favorite,
            ',
            'aliases' => '
                msoc|steel_door_color==color,
                msoc|shield_color==shield-color,
                ms|vendor==trademark,
                msoption|metal_thickness==metal-thickness,
                msoption|width==width,
                msoption|spontaneity==side,
                msoption|doortype==type,
                msoc|glass==glass-color,
            ',
            'values_delimeter' => ';',
            'paginator' => 'pdoPage@pageNavVar=`page.nav`',
            'canonicalQueryString' => true,
            'tplFilter.outer.color' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.color' => '@FILE chunks/tpl.filter.row.checkbox.color.tpl',
            'tplFilter.outer.shield-color' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.shield-color' => '@FILE chunks/tpl.filter.row.checkbox.color.tpl',
            'tplFilter.outer.trademark' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.trademark' => '@FILE chunks/tpl.filter.row.checkbox.tpl',
            'tplFilter.outer.metal-thickness' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.metal-thickness' => '@FILE chunks/tpl.filter.row.checkbox.tpl',
            'tplFilter.outer.width' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.width' => '@FILE chunks/tpl.filter.row.checkbox.tpl',
            'tplFilter.outer.side' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.side' => '@FILE chunks/tpl.filter.row.checkbox.tpl',
            'tplFilter.outer.type' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.type' => '@FILE chunks/tpl.filter.row.checkbox.door_type.tpl',
            'tplFilter.outer.glass-color' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.glass-color' => '@FILE chunks/tpl.filter.row.checkbox.color.tpl',
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
            'sortby' => '{"msProduct.pagetitle":"ASC"}',
            'limit' => $_modx->config.products_per_page,
            'filters' => '
                msoc|mscolor~value~pattern,
                ms|vendor:vendors,
                msoption|cover:cover,
                msoption|width:width,
                msoption|doorType:doorType,
                msoc|glass~value~pattern,
                ms|favorite:favorite,
            ',
            'aliases' => '
                msoption|cover==coating,
                msoption|width==width,
                ms|vendor==trademark,
                msoc|mscolor==color,
                msoption|doortype==type,
                msoc|glass==glass-color,
            ',
            'values_delimeter' => ';',
            'leftJoin' => '{
                "mscolor": {
                    "class": "msocColor",
                    "on": "mscolor.key = \'mscolor\' and mscolor.rid = msProduct.id"
                },
                "interiorDoorModel": {
                    "class": "msProductOption",
                    "on": "interiorDoorModel.product_id = msProduct.id AND interiorDoorModel.key = \'model\'"
                },
                "interiorDoorLeafColor": {
                    "class": "msProductOption",
                    "on": "interiorDoorLeafColor.product_id = msProduct.id AND interiorDoorLeafColor.key = \'mscolor\'"
                },
                "interiorDoorGlassColor": {
                    "class": "msProductOption",
                    "on": "interiorDoorGlassColor.product_id = msProduct.id AND interiorDoorGlassColor.key = \'glass\'"
                }
            }',
        	'select' => '{
        		"productModel":"interiorDoorModel.value as productModel",
                "productGroupRemainSum": "SUM(CAST(TV'~$.session.'cityselector.current_product_remain_tv'~'.value AS SIGNED)) as productGroupRemainSum",
                "availability":"CASE WHEN SUM(CAST(TV'~$.session.'cityselector.current_product_remain_tv'~'.value AS SIGNED)) > 0 THEN 1 ELSE 0 END AS availability",
                "productGroupMaxPrice":"MAX(Data.price) AS productGroupMaxPrice",
                "productGroupPrices":"GROUP_CONCAT(msProduct.id, \':\', Data.price, \':\', Data.old_price) AS productGroupPrices"
        	}',
            'disableGroupByProductId' => true,
            'disableGroupingForPreparedResults' => true,
            'groupby' => '["interiorDoorModel.value", "interiorDoorLeafColor.value", "interiorDoorGlassColor.value"]',
            'includeTVs' => $.session.'cityselector.current_product_remain_tv',
            'paginator' => 'pdoPage@pageNavVar=`page.nav`',
            'canonicalQueryString' => true,
            'suggestionsMaxResults' => 4000,
            'tplFilter.outer.color' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.color' => '@FILE chunks/tpl.filter.row.checkbox.color.tpl',
            'tplFilter.outer.trademark' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.trademark' => '@FILE chunks/tpl.filter.row.checkbox.tpl',
            'tplFilter.outer.coating' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.coating' => '@FILE chunks/tpl.filter.row.checkbox.tpl',
            'tplFilter.outer.width' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.width' => '@FILE chunks/tpl.filter.row.checkbox.tpl',
            'tplFilter.outer.type' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.type' => '@FILE chunks/tpl.filter.row.checkbox.door_type.tpl',
            'tplFilter.outer.glass-color' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.glass-color' => '@FILE chunks/tpl.filter.row.checkbox.color.tpl',
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
            'sortby' => '{"msProduct.pagetitle":"ASC"}',
            'limit' => $_modx->config.products_per_page,
            'filters' => '
                msoc|mscolor~value~pattern,
                ms|vendor:vendors,
                msoption|furniture_type:furniture_type,
                ms|favorite:favorite,
            ',
            'aliases' => '
                msoc|mscolor==color,
                ms|vendor==trademark,
                msoption|furniture_type==type,
            ',
            'values_delimeter' => ';',
            'includeTVs' => $.session.'cityselector.current_product_remain_tv',
            'select' => '{
                "availability":"CASE WHEN TV'~$.session.'cityselector.current_product_remain_tv'~'.value > 0 THEN 1 ELSE 0 END AS availability"
            }',
            'paginator' => 'pdoPage@pageNavVar=`page.nav`',
            'canonicalQueryString' => true,
            'tplFilter.outer.color' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.color' => '@FILE chunks/tpl.filter.row.checkbox.color.tpl',
            'tplFilter.outer.trademark' => '@FILE chunks/tpl.filter.outer.tpl',
            'tplFilter.row.trademark' => '@FILE chunks/tpl.filter.row.checkbox.tpl',
            'tplFilter.outer.type' => '@FILE chunks/tpl.filter.outer.furniture_type.tpl',
            'tplFilter.row.type' => '@FILE chunks/tpl.filter.row.checkbox.furniture_type.tpl',
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
