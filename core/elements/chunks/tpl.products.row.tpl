{set $showThisProduct = true}
{if
    (
        $_modx->config.'resources.room_doors' == $_modx->resource.id
    )
    && $productVariations
}
    {set $showThisProduct = false}
    {foreach $productVariations as $productVariation}
        {if $_modx->config.'resources.room_doors' == $_modx->resource.id && '800x2000' === $productVariation.size}
            {set $showThisProduct = true}
            {set $id = $productVariation.id}
            {set $pagetitle = $productVariation.pagetitle}
            {set $longtitle = $productVariation.longtitle}
            {set $price = $productVariation.price}
            {set $old_price = $productVariation.old_price}
            {* QUESTION: Should images be overridden? *}
        {/if}
    {/foreach}
{/if}

{if $showThisProduct?}
    {set $thumb1 = ''}
    {set $card_mask = ''}
    {set $card_height = 'h-rem-12'}
    {if ($template in [15])}
        {set $card_tile = 'card-tile-narrow card-product--vert'}
        {set $card_height = 'h-rem-8'}
    {elseif ($template == 13)}
        {set $card_tile = 'card-tile-wide'}
        {set $thumb1 = $card1?:''}
        {set $card_mask = 'mask-door'}
    {else}
        {set $card_tile = 'card-tile-wide'}
        {set $card_mask = 'mask-door'}
    {/if}
    {if ($_modx->resource.id in [$_modx->config.'resources.wishlist', $_modx->config.'resources.catalog']) or $_modx->config.'resources.brands' == $_modx->resource.parent}
        {set $card_tile = 'card-tile-narrow card-product--vert'}
        {set $card_height = 'h-rem-8'}
    {/if}

    {*
        Override id, price and old price if products in the product group have
        different prices
    *}
    {if $productGroupPrices?}
        {set $productGroupPrices = $productGroupPrices|split:','}
        {set $productGroupMinPrice = $.const.INF}

        {foreach $productGroupPrices as $productGroupPrice}
            {* Format: id:price:old_price *}
            {set $productGroupPrice = $productGroupPrice|split:':'}

            {if $productGroupMinPrice > $productGroupPrice.1}
                {set $productGroupMinPrice = $productGroupPrice.1}
                {set $productWithMinPrice = $productGroupPrice}
            {/if}
        {/foreach}
    {/if}

    {if $productWithMinPrice?}
        {set $id = $productWithMinPrice.0}

        {set $nfp = $_modx->config.ms2_price_format|json_decode}
        {set $price = $productWithMinPrice.1|number:0:$nfp.1:$nfp.2}
        {set $old_price = $productWithMinPrice.2|number:0:$nfp.1:$nfp.2}
    {/if}


    <div class="card-product {$thumb1? 'card-product--2' : ''} {$card_tile} msfavorites-parent" itemscope itemtype="http://schema.org/Product">
        {if $_modx->config.'resources.steel_doors' == $_modx->resource.id}
            {set $customProductTitle = 'Входная дверь ' ~ $pagetitle}
        {else}
            {set $customProductTitle = $longtitle ?: $pagetitle}
        {/if}
        {set $customProductTitle = $customProductTitle|escape}
        <div class="overlay-door">
            <div class="mask {$card_mask}{if ! $thumb?} bg-none{/if}">
                <a href="{$id | url}">
                    {if $thumb?}
                        <img src="{$thumb}" alt="{$customProductTitle}" title="{$customProductTitle}" itemprop="image" />
                    {else}
                        <img src="{'assets_url' | option}components/minishop2/img/web/ms2_small.png"
                             srcset="{'assets_url' | option}components/minishop2/img/web/ms2_small@2x.png 2x"
                             alt="{$customProductTitle}" title="{$customProductTitle}" />
                    {/if}
                    {if $thumb1?}
                        <img src="{$thumb1}" alt="{$customProductTitle}" title="{$customProductTitle}" itemprop="image" />
                    {/if}
                </a>
            </div>
        </div>
        <div class="card-block {$card_height}">
            {if $old_price>0}
                <div class="card-price-old">
                    <del>{$old_price}</del>
                </div>
            {/if}
            {if $price == 0}
                <div class="mb-2 product-price-request" data-toggle="modal" data-target="#product-price-order"><a class="btn-icon btn-icon-dvmk icon-phone text-primary"></a><a>Запросить цену</a></div>
            {else}
                <div class="card-price" itemscope itemprop="offers" itemtype="http://schema.org/Offer">
                    <span class="price" itemprop="price" content="{$price | replace: ' ' : ''}">{$price}</span>&nbsp;<span class="icon-rub"></span>
                    <meta itemprop="priceCurrency" content="RUB" />
                    <meta itemprop="availability" href="http://schema.org/InStock" content="В наличии" />
                </div>
            {/if}
            <div>
                <a href="{$id | url}" class="card-title">{$productModel ?: $pagetitle | truncate:$_modx->config.product_pagetitle_max_string_length:'...':true}</a>
                <meta itemprop="name" content="{$customProductTitle}" />
                <link itemprop="url" href="{$_modx->config.site_url ~ $id | url}" />
                <meta itemprop="brand" content="{$_pls['vendor.name'] | escape}" />
                <meta itemprop="model" content="{$_pls['model.value'] | escape}" />
            </div>
            <div class="card-description">
            <meta itemprop="description" content="{$description ?: $longtitle | escape}" />
            {set $showProductOptions = $_modx->resource.id in [$_modx->config.'resources.steel_doors', $_modx->config.'resources.room_doors']}
            {if $showProductOptions}
                {if $_modx->config.'resources.room_doors' == $parent}
                    {$_modx->runSnippet('!msProductOptions', ['tpl' => '@FILE chunks/tpl.productoptions.p.tpl', 'product' => $id, 'onlyOptions' => 'mscolor,cover,glass'])}
                {elseif $_modx->config.'resources.steel_doors' == $parent}
                    {$_modx->runSnippet('!msProductOptions', ['tpl' => '@FILE chunks/tpl.productoptions.p.tpl', 'product' => $id, 'onlyOptions' => 'steel_door_color,shield_color'])}
                {/if}
            {/if}
            <span class="mr-1 product-availability-label">Наличие:</span>
            {set $productRemain = $productGroupRemainSum ?: $id | resource : $.session.'cityselector.current_product_remain_tv'}
            {$_modx->runSnippet('@FILE snippets/dmProductAvailability.php', [
                'tpl' => '@INLINE <div class="product-availability-divider{if $class} {$class}{/if}"></div>',
                'tplWrapper' => '@INLINE <div class="product-availability d-inline-block pt-2'~($showProductOptions ? ' mt-2' : '')~'" data-toggle="tooltip" data-placement="top" title="{$title}" data-trigger="hover">{$items}</div>',
                'productRemain' => $productRemain,
                'availabilityLevels' => 3,
                'availabilityDividers' => 5,
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
            </div>
            {set $reviewsCount = $_modx->runSnippet('!ecMessagesCount', ['thread' => 'resource-' ~ $id])}
            {if 0 != $reviewsCount}
                {$_modx->setPlaceholder('reviewsCount', $reviewsCount)}
                {$_modx->runSnippet('!ecThreadRating', [
                    'thread' => 'resource-' ~ $id,
                    'tpl' => '@INLINE <div class="card-rating-stars" title="{$rating_simple}" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
                    <span style="width: {$rating_simple_percent}%"></span>
                    <meta itemprop="ratingValue" content="{$rating_simple|round:1}" />
                    <meta itemprop="ratingCount" content="{$_modx->getPlaceholder(\'reviewsCount\')}" />
                    <meta itemprop="reviewCount" content="{$_modx->getPlaceholder(\'reviewsCount\')}" />
                    <meta itemprop="bestRating" content="{$_modx->config.ec_rating_max}" />
                    <meta itemprop="worstRating" content="1" />
                </div>',
                ])}
            {/if}
        </div>
        <div class="card-buttons">
            <form method="post" class="ms2_form">
                <button class="btn btn-outline-dvmk btn-sm waves-effect waves-light" type="submit" name="ms2_action" value="cart/add"><span class="icon-cart"></span> {'ms2_frontend_add_to_cart' | lexicon}</button>
                {$_modx->getChunk('@FILE chunks/tpl.products.row.favoriteLink.tpl', ['id' => $id])}
                <input type="hidden" name="id" value="{$id}">
                <input type="hidden" name="count" value="1">
                <input type="hidden" name="options" value="[]">
            </form>
        </div>
    </div>
{/if}
