<?php

/**
 * Custom miniShop2 cart handler (allows to add multiple products in one request).
 *
 * @see miniShop2::handleRequest in
 * core/components/minishop2/model/minishop2/minishop2.class.php
 */

function jsonResponse($data) {
    echo json_encode($data);
    header('Content-Type: application/json');
    exit;
}

// Require MODX API
require_once $_SERVER['DOCUMENT_ROOT'].'/config.core.php';
require_once MODX_CORE_PATH.'model/modx/modx.class.php';
$modx = new modX();
$modx->initialize('web');
$modx->getService('error','error.modError', '', '');

// Get miniShop2 and initialize it
$miniShop2 = $modx->getService('miniShop2');
if (!$miniShop2 instanceof miniShop2) {
    jsonResponse([
        'success' => false,
        'error' => 'Ошибка при инициализации сервиса. Попробуйте позже.',
    ]);
}
$miniShop2->initialize($modx->context->key);

// Process request
$request = $_REQUEST;
$requestKey = 'products';
$output = [];
if (isset($request[$requestKey])) {
    foreach ($request[$requestKey] as $idOrKey => $value) {
        // Don't process invalid values
        if (!isset($value['count']) || !isset($value['options'])) {
            continue;
        }

        // Assume it's key, so change the count
        if (array_key_exists($idOrKey, $miniShop2->cart)) {
            // Not actually needed
        // Assume it's id, so add to the cart
        } else {
            $operationResponse = $miniShop2->cart->add($idOrKey, $value['count'], $value['options']);
            if (true === $operationResponse['success']) {
                $output['addedProductsStatus'][$idOrKey] = $operationResponse['data'];
            } else {
                jsonResponse([
                    'success' => false,
                    'error' => 'Ошибка при добавлении товара в корзину. Попробуйте позже.',
                    'errorDescription' => $operationResponse['message'],
                ]);
            }
        }
    }
}

$output['cartStatus'] = $miniShop2->cart->status();
jsonResponse($output);
