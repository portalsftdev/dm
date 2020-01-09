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
    {if $_modx->resource.id != $_modx->config.'resources.catalog' && $_modx->resource.parent != $_modx->config.'resources.brands'}
    <div class="card container-fluid bg-faded pt-3{$.session.user_preferences.show_filters ? ' expanded' : ''}" id="filters-collapsible" data-duration="400">
        <form action="{$_modx->makeUrl($_modx->resource.id)}" method="post" id="mse2_filters">
            <div class="container ">
                {if $_modx->resource.id == $_modx->config.'resources.steel_doors'}
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
                {set $withGlass = strpos($.get.'type', 'Остекленная') !== false}
                <div class="row switchable-filter" id="glass-colors"{if $withGlass} style="display:flex;"{/if}>
                    <div class="col-12">
                        <h5>Цвет остекления</h5>
                        {$_modx->getPlaceholder('mFilter2.msoc|glass')}
                    </div>
                </div>
                <div class="row">
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Тип исполнения</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.msoption|doortype')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Бренд</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.ms|vendor')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Металл</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.msoption|metal_thickness')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Ширина</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.msoption|width')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Сторонность</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.msoption|spontaneity')}
                        </div>
                        <h5>
                            <input id="mse2_ms|in-stock" name="in-stock" value="1" class="" type="checkbox"{if $.get.'in-stock' == 1} checked{/if} />
                            <label for="mse2_ms|in-stock">В наличии</label>
                        </h5>
                        <h5>
                            <input id="mse2_ms|favorite_1" name="ms|favorite" value="1" class="" type="checkbox"{if $.get.'ms|favorite' == 1} checked{/if} />
                            <label for="mse2_ms|favorite_1">Акция месяца</label>
                        </h5>
                    </div>
                </div>
                {elseif $_modx->resource.id == $_modx->config.'resources.room_doors'}
                <div class="row">
                    <div class="mx-3">
                        <h5>Цвет</h5>
                        {$_modx->getPlaceholder('mFilter2.msoc|mscolor')}
                    </div>
                </div>
                {set $withGlass = strpos($.get.'type', 'Остекленная') !== false}
                <div class="row switchable-filter" id="glass-colors"{if $withGlass} style="display:flex;"{/if}>
                    <div class="col-12">
                        <h5>Цвет остекления</h5>
                        {$_modx->getPlaceholder('mFilter2.msoc|glass')}
                    </div>
                </div>
                <div class="row">
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Тип исполнения</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.msoption|doortype')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Бренд</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.ms|vendor')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Покрытие</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.msoption|cover')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>Коллекция</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.msoption|collection')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>
                            <input id="mse2_ms|in-stock" name="in-stock" value="1" class="" type="checkbox"{if $.get.'in-stock' == 1} checked{/if} />
                            <label for="mse2_ms|in-stock">В наличии</label>
                        </h5>                        
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
                {elseif $_modx->resource.id == $_modx->config.'resources.furniture'}
                <div class="row">
                    <div class="mx-3">
                        <h5>Цвет</h5>
                        {$_modx->getPlaceholder('mFilter2.msoc|mscolor')}
                    </div>
                </div>
                <div class="row">
                    <div class="col-xl-2 col-lg-3 col-md-4 col-4">
                        <h5>Бренд</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.ms|vendor')}
                        </div>
                    </div>
                    <div class="col-xl-6 col-lg-9 col-md-8 col-8">
                        <h5>Вид фурнитуры</h5>
                        <div class="gr-white-l h-rem-10 mb-3 pre-scrollable">
                            {$_modx->getPlaceholder('mFilter2.msoption|furniture_type')}
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
                        <h5>
                            <input id="mse2_ms|in-stock" name="in-stock" value="1" class="" type="checkbox"{if $.get.'in-stock' == 1} checked{/if} />
                            <label for="mse2_ms|in-stock">В наличии</label>
                        </h5>
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
    <div class="container-fluid">
        <div class="row">
            <div class="mx-auto filter-toggler user-preference" data-target="#filters-collapsible" data-user-preference-key="show_filters" data-user-preference-value="{$.session.user_preferences.show_filters ? 'true' : 'false'}" data-shown-text="Скрыть фильтры" data-hidden-text="Показать фильтры">{$.session.user_preferences.show_filters ? 'Скрыть фильтры' : 'Показать фильтры'}</div>
        </div>
    </div>
    {/if}

    <div class="container py-3">
        <div id="mse2_sort" class="sorts text-uppercase">
            {set $sortBy = $_modx->getPlaceholder('mse2_sort')}
            {set $sortByPagetitle = '' == $sortBy || false !== strpos($sortBy, 'ms_product|pagetitle')}
            <span class="small">Сортировать по:</span>

            <span class="ml-3 font-weight-bold">{if $sortByPagetitle}{if '' == $sortBy || strpos($sortBy, 'asc')}↓{else}↑{/if}{/if}</span><a href="#" data-sort="ms_product|pagetitle" data-dir="{if $mse2_sort == 'ms_product|pagetitle:desc'}desc{elseif $sortByPagetitle}asc{/if}" data-default="asc" class="sort small{if $sortByPagetitle} active{/if}">Названию</a>

            <span class="ml-3 font-weight-bold">{if strpos($sortBy, 'ms|price') === 0}{if strpos($sortBy, 'asc')}↓{else}↑{/if}{/if}</span><a href="#" data-sort="ms|price" data-dir="{if $mse2_sort == 'ms|price:desc'}desc{/if}" data-default="asc" class="sort small{if strpos($sortBy, 'ms|price') === 0} active{/if}">Цене</a>

            {set $availabilitySortField =
                ($_modx->resource.id in [$_modx->config.'resources.room_doors', $_modx->config.'resources.steel_doors'])
                ? 'productGroupRemainSum'
                : 'tv|'~$.session.'cityselector.current_product_remain_tv'
            }
            <span class="ml-3 font-weight-bold">{if strpos($sortBy, $availabilitySortField) !== false}{if strpos($sortBy, 'asc')}↓{else}↑{/if}{/if}</span><a href="#" data-sort="{$availabilitySortField}" data-dir="{if $mse2_sort == $availabilitySortField~':desc'}desc{/if}" data-default="desc" class="sort small{if strpos($sortBy, $availabilitySortField) !== false} active{/if}">Наличию</a>

            <span class="ml-3 font-weight-bold">{if strpos($sortBy, 'availability') !== false}{if strpos($sortBy, 'asc')}↓{else}↑{/if}{/if}</span><a href="#" data-sort="availability:desc,ms|price" data-dir="{if $mse2_sort == 'availability:desc,ms|price:desc'}desc{/if}" data-default="asc" class="sort small{if strpos($sortBy, 'availability') !== false} active{/if}">Цене и наличию</a>
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

            {if '' != $_modx->resource.content && null == $.get.'page' || 1 == $.get.'page'}
                <div class="row mt-3">
                    <div class="col-12">
                        {$_modx->resource.content}
                    </div>
                </div>
            {/if}

        </div>
    </section>
</div>
