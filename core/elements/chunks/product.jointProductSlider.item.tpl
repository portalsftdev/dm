{set $nfp = $_modx->config.ms2_price_format|json_decode}
{set $price = $id | resource: $.session.'cityselector.current_product_price_tv' | number:0:$nfp.1:$nfp.2}
        <div class="slider-item">
            <div class="row no-gutters px-3">
                <div class="col-6 d-flex flex-column justify-content-center">
                    {if $thumb?}
                        <img class="img-fluid d-block mx-auto mb-2" src="{$thumb}" alt="{$pagetitle|escape}" title="{$pagetitle|escape}" />
                    {else}
                        <img class="img-fluid d-block mx-auto mb-2 dummy" src="{'assets_url'|option}components/minishop2/img/web/ms2_small.png"
                            srcset="{'assets_url'|option}components/minishop2/img/web/ms2_small@2x.png 2x"
                            alt="{$pagetitle|escape}" title="{$pagetitle|escape}"
                        />
                    {/if}
                    <div class="price">{$price} <i class="icon-rub"></i></div>
                </div>
                <div class="col-6 d-flex flex-column justify-content-center pl-3">
                    <div class="mb-3">
                        <a href="{$id|url}">{$pagetitle|truncate:$_modx->config.slider_pagetitle_max_string_length:'...':true}</a>
                    </div>
                    {$_modx->runSnippet('@FILE snippets/dmProductAvailability.php', [
                        'tpl' => '@INLINE <div class="product-availability-divider{if $class} {$class}{/if}"></div>',
                        'tplWrapper' => '@INLINE <div class="product-availability align-self-start d-inline-flex mb-3 pr-2" data-toggle="tooltip" data-placement="right" title="{$title}" data-trigger="hover">{$items}</div>',
                        'productRemain' => $id | resource : $.session.'cityselector.current_product_remain_tv',
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
                    {set $cartKey = ''}
                    {set $cartCount = 0}
                    {foreach $.session['minishop2']['cart'] as $cartItemKey => $cartItem}
                        {if $id == $cartItem['id']}
                            {set $cartKey = $cartItemKey}
                            {set $cartCount = $cartItem['count']}
                            {break}
                        {/if}
                    {/foreach}
                    <form method="post" class="ms2_form">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <button type="button" class="btn btn-secondary" data-spin="minus"><span>–</span></button>
                            </div>
                            <input name="id" value="{$id}" type="hidden">
                            {if '' != $cartKey}<input type="hidden" name="key" value="{$cartKey}" />{/if}
                            <input class="form-control no-spinners" placeholder="0" name="count" min="0" step="1" value="{$cartCount}" type="number">
                            <input name="options" value="[]" type="hidden">
                            <button type="submit" name="ms2_action" value="{if 0 == $cartCount}cart/add{else}cart/change{/if}" class="d-none"></button>
                            <div class="input-group-append">
                                <button type="button" class="btn btn-secondary" data-spin="plus">+</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
