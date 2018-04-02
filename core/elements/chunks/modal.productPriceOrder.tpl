<div id="product-price-order" class="modal fade" tabindex="-1" role="dialog" >
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Запрос цены</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid bd-example-row">
                    <div class="row">
                        <div class="col-12"><p>Оставьте ваш контактный номер и мы уточним цену товара. Менеджер перезвонит вам <strong>в течение часа</strong>.</p></div>
                            {$_modx->RunSnippet('!AjaxForm', [
                                'snippet' => 'FormIt',
                                'form' => '@FILE chunks/form.productPriceOrder.tpl',
                                'hooks' => 'email',
                                'emailTpl' => '@INLINE Здравствуйте. На сайте сделан запрос уточнения цены товара «{$product_name}». Оставленный пользователем номер телефона: {$phone}',
                                'emailSubject' => $_modx->config.info_company ~ '. Запрос уточнения цены товара',
                                'emailTo' => $_modx->config.manager_emails,
                                'customValidators' => 'validator.phone',
                                'validate' => 'phone:validator.phone',
                                'validationErrorMessage' => 'Проверьте введенные данные.',
                                'successMessage' => 'Сообщение успешно отправлено.',
                            ])}
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>
            </div>
        </div>
    </div>
</div>