<?php

// Retrive options
$conditions = $modx->getOption('conditions', $scriptProperties);
$currentOptionValue = $modx->getOption('currentOptionValue', $scriptProperties);
$optionKey = $modx->getOption('optionKey', $scriptProperties);
$optionLabel = $modx->getOption('optionLabel', $scriptProperties);
$withImage = $modx->getOption('withImage', $scriptProperties);
$tpl = $modx->getOption('tpl', $scriptProperties);
$tplWrapper = $modx->getOption('tplWrapper', $scriptProperties);

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

// Build subquery for product ids with specified option conditions
$productIDsSubquery = $modx->newQuery('msProductOption');
$whereCondition = [];
foreach ($conditions as $key => $value) {
    $productIDsSubquery->leftJoin('msProductOption', $key, "msProductOption.product_id = $key.product_id");
    $whereCondition["$key.value"] = $value;
}
$productIDsSubquery->where($whereCondition)
                   ->groupby('msProductOption.product_id');
$productIDsSubquery->select('msProductOption.product_id');
$productIDsSubquery->prepare();
// echo $productIDsSubquery->toSQL();

// Get unique options with specified option key and product ids having specified option key and value (retrieved by subquery above)
$criteria = $modx->newQuery('msProductOption');

// Join the table with images if needed
if ($withImage) {
    $criteria->leftJoin('msocColor', 'msocColor', 'msProductOption.value = msocColor.value');
}

// Add conditions and grouping
$criteria->where([
             'msProductOption.key' => $optionKey,
             'msProductOption.value:!=' => '',
             'msProductOption.product_id IN (' . $productIDsSubquery->toSQL() . ')',
           ])
         ->groupby('msProductOption.value');

// Set selection fields
$selectionFields = [
    'msProductOption.product_id',
    'msProductOption.value',
];
if ($withImage) {
    $selectionFields[] = 'msocColor.pattern';
}
$criteria->select($selectionFields);
// $criteria->prepare();
// echo $criteria->toSQL();

// Retrive the collection
$productOptionCollection = $modx->getCollection('msProductOption', $criteria);

// Nothing to output
if (sizeof($productOptionCollection) <= 1) {
    return;
}

// Prepare the items
$items = '';
foreach ($productOptionCollection as $id => $productOption) {
    $placeholders = [
        'id' => $id + 1, // For element's id
        'key' => $optionKey, // For element's id
        'productID' => $productOption->get('product_id'),
        'optionValue' => htmlspecialchars($productOption->get('value')),
        'optionImage' => $productOption->get('pattern'),
        'currentOptionValue' => $currentOptionValue, // For recognize an active item
    ];
    $items .= !empty($pdoTools)
        ? $pdoTools->getChunk($tpl, $placeholders)
        : $modx->getChunk($tpl, $placeholders);
}

// Wrap the items
$placeholders = [
    'items' => $items,
    'optionLabel' => $optionLabel,
];
$output = !empty($pdoTools)
    ? $pdoTools->getChunk($tplWrapper, $placeholders)
    : $modx->getChunk($tplWrapper, $placeholders);
return $output;
