<form method="POST" action="{$_modx->makeUrl($_modx->resource.id)}" class="product-availability">
    <div class="col-12">
        <input type="tel" name="phone" class="form-control form-control--border w-rem-16 mb-3 btn-right" placeholder="+7 (___) ___-_____">
        <button type="submit" class="btn btn-primary">Уточнить</button>
        <span class="error_phone"></span>
    </div>
</form>