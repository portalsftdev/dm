<?php

/**
 * 1. Calculate product remains and prices (by city) into template variables
 * 2. Resolve product groups
 * 3. mSearch2 reindex
 * 4. Clear cache
 *
 * To prevent `504 Gateway Timeout` increase either `fastcgi_read_timeout`
 * or something similar.
 *
 * URL example: https://example.com/assets/components/1cexchangepostprocessing/index.php?token={token}.
 */

require_once 'output.php';

// The flag which allows to require another scripts
define('_', true);
define('START_TIME', microtime(true));

// Require MODX API
require_once $_SERVER['DOCUMENT_ROOT'] . '/config.core.php';
require_once MODX_CORE_PATH . 'model/modx/modx.class.php';
$modx = new modX();
$modx->initialize('mgr');
$modx->getService('error','error.modError', '', '');

define('MODX_SYS_SETTING_1C_EXCHANGE_POSTPROCESSING_PASSWORD', '1c_exchange_postprocessing_password');
define('INDEXING_LIMIT', 1000);

$token = !empty($_REQUEST['token']) ? $_REQUEST['token'] : '';

// Authentication
if ($token != $modx->getOption(MODX_SYS_SETTING_1C_EXCHANGE_POSTPROCESSING_PASSWORD)) {
    output([
        'error_code' => '1c_exchange_postprocessing.access_denied',
        'error_desc' => 'Access denied',
    ], START_TIME);
}

/**
 * Product remains and prices processing
 */

$cityContainerResourceId = $modx->getOption('resources.cities');
$cities = $modx->getIterator('modResource', ['parent' => $cityContainerResourceId]);

$city1CStorages = [];
$cityProductRemainTVs = [];
$city1cPriceTypes = [];
$cityProductPriceTypeTvs = [];
foreach ($cities as $city) {
    // Retrieve city 1C storages and city product remain template variables
    $city1CStoragesTVArray = json_decode($city->getTVValue('city_1c_storages'), true);
    if (! is_array($city1CStoragesTVArray)) {
        continue;
    }
    foreach ($city1CStoragesTVArray as $city1CStorage) {
        $city1CStorages[$city->pagetitle][] = $city1CStorage['name'];
    }
    $remainTemplateVariableTVArray = json_decode($city->getTVValue('remain_template_variable'), true);
    if (is_array($remainTemplateVariableTVArray)) {
        $cityProductRemainTVs[$city->pagetitle] = $remainTemplateVariableTVArray[0]['remain_template_variable'];
    }

    // Retrieve city 1C price types and city product price type template variables
    $city1cPriceTypeList = json_decode($city->getTVValue('city_1c_price_types'), true);
    if (!is_array($city1cPriceTypeList)) {
        continue;
    }

    foreach ($city1cPriceTypeList as $city1cPriceType) {
        $city1cPriceTypes[$city->pagetitle][] = $city1cPriceType['name'];
    }

    $cityProductPriceTv = $city->getTVValue('price_template_variable');
    if (null !== $cityProductPriceTv) {
        $cityProductPriceTypeTvs[$city->pagetitle] = $cityProductPriceTv;
    }
}

