<tr>
    <td>
        <div class="lead">
            [[+productName]]
            <span class="question-mark-icon" data-toggle="tooltip" data-html="true" data-placement="right" title="<div style='padding:.75rem;text-align:left;text-indent:1rem;'><strong>Дверной добор</strong>&nbsp;&mdash;&nbsp;планка, применяющаяся для продолжения дверной коробки, ширина которой меньше размера толщины стен. Это декораторский прием, выигрышно улучшающий комплексную отделку дверного проема, и сохраняющий целостность композиции двери.<div>"></span>
        </div>
    </td>
    <td>
        <form class="ms2_form" data-link-name="[[+linkName]]" data-id="[[+id]]" method="post">
            <div class="input-group">
                <input name="count" type="number" min="0" step="1" class="form-control form-control-sm form-control--border w-rem-4" value="[[+count]]" placeholder="">
                <span class="input-group-addon form-control-sm form-control--border">шт.</span>
            </div>
            <input type="hidden" name="id" value="[[+id]]">
            [[+cartKey:notempty=`<input type="hidden" name="key" value="[[+cartKey]]" />`]]
            <input name="options" value="[]" type="hidden">
            <button type="submit" name="ms2_action" value="[[+count:is=`0`:then=`cart/add`:else=`cart/change`]]"></button>
        </form>
        </td>
    <td>
        <div class="card-price">
            x&nbsp;<span class="price ms2_product_price">[[+price]]</span>&nbsp;<span class="icon-rub"></span>
        </div>
    </td>
    <td>
        <div class="card-price">
            =&nbsp;<span class="price ms2_total_row_cost">[[+sum]]</span>&nbsp;<span class="icon-rub"></span>
        </div>
    </td>
</tr>