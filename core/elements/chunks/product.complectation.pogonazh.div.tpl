{if $menutitle == 'Короб'}
    {set $tooltipText = '<strong>Короб</strong>&nbsp;&mdash;&nbsp;рамочная П-образная конструкция, на которую навешивается дверное полотно. Это неподвижная часть дверного блока, которая прочно закрепляется в стенках дверного проема.'}
    {set $step = 0.2}
    {set $unit = 'к.'}
{elseif $menutitle == 'Наличник'}
    {set $tooltipText = '<strong>Наличники</strong>&nbsp;&mdash;&nbsp;накладные планки, закрывающие стыки и щели между дверной коробкой и стеной. Служат декоративным элементом обрамления двери, бывают плоские, скруглённые, фигурные, телескопические и на шпонке.'}
    {set $step = 0.2}
    {set $unit = 'к.'}
{elseif $menutitle == 'Добор'}
    {set $tooltipText = '<strong>Дверной добор</strong>&nbsp;&mdash;&nbsp;планка, применяющаяся для продолжения дверной коробки, ширина которой меньше размера толщины стен. Это декораторский прием, выигрышно улучшающий комплексную отделку дверного проема, и сохраняющий целостность композиции двери.'}
    {set $step = 1}
    {set $unit = 'шт.'}
{elseif $menutitle == 'Притворная планка'}
    {set $tooltipText = '<strong>Притворная планка</strong>&nbsp;&mdash;&nbsp;это тонкая рейка, расположенная на краю дверного полотна и при закрывании плотно прилегающая к дверной коробке. Без такой планки при закрытых дверях остается зазор, через который в помещение проникают посторонние звуки и сквозняк.'}
    {set $step = 1}
    {set $unit = 'шт.'}
{elseif $menutitle == 'Капитель'}
    {set $tooltipText = '<strong>Капитель</strong>&nbsp;&mdash;&nbsp;декоративный элемент, который служит для обрамления дверного проёма. Капитель используется вместо верхней перекладины наличника.'}
    {set $step = 1}
    {set $unit = 'шт.'}
{elseif $menutitle == 'Сандрик'}
    {set $tooltipText = '<strong>Сандрик</strong>&nbsp;&mdash;&nbsp;это декоративное украшение, которое располагается над дверью или окном, выступает из плоскости стены и помогает подчеркнуть особый стиль всего дома при оформлении фасада декором.'}
    {set $step = 1}
    {set $unit = 'шт.'}
{else}
    {set $tooltipText = 'Нет данных'}
    {set $step = 1}
    {set $unit = 'шт.'}
{/if}
<div class="row no-gutters product-complectation-list-item">
    <div class="col-6 col-md-5 col-lg-6 d-flex align-items-center lead">
        <span class="question-mark-icon mr-2 align-self-baseline align-self-md-center" data-toggle="tooltip" data-html="true" data-placement="right" title="<div class='product-complectation-item-definition'>{$tooltipText}<div>"></span>
        <span>{$productName}</span>
    </div>
    <div class="col-6 col-md-2 d-flex align-items-center justify-content-center">
        <div class="card-price">
            <span class="price ms2_product_price" data-value="{$price|replace:' ':''}">{$price}</span>&nbsp;<span class="icon-rub"></span>
        </div>
    </div>
    {* FIXME: Nested `d-flex align-items-center`. *}
    <div class="col-6 col-md-2 d-flex align-items-center">
        <div class="d-flex align-items-center">
            <div class="input-spinnerable">
                <span class="minus"></span>
                <form class="custom-ms2-form">
                    <input name="products[{$id}][count]" type="text" class="form-control form-control-sm form-control--border{if 'к.' === $unit} increase-from-0-to-1{/if}" value="0" min="0" max="99" step="{$step}" autocomplete="off" data-spinnerable>
                    <input name="products[{$id}][options]" type="hidden" value="[]">
                </form>
                <span class="plus"></span>
            </div>
            <span class="ml-2">{$unit}</span>
        </div>
    </div>
    <div class="col-6 col-md-3 col-lg-2 d-flex align-items-center justify-content-center total-row-cost">
        <div class="card-price">
            <span class="price ms2_total_row_cost" data-value="{$sum|replace:' ':''}">0</span>&nbsp;<span class="icon-rub"></span>
        </div>
    </div>
</div>
