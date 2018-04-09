<div>
    <form class="ms2_form" method="post" data-link-name="[[+linkName]]" data-id="[[+id]]">
        <input type="hidden" name="id" value="[[+id]]" />
        <input type="hidden" name="count" value="[[+count]]" />
        <input type="hidden" name="options" value="[]" />
        [[+cartKey:notempty=`<input type="hidden" name="key" value="[[+cartKey]]" />`]]
        <input id="complectation-item-[[+id]]" class="price-option" type="checkbox"[[+inCart:is=`1`:then=` checked`]]>
        <label for="complectation-item-[[+id]]">
            [[+productName]] <strong>+[[+price]]<span class="icon-rub"></span></strong>
        </label>
        <button type="submit" name="ms2_action" style="display:none;" value="[[+inCart:is=`1`:then=`cart/remove`:else=`cart/add`]]"></button>
    </form>
</div>
