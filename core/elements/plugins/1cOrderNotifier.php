<?php

switch ($modx->event->name) {
    case 'msOnChangeOrderStatus':
        // Only when order status is "new"
        if (1 == $status) {
            define('ONEC_WS_LOGIN', $modx->getOption('1c_ws_login'));
            define('ONEC_WS_PASSWORD', $modx->getOption('1c_ws_password'));
            define('ONEC_WS_ORDER_SYNC_URL', $modx->getOption('1c_ws_order_sync_url'));
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, ONEC_WS_ORDER_SYNC_URL);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
            curl_setopt($ch, CURLOPT_USERPWD, ONEC_WS_LOGIN.':'.ONEC_WS_PASSWORD);
            $response = curl_exec($ch);
            if ('success' != $response) {
                $modx->log(modX::LOG_LEVEL_ERROR, 'An error occurred while trying to notificate 1C about new order: '.$response);
            }
        }
        return true;
    break;
}
