<?php

// Require MODX API
require_once $_SERVER['DOCUMENT_ROOT'].'/config.core.php';
require_once MODX_CORE_PATH.'model/modx/modx.class.php';
$modx = new modX();
$modx->initialize('web');
$modx->getService('error','error.modError', '', '');

$pdoTools = $modx->getService('pdoTools');

define('MAX_VALUE_COUNT_PER_CONDITION', 50);
$availableAttributeKeys = [
    'telescopic',
];

$product = $_POST['product'] ?? null;
$conditions = [];
foreach ($availableAttributeKeys as $key) {
    if (array_key_exists($key, $_POST)) {
        if (
            is_array($_POST[$key])
            && MAX_VALUE_COUNT_PER_CONDITION >= count($_POST[$key])
        ) {
            $conditions[$key] = $_POST[$key];
        }
    }
}

$output = $pdoTools->runSnippet('@FILE snippets/dmComplectation.php', [
    'productID' => $product,
    // TODO: Load `linkName` and `types` externally.
    'linkName' => 'pogonazh',
    'types' => [
        'Добор',
        'Капитель',
        'Короб',
        'Наличник',
        'Притворная планка',
        'Розетка',
        'Сандрик',
        'Соединитель для добора',
    ],
    'conditions' => $conditions,
    'tpl' => '@FILE chunks/product.complectation.pogonazh.tpl',
]);

echo $output;
exit;
