<?php

switch ($modx->event->name) {
    case 'msOnChangeOrderStatus':
        // Only when order status is "new"
        if (1 == $status ) {
            // The message should be in system settings
            $message = 'Здравствуйте. На сайте '.$modx->getOption('site_url').' сделан новый заказ. Пожалуйста, обработайте заказ через панель администрирования сайта.';
            $modx->getService('mail', 'mail.modPHPMailer');
            $modx->mail->set(modMail::MAIL_FROM, 'webmaster@portal-nk.ru');
            $modx->mail->set(modMail::MAIL_FROM_NAME, $modx->getOption('site_name'));
            $modx->mail->set(modMail::MAIL_SUBJECT, 'Новый заказ на сайте '.$modx->getOption('site_url'));
            $modx->mail->set(modMail::MAIL_BODY, $message);
            $modx->mail->address('to', $modx->getOption('manager_emails'));
            $modx->mail->setHTML(true);
            if (!$modx->mail->send()) {
                $modx->log(modX::LOG_LEVEL_ERROR,'An error occurred while trying to send the email: '.$modx->mail->mailer->ErrorInfo);
            }
            $modx->mail->reset();
        }
        return true;
    break;
}
