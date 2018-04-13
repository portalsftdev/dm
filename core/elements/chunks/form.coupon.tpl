<div id="discount-coupon-preform">
    <input type="email" name="email" class="form-control btn-right" placeholder="Ваш email">
    <button type="submit" data-toggle="modal" data-target="#discount-coupon" class="btn btn-dvmk hover-effect hover-effect--apollo">ПОЛУЧИТЬ</button>
</div>

<div id="discount-coupon" class="modal fade" tabindex="-1" role="dialog" >
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" style="color:#292b2c">Купон на скидку</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <form action="{$_modx->makeUrl($_modx->resource.id)}" class="coupon" novalidate>
                                <input type="email" name="email" class="form-control form-control--border mt-3" placeholder="Ваш email">
                                <span class="error_email"></span>
                                <input name="phone" class="form-control form-control--border mt-4" placeholder="+7 (___) ___-_____" type="tel">
                                <span class="error_phone"></span>
                                <div class="captcha mt-4">
                                    <img class="form-control--border" src="assets/components/captcha/" alt="Введите код с картинки" title="Введите код с картинки" />
                                    <a class="captcha-refresh ml-3">Не вижу код</a>
                                </div>
                                <input name="captcha" class="form-control form-control--border mt-4" placeholder="Введите код с картинки" type="text" />
                                <span class="error_captcha"></span>
                                <button type="submit" class="btn btn-block btn-dvmk hover-effect hover-effect--apollo mt-4 mb-5">ПОЛУЧИТЬ</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
