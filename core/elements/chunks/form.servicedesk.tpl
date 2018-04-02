<form method="POST" action="{$_modx->makeUrl($_modx->resource.id)}" class="servicedesk">
    <input id="phone-for-{$link_attributes}" type="tel" name="phone" class="form-control form-control--border w-rem-16 mb-3" placeholder="+7 (___) ___-_____">
    <span class="error_phone"></span>
    <button type="submit" class="btn btn-dvmk w-rem-16 hover-effect hover-effect--apollo text-uppercase">{if $pagetitle == 'Вызвать сервисную службу'}Вызвать специалиста{else}{$pagetitle}{/if}</button>
</form>