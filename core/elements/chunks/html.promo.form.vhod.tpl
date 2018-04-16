<div class="row">
    <div class="col-12">
        <h5>Отделка снаружи</h5>
        {$_modx->getPlaceholder('mFilter2.msoc|steel_door_color')}
    </div>
    <div class="col-12">
        <h5>Цвет внутри</h5>
        {$_modx->getPlaceholder('mFilter2.msoc|shield_color')}
    </div>
    <div class="col-6 col-lg-3 pre-scrollable-container">
        <h5>Бренд</h5>
        <div class="gr-white-l h-rem-10 pre-scrollable">
            {$_modx->getPlaceholder('mFilter2.msvendor|name')}
        </div>
    </div>
    <div class="col-6 col-lg-2 pre-scrollable-container">
        <h5>Металл</h5>
        <div class="gr-white-l h-rem-10 pre-scrollable">
            {$_modx->getPlaceholder('mFilter2.msoption|metal_thickness')}
        </div>
    </div>
    <div class="col-6 col-lg-2 pre-scrollable-container">
        <h5>Ширина</h5>
        <div class="gr-white-l h-rem-10 pre-scrollable">
            {$_modx->getPlaceholder('mFilter2.msoption|width')}
        </div>
    </div>
    <div class="col-6 col-lg-3 pre-scrollable-container">
        <h5>Сторонность</h5>
        <div class="gr-white-l h-rem-10 pre-scrollable">
            {$_modx->getPlaceholder('mFilter2.msoption|spontaneity')}
        </div>
        <h5>
            <input id="mse2_vhod_ms|favorite_1" name="ms|favorite" value="1" type="checkbox" />
            <label for="mse2_vhod_ms|favorite_1">Акция месяца</label>
        </h5>
    </div>
</div>
