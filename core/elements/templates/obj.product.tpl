{extends 'template:base'}
{block 'content'}
    <section>
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
                                    <h1 class="expo-title">{$_modx->runSnippet('!msProductOptions', ['tpl' => '@FILE /chunks/tpl.customProductOptions.tpl', 'onlyOptions' => 'model'])}</h1>
                                    <p>
                                    {$_modx->runSnippet('!msProductOptions', ['tpl' => '@FILE chunks/tpl.productoptions.p.tpl', 'onlyOptions' => 'pattern,cover'])}
                                    </p>
                                </div>
                                <div class="col">
                                    <div class="row mx-0">
                                        <div>
                                            <!--<img src="/assets/images/brands/brand-zadoor-color.jpg" class="expo-logo" data-toggle="popover" data-placement="bottom" data-html="true" title="<p class='align-left'>Здесь небольшой текст о компании. Буквально два или три предложения без воды, по существу.</p>">-->
                                            <a class="no_underline" data-toggle="popover" data-trigger="hover" data-delay='{ "show": 0, "hide": 1000 }' title="{$_pls['vendor.name']}" data-placement="bottom" data-html="true" data-content="Здесь небольшой текст о компании. Буквально два или три предложения без воды, по существу. Можно <a href=''>со ссылкой</a>"><img src="{$_pls['vendor.logo']}" alt="Бренд «{$_pls['vendor.name'] | escape}»" class="expo-logo"></a>
                                        </div>
                                        {if $_pls['vendor.name'] == 'Фрегат'}
                                         <div id="lg-serts">
<!--                                             <a href="/assets/i/sert2a.jpg" class="no_underline">
    <img src="/assets/i/sert2.jpg" class="expo-sert float-right ml-2" alt="Сертификат соответствия">
