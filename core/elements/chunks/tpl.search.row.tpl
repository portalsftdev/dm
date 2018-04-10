{set $thumb1 = ''}
{if ($template in [15])}
    {set $card_mask = ''}
{elseif ($template == 13)}
    {set $thumb1 = $card1?:''}
    {set $card_mask = 'mask-door'}
{else}
    {set $card_mask = 'mask-door'}
{/if}
{set $card_tile = 'card-product--vert'}
{set $card_height = 'h-rem-8'}

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
        <div class="card-price">
            <span class="price">{$price}</span>&nbsp;<span class="icon-rub"></span>
        </div>
        <div>
            <a href="{$id | url}" class="card-title">{$pagetitle}</a>
        </div>

    </div>
</div>
