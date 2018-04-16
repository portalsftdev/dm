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
{if ($_modx->resource.id in [101, 5]) or $_modx->resource.parent == 31}
    {set $card_tile = 'card-tile-narrow card-product--vert'}
    {set $card_height = 'h-rem-8'}
{/if}

<div class="card-product {$thumb1? 'card-product--2' : ''} {$card_tile} msfavorites-parent">
    <div class="overlay-door">
        <div class="mask {$card_mask}">
            <a href="{$id | url}">
                {if $thumb?}
                    <img src="{$thumb}" alt="{$pagetitle | escape}" title="{$pagetitle | escape}"/>
                {else}
                    <img src="{'assets_url' | option}components/minishop2/img/web/ms2_small.png"
                         srcset="{'assets_url' | option}components/minishop2/img/web/ms2_small@2x.png 2x"
                         alt="{$pagetitle | escape}" title="{$pagetitle | escape}"/>
                {/if}
                {if $thumb1?}
                    <img src="{$thumb1}" alt="{$pagetitle | escape}" title="{$pagetitle | escape}"/>
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
            <div style="margin-bottom:.5rem;" data-toggle="modal" data-target="#product-price-order"><a class="btn-icon btn-icon-dvmk icon-phone text-primary" style="position:relative;top:2px;padding:0;padding-right:.375rem;font-size:1.25rem;line-height:1;"></a><a style="cursor:pointer;">Запросить цену</a></div>
        {else}
            <div class="card-price">
                <span class="price">{$price}</span>&nbsp;<span class="icon-rub"></span>
            </div>
        {/if}
        <div>
            <a href="{$id | url}" class="card-title">{$pagetitle}</a>
        </div>
        <div class="card-description">
        {if $_modx->config.'resources.room_doors' == $parent}
            {$_modx->runSnippet('!msProductOptions', ['tpl' => '@FILE chunks/tpl.productoptions.p.tpl', 'product' => $id, 'onlyOptions' => 'mscolor,cover'])}
        {elseif $_modx->config.'resources.steel_doors' == $parent}

        {/if}
        </div>

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
