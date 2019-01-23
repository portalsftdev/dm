{extends 'template:base'}
{block 'content'}
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
                        <div class="container pt-4 pb-1">
                            <div class="row">
                                <div class="col">
                                    <h1 class="expo-title{if $_modx->resource.parent in [$_modx->config.'resources.room_doors', $_modx->config.'resources.steel_doors']} model{/if}">{$_modx->runSnippet('!msProductOptions', ['tpl' => '@INLINE {$options.model.value[0]}', 'onlyOptions' => 'model'])} ({$_pls['vendor.name'] | escape})</h1>
                                    <meta itemprop="name" content="{$_modx->resource.pagetitle | escape}" />
                                    <link itemprop="url" href="{$_modx->config.site_url ~ $_modx->resource.uri}" />
                                    <meta itemprop="model" content="{$_pls['model.value'] | escape}" />
                                </div>
                                <div class="col">
                                    <div class="row mx-0">
                                        <div>
                                            <a class="no_underline" title="{$_pls['vendor.name'] | escape}" href="{$_modx->makeUrl($_modx->resource.parent, '', ['trademark' => $vendor | escape])}"><img src="{$_pls['vendor.logo']}" class="expo-logo" alt="Бренд «{$_pls['vendor.name'] | escape}»"></a>
                                            <meta itemprop="brand" content="{$_pls['vendor.name'] | escape}" />
                                        </div>
                                        {if $_pls['vendor.name'] == 'Фрегат'}
                                         <div id="lg-serts">
                                            <a href="/assets/i/sert1a.jpg" class="no_underline">
                                                <img src="/assets/i/sert.jpg" class="expo-sert float-right ml-2" alt="Сертификат соответствия">
                                            </a>
                                        </div>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="container">
                            <div class="row">
                                <div class="col-6 product-buttons-container">
                                    {if $price == 0}
                                        <div class="mb-3" data-toggle="modal" data-target="#product-price-order"><i class="btn-icon btn-icon-dvmk icon-phone text-primary"></i><a class="c-pointer">Запросить цену</a></div>
                                        <input type="hidden" name="pagetitle" value="{$_modx->resource.pagetitle | escape}" />
                                        {$_modx->getChunk('@FILE chunks/modal.productPriceOrder.tpl')}
                                    {else}
                                        <div>
                                            Цена <span class="label-price">за полотно</span>{if $old_price > 0}&nbsp;<span class="expo-price-old"><del><span class="ms2-old_price">{$old_price}</span>&nbsp;<span class="icon-rub"></span></del></span>{/if}
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
                                        'tpl' => '@FILE chunks/product.option.size.item.tpl',
                                        'tplWrapper' => '@FILE chunks/product.option.size.wrapper.tpl',
                                        'productAvailabilityToPlaceholder' => 'productAvailability',
                                        'productAvailabilityTpl' => '@INLINE <div class="product-availability-divider{if $class} {$class}{/if}"></div>',
                                        'productAvailabilityTplWrapper' => '@INLINE <div class="row mb-2"><div class="col-6">{$optionValues.width}x{$optionValues.height}</div><div class="col-6 text-right pr-4"><div class="product-availability d-inline-flex pl-2" data-toggle="tooltip" data-placement="left" title="{$title}" data-trigger="hover">{$items}</div></div></div>',
                                        'availabilityLevels' => 3,
                                        'availabilityDividers' => 5,
                                        'levelOptions' => $availabilityLevelOptions,
                                    ])}
                                    <div class="product-buttons">
                                        <button type="button" class="btn btn-dvmk mb-3 mr-3 waves-effect waves-light product-size-toggle" data-show="#product-sizes" data-hide=".product-buttons" aria-expanded="false"><span class="icon-cart"></span> В корзину</button>
                                        <div class="tab-open c-pointer" data-target="#product-availability"><a class="btn-icon btn-icon-dvmk icon-info-circled text-primary"></a><a>Уточнить наличие</a></div>
                                        <div>
                                            {$_modx->getChunk('@FILE chunks/tpl.product.favoriteLink.tpl')}
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 mt-4">
                                    {*$_modx->runSnippet('!msOptions', ['tpl' => '@FILE chunks/tpl.options.select.tpl', 'options' => 'size'])*}
                                    {set $complectation = $_modx->RunSnippet('@FILE snippets/dmComplectation.php', [
                                        'linkName' => 'pogonazh',
                                        'tpl' => '@FILE chunks/product.complectation.item.tpl',
                                        'productNameField' => 'pagetitle',
                                        'mandatoryCount' => true,
                                    ])}
                                    {if $complectation}
                                    <div id="complectation-items" class="pre-scrollable h-rem-12">
                                        {$complectation}
                                    </div>
                                    <div id="expo_custom" class="modal fade" tabindex="-1" role="dialog">
                                        <div class="modal-dialog modal-lg" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="gridModalLabel">Комплектация</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                                </div>
                                              <div class="modal-body">
                                                    <div class="container-fluid bd-example-row">
                                                        <div class="row card-product--small">
                                                            <div class="table-responsive" id="door-complectation">
                                                            <table class="table" id="msCart">
                                                                <tbody>
                                                                    {$_modx->RunSnippet('@FILE snippets/dmComplectation.php', [
                                                                        'linkName' => 'pogonazh',
                                                                        'tpl' => '@FILE chunks/product.complectation.pogonazh.tpl',
                                                                        'complectationAvailabilityToPlaceholder' => 'complectationAvailability',
                                                                        'productAvailabilityTpl' => '@INLINE <div class="product-availability-divider{if $class} {$class}{/if}"></div>',
                                                                        'productAvailabilityTplWrapper' => '@INLINE <div class="row mb-2"><div class="col-6">{$pagetitle}</div><div class="col-6 text-right pr-4"><div class="product-availability d-inline-flex pl-2" data-toggle="tooltip" data-placement="left" title="{$title}" data-trigger="hover">{$items}</div></div></div>',
                                                                        'availabilityLevels' => 3,
                                                                        'availabilityDividers' => 5,
                                                                        'levelOptions' => $availabilityLevelOptions,
                                                                    ])}
                                                                </tbody>
                                                            </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>
                                                    <button type="button" class="btn btn-primary" data-dismiss="modal">Применить</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="button" class="btn btn-outline-dvmk waves-effect waves-light mt-2" data-toggle="modal" data-target="#expo_custom">Список комплектующих</button>
                                    {/if}
                                </div>
                            </div>
                            <hr>
                            {$_modx->runSnippet('@FILE snippets/dmProductOptions.php', [
                                'conditions' => [
                                    'parent' => $_modx->resource.parent,
                                    'vendor' => $vendor,
                                    'model' => $_pls['model.value'],
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
                            <meta itemprop="description" content="{$_modx->resource.description ?: $_modx->resource.longtitle | escape}" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    {set $link = $_modx->runSnippet('@FILE snippets/msGetLinkByName.php', ['name' => 'furniture'])}
    {if false != $link}
        {$_modx->runSnippet('!msProducts', [
            'master' => $_modx->resource.id,
            'link' => $link->get('id'),
            'parents' => 0,
            'tplWrapper' => '@FILE chunks/product.jointProductSlider.wrapper.tpl',
            'tpl' => '@FILE chunks/product.jointProductSlider.item.tpl',
            'limit' => 100,
        ])}
    {/if}

    <section class="mt-2">

        <div class="container-fluid">
            <div class="row">
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
