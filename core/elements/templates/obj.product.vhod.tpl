{extends 'template:base'}
{block 'content'}
    <section itemscope itemtype="http://schema.org/Product" id="product">
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
                        <div class="container pt-4 pb-1">
                            <div class="row">
                                <div class="col">
                                    <h1 class="expo-title">{$_modx->runSnippet('!msProductOptions', ['tpl' => '@FILE chunks/tpl.customProductOptions.tpl', 'onlyOptions' => 'model'])}</h1>
                                    <meta itemprop="name" content="{$_modx->resource.pagetitle | escape}" />
                                    <link itemprop="url" href="{$_modx->config.site_url ~ $_modx->resource.uri}" />
                                    <meta itemprop="model" content="{$_pls['model.value'] | escape}" />
                                </div>
                                <div class="col">
                                    <div class="row mx-0">
                                        <div>
                                            <a class="no_underline" title="{$_pls['vendor.name'] | escape}" href="{$_modx->makeUrl($_modx->resource.parent, '', ['msvendor|name' => $_pls['vendor.name'] | escape])}"><img src="{$_pls['vendor.logo']}" class="expo-logo" alt="Бренд «{$_pls['vendor.name'] | escape}»"></a>
                                            <meta itemprop="brand" content="{$_pls['vendor.name'] | escape}" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="container">
                            <div class="row">
                                <div class="col-6" style="margin-top:-1.5rem">
                                    {if $price == 0}
                                        <div style="margin-bottom:1rem;" data-toggle="modal" data-target="#product-price-order"><i class="btn-icon btn-icon-dvmk icon-phone text-primary"></i><a style="cursor:pointer;">Запросить цену</a></div>
                                        <input type="hidden" name="pagetitle" value="{$_modx->resource.pagetitle | escape}" />
                                        {$_modx->getChunk('@FILE chunks/modal.productPriceOrder.tpl')}
                                    {else}
                                        <div>
                                            Цена <span class="label-price">за дверь</span>{if $old_price > 0}&nbsp;<span class="expo-price-old"><del><span class="ms2-old_price">{$old_price}</span>&nbsp;<span class="icon-rub"></span></del></span>{/if}
                                        </div>
                                        <div class="expo-price" itemscope itemprop="offers" itemtype="http://schema.org/Offer">
                                            <span class="btn-icon btn-icon-dvmk icon-label-o hidden-sm-down"></span><span class="ms2-price" id="price" itemprop="price" content="{$price | replace: ' ' : ''}">{$price}</span>&nbsp;<span class="icon-rub"></span>
                                            <meta itemprop="priceCurrency" content="RUB" />
                                            <meta itemprop="availability" href="http://schema.org/InStock" content="В наличии" />
                                        </div>
                                    {/if}
                                    {set $reviewsCount = $_modx->runSnippet('!ecMessagesCount')}
                                    {if 0 != $reviewsCount}
                                        <div class="expo-rating mb-3" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
                                            {$_modx->getChunk('@FILE chunks/tpl.product.rating.tpl', ['reviewsCount' => $reviewsCount])}
                                        </div>
                                    {/if}
                                    {$_modx->runSnippet('@FILE snippets/dmProductOptionCombinations.php', [
                                        'conditions' => [
                                            'model' => $_pls['model.value'],
                                            'shield_color' => $_pls['shield_color.value'],
                                            'steel_door_color' => $_pls['steel_door_color.value'],
                                        ],
                                        'currentOptionValues' => '{
                                            "width": "'~$_pls['width.value']~'",
                                            "height": "'~$_pls['height.value']~'"
                                        }',
                                        'optionKeys' => 'width|height',
                                        'optionLabel' => 'Размер двери',
                                        'showSingleOption' => true,
                                        'tpl' => '@FILE chunks/product.option.size.item.tpl',
                                        'tplWrapper' => '@FILE chunks/product.option.size.wrapper.tpl',
                                    ])}
                                    <div class="product-buttons">
                                        <button type="button" class="btn btn-dvmk mb-3 mr-3 waves-effect waves-light product-size-toggle" data-show="#product-sizes" data-hide=".product-buttons" aria-expanded="false"><span class="icon-cart"></span> В корзину</button>
                                        <div data-toggle="modal" data-target="#expo_available"><a class="btn-icon btn-icon-dvmk icon-phone text-primary"></a><a>Уточнить наличие</a></div>
                                        <div>
                                            {$_modx->getChunk('@FILE chunks/tpl.product.favoriteLink.tpl')}
                                        </div>
                                    </div>
                                    <div id="expo_available" class="modal fade" tabindex="-1" role="dialog" >
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="expo_availableModalLabel">Cрок поставки</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid bd-example-row">
                                                        <div class="row">
                                                            <div class="col-12"><p>Возможный срок поставки в Кемерово <strong>от 3-х дней</strong>. Оставьте ваш контактный номер, мы уточним дату поставки и цену. Менеджер перезвонит вам <strong>в течение часа</strong>.</p></div>
                                                                {$_modx->RunSnippet('!AjaxForm', [
                                                                    'snippet' => 'FormIt',
                                                                    'form' => '@FILE chunks/form.productAvailability.tpl',
                                                                    'hooks' => 'email',
                                                                    'emailTpl' => '@INLINE Здравствуйте. На сайте сделан запрос уточнения наличия товара «' ~ $_modx->resource.pagetitle ~ '». Оставленный пользователем номер телефона: {$phone}',
                                                                    'emailSubject' => $_modx->config.info_company ~ '. Запрос уточнения наличия товара',
                                                                    'emailTo' => $_modx->config.manager_emails,
                                                                    'customValidators' => 'validator.phone',
                                                                    'validate' => 'phone:validator.phone',
                                                                    'validationErrorMessage' => 'Проверьте введенные данные.',
                                                                    'successMessage' => 'Сообщение успешно отправлено.',
                                                                ])}
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            {$_modx->runSnippet('@FILE snippets/dmProductOptions.php', [
                                'conditions' => [
                                    'model' => $_pls['model.value'],
                                    'shield_color' => $_pls['shield_color.value'],
                                    'width' => $_pls['width.value'],
                                    'height' => $_pls['height.value'],
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
                                    'model' => $_pls['model.value'],
                                    'steel_door_color' => $_pls['steel_door_color.value'],
                                    'width' => $_pls['width.value'],
                                    'height' => $_pls['height.value'],
                                ],
                                'currentOptionValue' => $_pls['shield_color.value'],
                                'optionKey' => 'shield_color',
                                'optionLabel' => 'Другие цвета внутренней панели',
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
