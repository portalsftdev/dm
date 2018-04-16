{if $_modx->resource.id == 1}
    {if !$_modx->getPlaceholder('discounts.padding')?}
        {$_modx->setPlaceholder('discounts.padding', 'right')}
    {/if}
{/if}
<div class="col-lg-6 col-md-12 px-0 {if $_modx->resource.id == 1}{if $_modx->getPlaceholder('discounts.padding') == 'right'}pr-lg-3{elseif $_modx->getPlaceholder('discounts.padding') == 'left'}pl-lg-3{/if}{else}pl-lg-3{/if} wow fadeIn" data-wow-delay="0.4s" style="visibility: visible; animation-delay: 0.4s; animation-name: fadeIn;">
    <div class="card card-overlay-door card-overlay--marketing hover-effect-control mb-4" style="background-image: url('/assets/i/{if $parent == $_modx->config.'resources.room_doors'}bg-door-of-month.jpg{elseif $parent == $_modx->config.'resources.steel_doors'}bg-door-of-month-vhod.jpg{/if}')">
        <div class="overlay-door">
            <a href="{$id | url}">
                {if $thumb?}
                    <img src="{$thumb}" alt="{$pagetitle | escape}" title="{$pagetitle | escape}"/>
                {else}
                    <img src="{'assets_url' | option}components/minishop2/img/web/ms2_small.png"
                         srcset="{'assets_url' | option}components/minishop2/img/web/ms2_small@2x.png 2x"
                         alt="{$pagetitle | escape}" title="{$pagetitle | escape}"/>
                {/if}
            </a>
        </div>
        <div class="card-block">
            <div class="row mb-3">
                <div class="col-3 push-9 text-right">
                    <div class="promo-labels">
                        <div class="promo-label promo-label--red">Акция&nbsp;месяца</div>
                    </div>
                </div>
                {*<div class="col-9 pull-xxl-3 pull-xl-4 pull-lg-9 pull-md-3">
                    <span class="mr-3">Осталось:</span>
                    <span class="tag tag-lg relative">
                        <span class="tag-outline-orange tag-mask animate-tremor"></span>
                        {$_modx->RunSnippet('@FILE snippets/discountDaysLeft.php')}
                    </span>
                </div>*}
            </div>
            <h3 class="mt-5"><a href="{$id | url}">{$_pls['model.value']}</a></h3>
            <p>
            {if $_modx->config.'resources.room_doors' == $parent}
                Покрытие: {$_pls['cover.value']}<br>
            {elseif $_modx->config.'resources.steel_doors' == $parent }
                Цвет внешнего покрытия: {$_pls['steel_door_color.value']}<br>
            {/if}
            {if $_modx->config.'resources.room_doors' == $parent}
                Цвет: {$_pls['mscolor.value']}
            {elseif $_modx->config.'resources.steel_doors' == $parent}
                Цвет внутренней панели: {$_pls['shield_color.value']}
            {/if}
            </p>
            <div class=" mt-5">
                <div class="float-right ml-3">
                    {if $old_price > 0}
                    <div class="card-price-old">
                        <del>{$old_price}</del>
                    </div>
                    {/if}
                    <div class="card-price">
                        <span class="price">{$price}</span>&nbsp;<span class="icon-rub"></span>
                    </div>
                </div>
                <div class="float-left">
                    <form method="post" class="ms2_form">
                        <button type="submit" name="ms2_action" value="cart/add" class="btn btn-dvmk hover-effect hover-effect--apollo waves-effect waves-light"><span class="icon-cart"></span> В корзину</button>
                        <input type="hidden" name="id" value="{$id}">
                        <input type="hidden" name="count" value="1">
                        <input type="hidden" name="options" value="[]">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
{if $_modx->resource.id == 1}
    {if ($_modx->getPlaceholder('discounts.padding') == 'left')}
        {$_modx->setPlaceholder('discounts.padding', 'right')}
    {elseif ($_modx->getPlaceholder('discounts.padding') == 'right')}
        {$_modx->setPlaceholder('discounts.padding', 'left')}
    {/if}
{/if}
