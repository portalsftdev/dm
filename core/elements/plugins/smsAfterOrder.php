<?php

switch ($modx->event->name) {
    case 'msOnChangeOrderStatus':

    define('MODX_SYS_SETTING_SMS_API_URL', 'sms.api_url');
    define('MODX_SYS_SETTING_SMS_API_PASSWORD', 'sms.api_password');
    define('MODX_SYS_SETTING_SMS_API_CONNECTION_TIMEOUT', 'sms.api_connection_timeout');
    define('MODX_SYS_SETTING_SMS_LOG', 'sms.log');
    define('MODX_SYS_SETTING_SMS_ORDER_MESSAGE', 'sms.order_message');

    define('SMS_API_URL', $modx->getOption(MODX_SYS_SETTING_SMS_API_URL));
    define('SMS_API_PASSWORD', $modx->getOption(MODX_SYS_SETTING_SMS_API_PASSWORD));
    define('SMS_API_CONNECTION_TIMEOUT', $modx->getOption(MODX_SYS_SETTING_SMS_API_CONNECTION_TIMEOUT));
    define('SMS_LOG_FILEPATH',  $modx->getOption('base_path').$modx->getOption(MODX_SYS_SETTING_SMS_LOG));
    define('SMS_ORDER_MESSAGE', $modx->getOption(MODX_SYS_SETTING_SMS_ORDER_MESSAGE));

    // Only when order status is "new"
    if ($status == 1) {
        $address = $order->getOne('Address');
        $phone = str_replace(['+', '-'], '', $address->get('phone'));
        if (empty($phone)) {
            return false;
        }
        // Set CURL options
        $post = [
            'password' => SMS_API_PASSWORD,
            'numbers' => $phone,
            'message' => base64_encode(SMS_ORDER_MESSAGE),
        ];
        $ch = curl_init(SMS_API_URL);
        curl_setopt($ch, CURLOPT_URL, SMS_API_URL);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); // Return output as string (no direct output)
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, SMS_API_CONNECTION_TIMEOUT);
        curl_setopt($ch, CURLOPT_POST, true); // POST request
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post); // POST variables
        // Execute the query
        file_put_contents(SMS_LOG_FILEPATH, date('d-m-Y H:i:s') . " Sending sms to {$post['numbers']}... ", FILE_APPEND);
        $response = curl_exec($ch);
        // Write to log if something goes wrong
        $errorInfo = curl_error($ch);
        if (!empty($errorInfo)) {
            file_put_contents(SMS_LOG_FILEPATH, "$errorInfo\n", FILE_APPEND);
            return false;
        }
        // Write to log response info
        $response = json_decode($response, true);
        file_put_contents(SMS_LOG_FILEPATH, "{$response['error_info']}\n", FILE_APPEND);
        return true;
    }
    break;
}
