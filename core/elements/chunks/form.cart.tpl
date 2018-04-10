    <section class="py-4">

        <!--<div class="container-fluid">-->
            <!--<h3 class="doc-title"><span>Новинки</span></h3>-->

        <!--</div>-->

        <div class="container" id="msCart">

            <h1>Корзина покупок</h1>

            {if count($products) == 0}
                <div style="margin:7rem 0 10rem;text-align:center;font-size:2rem">Корзина пуста.</div>
            </div>
        </section>
            {else}

            <table class="table table-striped table-hover mt-4">
                <!--<thead>-->
                <!--<tr>-->
                <!--<th class="card-title lead">О товаре</th>-->
                <!--<th class="card-title lead">Количество и сумма</th>-->
                <!--<th class="card-title lead hidden-lg-down">Удалить</th>-->
                <!--</tr>-->
                <!--</thead>-->
                <tbody>
                {foreach $products as $product}
                <tr id="{$product.key}" class="cart-item">
                    <td>
                        <div class="card-product card-product--small px-3{if $product.'type_of_goods.value' == 'Фурнитура'} furniture{/if}">
                                <div class="d-inline-block align-top mr-4 {if $product.'type_of_goods.value' == 'Фурнитура'}w-rem-12{else}w-rem-20{/if}">
                                    <div class="overlay-door mb-3{if !$product.thumb} no-photo{/if}">
                                        <div class="mask mask-door">
                                            <a href="{$product.id | url}">
                                            {if $product.thumb?}
                                                <img src="{$product.thumb}" alt="{$product.pagetitle | escape}" title="{$product.pagetitle | escape}"/>
                                            {else}
                                                <img style="width:150px;" src="{$_modx->config.assets_url}images/no-photo.png" alt="{$product.pagetitle | escape}" title="{$product.pagetitle | escape}"/>
                                            {/if}
                                            </a>
                                        </div>
                                    </div>
                                    <div class="card-block">
                                        <a href="{$product.id | url}" class="card-title">{$product.pagetitle}</a>
                                        {if $product.'type_of_goods.value' == 'Межкомнатные двери'}
                                        <div class="mt-2">
                                            Размер: {$product.'width.value'}х{$product.'height.value'}
                                        </div>
                                        <div class="card-description">
                                            Покрытие: {$product.'cover.value'}<br>
                                            Цвет: {$product.'mscolor.value'}
                                        </div>
                                        {/if}
                                    </div>
                                </div>
                                <div class="d-inline-block">
                                    <div class="d-inline-block align-top mr-4">
                                        <div>Количество</div>
                                        <form method="post" class="ms2_form" role="form">
                                            <input type="hidden" name="key" value="{$product.key}"/>
                                            <input type="number" class="form-control form-control-sm form-control--border w-rem-4 mb-3 mr-2 d-inline-block" value="{$product.count}" min="0" step="{if $product.'molding_type.value' == 'Короб' || $product.'molding_type.value' == 'Наличник'}0.2{else}1{/if}" name="count" placeholder="">
                                            <button type="submit" name="ms2_action" value="cart/change" style="display:none;"></button>
                                            <div class="card-price d-inline-block">
                                                x&nbsp;<span class="price ms2_product_price">{$product.price}</span>&nbsp;<span class="icon-rub"></span>
                                            </div>
                                            {$_modx->RunSnippet('!msAddLinked.info', [
                                                'key' => $product.key,
                                                'option' => $product.options.msal,
                                            ])}
                                        </form>
                                    </div>
                                </div>
                                <div class="d-inline-block align-top ml-4 float-right">
                                    <div class="lead">Итого</div>
                                    <div class="d-inline-block h3">
                                        <span class="price ms2_total_row_cost">{$product.cost}</span>&nbsp;<span class="icon-rub"></span>
                                    </div>
                                    <!--<div><button type="button" class="btn btn-sm btn-outline-secondary mt-3"><span class="icon-close"></span>Удалить</button></div>-->
                                </div>
                                <div class="d-inline-block float-right">
                                    <!--<button type="button" class="btn btn-outline-secondary icon-close mt-3 "> Удалить</button>-->
                                    <form method="post" class="ms2_form" role="form">
                                        <input type="hidden" name="key" value="{$product.key}">
                                        <button type="submit" name="ms2_action" value="cart/remove" class="btn btn-sm btn-outline-secondary mt-3"><span class="icon-close"></span>Удалить</button>
                                    </form>
                                </div>
                        </div>
                    </td>
                </tr>
                {/foreach}
                <!--<tr>-->
                    <!--<td>-->
                        <!--<div class="card-product card-product&#45;&#45;small">-->
                            <!--<div class="overlay-door mb-3">-->
                                <!--<div class="mask mask-door">-->
                                    <!--<a href=""><img src="/assets/images/doors/d6.jpg"></a>-->
                                <!--</div>-->
                            <!--</div>-->
                            <!--<div class="card-block">-->
                                <!--<a href="" class="card-title">Верона 12ДГ</a>-->
                                <!--<div class="mt-2">-->
                                    <!--Размер: 2000х600-->
                                <!--</div>-->
                                <!--<div class="card-description">-->
                                    <!--Покрытие: Экошпон<br>-->
                                    <!--Цвет: Белый глянец-->
                                <!--</div>-->
                            <!--</div>-->
                        <!--</div>-->
                    <!--</td>-->
                    <!--<td>-->
                        <!--<div class="card-product card-product&#45;&#45;small">-->
                            <!--<div class="row">-->
                                <!--<div class="col-md-6 col-12">-->
                                    <!--<div class="lead">Полотно</div>-->
                                    <!--<input type="number" class="form-control form-control&#45;&#45;border w-rem-6 mb-3 mr-2 d-inline-block" value="1" placeholder="">-->
                                    <!--<div class="card-price d-inline-block">-->
                                        <!--x&nbsp;<span class="price">8&nbsp;399</span>&nbsp;- -->
                                    <!--</div>-->
                                    <!--<div class="lead">Доборы 150мм</div>-->
                                    <!--<input type="number" class="form-control form-control&#45;&#45;border w-rem-6 mb-3 mr-2 d-inline-block" value="2" placeholder="">-->
                                    <!--<div class="card-price d-inline-block">-->
                                        <!--x&nbsp;<span class="price">1&nbsp;399</span>&nbsp;- -->
                                    <!--</div>-->
                                <!--</div>-->
                                <!--<div class="col-md-6 col-12">-->
                                    <!--<div class="lead">Короб</div>-->
                                    <!--<input type="number" class="form-control form-control&#45;&#45;border w-rem-6 mb-3 mr-2 d-inline-block" value="1" placeholder="">-->
                                    <!--<div class="card-price d-inline-block">-->
                                        <!--x&nbsp;<span class="price">1&nbsp;399</span>&nbsp;- -->
                                    <!--</div>-->
                                    <!--<div class="lead">Наличники</div>-->
                                    <!--<input type="number" class="form-control form-control&#45;&#45;border w-rem-6 mb-3 mr-2 d-inline-block" value="2" placeholder="">-->
                                    <!--<div class="card-price d-inline-block">-->
                                        <!--x&nbsp;<span class="price">2&nbsp;399</span>&nbsp;- -->
                                    <!--</div>-->
                                <!--</div>-->
                            <!--</div>-->
                            <!--<div class="row">-->
                                <!--<div class="col">-->
                                    <!--<div class="lead">Итого</div>-->
                                    <!--<div class="card-price d-inline-block">-->
                                        <!--<span class="price">13&nbsp;399</span>&nbsp;- -->
                                    <!--</div>-->
                                <!--</div>-->
                                <!--<div class="col hidden-xl-up">-->
                                    <!--<div class="lead">Удалить</div>-->
                                    <!--<button type="button" class="btn btn-outline-secondary icon-close mt-3"></button>-->
                                <!--</div>-->
                            <!--</div>-->
                        <!--</div>-->

                    <!--</td>-->
                    <!--<td class=" hidden-lg-down">-->
                        <!--<button type="button" class="btn btn-outline-secondary icon-close mt-3"></button>-->
                    <!--</td>-->
                <!--</tr>-->
                </tbody>
                <tfoot>
                <tr>
                    <th class="card-title lead">
                        <div id="cartClean">
                            <form class="ms2_form">
                                <button type="submit" name="ms2_action" value="cart/clean" class="btn btn-secondary">Очистить корзину</button>
                            </form>
                        </div>
                        <div class="text-right">
                            <strong>Итого</strong>
                            <div class="card-price d-inline-block ml-3 ">
                                <div class="h2"><span class="price ms2_total_cost">{$total.cost}</span><span class="icon-rub"></span> </div>
                            </div>
                        </div>
                    </th>
                </tr>
                </tfoot>
            </table>
        </div>
    </section>
{/if}
