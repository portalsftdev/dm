<?php

// Require MODX API
require_once $_SERVER['DOCUMENT_ROOT'].'/config.core.php';
require_once MODX_CORE_PATH.'model/modx/modx.class.php';
$modx = new modX();
$modx->initialize('web');
$modx->getService('error','error.modError', '', '');
$pdoTools = $modx->getService('pdoTools');

$citiesShortInfo = $pdoTools->runSnippet('@FILE snippets/dmCities.php', ['mode' => 'shortInfo']);
$selectedCity = !empty($_REQUEST['selected_city']) ? $_REQUEST['selected_city'] : '';

$output = [];
if (!array_key_exists($selectedCity, $citiesShortInfo)) {
    $output = [
        'success' => false,
        'message' => 'Указан не существующий город.',
    ];
} else {
    $_SESSION['cityselector.current_city'] = $selectedCity;
    $_SESSION['cityselector.current_phone'] = $citiesShortInfo[$selectedCity]['phone'];
    $_SESSION['cityselector.current_phone_href'] = $citiesShortInfo[$selectedCity]['phone_href'];
    $_SESSION['cityselector.current_product_remain_tv'] = $citiesShortInfo[$selectedCity]['product_remain_tv'];
    $output = [
        'success' => true,
    ];
}

echo json_encode($output);
exit;
