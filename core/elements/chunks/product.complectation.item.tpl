<div>
    <form class="ms2_form" method="post" data-link-name="{$linkName}" data-id="{$id}">
        <input type="hidden" name="id" value="{$id}" />
        <input type="hidden" name="count" value="{$count}" />
        <input type="hidden" name="options" value="[]" />
        {if '' != $cartKey}<input type="hidden" name="key" value="{$cartKey}" />{/if}
        <input id="complectation-item-{$id}" class="price-option" type="checkbox"{if $inCart} checked{/if}>
        <label for="complectation-item-{$id}">
            {$productName} <strong>+{$price}<span class="icon-rub"></span></strong>
        </label>
        <button type="submit" name="ms2_action" class="d-none" value="{if $inCart}cart/remove{else}cart/add{/if}"></button>
    </form>
</div>
