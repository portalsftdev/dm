<?php

// Require MODX API
require_once $_SERVER['DOCUMENT_ROOT'].'/config.core.php';
require_once MODX_CORE_PATH.'model/modx/modx.class.php';
$modx = new modX();
$modx->initialize('web');
$modx->getService('error','error.modError', '', '');
$pdoTools = $modx->getService('pdoTools');

$key = $_POST['key'] ?? '';
$value = $_POST['value'] ?? '';

$output = $pdoTools->runSnippet('@FILE snippets/dmUserPreferences.php', [
    'mode' => 'set',
    'key' => $key,
    'value' => $value,
]);

echo json_encode($output);
exit;
