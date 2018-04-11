<div class="msearch2" id="mse2_mfilter">
    <div class="card container-fluid bg-faded">
        <div class="container">
            <div class="row">
                <div class="col py-2">
                    {$_modx->getChunk('@FILE chunks/html.search.tpl', ['local' => 0])}
                </div>
            </div>
        </div>
    </div>
    {if $_modx->resource.id != 5 && $_modx->resource.parent != 31}
    <div class="card container-fluid bg-faded pt-3">
        <form action="{$_modx->makeUrl($_modx->resource.id)}" method="post" id="mse2_filters">
            <div class="container ">
                {if $_modx->resource.id == 6}
                <div class="row">
                    <div class="mx-3">
                        <h5>Отделка снаружи</h5>
                        {$_modx->getPlaceholder('mFilter2.msoc|steel_door_color')}
                    </div>
                </div>
                <div class="row">
                    <div class="mx-3">
                        <h5>Цвет внутри</h5>
                        {$_modx->getPlaceholder('mFilter2.msoc|shield_color')}
                    </div>
                </div>
                <div class="row">
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Бренд</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.msvendor|name')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Металл</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.msoption|metal_thickness')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>
                            <input id="mse2_ms|favorite_1" name="ms|favorite" value="1" class="" type="checkbox"{if $.get.'ms|favorite' == 1} checked{/if} />
                            <label for="mse2_ms|favorite_1">Акция месяца</label>
                        </h5>
                    </div>
                </div>
                {elseif $_modx->resource.id == 7}
                <div class="row">
                    <div class="mx-3">
                        <h5>Цвет</h5>
                        {$_modx->getPlaceholder('mFilter2.msoc|mscolor')}
                    </div>
                </div>
                <div class="row">
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Бренд</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.msvendor|name')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Покрытие</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.msoption|cover')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Ширина</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.msoption|width')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Тип исполнения</h5>
                        {$_modx->getPlaceholder('mFilter2.msoption|doortype')}
                        {set $withGlass = strpos($.get.'msoption|doortype', 'Остекленная') !== false}
                        <div class="switchable-filter mt-2" id="glass-colors"{if $withGlass} style="display:block;"{/if}>
                            <h5>Цвет остекления</h5>
                            {$_modx->getPlaceholder('mFilter2.msoc|glass')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>
                            <input id="mse2_ms|favorite_1" name="ms|favorite" value="1" type="checkbox"{if $.get.'ms|favorite' == 1} checked{/if} />
                            <label for="mse2_ms|favorite_1">Акция месяца</label>
                        </h5>
                    </div>
                    {*<div>
                        <h5>Цена</h5>
                        {set $price = $.get.'ms|price'}
                        <div><input type="radio" id="price0" name="ms|price" value="0,7000"{if $price == '0,7000'} checked{/if}><label for="price0">до 7 000&nbsp;<span class="icon-rub"></span></label></div>
                        <div><input type="radio" id="price1" name="ms|price" value="7000,10000"{if $price == '7000,10000'} checked{/if}><label for="price1">от 7 000 до 10 000&nbsp;<span class="icon-rub"></span></label></div>
                        <div><input type="radio" id="price2" name="ms|price" value="10000,15000"{if $price == '10000,15000'} checked{/if}><label for="price2">от 10 000 до 15 000&nbsp;<span class="icon-rub"></span></label></div>
                        <div><input type="radio" id="price3" name="ms|price" value="15000,25000"{if $price == '15000,25000'} checked{/if}><label for="price3">от 15 000 до 25 000&nbsp;<span class="icon-rub"></span></label></div>
                        <div><input type="radio" id="price4" name="ms|price" value="25000,1000000"{if $price == '25000,1000000'} checked{/if}><label for="price4">от 25 000&nbsp;<span class="icon-rub"></span></label></div>
                    </div>*}
                </div>
                {elseif $_modx->resource.id == 8}
                <div class="row">
                    <div class="mx-3">
                        <h5>Цвет</h5>
                        {$_modx->getPlaceholder('mFilter2.msoc|mscolor')}
                    </div>
                </div>
                <div class="row">
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Бренд</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.msvendor|name')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Вид фурнитуры</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.msoption|furniture_type')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>
                            <input id="mse2_ms|favorite_1" name="ms|favorite" value="1" type="checkbox"{if $.get.'ms|favorite' == 1} checked{/if} />
                            <label for="mse2_ms|favorite_1">Акция месяца</label>
                        </h5>
                    </div>
                </div>
                {/if}
                <div class="row" id="mfilter-reset-row">
                    <button type="reset" class="btn btn-secondary waves-effect waves-light">Очистить все</button>
                </div>
            </div>
        </form>
    </div>
    {/if}

    <div class="container py-3">
        <div id="mse2_sort" class="sorts text-uppercase">
            {set $sortBy = $_modx->getPlaceholder('mse2_sort')}
            <span class="small">Сортировать по:</span>
            <span class="ml-3 font-weight-bold">{if strpos($sortBy, 'ms_product|pagetitle') !== false}{if strpos($sortBy, 'asc')}↓{else}↑{/if}{/if}</span><a href="#" data-sort="ms_product|pagetitle" data-dir="{if $mse2_sort == 'ms_product|pagetitle:desc'}desc{/if}" data-default="asc" class="sort small{if strpos($sortBy, 'ms_product|pagetitle') !== false} active{/if}">Названию</a>
            {if $_modx->resource.id == 7}
            <span class="ml-3 font-weight-bold">{if strpos($sortBy, 'msoc|value') !== false}{if strpos($sortBy, 'asc')}↓{else}↑{/if}{/if}</span><a href="#" data-sort="msoc|value" data-dir="{if $mse2_sort == 'msoc|value:desc'}desc{/if}" data-default="asc" class="sort small{if strpos($sortBy, 'msoc|value') !== false} active{/if}">Цвету</a>
            {/if}
            <span class="ml-3 font-weight-bold">{if strpos($sortBy, 'ms|price') !== false}{if strpos($sortBy, 'asc')}↓{else}↑{/if}{/if}</span><a href="#" data-sort="ms|price" data-dir="{if $mse2_sort == 'ms|price:desc'}desc{/if}" data-default="asc" class="sort small{if strpos($sortBy, 'ms|price') !== false} active{/if}">Цене</a>
        </div>
    </div>

    <section class="px-3 pb-2">
        <div class="container-fluid">

            <div class="row" id="mse2_results">
                {$_modx->getPlaceholder('mFilter2.results')}
	        </div>

	        {$_modx->getChunk('@FILE chunks/modal.productPriceOrder.tpl')}

            <div class="row mt-4">
                <nav class="m-auto mse2_pagination">
                    {$_modx->getPlaceholder('page.nav')}
                </nav>
    	    </div>

        </div>
    </section>
</div>
