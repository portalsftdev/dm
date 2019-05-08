<section class="pb-2 px-3">
    <div class="container-fluid">
        <h3 class="doc-title "><span>Новинки</span></h3>
    </div>
    <div class="container-fluid">
        <div class="row">
        {$_modx->RunSnippet('msProducts', [
            'tpl' => '@FILE chunks/tpl.products.new.row.tpl',
            'limit' => 5,
            'sortby' => 'RAND()',
            'where' => '{"Data.new":1}',
        ])}
        </div>
    </div>
</section>
