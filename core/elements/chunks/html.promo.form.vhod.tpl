<div class="row">
    <div class="col-12">
        <h5>Отделка снаружи</h5>
        {$_modx->getPlaceholder('mFilter2.msoc|steel_door_color')}
    </div>
    <div class="col-12">
        <h5>Цвет внутри</h5>
        {$_modx->getPlaceholder('mFilter2.msoc|shield_color')}
    </div>

    <!--<div class="col-4">-->
    <!--<h4>Технологии</h4>-->
    <!--<div><input type="checkbox" id="vhod_style0"><label for="vhod_style0">Скрытые петли</label></div>-->
    <!--<div><input type="checkbox" id="vhod_style01"><label for="vhod_style01">Антивандальное покрытие</label></div>-->
    <!--<div><input type="checkbox" id="vhod_style02"><label for="vhod_style02">Усиленная теплоизоляция</label></div>-->
    <!--</div>-->
    <div class="col-6 col-lg-3 pre-scrollable-container">
        <h5>Бренд</h5>
        <div class="gr-white-l h-rem-10 pre-scrollable">
            {$_modx->getPlaceholder('mFilter2.msvendor|name')}
        </div>
    </div>
    <div class="col-6 col-lg-2 pre-scrollable-container">
        <h5>Металл</h5>
        <!--<div><input type="checkbox" id="vhod_cover0"><label for="vhod_cover0">0,4мм</label></div>-->
        <div class="gr-white-l h-rem-10 pre-scrollable">
            {$_modx->getPlaceholder('mFilter2.msoption|metal_thickness')}
        </div>
    </div>
    <div class="col-xl-2 col-lg-3 col-md-4 col-6">
        <h5>
            <input id="mse2_vhod_ms|favorite_1" name="ms|favorite" value="1" type="checkbox" />
            <label for="mse2_vhod_ms|favorite_1">Акция месяца</label>
        </h5>
    </div>
<!--     <div class="col-12 col-lg-5">
    <h5>Цена</h5>
    <div><input type="radio" id="vhod_price0" name="ms|price" value="0,7000"><label for="vhod_price0">до 7 000&nbsp;<span class="icon-rub"></span></label></div>
    <div><input type="radio" id="vhod_price1" name="ms|price" value="7000,10000"><label for="vhod_price1">от 7 000 до 10 000&nbsp;<span class="icon-rub"></span></label></div>
    <div><input type="radio" id="vhod_price2" name="ms|price" value="10000,15000"><label for="vhod_price2">от 10 000 до 15 000&nbsp;<span class="icon-rub"></span></label></div>
    <div><input type="radio" id="vhod_price3" name="ms|price" value="15000,25000"><label for="vhod_price3">от 15 000 до 25 000&nbsp;<span class="icon-rub"></span></label></div>
    <div><input type="radio" id="vhod_price4" name="ms|price" value="25000,1000000"><label for="vhod_price4">от 25 000&nbsp;<span class="icon-rub"></span></label></div>
</div> -->
</div>
