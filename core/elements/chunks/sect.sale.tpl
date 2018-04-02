<section class="pb-2">
    <div class="container-fluid">
        <div class="row mt-4">
            {$_modx->RunSnippet('!msProducts', [
                'tpl' => '@FILE chunks/product.discount.item.tpl',
                'parents' => 0,
                'where' => '{"Data.favorite": "1"}',
                'sortby' => 'RAND()',
                'limit' => 2,
            ])}
        </div>
    </div>
</section>
