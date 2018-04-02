            <div class="card-product card-tile-wide card-tile--trim">

                <div class="overlay-door">
                    <div class="mask mask-door">
                        <a href="{$id | url}">
                        {if $thumb?}
                            <img src="{$thumb}" alt="{$pagetitle}" title="{$pagetitle}"/>
                        {else}
                            <img src="{'assets_url' | option}components/minishop2/img/web/ms2_small.png"
                                 srcset="{'assets_url' | option}components/minishop2/img/web/ms2_small@2x.png 2x"
                                 alt="{$pagetitle}" title="{$pagetitle}"/>
                        {/if}
                        </a>
                    </div>
                </div>

                <div class="card-block h-rem-12">
                    {if $old_price>0}
                    <div class="card-price-old">
                        <del>{$old_price}</del>
                    </div>
                    {/if}
                    <div class="card-price">
                        <span class="price">{$price}</span>&nbsp;<span class="icon-rub"></span>
                    </div>

                    <a href="{$id | url}" class="card-title">{$pagetitle}</a>

                    <div class="card-description">
                        {$_modx->runSnippet('!msProductOptions', ['tpl' => '@FILE chunks/tpl.productoptions.p.tpl', 'product' => $id, 'onlyOptions' => 'mscolor,cover'])}
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