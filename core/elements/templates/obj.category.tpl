{extends 'template:base'}
{block 'content'}
        <section>
            <div class="container-fluid card-overlay text-white" style="background-image: url({$_modx->resource.bg ?: '/assets/i/bg-catalog-room.jpg'})">
                <div class="row">
                    <div class="col-md-6 col-12 card-img-overlay gr-black-r"></div>
                    <div class="col-md-6 col-12 px-5 py-4">
                        <h1 class="promo-title h-rem-3">{$_modx->resource.pagetitle}</h1>
                        <!--<p>В нашем интернет-магазине представлены межкомнатные двери с фото и ценами. Если у вас возникнут вопросы, мы с удовольствием проконсультируем и поможем сделать правильный выбор.</p>-->
                    </div>
                    <div class="col-md-6 col-12 px-5 py-4">
                        <div class="d-inline-block float-md-right">
                            <div class="btn-group btn-group-sm" role="group">
                                <!-- 6 => dvmk, 7 => danger, 8 => dariano -->
                                {$_modx->runSnippet('!pdoResources', [
                                'parents' => 39,
                                'limit' => 3,
                                'includeContent' => 1,
                                'where' => ['content:!=' => $_modx->resource.id],
                                'sortby' => 'id',
                                'sortdir' => 'asc',
                                'tpl' => '@INLINE <a type="button" href="{$_modx->makeUrl($content)}" class="btn btn-{if $content == 6}dvmk{elseif $content == 7}dvmk{elseif $content == 8}dvmk{/if}">{$pagetitle}</a>',
                                ])}
                            </div>
                        </div>
                        <!--<p>В нашем интернет-магазине представлены межкомнатные двери с фото и ценами. Если у вас возникнут вопросы, мы с удовольствием проконсультируем и поможем сделать правильный выбор.</p>-->
                    </div>
                    <!--<div class="col-lg-6 px-5 py-4">-->
                    <!--<div class="card card-overlay text-white" style="background-image: url('/assets/i/bg-leaf-dark.jpg')">-->
                    <!--<div class="card-block px-5 py-4 text-xs-center">-->
                    <!--<h3 class="card-title"><strong>Пора</strong> сделать замер</h3>-->
                    <!--<div class="md-form">-->
                    <!--<i class="fa fa-envelope prefix"></i>-->
                    <!--<input type="tel" id="form2" class="form-control btn-right" placeholder="+7 (___) ___-____"><button class="btn btn-dvmk">ВЫЗВАТЬ ЗАМЕРЩИКА</button>-->
                    <!--<p class="mt-3">с <strong>9:00</strong> до <strong>21:00</strong> без выходных</p>-->
                    <!--</div>-->
                    <!--</div>-->
                    <!--</div>-->
                    <!--</div>-->
                </div>
            </div>
        </section>
        {if $_modx->resource.id == 5}
        {$_modx->RunSnippet('!mFilter2', [
            'parents' => '5',
            'element' => 'msProducts',
            'class' => 'msProduct',
            'loadModels' => 'gallery',
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
            'tplPagePrev' => '@INLINE <!--Arrow left--> <li class="page-item"><a class="page-link waves-effect waves-effect" aria-label="Previous" href="{$href}"><span aria-hidden="true">←</span><span class="sr-only">Предыдущая</span></a></li>',
            'tplPageNext' => '@INLINE <!--Arrow right--> <li class="page-item"><a class="page-link waves-effect waves-effect" aria-label="Next" href="{$href}"><span aria-hidden="true">→</span><span class="sr-only">Следующая</span></a></li>',
            'tplPageFirst' => '@INLINE',
            'tplPageLast' => '@INLINE',
            'tplPagePrevEmpty' => '@INLINE',
            'tplPageNextEmpty' => '@INLINE',
            'tplPageFirstEmpty' => '@INLINE',
            'tplPageLastEmpty' => '@INLINE',
        ])}
        {elseif $_modx->resource.id == 6}
        {$_modx->RunSnippet('!mFilter2', [
            'parents' => $_modx->resource.id,
            'element' => 'msProducts',
            'class' => 'msProduct',
            'toSeparatePlaceholders' => 'mFilter2.',
            'tpl' => '@FILE chunks/tpl.products.row.tpl',
        	'loadModels' => 'gallery',
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
            ',
            'values_delimeter' => ';',
            'paginator' => 'pdoPage@pageNavVar=`page.nav`',
            'tplFilter.outer.msoc|steel_door_color' => 'tpl.filter.outer.msoption.msColor',
            'tplFilter.row.msoc|steel_door_color' => 'tpl.filter.row.msoption.msColor',
            'tplFilter.outer.msoc|shield_color' => 'tpl.filter.outer.msoption.msColor',
            'tplFilter.row.msoc|shield_color' => 'tpl.filter.row.msoption.msColor',
            'tplFilter.outer.msvendor|name' => 'tpl.filter.outer.msvendor.name',
            'tplFilter.row.msvendor|name' => 'tpl.filter.row.msvendor.name',
            'tplFilter.outer.msoption|metal_thickness' => 'tpl.filter.outer.msoption.cover',
            'tplFilter.row.msoption|metal_thickness' => 'tpl.filter.row.msoption.cover',
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
        {elseif $_modx->resource.id == 7}
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
            ',
            'values_delimeter' => ';',
            'leftJoin' => '{
                "mscolor": {
                    "class": "msocColor",
                    "on": "mscolor.key = \'mscolor\' and mscolor.rid = msProduct.id"
                }
            }',
            'paginator' => 'pdoPage@pageNavVar=`page.nav`',
            'tplFilter.outer.msoc|mscolor' => 'tpl.filter.outer.msoption.msColor',
            'tplFilter.row.msoc|mscolor' => 'tpl.filter.row.msoption.msColor',
            'tplFilter.outer.msvendor|name' => 'tpl.filter.outer.msvendor.name',
            'tplFilter.row.msvendor|name' => 'tpl.filter.row.msvendor.name',
            'tplFilter.outer.msoption|cover' => 'tpl.filter.outer.msoption.cover',
            'tplFilter.row.msoption|cover' => 'tpl.filter.row.msoption.cover',
            'tplFilter.outer.msoption|width' => 'tpl.filter.outer.msoption.width',
            'tplFilter.row.msoption|width' => 'tpl.filter.row.msoption.width',
            'tplFilter.outer.msoption|doorType' => 'tpl.filter.outer.msoption.doorType',
            'tplFilter.row.msoption|doorType' => 'tpl.filter.row.msoption.doorType',
            'tplFilter.outer.msoc|glass' => 'tpl.filter.outer.msoption.glass',
            'tplFilter.row.msoc|glass' => 'tpl.filter.row.msoption.glass',
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
        {elseif $_modx->resource.id == 8}
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
            ',
            'values_delimeter' => ';',
            'paginator' => 'pdoPage@pageNavVar=`page.nav`',
            'tplFilter.outer.msoc|mscolor' => 'tpl.filter.outer.msoption.msColor',
            'tplFilter.row.msoc|mscolor' => 'tpl.filter.row.msoption.msColor',
            'tplFilter.outer.msvendor|name' => 'tpl.filter.outer.msvendor.name',
            'tplFilter.row.msvendor|name' => 'tpl.filter.row.furniture_msvendor.name',
            'tplFilter.outer.msoption|furniture_type' => 'tpl.filter.outer.msoption.cover',
            'tplFilter.row.msoption|furniture_type' => 'tpl.filter.row.msoption.cover',
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
