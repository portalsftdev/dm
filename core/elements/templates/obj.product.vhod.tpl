{extends 'template:base'}
{block 'content'}
    {set $nfp = $_modx->config.ms2_price_format|json_decode}
    {set $price = $_modx->resource.id | resource: $.session.'cityselector.current_product_price_tv' | number:0:$nfp.1:$nfp.2}
    <section itemscope itemtype="http://schema.org/Product" id="product" data-url="{$_modx->resource.uri}">
        <div class="expo">
            <div class="container-fluid">
                <div class="row">
                    {$_modx->setPlaceholder('productImageTitle', $_pls['model.value'] ?: $_modx->resource.pagetitle)}
                    {$_modx->runSnippet('!msGallery@PropertySet', [
                    'limit' => 2,
                    'tpl' => '@FILE chunks/tpl.product.expo.tpl',
                    'frontend_css=' => '',
                    'frontend_js' => '',
                    ])}
                    <div class="col-xl-6 ">
                        <div class="container pt-4">
                            <div class="row">
                              <div class="col-12 col-md-6">
                                  <h1 class="mb-3 expo-title">{$_modx->runSnippet('!msProductOptions', ['tpl' => '@INLINE {$options.model.value[0]}', 'onlyOptions' => 'model'])} ({$_pls['vendor.name']|escape})</h1>
                                  <meta itemprop="name" content="{$_modx->resource.pagetitle|escape}" />
                                  <link itemprop="url" href="{$_modx->config.site_url ~ $_modx->resource.uri}" />
                                  <meta itemprop="model" content="{$_pls['model.value']|escape}" />
                                  <div itemscope itemprop="offers" itemtype="http://schema.org/Offer">
                                      <meta itemprop="price" content="{$price|replace:' ':''}" />
                                      <meta itemprop="priceCurrency" content="RUB" />
                                      <link itemprop="availability" href="http://schema.org/InStock" />
                                  </div>
                                  <div class="row">
                                      {$_modx->runSnippet('@FILE snippets/dmProductOptions.php', [
                                          'conditions' => [
                                              'parent' => $_modx->resource.parent,
                                              'vendor' => $vendor,
                                              'model' => $_pls['model.value'],
                                              'doorType' => $_pls['doorType.value'],
                                              'mscolor' => $_pls['mscolor.value'],
                                              'glass' => $_pls['glass.value'],
                                              'height' => $_pls['height.value'],
                                          ],
                                          'currentOptionValue' => $_pls['width.value'],
                                          'optionKey' => 'width',
                                          'optionLabel' => 'Ширина (мм):',
                                          'showSingleOption' => true,
                                          'tpl' => '@FILE chunks/product.otherOptionOfTheModel.item.tpl',
                                          'tplWrapper' => '@FILE chunks/product.otherOptionOfTheModel.wrapper.tpl',
                                      ])}
                                      {$_modx->runSnippet('@FILE snippets/dmProductOptions.php', [
                                          'conditions' => [
                                              'parent' => $_modx->resource.parent,
                                              'vendor' => $vendor,
                                              'model' => $_pls['model.value'],
                                              'doorType' => $_pls['doorType.value'],
                                              'mscolor' => $_pls['mscolor.value'],
                                              'glass' => $_pls['glass.value'],
                                              'width' => $_pls['width.value'],
                                          ],
                                          'currentOptionValue' => $_pls['height.value'],
                                          'optionKey' => 'height',
                                          'optionLabel' => 'Высота (мм):',
                                          'showSingleOption' => true,
                                          'tpl' => '@FILE chunks/product.otherOptionOfTheModel.item.tpl',
                                          'tplWrapper' => '@FILE chunks/product.otherOptionOfTheModel.wrapper.tpl',
                                      ])}
                                      <div class="col-12"><hr></div>
                                      {$_modx->runSnippet('@FILE snippets/dmProductOptions.php', [
                                          'conditions' => [
                                              'parent' => $_modx->resource.parent,
                                              'vendor' => $vendor,
                                              'model' => $_pls['model.value'],
                                              'height' => $_pls['height.value'],
                                              'width' => $_pls['width.value'],
                                              'mscolor' => $_pls['mscolor.value'],
                                          ],
                                          'currentOptionValue' => $_pls['doorType.value'],
                                          'optionKey' => 'doorType',
                                          'tpl' => '@FILE chunks/product.otherOptionOfTheModel.item.tpl',
                                          'tplWrapper' => '@FILE chunks/product.otherOptionOfTheModel.wrapper.tpl',
                                      ])}
                                      {$_modx->runSnippet('@FILE snippets/dmProductOptions.php', [
                                          'conditions' => [
                                              'parent' => $_modx->resource.parent,
                                              'vendor' => $vendor,
                                              'model' => $_pls['model.value'],
                                              'height' => $_pls['height.value'],
                                              'width' => $_pls['width.value'],
                                              'doorType' => $_pls['doorType.value'],
                                              'glass' => $_pls['glass.value'],
                                          ],
                                          'currentOptionValue' => $_pls['mscolor.value'],
                                          'optionKey' => 'mscolor',
                                          'optionLabel' => 'Другие цвета',
                                          'withImage' => true,
                                          'tpl' => '@FILE chunks/product.otherColorOfTheModel.item.tpl',
                                          'tplWrapper' => '@FILE chunks/product.otherColorOfTheModel.wrapper.tpl',
                                      ])}
                                      {if $_pls['doorType.value'] == 'Остекленная'}
                                          {$_modx->runSnippet('@FILE snippets/dmProductOptions.php', [
                                              'conditions' => [
                                                  'parent' => $_modx->resource.parent,
                                                  'vendor' => $vendor,
                                                  'model' => $_pls['model.value'],
                                                  'height' => $_pls['height.value'],
                                                  'width' => $_pls['width.value'],
                                                  'mscolor' => $_pls['mscolor.value'],
                                              ],
                                              'currentOptionValue' => $_pls['glass.value'],
                                              'optionKey' => 'glass',
                                              'optionLabel' => 'Другие остекления',
                                              'withImage' => true,
                                              'tpl' => '@FILE chunks/product.otherColorOfTheModel.item.tpl',
                                              'tplWrapper' => '@FILE chunks/product.otherColorOfTheModel.wrapper.tpl',
                                          ])}
                                      {/if}
                                  </div>
                              </div>
                              <div class="col-12 col-md-6 pb-3">
                                  <div class="mb-3 p-3 text-center rounded bordered-container total-cost-description">
                                    {if $price == 0}
                                        <div class="mb-3" data-toggle="modal" data-target="#product-price-order"><i class="btn-icon btn-icon-dvmk icon-phone text-primary"></i><a class="c-pointer">Запросить цену</a></div>
                                        <input type="hidden" name="pagetitle" value="{$_modx->resource.pagetitle | escape}" />
                                        {$_modx->getChunk('@FILE chunks/modal.productPriceOrder.tpl')}
                                    {else}
                                        <div>
                                            Цена <span class="label-price">за дверь</span>{if $old_price > 0}&nbsp;<span class="expo-price-old"><del><span class="ms2-old_price">{$old_price}</span>&nbsp;<span class="icon-rub"></span></del></span>{/if}
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
                                    <!--{$_modx->runSnippet('@FILE snippets/dmProductOptionCombinations.php', [
                                        'conditions' => [
                                            'parent' => $_modx->resource.parent,
                                            'vendor' => $vendor,
                                            'model' => $_pls['model.value'],
                                            'shield_color' => $_pls['shield_color.value'],
                                            'steel_door_color' => $_pls['steel_door_color.value'],
                                        ],
                                        'currentOptionValues' => '{
                                            "width": "'~$_pls['width.value']~'",
                                            "height": "'~$_pls['height.value']~'",
                                            "spontaneity": "'~$_pls['spontaneity.value']~'"
                                        }',
                                        'optionKeys' => 'width|height|spontaneity',
                                        'optionLabel' => 'Размер двери',
                                        'showSingleOption' => true,
                                        'tpl' => '@FILE chunks/product.option.size.item.tpl',
                                        'tplWrapper' => '@FILE chunks/product.option.size.wrapper.tpl',
                                        'productAvailabilityToPlaceholder' => 'productAvailability',
                                        'productAvailabilityTpl' => '@INLINE <div class="product-availability-divider{if $class} {$class}{/if}"></div>',
                                        'productAvailabilityTplWrapper' => '@INLINE <div class="row mb-2"><div class="col-6">{$optionValues.width}x{$optionValues.height} ({$optionValues.spontaneity})</div><div class="col-6 text-right pr-4"><div class="product-availability d-inline-flex pl-2" data-toggle="tooltip" data-placement="left" title="{$title}" data-trigger="hover">{$items}</div></div></div>',
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
                                    ])}-->

                                    <!-- <div class="product-buttons"> -->
                                        <!-- <button type="button" class="btn btn-dvmk mb-md-3 waves-effect waves-light product-size-toggle" data-show="#product-sizes" data-hide=".product-buttons" aria-expanded="false"><span class="icon-cart"></span> В корзину</button> -->
                                        <!-- <button type="button" class="btn btn-dvmk waves-effect waves-light mb-md-3" data-action="add-to-cart"><span class="icon-cart"></span> В корзину</button> -->
                                        <div class="d-inline d-md-block">
                                            <form class="custom-ms2-form">
                                                <input name="products[{$_modx->resource.id}][count]" type="hidden" value="1">
                                                <input name="products[{$_modx->resource.id}][options]" type="hidden" value="[]">
                                            </form>
                                            <button type="button" class="btn btn-dvmk waves-effect waves-light mb-md-3" data-action="add-to-cart"><span class="icon-cart"></span> В корзину</button>
                                        </div>
                                        <div class="d-inline d-md-block">
                                            <button type="button" class="btn btn-outline-dvmk waves-effect waves-light" data-toggle="modal" data-target="#measurement-order">Заказать замер</button>
                                        </div>
                                        <!--<div class="tab-open c-pointer" data-target="#product-availability"><a class="btn-icon btn-icon-dvmk icon-info-circled text-primary"></a><a>Уточнить наличие</a></div>-->
                                        <!--<div>
                                            {$_modx->getChunk('@FILE chunks/tpl.product.favoriteLink.tpl')}
                                        </div>-->

                                <!--    </div> -->

                              </div>
                                <div class="d-inline-block tab-open c-pointer" data-target="#product-availability">
                                    <a class="btn-icon btn-icon-dvmk icon-info-circled text-primary"></a><a>Уточнить наличие</a>
                                </div>

                                <div class="d-inline-block">
                                    {$_modx->getChunk('@FILE chunks/tpl.product.favoriteLink.tpl')}
                                </div>

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
                            {$_modx->runSnippet('@FILE snippets/dmProductOptions.php', [
                                'conditions' => [
                                    'parent' => $_modx->resource.parent,
                                    'vendor' => $vendor,
                                    'model' => $_pls['model.value'],
                                    'shield_color' => $_pls['shield_color.value'],
                                ],
                                'currentOptionValue' => $_pls['steel_door_color.value'],
                                'optionKey' => 'steel_door_color',
                                'optionLabel' => 'Другие цвета внешнего покрытия',
                                'withImage' => true,
                                'tpl' => '@FILE chunks/product.otherColorOfTheModel.item.tpl',
                                'tplWrapper' => '@FILE chunks/product.otherColorOfTheModel.wrapper.tpl',
                            ])}
                            {$_modx->runSnippet('@FILE snippets/dmProductOptions.php', [
                                'conditions' => [
                                    'parent' => $_modx->resource.parent,
                                    'vendor' => $vendor,
                                    'model' => $_pls['model.value'],
                                    'steel_door_color' => $_pls['steel_door_color.value'],
                                ],
                                'currentOptionValue' => $_pls['shield_color.value'],
                                'optionKey' => 'shield_color',
                                'optionLabel' => 'Другие цвета внутренней панели',
                                'withImage' => true,
                                'tpl' => '@FILE chunks/product.otherColorOfTheModel.item.tpl',
                                'tplWrapper' => '@FILE chunks/product.otherColorOfTheModel.wrapper.tpl',
                            ])}
                            {if 'Остекленная' === $_pls['doorType.value']}
                                {$_modx->runSnippet('@FILE snippets/dmProductOptions.php', [
                                    'conditions' => [
                                        'parent' => $_modx->resource.parent,
                                        'vendor' => $vendor,
                                        'model' => $_pls['model.value'],
                                        'steel_door_color' => $_pls['steel_door_color.value'],
                                        'shield_color' => $_pls['shield_color.value'],
                                    ],
                                    'currentOptionValue' => $_pls['glass.value'],
                                    'optionKey' => 'glass',
                                    'optionLabel' => 'Другие остекления',
                                    'withImage' => true,
                                    'tpl' => '@FILE chunks/product.otherColorOfTheModel.item.tpl',
                                    'tplWrapper' => '@FILE chunks/product.otherColorOfTheModel.wrapper.tpl',
                                ])}
                            {/if}
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
