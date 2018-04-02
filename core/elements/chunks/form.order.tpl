<form id="msOrder" class="ms2_form" enctype="multipart/form-data" method="post">
    <section class="pb-2 px-0">
        <div class="container-fluid px-0">
            <h3 class="doc-title "><span>Оформить заказ</span></h3>
        </div>

        <h3 class="card-title text-center mt-5">Получатель</h3>
        <div class="container container--narrow">
            <div class="card-overlay mt-3">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs nav-fill " role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" data-payer-type="Физическое лицо" data-toggle="tab" href="#client" role="tab">Физическое лицо</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-payer-type="Юридическое лицо" data-toggle="tab" href="#company" role="tab">Юридическое лицо</a>
                    </li>
                </ul>
                <input type="hidden" name="payer-type" value="Физическое лицо" />
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane active" id="client" role="tabpanel">
                        <div class="row py-3">
                            <div class="col-6 p-3">
                                <input type="text" data-name="name" name="name" class="form-control form-control--border  mb-3 mr-2 " placeholder="Имя">
                                <input type="email" data-name="email" name="email" class="form-control form-control--border  mb-3 mr-2 " placeholder="Email">
                            </div>
                            <div class="col-6 p-3">
                                <input type="text" data-name="surname" name="surname" class="form-control form-control--border  mb-3 mr-2 " placeholder="Фамилия">
                                <input type="tel" data-name="phone" name="phone" class="form-control form-control--border  mb-3 mr-2 " placeholder="Телефон">
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="company" role="tabpanel">
                        <div class="row py-3">
                            <div class="col-6 p-3">
                                <input type="text" data-name="name" class="form-control form-control--border  mb-3 mr-2 " placeholder="Имя">
                                <input type="email" data-name="email" class="form-control form-control--border  mb-3 mr-2 " placeholder="Email">
                            </div>
                            <div class="col-6 p-3">
                                <input type="text" data-name="surname" class="form-control form-control--border  mb-3 mr-2 " placeholder="Фамилия">
                                <input type="tel" data-name="phone" class="form-control form-control--border  mb-3 mr-2 " placeholder="Телефон">
                            </div>
                            <div class="col-6 p-3">
                                <input type="text" name="company" class="form-control form-control--border  mb-3 mr-2 " placeholder="Компания">
                                <input type="text" name="inn" class="form-control form-control--border  mb-3 mr-2 " placeholder="ИНН">
                            </div>
                            <div class="col-6 p-3">
                                <input type="text" name="legal-address" class="form-control form-control--border  mb-3 mr-2 " placeholder="Юр. адрес">
                                <input type="tet" name="kpp" class="form-control form-control--border  mb-3 mr-2 " placeholder="КПП">
                            </div>
                           
                            <div class="col-12 p-3">
                                <div class="dropzone" id="requisites">
                                    <div class="dz-default dz-message">
                                        <div class="dz-message-placeholder">Реквизиты</div>
                                        <svg class="o-icon" viewBox="0 0 512 512">
                                            <path d="m448 178l0-2c0-80-64-144-144-144c-53 0-100 29-124 73c-11-6-23-9-36-9c-44 0-80 36-80 80l0 2c-38 22-64 63-64 110c0 70 58 128 128 128l32 0l0-32l-32 0c-53 0-96-43-96-96c0-34 18-65 48-83l16-9l0-18l0-4c1-25 22-46 48-46c7 0 14 2 21 5l27 14l15-26c21-36 57-57 97-57c61 0 111 49 112 110l0 1l0 21l16 9c30 18 48 49 48 83c0 53-43 96-96 96l-32 0l0 32l32 0c70 0 128-58 128-128c0-47-26-88-64-110z m-192 14l-96 128l64 0l0 160l64 0l0-160l64 0z"></path>
                                        </svg>
                                        <div style="font-size:.9rem">Перетащите файл(ы) сюда</div>
                                    </div>
                                    <div class="fallback">
                                        <input type="file" name="requisites" />
                                    </div>
                                </div>
                                <!-- <textarea class="form-control form-control--border" id="exampleTextarea" placeholder="Реквизиты" rows="3"></textarea> -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <input type="hidden" name="receiver" value="Не указан" />

            <h3 class="card-title text-center">Замер</h3>
            <div class="card-overlay px-3 mb-5">
                <div class="row nav" role="tablist">
                    <div class="col mb-3">
                        <fieldset class="d-inline-block">
                            <input name="measuring" value="Профессиональный замер" type="radio" id="radio1" class="checkbox" data-checktype="tab" data-target="#zamer1" role="tab" aria-controls="zamer1" checked="checked">
                            <label for="radio1">Профессиональный замер</label>
                        </fieldset>
                    </div>
                    <div class="col mb-3">
                        <fieldset class="d-inline-block ">
                            <input name="measuring" value="Самостоятельный замер" type="radio" id="radio2" class="checkbox" data-checktype="tab" data-target="#zamer2" role="tab" aria-controls="zamer2">
                            <label for="radio2">Самостоятельный замер</label>
                        </fieldset>
                    </div>
                </div>
                <div class="row">
                    <div class="col tab-content bg-faded p-4">
                        <div class="tab-pane active" id="zamer1" role="tabpanel">
                            Стоимость замера от 100 рублей в зависимости от количества проёмов и удалённости от города оплачивается замерщику и возвращается Вам при заключении договора на две и более межкомнатные двери с фурнитурой или при установке входной металлической двери.
                        </div>
                        <div class="tab-pane " id="zamer2" role="tabpanel">
                            Рекомендуем Вам воспользоваться услугой "бесплатный замер", чтобы заказанные двери идеально вписалась в дверные проёмы. Наш специалист определит состояние и размеры проёмов, оценит общую готовность объекта для монтажа дверей, определит необходимость и размеры доборных элементов, рассчитает зазоры и прочие детали, которые прямо или косвенно будут оказывать влияние на установку и дальнейшую эксплуатацию дверей.
                        </div>
                    </div>
                </div>
            </div>

            <h3 class="card-title text-center">Монтаж</h3>
            <div class="card-overlay px-3 mb-5">
                <div class="row nav" role="tablist">
                    <div class="col mb-3">
                        <fieldset class="d-inline-block">
                            <input name="installation" value="Профессиональный монтаж" type="radio" id="radio11" class="checkbox" data-checktype="tab" data-target="#zamer11" role="tab" aria-controls="zamer11" checked="checked">
                            <label for="radio11">Профессиональный монтаж</label>
                        </fieldset>
                    </div>
                    <div class="col mb-3">
                        <fieldset class="d-inline-block ">
                            <input name="installation" value="Самостоятельный монтаж" type="radio" id="radio12" class="checkbox" data-checktype="tab" data-target="#zamer12" role="tab" aria-controls="zamer12">
                            <label for="radio12">Самостоятельный монтаж</label>
                        </fieldset>
                    </div>
                </div>
                <div class="row">
                    <div class="col tab-content bg-faded p-4">
                        <div class="tab-pane active" id="zamer11" role="tabpanel">
                            Установка дверей осуществляется специалистами, прошедшими профессиональное обучение и имеющими опыт монтажных работ от 7 лет и более. У них имеется профессиональный инструмент для врезки фурнитуры и выполнения всех запилов и зарезок, необходимых для правильной и качественной установки двери.
                        </div>
                        <div class="tab-pane " id="zamer12" role="tabpanel">
                            Установка как входных, так и межкомнатных дверей - это сложный технический процесс, которым должны заниматься профессионалы. Они как никто другой знают все тонкости и особенности монтажа, а значит смогут сделать работу максимально качественно и быстро. Без наличия значительного опыта даже самый умелый и "рукастый" человек может совершить ошибку и тем самым испортить только что приобретённую дверь.
                        </div>
                    </div>
                </div>
            </div>

            <h3 class="card-title text-center">Доставка</h3>
            <div class="card-overlay px-3 mb-5">
                <div class="row nav" role="tablist" id="deliveries">
                    {foreach $deliveries as $delivery first=$first}
                    <div class="col mb-3">
                        <fieldset class="d-inline-block">
                            <input name="delivery" value="{$delivery.id}" type="radio" id="delivery_{$delivery.id}" class="checkbox" data-checktype="tab" data-target="#delivery-{$delivery.id}-description" role="tab" aria-controls="delivery-{$delivery.id}-description"{($delivery.id == $order.delivery || $first) ? ' checked' : ''} data-payments="{$delivery.payments | json_encode}">
                            <label for="delivery_{$delivery.id}">{$delivery.name}</label>
                        </fieldset>
                    </div>
                    {/foreach}
                </div>
                <div class="row">
                    <div class="col tab-content bg-faded p-4">
                        {foreach $deliveries as $delivery first=$first}
                        <div class="tab-pane{($delivery.id == $order.delivery || $first) ? ' active' : ''}" id="delivery-{$delivery.id}-description" role="tabpanel">
                            {$delivery.description}
                        </div>
                        {/foreach}
                    </div>
                </div>
            </div>

            <h3 class="card-title text-center">Оплата</h3>
            <div class="card-overlay px-3 mb-5">
                <div class="row nav" role="tablist" id="payments">
                    {foreach $payments as $payment first=$first}
                    <div class="col mb-3">
                        <fieldset class="d-inline-block">
                            <input name="payment" value="{$payment.id}" type="radio" id="payment_{$payment.id}" class="checkbox" data-checktype="tab" data-target="#payment-{$payment.id}-description" role="tab" aria-controls="payment-{$payment.id}-description"{($payment.id == $order.payment || $first) ? ' checked' : ''}>
                            <label class="payment" for="payment_{$payment.id}">{$payment.name}</label>
                        </fieldset>
                    </div>
                    {/foreach}
                </div>
                <div class="row">
                    <div class="col tab-content bg-faded p-4">
                        {foreach $payments as $payment first=$first}
                        <div class="tab-pane{($payment.id == $order.payment || $first) ? ' active' : ''}" id="payment-{$payment.id}-description" role="tabpanel">
                            {$payment.description}
                        </div>
                        {/foreach}
                    </div>
                </div>
            </div>

            <h3 class="card-title text-center">Комментарий</h3>
            <div class="card-overlay px-3 mb-5 hover-effect-control">
                <div class="row">
                    <div class="col mb-3">
                        <textarea name="comment" class="form-control form-control--border mt-3" placeholder="Комментарий" rows="3"></textarea>
                    </div>
                </div>
                <div class="row mt-4 h-rem-8">
                    <div class="col mb-3 text-center">
                        <button type="submit" name="ms2_action" value="order/submit" class="btn btn-dvmk btn-lg hover-effect hover-effect--apollo">Отправить заказ</button>
                    </div>
                </div>
            </div>

        </div>
    </section>
</form>