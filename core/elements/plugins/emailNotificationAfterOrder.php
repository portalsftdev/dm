<?php

switch ($modx->event->name) {
    case 'msOnChangeOrderStatus':
        // Only when order status is "new"
        if (1 == $status) {
            $emailMessageData = [
                'subject' => $modx->getOption('order_notification_email_subject'),
                'message' => $modx->getOption('order_notification_email_message'),
            ];
            // Process system settings
            foreach ($emailMessageData as $key => $value) {
                $chunk = $modx->newObject('modChunk');
                $chunk->setCacheable(false);
                $chunk->setContent($value);
                $emailMessageData[$key] = $chunk->process();
            }
            $modx->getService('mail', 'mail.modPHPMailer');
            $modx->mail->set(modMail::MAIL_FROM, 'webmaster@portal-nk.ru');
            $modx->mail->set(modMail::MAIL_FROM_NAME, $modx->getOption('site_name'));
            $modx->mail->set(modMail::MAIL_SUBJECT, $emailMessageData['subject']);
            $modx->mail->set(modMail::MAIL_BODY, $emailMessageData['message']);
            $modx->mail->address('to', $modx->getOption('manager_emails'));
            $modx->mail->setHTML(true);
            if (!$modx->mail->send()) {
                $modx->log(modX::LOG_LEVEL_ERROR, 'An error occurred while trying to send the email: '.$modx->mail->mailer->ErrorInfo);
            }
            $modx->mail->reset();
        }
        return true;
    break;
}
