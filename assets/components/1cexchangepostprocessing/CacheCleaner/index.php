<?php

if ('cli' !== php_sapi_name()) {
    echo 'Access denied.';
    exit;
}

$_SERVER['DOCUMENT_ROOT'] = $_SERVER['DOCUMENT_ROOT'] ?: realpath(__DIR__.'/../../../..');

require_once $_SERVER['DOCUMENT_ROOT'].'/config.core.php';
require_once MODX_CORE_PATH.'model/modx/modx.class.php';
$modx = new modX();
$modx->initialize('mgr');
$modx->getService('error','error.modError', '', '');

if ($modx->cacheManager->refresh()) {
    echo 'Cache was cleared successfully.';
} else {
    echo 'Cache clear error.';
}

echo PHP_EOL;
