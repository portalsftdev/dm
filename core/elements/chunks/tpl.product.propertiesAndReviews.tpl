<div class="container" id="product-tabs">
    <ul class="nav nav-tabs nav-fill mb-4" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" data-toggle="tab" href="#product-properties" role="tab">Характеристики</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#product-reviews" role="tab">Отзывы ({$reviewsCount})</a>
        </li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active" id="product-properties" role="tabpanel">
            {$_modx->runSnippet('!msProductOptions', ['tpl' => '@FILE chunks/tpl.productoptions.tpl', 'ignoreOptions' => $ignoreOptions])}
        </div>
        <div class="tab-pane" id="product-reviews" role="tabpanel">
            {if 0 == $reviewsCount}
                <div class="text-center my-5">Ни одного отзыва еще не было оставлено.</div>
            {else}
                <div class="mb-5">
                    {$_modx->runSnippet('!ecMessages', [
                        'tpl' => '@FILE chunks/tpl.product.review.message.tpl',
                    ])}
                </div>
            {/if}
            <h5 class="mb-4 pb-2">Написать отзыв</h5>
            {$_modx->runSnippet('!ecForm', [
                'tplForm' => '@FILE chunks/tpl.product.review.form.tpl',
                'requiredFields' => 'user_name, rating, text',
                'tplSuccess' => '@FILE chunks/tpl.product.review.form.success.tpl',
                'mailManager' => $_modx->config.manager_emails,
                'tplNewEmailManager' => '@FILE chunks/tpl.product.review.email.manager.tpl',
                'tplNewEmailUser' => '@FILE chunks/tpl.product.review.email.reviewer.tpl',
            ])}
        </div>
    </div>
</div>
