<li class="row mb-3 mb-md-2">
    <div class="col-12 col-md-6">
        {$optionValues.width}x{$optionValues.height}
    </div>
    <form method="post" class="ms2_form col-12 col-md-6">
        <div class="input-group">
            <div class="input-group-prepend">
                <button type="button" class="btn btn-secondary" data-spin="minus"><span>–</span></button>
            </div>
            <input type="hidden" name="id" value="{$productId}">
            <input type="number" class="form-control no-spinners" placeholder="0" name="count" min="0" step="1" value="{$productCartCount}">
            <input type="hidden" name="options" value="[]">
            {if $productCartKey}<input type="hidden" name="key" value="{$productCartKey}">{/if}
            <button type="submit" name="ms2_action" value="{0 < $productCartCount ? 'cart/change' : 'cart/add'}" class="d-none"></button>
            <div class="input-group-append">
                <button type="button" class="btn btn-secondary" data-spin="plus">+</button>
            </div>
        </div>
    </form>
</li>
