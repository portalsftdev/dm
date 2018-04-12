<?php

$tpl = $modx->getOption('tpl', $scriptProperties);

// Use pdoTools if it's possible
if (class_exists('pdoTools')) {
    $pdoTools = $modx->getService('pdoTools');
    // Use $pdoTools->getChunk($tpl, $placeholders)
} else {
    // Use $modx->getChunk($tpl, $placeholders)
}

$criteria = $modx->newQuery('msVendor')
                 ->leftJoin('modResource', 'modResource', 'msVendor.resource = modResource.id')
                 ->where(['msVendor.logo:!=' => ''])
                 ->sortBy('modResource.menuindex', 'ASC');
$criteria->select('msVendor.name, msVendor.logo, msVendor.address as size, modResource.id');
// $criteria->prepare();
// echo $criteria->toSQL();

$vendorCollection = $modx->getCollection('msVendor', $criteria);

// Wrap output into the chunks
$output = '';
foreach ($vendorCollection as $vendor) {
    $placeholders = [
        'id' => $vendor->get('id'),
        'name' => $vendor->get('name'),
        'logo' => '/'.$vendor->get('logo'),
        'size' => $vendor->get('size'),
    ];
    $output .= !empty($pdoTools)
        ? $pdoTools->getChunk($tpl, $placeholders)
        : $modx->getChunk($tpl, $placeholders);
}
return $output;
