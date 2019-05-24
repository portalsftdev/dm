<div class="container" id="product-tabs">
    <ul class="nav nav-tabs nav-fill mb-4" role="tablist">
        <li class="nav-item">
            <a class="nav-link h-100 active" data-toggle="tab" href="#product-availability" role="tab">Наличие на складе</a>
        </li>
        <li class="nav-item">
            <a class="nav-link h-100" data-toggle="tab" href="#product-properties" role="tab">Характеристики</a>
        </li>
        {if '' != $_modx->resource.description}
            <li class="nav-item">
                <a class="nav-link h-100" data-toggle="tab" href="#product-description" role="tab">Описание</a>
            </li>
        {/if}
        <li class="nav-item">
            <a class="nav-link h-100" data-toggle="tab" href="#product-reviews" role="tab">Отзывы ({$reviewsCount})</a>
        </li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active" id="product-availability" role="tabpanel">
            {set $productAvailability = $_modx->getPlaceholder('productAvailability')}
            {if $productAvailability}
                <h5 class="mb-3 pb-2">Вариации</h5>
                {$productAvailability}
                {set $complectationAvailability = $_modx->getPlaceholder('complectationAvailability')}
                {set $plinthListAvailability = $_modx->getPlaceholder('plinthListAvailability')}
                {if $complectationAvailability || $plinthListAvailability}
                    <h5 class="mt-4 mb-3 pb-2">Комплектующие</h5>
                    {$complectationAvailability ?: ''}
                    {$plinthListAvailability ?: ''}
                {/if}
            {else}
                {set $currentProductRemainTV = $.session.'cityselector.current_product_remain_tv'}
                {$_modx->runSnippet('@FILE snippets/dmProductAvailability.php', [
                    'tpl' => '@INLINE <div class="product-availability-divider{if $class} {$class}{/if}"></div>',
                    'tplWrapper' => '@INLINE <div class="row mb-2"><div class="col-6">'~$_modx->resource.pagetitle~'</div><div class="col-6 text-right pr-4"><div class="product-availability d-inline-flex pl-2" data-toggle="tooltip" data-placement="left" title="{$title}" data-trigger="hover">{$items}</div></div></div>',
                    'availabilityLevels' => 3,
                    'availabilityDividers' => 5,
                    'productRemain' => $_modx->resource.$currentProductRemainTV,
                    'levelOptions' => '{
                        "0": {
                            "title":"Под заказ"
                        },
                        "1": {
                            "dividersCount":"1",
                            "class":"level-1",
                            "min":"1",
                            "max":"2",
                            "title":"Мало"
                        },
                        "2": {
                            "dividersCount":"3",
                            "class":"level-2",
                            "min":"3",
                            "max":"5",
                            "title":"Средне"
                        },
                        "3": {
                            "dividersCount":"5",
                            "class":"level-3",
                            "min":"6",
                            "title":"Много"
                        }
                    }',
                ])}
            {/if}
        </div>
        <div class="tab-pane" id="product-properties" role="tabpanel">
            {$_modx->runSnippet('!msProductOptions', ['tpl' => '@FILE chunks/tpl.productoptions.tpl', 'ignoreOptions' => $ignoreOptions])}
        </div>
        {if '' != $_modx->resource.description}
            <div class="tab-pane" id="product-description" role="tabpanel">{$_modx->resource.description}</div>
        {/if}
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
