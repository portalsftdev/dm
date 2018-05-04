<form class="product-review ec-form" role="form" action="{$_modx->resource.id | url}" method="post" id="ec-form-resource-{$_modx->resource.id}" data-fid="resource-{$_modx->resource.id}">
    <input type="hidden" name="thread" value="resource-{$_modx->resource.id}">
    <div class="row no-gutters">
        <div class="col mr-3 form-group">
            <input class="form-control" type="text" name="user_name" placeholder="Ваше имя" />
            <span class="ec-error" id="ec-user_name-error-resource-{$_modx->resource.id}"></span>
        </div>
        <div class="col mr-3 form-group">
            <input class="form-control" type="email" name="user_email" placeholder="Ваш email" />
            <span class="ec-error" id="ec-user_email-error-resource-{$_modx->resource.id}"></span>
        </div>
        <div class="col-4 col-md-3 col-lg-4 col-xl-3 text-center form-group">
            <span>Ваша оценка:</span>
            <div class="rating-stars">
                <input type="radio" name="rating" value="1" id="product-rating-1" />
                <label for="product-rating-1">
                    <i class="icon-star-o text-primary"></i>
                </label>
                <input type="radio" name="rating" value="2" id="product-rating-2" />
                <label for="product-rating-2">
                    <i class="icon-star-o text-primary"></i>
                </label>
                <input type="radio" name="rating" value="3" id="product-rating-3" />
                <label for="product-rating-3" >
                    <i class="icon-star-o text-primary"></i>
                </label>
                <input type="radio" name="rating" value="4" id="product-rating-4" />
                <label for="product-rating-4">
                    <i class="icon-star-o text-primary"></i>
                </label>
                <input type="radio" name="rating" value="5" id="product-rating-5" />
                <label for="product-rating-5">
                    <i class="icon-star-o text-primary"></i>
                </label>
            </div>
            <span class="ec-error" id="ec-rating-error-resource-{$_modx->resource.id}"></span>
        </div>
    </div>
    <div class="form-group">
        <textarea class="form-control" name="text" placeholder="Ваш отзыв"></textarea>
        <span class="ec-error" id="ec-text-error-resource-{$_modx->resource.id}"></span>
    </div>
    <button type="submit" class="btn btn-dvmk hover-effect hover-effect--apollo mb-4 float-right text-uppercase">Отправить</button>
</form>
<div id="ec-form-success-resource-{$_modx->resource.id}"></div>
