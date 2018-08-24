{extends 'template:base'}
{block 'content'}
<section>
    <div class="container-fluid card-overlay text-white" style="background-image: url({$_modx->resource.bg ?: '/assets/i/bg-catalog-room.jpg'})">
        <div class="row">
            <div class="col-md-6 col-12 card-img-overlay gr-black-r"></div>
            <div class="col-md-6 col-12 px-5 py-4">
                <h1 class="promo-title h-rem-3">Товары бренда «{$_modx->resource.pagetitle}»</h1>
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

{$_modx->RunSnippet('!mFilter2', [
    'parents' => 0,
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
	'where' => '{"Data.vendor":"'~$_modx->resource.alias~'"}',
    'sortby' => '{"msProduct.pagetitle":"ASC"}',
    'limit' => 20,
    'values_delimeter' => ';',
    'toSeparatePlaceholders' => 'mFilter2.',
    'tpl' => '@FILE chunks/tpl.products.row.tpl',
    'tplOuter' => '@FILE chunks/tpl.productList.tpl',
    'includeTVs' => $.session.'cityselector.current_product_remain_tv',
    'paginator' => 'pdoPage@pageNavVar=`page.nav`',
    'canonicalQueryString' => true,
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
