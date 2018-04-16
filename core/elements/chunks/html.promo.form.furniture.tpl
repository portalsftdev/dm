<div class="row">
    <div class="col-12 mt-2">
        <h5>Цвет</h5>
        {$_modx->getPlaceholder('mFilter2.msoc|mscolor')}
    </div>
    <div class="col-6 col-lg-3 mt-2 pre-scrollable-container">
        <h5>Бренд</h5>
        <div class="gr-white-l h-rem-10 pre-scrollable">
            {$_modx->getPlaceholder('mFilter2.msvendor|name')}
        </div>
    </div>
    <div class="col-6 col-lg-3 mt-2 pre-scrollable-container">
        <h5>Вид фурнитуры</h5>
        <div class="gr-white-l h-rem-10 pre-scrollable">
            {$_modx->getPlaceholder('mFilter2.msoption|furniture_type')}
        </div>
    </div>
    <div class="col-6 col-lg-3 mt-2 pre-scrollable-container">
        <h5>
            <input id="mse2_furniture_ms|favorite_1" name="ms|favorite" value="1" type="checkbox" />
            <label for="mse2_furniture_ms|favorite_1">Акция месяца</label>
        </h5>
    </div>
</div>
