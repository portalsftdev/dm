<div class="card card-overlay card-overlay--marketing hover-effect-control text-white mb-3" style="background-image: url('/assets/i/bg-kupon.jpg')">
    <div class="card-block text-xs-center gr-black-r">
        <h2 class="card-title"><img src="/assets/i/icon-kupon.png"> Купон на <strong>скидку</strong></h2>
        <hr>
        <h4 class="card-title">Купи двери <strong>в салоне</strong> по <mark>онлайн</mark> цене</h4>
        <div class="md-form">
            <i class="fa fa-envelope prefix"></i>
            {$_modx->RunSnippet('!AjaxForm', [
                'snippet' => 'FormIt',
                'form' => '@FILE chunks/form.coupon.tpl',
                'customValidators' => 'validator.phone,validator.captcha',
                'validate' => 'email:required:email,phone:validator.phone,captcha:validator.captcha',
                'vTextEmailInvalid' => 'Неверный формат электронной почты.',
                'vTextEmailInvalidDomain' => 'Неверный формат электронной почты.',
                'hooks' => 'FormItAutoResponder,email',
                'fiarToField' => 'email',
                'fiarFrom' => $_modx->config.emailsender,
                'fiarSubject' => $_modx->config.info_company ~ '. Купон на скидку',
                'fiarTpl' => '@INLINE Здравствуйте. Вы сделали запрос на получение купона на скидку. Купон во вложении',
                'fiarFiles' => $_modx->config.base_path ~ $_modx->config.discount_coupon_file,
                'emailTo' => $_modx->config.manager_emails,
                'emailFrom' => $_modx->config.emailsender,
                'emailSubject' => $_modx->config.info_company ~ '. Купон на скидку',
                'emailTpl' => '@INLINE Здравствуйте. На сайте сделан запрос на получение купона на скидку. Введенный пользователем электронный адрес: {$email}. Введенный пользователем телефон: {$phone}',
                'emailReplyTo' => 'This field must be empty',
                'validationErrorMessage' => 'Проверьте введенные данные.',
                'successMessage' => 'Сообщение успешно отправлено.',
            ])}
        </div>
    </div>
</div>
