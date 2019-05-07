<div id="measurement-order" class="modal fade" tabindex="-1" role="dialog" >
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Заказ замера</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Закрыть"><span aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body">
                {$_modx->RunSnippet('!AjaxForm', [
                    'snippet' => 'FormIt',
                    'form' => '@INLINE <form method="POST" action="{$_modx->makeUrl($_modx->resource.id)}" class="measurement-order">
                        <input type="tel" name="phone" class="form-control form-control--border w-rem-16 mb-3 btn-right" placeholder="+7 (___) ___-_____">
                        <button type="submit" class="btn btn-primary">Заказать</button>
                        <span class="error_phone"></span>
                    </form>',
                    'hooks' => 'email',
                    'emailTpl' => '@INLINE Здравствуйте. На сайте сделан вызов замерщика. Оставленный пользователем номер телефона: {$phone}',
                    'emailSubject' => $_modx->config.info_company ~ '. Вызов замерщика',
                    'emailTo' => $_modx->config.manager_emails,
                    'customValidators' => 'validator.phone',
                    'validate' => 'phone:validator.phone',
                    'validationErrorMessage' => 'Проверьте введенные данные.',
                    'successMessage' => 'Сообщение успешно отправлено.',
                    'pagetitle' => 'Вызвать замерщика',
                ])}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>
            </div>
        </div>
    </div>
</div>
