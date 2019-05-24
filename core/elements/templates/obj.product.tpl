{extends 'template:base'}
{block 'content'}
    <section itemscope itemtype="http://schema.org/Product" id="product" data-url="{$_modx->resource.uri}">
        <div class="expo">
            <div class="container-fluid">
                <div class="row">
                    {$_modx->setPlaceholder('productImageTitle', $_pls['model.value'] ?: $_modx->resource.pagetitle)}
                    {$_modx->setPlaceholder('productVendorId', $vendor)}
                    {$_modx->setPlaceholder('productVendorName', $_pls['vendor.name'])}
                    {$_modx->setPlaceholder('productVendorLogo', $_pls['vendor.logo'])}
                    {$_modx->runSnippet('!msGallery@PropertySet', [
                        'limit' => 2,
                        'tpl' => '@FILE chunks/tpl.product.expo.tpl',
                        'frontend_css=' => '',
                        'frontend_js' => '',
                    ])}
                    <div class="col-xl-6">
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
                                        <div class="total">
                                            Итого: <span data-value="{$price|replace:' ':''}" class="mr-1 total-sum">{$price}</span><span class="icon-rub"></span>
                                        </div>
                                        <div class="mb-3 description">
                                            Включает стоимость одного полотна (<span id="product-price" data-value="{$price|replace:' ':''}">{$price}</span> р.) и комплектующих (<span class="complectation-sum">0</span> р.).
                                        </div>
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
                                    </div>
                                    <div class="d-inline-block tab-open c-pointer" data-target="#product-availability">
                                        <a class="btn-icon btn-icon-dvmk icon-info-circled text-primary"></a><a>Уточнить наличие</a>
                                    </div>
                                    <div class="d-inline-block">
                                        {$_modx->getChunk('@FILE chunks/tpl.product.favoriteLink.tpl')}
                                    </div>
                                    {set $reviewsCount = $_modx->runSnippet('!ecMessagesCount')}
                                    {* TODO: Add product rating when it'll be necessary. *}
                                    {*
                                        {if 0 != $reviewsCount}
                                            <div class="expo-rating mb-3" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
                                                {$_modx->getChunk('@FILE chunks/tpl.product.rating.tpl', ['reviewsCount' => $reviewsCount])}
                                            </div>
                                        {/if}
                                    *}
                                </div>
                            </div>
                        </div>
                        <meta itemprop="description" content="{$_modx->resource.description ?: $_modx->resource.longtitle|escape}" />
                    </div>
                </div>
            </div>
        </div>
    </section>

    {set $availabilityLevelOptions = '{
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
    }'}
    {set $complectationList = $_modx->RunSnippet('@FILE snippets/dmComplectation.php', [
        'linkName' => 'pogonazh',
        'types' => [
            'Добор',
            'Капитель',
            'Короб',
            'Наличник',
            'Притворная планка',
            'Розетка',
            'Сандрик',
            'Соединитель для добора',
        ],
        'tpl' => '@FILE chunks/product.complectation.pogonazh.tpl',
        'complectationAvailabilityToPlaceholder' => 'complectationAvailability',
        'productAvailabilityTpl' => '@INLINE <div class="product-availability-divider{if $class} {$class}{/if}"></div>',
        'productAvailabilityTplWrapper' => '@INLINE <div class="row mb-2"><div class="col-6">{$pagetitle}</div><div class="col-6 text-right pr-4"><div class="product-availability d-inline-flex pl-2" data-toggle="tooltip" data-placement="left" title="{$title}" data-trigger="hover">{$items}</div></div></div>',
        'availabilityLevels' => 3,
        'availabilityDividers' => 5,
        'levelOptions' => $availabilityLevelOptions,
    ])}
    {set $plinthList = $_modx->RunSnippet('@FILE snippets/dmComplectation.php', [
        'linkName' => 'pogonazh',
        'types' => [
            'Плинтус',
            'Плинтуса',
        ],
        'tpl' => '@FILE chunks/product.complectation.pogonazh.tpl',
        'complectationAvailabilityToPlaceholder' => 'plinthListAvailability',
        'productAvailabilityTpl' => '@INLINE <div class="product-availability-divider{if $class} {$class}{/if}"></div>',
        'productAvailabilityTplWrapper' => '@INLINE <div class="row mb-2"><div class="col-6">{$pagetitle}</div><div class="col-6 text-right pr-4"><div class="product-availability d-inline-flex pl-2" data-toggle="tooltip" data-placement="left" title="{$title}" data-trigger="hover">{$items}</div></div></div>',
        'availabilityLevels' => 3,
        'availabilityDividers' => 5,
        'levelOptions' => $availabilityLevelOptions,
    ])}
    {if $complectationList || $plinthList}
        <section class="container product-complectation">
            <div class="row">
                <div class="col-12">
                    <h4>Список комплектующих</h4>
                    <p class="mt-3">
                        <i class="icon-info-circled mr-1"></i>
                        Рекомендованные комплектующие к полотну: наличник 1 комплект (5 шт.), короб 1 комплект (2.5 шт.).
                    </p>
                    <div class="table-responsive">
                        <table class="table">
                            <tbody>
                                {$complectationList}
                                {if !$plinthList}
                                    {* FIXME: Prevent duplicate code. *}
                                    <tr class="total">
                                        <td>Итого по комплектующим</td>
                                        <td></td>
                                        <td></td>
                                        <td class="text-center">
                                            <span class="complectation-sum">0</span>
                                            <span class="icon-rub"></span>
                                        </td>
                                    </tr>
                                {/if}
                            </tbody>
                        </table>
                    </div>
                    {set $plinthHeader = ($complectationList && $plinthList)
                        ? 'Также представляем вашему вниманию МДФ-плинтусы'
                        : 'Представляем вашему вниманию МДФ-плинтусы'
                    }
                    {if $plinthList}
                        <div class="row no-gutters p-3 bordered-container plinth-promo">
                            <div class="col-12 col-md-6 text-center">
                                <img src="assets/images/plinth.jpg" alt="Плинтусы">
                            </div>
                            <div class="col-12 col-md-6 d-flex align-items-center">
                                <h5 class="h3 text-center">{$plinthHeader}</h5>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table">
                                <tbody>
                                    {$plinthList}
                                    <tr class="total">
                                        <td>Итого по комплектующим</td>
                                        <td></td>
                                        <td></td>
                                        <td class="text-center">
                                            <span class="complectation-sum">0</span>
                                            <span class="icon-rub"></span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    {/if}
                </div>
                <div class="col-6 mt-3 mt-md-0 total-cost-description">
                    <div class="total">
                        Итого: <span data-value="{$price|replace:' ':''}" class="mr-1 total-sum">{$price}</span><span class="icon-rub"></span>
                    </div>
                    <div class="mb-3 description">
                        Включает стоимость одного полотна (<span id="product-price" data-value="{$price|replace:' ':''}">{$price}</span> р.) и комплектующих (<span class="complectation-sum">0</span> р.).
                    </div>
                </div>
                <div class="col-6 mt-3 mt-md-0 text-right">
                    <button type="button" class="btn btn-dvmk waves-effect waves-light mr-lg-2 mb-3 mb-lg-0" data-action="add-to-cart"><span class="icon-cart"></span> В корзину</button>
                    <button type="button" class="btn btn-outline-dvmk waves-effect waves-light" data-toggle="modal" data-target="#measurement-order">Заказать замер</button>
                </div>
            </div>
        </section>
    {/if}

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

    <section class="mt-2">
        <div class="container-fluid">
            <div class="row">
                {$_modx->runSnippet('@FILE snippets/dmProductOptionCombinations.php', [
                    'conditions' => [
                        'parent' => $_modx->resource.parent,
                        'vendor' => $vendor,
                        'model' => $_pls['model.value'],
                        'doorType' => $_pls['doorType.value'],
                        'mscolor' => $_pls['mscolor.value'],
                        'glass' => $_pls['glass.value'],
                    ],
                    'currentOptionValues' => '{
                        "width": "'~$_pls['width.value']~'",
                        "height": "'~$_pls['height.value']~'"
                    }',
                    'optionKeys' => 'width|height',
                    'optionLabel' => 'Размер полотна',
                    'showSingleOption' => true,
                    'tpl' => '',
                    'tplWrapper' => '',
                    'productAvailabilityToPlaceholder' => 'productAvailability',
                    'productAvailabilityTpl' => '@INLINE <div class="product-availability-divider{if $class} {$class}{/if}"></div>',
                    'productAvailabilityTplWrapper' => '@INLINE <div class="row mb-2"><div class="col-6">{$optionValues.width}x{$optionValues.height}</div><div class="col-6 text-right pr-4"><div class="product-availability d-inline-flex pl-2" data-toggle="tooltip" data-placement="left" title="{$title}" data-trigger="hover">{$items}</div></div></div>',
                    'availabilityLevels' => 3,
                    'availabilityDividers' => 5,
                    'levelOptions' => $availabilityLevelOptions,
                ])}
                <div class="col-lg-6 push-lg-6 mt-4">
                    {$_modx->getChunk('@FILE chunks/tpl.product.propertiesAndReviews.tpl', ['ignoreOptions' => 'doorType', 'reviewsCount' => $reviewsCount])}
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
