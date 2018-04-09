<form method="POST" action="{$_modx->makeUrl($_modx->resource.id)}" class="product-price-order">
    <div class="col-12">
        <input type="tel" name="phone" class="form-control form-control--border w-rem-16 mb-3 btn-right" placeholder="+7 (___) ___-_____">
        <button type="submit" class="btn btn-primary">Запросить</button>
        <span class="error_phone"></span>
        <input type="hidden" name="product_name" />
    </div>
</form>
