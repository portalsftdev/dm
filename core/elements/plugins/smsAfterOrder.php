<?php

switch ($modx->event->name) {
    case 'msOnChangeOrderStatus':

    define('MODX_SYS_SETTING_SMS_API_URL', 'sms.api_url');
    define('MODX_SYS_SETTING_SMS_API_PASSWORD', 'sms.api_password');
    define('MODX_SYS_SETTING_SMS_API_CONNECTION_TIMEOUT', 'sms.api_connection_timeout');
    define('MODX_SYS_SETTING_SMS_LOG', 'sms.log');
    define('MODX_SYS_SETTING_SMS_ORDER_MESSAGE_TO_CUSTOMER', 'sms.order_message_to_customer');
    define('MODX_SYS_SETTING_SMS_MANAGER_PHONE', 'sms.manager_phone');
    define('MODX_SYS_SETTING_SMS_ORDER_MESSAGE_TO_MANAGER', 'sms.order_message_to_manager');

    define('SMS_API_URL', $modx->getOption(MODX_SYS_SETTING_SMS_API_URL));
    define('SMS_API_PASSWORD', $modx->getOption(MODX_SYS_SETTING_SMS_API_PASSWORD));
    define('SMS_API_CONNECTION_TIMEOUT', $modx->getOption(MODX_SYS_SETTING_SMS_API_CONNECTION_TIMEOUT));
    define('SMS_LOG_FILEPATH',  $modx->getOption('base_path').$modx->getOption(MODX_SYS_SETTING_SMS_LOG));
    define('SMS_ORDER_MESSAGE_TO_CUSTOMER', $modx->getOption(MODX_SYS_SETTING_SMS_ORDER_MESSAGE_TO_CUSTOMER));
    define('SMS_MANAGER_PHONE', $modx->getOption(MODX_SYS_SETTING_SMS_MANAGER_PHONE));
    define('SMS_ORDER_MESSAGE_TO_MANAGER', $modx->getOption(MODX_SYS_SETTING_SMS_ORDER_MESSAGE_TO_MANAGER));

    function sendSms(
        $apiUrl,
        $apiPassword,
        $apiConnectionTimeout,
        $logFilePath,
        $numbers,
        $message
    ) {
        // Set CURL options
        $post = [
            'password' => $apiPassword,
            'numbers' => $numbers,
            'message' => base64_encode($message),
        ];
        $ch = curl_init($apiUrl);
        curl_setopt($ch, CURLOPT_URL, $apiUrl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); // Return output as string (no direct output)
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $apiConnectionTimeout);
        curl_setopt($ch, CURLOPT_POST, true); // POST request
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post); // POST variables
        // Execute the query
        file_put_contents($logFilePath, date('d-m-Y H:i:s') . " Sending sms to {$post['numbers']}... ", FILE_APPEND);
        $response = curl_exec($ch);
        // Write to log if something goes wrong
        $errorInfo = curl_error($ch);
        if (!empty($errorInfo)) {
            file_put_contents($logFilePath, "$errorInfo\n", FILE_APPEND);
            return false;
        }
        // Write to log response info
        $response = json_decode($response, true);
        file_put_contents($logFilePath, "{$response['error_info']}\n", FILE_APPEND);
        return true;
    }

    // Only when order status is "new"
    if ($status == 1) {
        $address = $order->getOne('Address');
        $phone = str_replace(['+', '-'], '', $address->get('phone'));
        if (empty($phone)) {
            return false;
        }
        $smsMessageToCustomer = SMS_ORDER_MESSAGE_TO_CUSTOMER;
        $smsMessageToManager = SMS_ORDER_MESSAGE_TO_MANAGER;
        $modx->parser->processElementTags('', $smsMessageToCustomer, true, false, '[[', ']]', [], 10);
        $modx->parser->processElementTags('', $smsMessageToManager, true, false, '[[', ']]', [], 10);
        $smsData = [
            [
                'phone' => $phone,
                'message' => $smsMessageToCustomer,
            ],
            [
                'phone' => SMS_MANAGER_PHONE,
                'message' => $smsMessageToManager,
            ]
        ];
        foreach ($smsData as $smsDataItem) {
            if (!sendSms(
                SMS_API_URL,
                SMS_API_PASSWORD,
                SMS_API_CONNECTION_TIMEOUT,
                SMS_LOG_FILEPATH,
                $smsDataItem['phone'],
                $smsDataItem['message']
            )) {
                return false;
            }
        }

        return true;
    }
    break;
}
