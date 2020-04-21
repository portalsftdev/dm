{extends 'template:base'}
{block 'content'}
    {set $nfp = $_modx->config.ms2_price_format|json_decode}
    {set $price = $_modx->resource.id | resource: $.session.'cityselector.current_product_price_tv' | number:0:$nfp.1:$nfp.2}
    <section itemscope itemtype="http://schema.org/Product" id="product" data-url="{$_modx->resource.uri}">
        <div class="expo">
            <div class="container-fluid">
                <div class="row">
                    {$_modx->setPlaceholder('productImageTitle', $_modx->resource.longtitle ?: $_modx->resource.pagetitle)}
                    {$_modx->runSnippet('!msGallery@PropertySet', [
                    'tpl' => '@FILE chunks/tpl.product.gallery.tpl',
                    'frontend_css=' => '',
                    'frontend_js' => '',
                    ])}
                    <div class="col-xl-6 bg-shadow-l">
                        <div class="container pt-4 pb-1">
                            <div class="row">
                                <div class="col">
                                    <h1 class="expo-title">{$_modx->resource.longtitle ?: $_modx->resource.pagetitle}</h1>
                                    <meta itemprop="name" content="{$_modx->resource.pagetitle | escape}" />
                                    <link itemprop="url" href="{$_modx->config.site_url ~ $_modx->resource.uri}" />
                                    <meta itemprop="model" content="{$_pls['model.value'] | escape}" />
                                    <p>
                                    {$_modx->runSnippet('!msProductOptions', ['tpl' => '@FILE chunks/tpl.productoptions.p.tpl', 'onlyOptions' => 'pattern,cover'])}
                                    </p>
                                </div>
                                <div class="col">
                                    <div class="row mx-0">
                                        <div>
                                            <a class="no_underline" title="{$_pls['vendor.name'] | escape}" href="{$_modx->makeUrl($_modx->resource.parent, '', ['trademark' => $vendor | escape])}"><img src="{$_pls['vendor.logo']}" class="expo-logo" alt="Бренд «{$_pls['vendor.name'] | escape}»"></a>
                                            <meta itemprop="brand" content="{$_pls['vendor.name'] | escape}" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="container">
                            <div class="row">
                                <div class="col-12 col-md-6 pb-3">
								<div class="mb-3 p-3 text-center rounded bordered-container total-cost-description">
                                    {if $price == 0}
                                        <div class="mb-3" data-toggle="modal" data-target="#product-price-order"><i class="btn-icon btn-icon-dvmk icon-phone text-primary"></i><a class="c-pointer">Запросить цену</a></div>
                                        <input type="hidden" name="pagetitle" value="{$_modx->resource.pagetitle | escape}" />
                                        {$_modx->getChunk('@FILE chunks/modal.productPriceOrder.tpl')}
                                    {else}
                                        <div class="total">
                                            Цена{if $old_price > 0}&nbsp;<span class="expo-price-old"><del><span class="ms2-old_price">{$old_price}</span>&nbsp;<span class="icon-rub"></span></del></span>{/if}
                                        </div>
                                        <div class="expo-price" itemscope itemprop="offers" itemtype="http://schema.org/Offer">
                                            <span class="btn-icon btn-icon-dvmk icon-label-o hidden-sm-down"></span><span class="ms2-price" id="price" itemprop="price" content="{$price | replace: ' ' : ''}">{$price}</span>&nbsp;<span class="icon-rub"></span>
                                            <meta itemprop="priceCurrency" content="RUB" />
                                            <link itemprop="availability" href="http://schema.org/InStock" />
                                        </div>
                                    {/if}
                                    {set $reviewsCount = $_modx->runSnippet('!ecMessagesCount')}
                                    {if 0 != $reviewsCount}
                                        <div class="expo-rating mb-3" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
                                            {$_modx->getChunk('@FILE chunks/tpl.product.rating.tpl', ['reviewsCount' => $reviewsCount])}
                                        </div>
                                    {/if}
									<div class="d-inline d-md-block">
                                            <form class="custom-ms2-form">
                                                <input name="products[{$_modx->resource.id}][count]" type="hidden" value="1">
                                                <input name="products[{$_modx->resource.id}][options]" type="hidden" value="[]">
                                            </form>
                                            <button type="button" class="btn btn-dvmk waves-effect waves-light mb-md-3" data-action="add-to-cart"><span class="icon-cart"></span> В корзину</button>
                                        </div>
										<div class="d-inline d-md-block">
                                            <button type="button" class="btn btn-outline-dvmk waves-effect waves-light" data-toggle="modal" data-target="#measurement-order">Заказать звонок</button>
                                        </div>
                                    <!-- <form method="post" class="ms2_form">
                                        <button type="submit" name="ms2_action" value="cart/add" class="btn btn-dvmk mb-3 mr-3 waves-effect waves-light"><span class="icon-cart"></span> В корзину</button>
                                        <input type="hidden" name="id" value="{$_modx->resource.id}">
                                        <input type="hidden" name="count" value="1">
                                        <input type="hidden" name="options" value="[]">
                                    </form> -->
									
                                    <!-- <div class="tab-open c-pointer" data-target="#product-availability"><a class="btn-icon btn-icon-dvmk icon-phone text-primary"></a><a>Уточнить наличие</a></div> -->
									
                                    <!-- <div>
                                        {$_modx->getChunk('@FILE chunks/tpl.product.favoriteLink.tpl')}
                                    </div> -->
								</div>
								<div class="d-inline-block tab-open c-pointer" data-target="#product-availability">
                                        <a class="btn-icon btn-icon-dvmk icon-info-circled text-primary"></a><a>Уточнить наличие</a>
                               </div>
							   <div class="d-inline-block">
                                        {$_modx->getChunk('@FILE chunks/tpl.product.favoriteLink.tpl')}
                                    </div>
                               </div>
							   
                            </div>
							{* Used as a temporary solution. *}
    <div id="added-to-cart" class="modal fade" tabindex="-1" role="dialog" >
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Уведомление</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Закрыть"><span aria-hidden="true">×</span></button>
                </div>
                <div class="modal-body">Товары добавлены в корзину.</div>
                <div class="modal-footer">
                    <a role="button" class="btn btn-dvmk" href="{$_modx->makeUrl($_modx->config.'resources.cart')}">Перейти в корзину</a>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Продолжить покупки</button>
                </div>
            </div>
        </div>
    </div>
    {$_modx->getChunk('@FILE chunks/modal.measurementOrder.tpl')}
                            <hr>
                            {set $conditions = [
                                'parent' => $_modx->resource.parent,
                                'vendor' => $vendor,
                                'model' => $_pls['model.value'],
                            ]}
                            {if $_modx->config.'resources.furniture' == $_modx->resource.parent}
                                {set $conditions['furniture_type'] = $_pls['furniture_type.value']}
                            {/if}
                            {$_modx->runSnippet('@FILE snippets/dmProductOptions.php', [
                                'conditions' => $conditions,
                                'currentOptionValue' => $_pls['mscolor.value'],
                                'optionKey' => 'mscolor',
                                'optionLabel' => 'Другие цвета',
                                'withImage' => true,
                                'tpl' => '@FILE chunks/product.otherColorOfTheModel.item.tpl',
                                'tplWrapper' => '@FILE chunks/product.otherColorOfTheModel.wrapper.tpl',
                            ])}
                            <meta itemprop="description" content="{$_modx->resource.description ?: $_modx->resource.longtitle | escape}" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <section class="mt-2">

        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-6 push-lg-6 mt-4">
                    {$_modx->getChunk('@FILE chunks/tpl.product.propertiesAndReviews.tpl', ['reviewsCount' => $reviewsCount])}
                </div>
                <div class="col-lg-6 pull-lg-6 col-md-12 px-0 pr-lg-3 mt-4 wow fadeIn" data-wow-delay="0.4s" style="visibility: visible; animation-delay: 0.4s; animation-name: fadeIn;">
                    {$_modx->getChunk('@FILE chunks/card.koupon.tpl')}
                </div>
            </div>
        </div>
    </section>
    <section>
        <div class="container-fluid">
            <div class="row mt-3">
                <div class="col-lg-6 col-md-12 px-0 pr-lg-3 wow fadeIn" data-wow-delay="0.4s" style="visibility: visible; animation-delay: 0.4s; animation-name: fadeIn;">
                    {$_modx->getChunk('@FILE chunks/card.marketing.tpl')}
                </div>
                {$_modx->RunSnippet('!msProducts', [
                    'tpl' => '@FILE chunks/product.discount.item.tpl',
                    'parents' => 0,
                    'where' => '{"Data.favorite": "1"}',
                    'sortby' => 'RAND()',
                    'limit' => 1,
                ])}
            </div>
        </div>
    </section>
    {$_modx->getChunk('@FILE chunks/sect.servicedesk.tpl')}
    {$_modx->getChunk('@FILE chunks/sect.360.tpl')}
{/block}
