<?php

/**
 * This snippet is a fast and temporary solution
 * IMPORTANT: this snippet should be an implementation of dmProductOptions in order of avoiding duplicate code
 */

// Retrive options
$conditions = $modx->getOption('conditions', $scriptProperties);
$currentOptionValues = $modx->getOption('currentOptionValues', $scriptProperties);
$optionKeys = $modx->getOption('optionKeys', $scriptProperties);
$optionLabel = $modx->getOption('optionLabel', $scriptProperties);
$showSingleOption = $modx->getOption('showSingleOption', $scriptProperties);
$tpl = $modx->getOption('tpl', $scriptProperties);
$tplWrapper = $modx->getOption('tplWrapper', $scriptProperties);
$productAvailabilityToPlaceholder = $modx->getOption('productAvailabilityToPlaceholder', $scriptProperties);

define('NO_SUBQUERY_STRATEGY', true);

// Use pdoTools if it's possible
if (class_exists('pdoTools')) {
    $pdoTools = $modx->getService('pdoTools');
    // Using $pdoTools->getChunk($tpl, $placeholders)
} else {
    // Using $modx->getChunk($tpl, $placeholders)
}

// Set empty conditions if not an array is passed
if (!is_array($conditions)) {
    $conditions = [];
}

// Remove condtions with empty value
foreach ($conditions as $key => $value) {
    if (empty($value)) {
        unset($conditions[$key]);
    }
}

// Cast current option values to array
$currentOptionValues = json_decode($currentOptionValues, true);

// Build subquery for product ids with specified option conditions
$productIDsSubquery = $modx->newQuery('msProductOption');
$whereCondition = [];
foreach ($conditions as $key => $value) {
    if ('parent' == $key) {
        $productIDsSubquery->leftJoin('msProduct', 'msProduct', 'msProductOption.product_id = msProduct.id');
        $whereCondition["msProduct.$key"] = $value;
    } elseif ('vendor' == $key) {
        $productIDsSubquery->leftJoin('msProductData', 'msProductData', 'msProductOption.product_id = msProductData.id');
        $whereCondition["msProductData.$key"] = $value;
    } else {
        $productIDsSubquery->leftJoin('msProductOption', $key, "msProductOption.product_id = $key.product_id");
        $whereCondition["$key.value"] = $value;
    }
}

$productIDsSubquery
    ->where($whereCondition)
    // ->groupby('msProductOption.product_id')
    ->select('msProductOption.product_id')
;
// $productIDsSubquery->prepare();
// echo $productIDsSubquery->toSQL();

if (NO_SUBQUERY_STRATEGY) {
    // Main time consumption goes here
    $productOptionCollection = $modx->getIterator('msProductOption', $productIDsSubquery);
    $productIds = [];
    foreach ($productOptionCollection as $productOption) {
        $productIds[] = $productOption->get('product_id');
    }
} else {
    $productIDsSubquery->prepare();
}

// Get unique options with specified option keys and product ids having specified option key and value (retrieved by subquery above)
$criteria = $modx->newQuery('msProductOption');

// Join resources for checking for non-deleted product
$criteria->leftJoin('modResource', 'modResource', 'msProductOption.product_id = modResource.id');

$optionKeys = explode('|', $optionKeys);
$selectionFields = [
    'msProductOption.product_id',
    'modResource.deleted',
];

// Join tables with specified keys
foreach ($optionKeys as $optionKey) {
    $criteria->leftJoin('msProductOption', $optionKey, "$optionKey.product_id = msProductOption.product_id AND $optionKey.`key` = '$optionKey'");
    $selectionFields[] = "$optionKey.value AS $optionKey";
}

// Join product remains
$currentProductRemainTVId = $modx->getObject('modTemplateVar', ['name' => $_SESSION['cityselector.current_product_remain_tv']])->get('id');
$criteria->leftJoin('modTemplateVarResource', 'modTemplateVarResource', "msProductOption.product_id = modTemplateVarResource.contentid AND modTemplateVarResource.tmplvarid = $currentProductRemainTVId");
$selectionFields[] = 'modTemplateVarResource.value AS remain';