// Retrieve product raw remains and prices and set them to template variables
$products = $modx->getIterator('msProduct', ['class_key' => 'msProduct']); // doesn't work properly w/o explicit class_name
foreach ($products as $id => $product) {
    // Retrieve product raw remains and cast it to array
    $productRawRemains = json_decode($product->getTVValue('product_remains'), true);
    if (! is_array($productRawRemains)) {
        $productRawRemains = [];
    }
    // Initialize product remains with zero values
    $productRemains = [];
    foreach ($cityProductRemainTVs as $city => $dummyVariable) {
        $productRemains[$city] = 0;
    }
    // Group remains by city
    foreach ($productRawRemains as $productRawRemain) {
        if ($city = findStorageCity($productRawRemain['storage'], $city1CStorages)) {
            $productRemains[$city] += $productRawRemain['count'];
        }
    }
    // Set all necessary template variables
    foreach ($productRemains as $city => $productRemain) {
        $product->setTVValue($cityProductRemainTVs[$city], $productRemain);
    }

    $productRawPrices = json_decode($product->getTVValue('product_prices'), true);
    if (!is_array($productRawPrices)) {
        $productRawPrices = [];
    }

    $productPrices = [];
    foreach ($cityProductPriceTypeTvs as $city => $value) {
        $productPrices[$city] = 0.00;
    }

    foreach ($city1cPriceTypes as $city => $priceTypes) {
        if (is_array($priceTypes) && isset($priceTypes[0])) {
            foreach ($productRawPrices as $key => $productRawPrice) {
                if ($priceTypes[0] === $productRawPrice['type']) {
                    $productPrices[$city] = $productRawPrice['price'];
                }
            }
        }
    }

    foreach ($productPrices as $city => $productPrice) {
        $product->setTVValue($cityProductPriceTypeTvs[$city], $productPrice);
    }
}

function findStorageCity($neededStorage, $cityStorages)
{
    foreach ($cityStorages as $city => $storages) {
        foreach ($storages as $storage) {
            if ($storage == $neededStorage) {
                return $city;
            }
        }
    }
    return false;
}

/**
 * Resolve product groups
 */

require_once 'ProductGroupResolver/index.php';

/**
 * Resource re-indexing
 */

// Retrieve miniShop2 processors path
$mSearch2CorePath = $modx->getOption('msearch2.core_path', null, $modx->getOption('core_path') . 'components/msearch2/');

// Get indexes statistics
$processorResponse = $modx->runProcessor('mgr/index/stat', [], ['processors_path' => $mSearch2CorePath . 'processors/']);

if (
    $processorResponse->response['success'] != true ||
    !isset($processorResponse->response['object']['total']) ||
    !is_numeric($processorResponse->response['object']['total'])
) {
    output([
        'error_code' => '1c_exchange_postprocessing.search_engine.statistics_error',
        'error_desc' => 'Error while getting the count of pages',
        'response' => $processorResponse->response,
    ], START_TIME);
} else {
    $totalPages = $processorResponse->response['object']['total'];
}

// Clear indexes
// $processorResponse = $modx->runProcessor('mgr/index/remove', [], ['processors_path' => $mSearch2CorePath . 'processors/']);

// Run the processor directly avoiding permission_denied error
require_once $mSearch2CorePath.'processors/mgr/index/remove.class.php';
$mseIndexUpdateProcessor = new mseIndexUpdateProcessor($modx);
$processorResponse = $mseIndexUpdateProcessor->process();
if ($processorResponse['success'] != true) {
    output([
        'error_code' => '1c_exchange_postprocessing.search_engine.indexes_clear_error',
        'error_desc' => 'Indexes clear error',
        'response' => $processorResponse,
    ], START_TIME);
}

// Re-indexing
$passesCount = ceil($totalPages / INDEXING_LIMIT);
for ($i = 0, $offset = 0; $i < $passesCount; $i++) {
    $processorResponse = $modx->runProcessor(
        'mgr/index/create',
        ['offset' => $offset, 'limit' => INDEXING_LIMIT],
        ['processors_path' => $mSearch2CorePath . 'processors/']
    );
    if ($processorResponse->response['success'] != true) {
        output([
            'error_code' => '1c_exchange_postprocessing.search_engine.reindex_error',
            'error_desc' => 'Error while re-indexing, offset: '.$offset.', limit: '.INDEXING_LIMIT,
            'response' => $processorResponse->response,
        ], START_TIME);
    }
    $offset += INDEXING_LIMIT;
}

/**
 * Clear cache
 */
if (!$modx->cacheManager->refresh()) {
    output([
        'error_code' => '1c_exchange_postprocessing.cache_clear_error',
        'error_desc' => 'Cache clear error',
    ], START_TIME);
}

// Return the result
output([
    'error_code' => '1c_exchange_postprocessing.no_error',
    'error_desc' => 'Success',
], START_TIME);
