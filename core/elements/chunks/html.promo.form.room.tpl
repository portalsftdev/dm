<div class="row">
    <div class="col-12 mt-2">
        <h5>Цвет</h5>
        {$_modx->getPlaceholder('mFilter2.msoc|mscolor')}
    </div>
    <div class="col-12 mt-2">
        <h5>Тип исполнения</h5>
        {$_modx->getPlaceholder('mFilter2.msoption|doortype')}
    </div>
    <div class="col-12 mt-2 switchable-filter" id="glass-colors">
        <h5>Цвет остекления</h5>
        {$_modx->getPlaceholder('mFilter2.msoc|glass')}
    </div>
    <div class="col-6 col-lg-3 mt-2 pre-scrollable-container">
        <h5>Бренд</h5>
        <div class="gr-white-l h-rem-10 pre-scrollable">
            {$_modx->getPlaceholder('mFilter2.msvendor|name')}
        </div>
    </div>
    <div class="col-6 col-lg-3 mt-2 pre-scrollable-container">
        <h5>Покрытие</h5>
        <div class="gr-white-l h-rem-10 pre-scrollable">
            {$_modx->getPlaceholder('mFilter2.msoption|cover')}
        </div>
    </div>
    <div class="col-6 col-lg-2 mt-2 pre-scrollable-container">
        <h5>Ширина</h5>
        <div class="gr-white-l h-rem-10 pre-scrollable">
            {$_modx->getPlaceholder('mFilter2.msoption|width')}
        </div>
    </div>
    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
        <h5>
            <input id="mse2_ms|favorite_1" name="ms|favorite" value="1" type="checkbox" />
            <label for="mse2_ms|favorite_1">Акция месяца</label>
        </h5>
    </div>
    {*<div class="col-6 col-lg-4 mt-2">
        <h5>Цена</h5>
        <div><input type="radio" id="price0" name="ms|price" value="0,7000"><label for="price0">до 7 000&nbsp;<span class="icon-rub"></span></label></div>
        <div><input type="radio" id="price1" name="ms|price" value="7000,10000"><label for="price1">от 7 000 до 10 000&nbsp;<span class="icon-rub"></span></label></div>
        <div><input type="radio" id="price2" name="ms|price" value="10000,15000"><label for="price2">от 10 000 до 15 000&nbsp;<span class="icon-rub"></span></label></div>
        <div><input type="radio" id="price3" name="ms|price" value="15000,25000"><label for="price3">от 15 000 до 25 000&nbsp;<span class="icon-rub"></span></label></div>
        <div><input type="radio" id="price4" name="ms|price" value="25000,1000000"><label for="price4">от 25 000&nbsp;<span class="icon-rub"></span></label></div>
    </div>*}
</div>
