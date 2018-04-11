<div class="col-xl-3 col-lg-4 col-sm-6">
    <div class="md-form mb-4">
        <p class="servicedesk-p">{$introtext}</p>
        <i class="fa fa-envelope prefix"></i>
        {$_modx->RunSnippet('!AjaxForm', [
            'snippet' => 'FormIt',
            'form' => '@FILE chunks/form.servicedesk.tpl',
            'hooks' => 'email',
            'emailTpl' => '@INLINE Здравствуйте. На сайте сделан ' ~ $longtitle | lower ~ '. Оставленный пользователем номер телефона: {$phone}',
            'emailSubject' => $_modx->config.info_company ~ '. ' ~ $longtitle,
            'emailTo' => $_modx->config.manager_emails,
            'customValidators' => 'validator.phone',
            'validate' => 'phone:validator.phone',
            'validationErrorMessage' => 'Проверьте введенные данные.',
            'successMessage' => 'Сообщение успешно отправлено.',
            'pagetitle' => $pagetitle,
            'link_attributes' => $link_attributes,
        ])}
    </div>
</div>
