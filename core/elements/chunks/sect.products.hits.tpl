<section class="pb-2 px-3">
    <div class="container-fluid container-xxl">
        <h3 class="doc-title"><span>Хиты продаж</span></h3>
    </div>
    <div class="container-fluid">
        <div class="row">
        {$_modx->RunSnippet('msProducts', [
            'tpl' => '@FILE chunks/tpl.products.hit.row.tpl',
            'limit' => 5,
            'sortby' => 'RAND()'
            'where' => '{"Data.popular":1}'
        ])}
        </div>
    </div>
</section>