</a> -->
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
                                <div class="col-6">
                                    {if $price == 0}
                                        <div style="margin-bottom:1rem;" data-toggle="modal" data-target="#product-price-order"><i class="btn-icon btn-icon-dvmk icon-phone text-primary"></i><a style="cursor:pointer;">Запросить цену</a></div>
                                        <input type="hidden" name="pagetitle" value="{$_modx->resource.pagetitle | escape}" />
                                        {$_modx->getChunk('@FILE chunks/modal.productPriceOrder.tpl')}
                                    {else}
                                        <div class="">
                                            Цена <span class="label-price">за полотно</span>{if $old_price > 0}&nbsp;<span class="expo-price-old"><del><span class="ms2-old_price">{$old_price}</span>&nbsp;<span class="icon-rub"></span></del></span>{/if}
                                        </div>
                                        <div class="expo-price">
                                            <span class="btn-icon btn-icon-dvmk icon-label-o hidden-sm-down"></span><span class="ms2-price" id="price">{$price}</span>&nbsp;<span class="icon-rub"></span>
                                        </div>
                                    {/if}
                                    <form method="post" id="leaf" class="ms2_form">
                                        <button type="submit" name="ms2_action" value="cart/add" class="btn btn-dvmk mb-3 mr-3 waves-effect waves-light"><span class="icon-cart"></span> В корзину</button>
                                        <input type="hidden" name="id" value="{$_modx->resource.id}">
                                        <input type="hidden" name="count" value="1">
                                        <input type="hidden" name="options" value="[]">
                                    </form>
                                    <!--<div class="d-inline-block "><a class="btn-icon btn-icon-dvmk icon-cube text-primary"></a><a class="font-weight-bold no_underline">В наличии</a></div>-->
                                    <!--<div class="d-inline-block py-3"><div class="expo-label m-0">В наличии</div></div>-->
                                    <div data-toggle="modal" data-target="#expo_available"><a class="btn-icon btn-icon-dvmk icon-phone text-primary"></a><a>Уточнить наличие</a></div>
                                    <div>
                                        {$_modx->getChunk('@FILE chunks/tpl.product.favoriteLink.tpl')}
                                    </div>
                                    <!--<a href="" class="btn-icon btn-icon-dvmk icon-print ml-3"></a><a href="">Распечатать</a>-->

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
                                <div class="col-6">
                                    {*$_modx->runSnippet('!msOptions', ['tpl' => '@FILE chunks/tpl.options.select.tpl', 'options' => 'size'])*}
                                    {set $complectation = $_modx->RunSnippet('!dmComplectation', ['linkName' => 'pogonazh', 'tpl' => '@FILE chunks/product.complectation.item.tpl', 'productNameField' => 'pagetitle', 'mandatoryCount' => true])}
                                    {if $complectation}
                                    <div id="complectation-items" class="pre-scrollable h-rem-15">
                                        {$complectation}
                                    </div>
                                    {/if}
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
                                                                    {$_modx->RunSnippet('!productInCartInfo', [
                                                                        'complectationCostPlaceholder' => 'complectationCost',
                                                                    ])}
                                                                    <tr>
                                                                        <td><div class="lead">Полотно</div></td>
                                                                        <td>
                                                                            <form class="ms2_form leaf" method="post">
                                                                                <div class="input-group">
                                                                                    <input name="count" type="number" min="0" step="1" class="form-control form-control-sm form-control--border w-rem-4" value="{$_modx->getPlaceholder('cart.count')}" placeholder="">
                                                                                    <span class="input-group-addon form-control-sm form-control--border">шт.</span>
                                                                                </div>
                                                                                <input type="hidden" name="id" value="{$_modx->resource.id}">
                                                                                {if $_modx->getPlaceholder('cart.key')}
                                                                                    <input type="hidden" name="key" value="{$_modx->getPlaceholder('cart.key')}" />
                                                                                {/if}
                                                                                <input name="options" value="[]" type="hidden">
                                                                                <button type="submit" name="ms2_action" value="cart/{$_modx->getPlaceholder('cart.count') == 0 ? 'add' : 'change'}"></button>
                                                                            </form>
                                                                        </td>
                                                                        <td>
                                                                            <div class="card-price">
                                                                                x&nbsp;<span class="price ms2_product_price">{$price}</span>&nbsp;<span class="icon-rub"></span>
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <div class="card-price">
                                                                                =&nbsp;<span class="price ms2_total_row_cost">{$_modx->getPlaceholder('cart.sum')}</span>&nbsp;<span class="icon-rub"></span>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    {$_modx->RunSnippet('!dmComplectation', ['linkName' => 'pogonazh', 'tpl' => '@FILE chunks/product.complectation.pogonazh.tpl', 'complectationCostPlaceholder' => 'complectationCost'])}
                                                                </tbody>
                                                            </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <div class="card-product--small mr-auto" style="padding-left:12px;">
                                                        <div class="lead">Итого</div>
                                                        <div class="card-price">
                                                            <span class="price ms2_total_cost">{$_modx->getPlaceholder('complectationCost')}</span>&nbsp;<span class="icon-rub"></span>
                                                        </div>
                                                    </div>
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>
                                                    <button type="button" class="btn btn-primary" data-dismiss="modal">Применить</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="button" class="btn btn-outline-dvmk waves-effect waves-light mt-2" data-toggle="modal" data-target="#expo_custom">Список комплектующих</button>
                                </div>
                            </div>
                            <hr>
                            {$_modx->runSnippet('!dmProductOptions', [
                                'conditions' => [
                                    'model' => $_pls['model.value'],
                                    'mscolor' => $_pls['mscolor.value'],
                                ],
                                'currentOptionValue' => $_pls['doorType.value'],
                                'optionKey' => 'doorType',
                                'tpl' => '@FILE chunks/product.otherOptionOfTheModel.item.tpl',
                                'tplWrapper' => '@FILE chunks/product.otherOptionOfTheModel.wrapper.tpl',
                            ])}
                            {$_modx->runSnippet('!dmProductOptions', [
                                'conditions' => [
                                    'model' => $_pls['model.value'],
                                    'doorType' => $_pls['doorType.value'],
                                ],
                                'currentOptionValue' => $_pls['mscolor.value'],
                                'optionKey' => 'mscolor',
                                'optionLabel' => 'Другие цвета',
                                'withImage' => true,
                                'tpl' => '@FILE chunks/product.otherColorOfTheModel.item.tpl',
                                'tplWrapper' => '@FILE chunks/product.otherColorOfTheModel.wrapper.tpl',
                            ])}
                            {if $_pls['doorType.value'] == 'Остекленная'}
                                {$_modx->runSnippet('!dmProductOptions', [
                                    'conditions' => [
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
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <section class="mt-2">

        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-6 push-lg-6 mt-3">
                    <div class="container pt-3">
                        {$_modx->runSnippet('!msProductOptions', ['tpl' => '@FILE chunks/tpl.productoptions.tpl', 'ignoreOptions' => 'doorType'])}
                    </div>
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