// Add conditions
$criteria
    ->where([
        NO_SUBQUERY_STRATEGY
            ? ['msProductOption.product_id:IN' => $productIds]
            : 'msProductOption.product_id IN ('.$productIDsSubquery->toSQL().')'
        ,
    ])
    // Group by specified key values and `deleted` field
    ->groupby(implode(', ', array_merge($optionKeys, ['modResource.deleted'])))
;

$criteria->select($selectionFields);
// $criteria->prepare();
// echo $criteria->toSQL();

// Retrive the collection
$productOptionCollection = $modx->getCollection('msProductOption', $criteria);

// Nothing to output
if (! $showSingleOption && sizeof($productOptionCollection) <= 1) {
    return;
}

// Prepare the items
$items = '';
if ($productAvailabilityToPlaceholder) {
    $productAvailabilitySnippetParameters = [
        'tpl' => $scriptProperties['productAvailabilityTpl'],
        'tplWrapper' => $scriptProperties['productAvailabilityTplWrapper'],
        'availabilityLevels' => $scriptProperties['availabilityLevels'],
        'availabilityDividers' => $scriptProperties['availabilityDividers'],
        'levelOptions' => $scriptProperties['levelOptions'],
    ];
    $productAvailabilityOutput = '';
}
$nonDeletedProductCount = 0;
foreach ($productOptionCollection as $id => $productOption) {
    // Check for non-deleted product (checking in code works faster than where condition)
    if ($productOption->get('deleted')) {
        continue;
    }
    $nonDeletedProductCount++;
    $optionValues = [];
    foreach ($optionKeys as $optionKey) {
        $optionValues[$optionKey]  = $productOption->get($optionKey);
    }
    $productId = $productOption->get('product_id');
    // Find product in the cart
    $productCartKey = '';
    foreach ($_SESSION['minishop2']['cart'] as $cartKey => $cartItem) {
        if ($productId == $cartItem['id']) {
            $productCartKey = $cartKey;
            break;
        }
    }

    if ($tplWrapper && $tpl) {
        $placeholders = [
            'id' => $id + 1,
            'optionKeys' => $optionKeys,
            'productId' => $productId,
            'optionValues' => $optionValues,
            'optionImage' => $productOption->get('pattern'),
            'currentOptionValues' => $currentOptionValues, // For recognize active items
            'productCartKey' => $productCartKey,
            'productCartCount' => $productCartKey ? $_SESSION['minishop2']['cart'][$productCartKey]['count'] : 0,
            'productRemain' => $productOption->get('remain'),
        ];
        $items .= !empty($pdoTools)
            ? $pdoTools->getChunk($tpl, $placeholders)
            : $modx->getChunk($tpl, $placeholders);
    }

    if ($productAvailabilityToPlaceholder) {
        $productAvailabilitySnippetParameters = array_merge($productAvailabilitySnippetParameters, [
            'productRemain' => $productOption->get('remain'),
            'optionValues' => $optionValues,
        ]);
        $productAvailabilityOutput .= !empty($pdoTools)
            ? $pdoTools->runSnippet('@FILE snippets/dmProductAvailability.php', $productAvailabilitySnippetParameters)
            : $modx->runSnippet('@FILE snippets/dmProductAvailability.php', $productAvailabilitySnippetParameters);
    }
}

// Output nothing if non-deleted product count <= 1
if (!$showSingleOption && 1 >= $nonDeletedProductCount) {
    return false;
}

$output = '';

if ($tplWrapper && $tpl) {
    // Wrap the items
    $placeholders = [
        'items' => $items,
        'optionLabel' => $optionLabel,
    ];
    $output = !empty($pdoTools)
        ? $pdoTools->getChunk($tplWrapper, $placeholders)
        : $modx->getChunk($tplWrapper, $placeholders);
}

if ($productAvailabilityToPlaceholder) {
    $modx->setPlaceholder($productAvailabilityToPlaceholder, $productAvailabilityOutput);
}

return $output;
