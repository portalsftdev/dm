<?php

// Retrive options
$tpl = $modx->getOption('tpl', $scriptProperties);
$conditions = $modx->getOption('conditions', $scriptProperties);
$linkName = $modx->getOption('linkName', $scriptProperties);
$productID = $modx->getOption('productID', $scriptProperties, $modx->resource->id);
$productNameField = $modx->getOption('productNameField', $scriptProperties, 'pagetitle');
// List of `modResource.menutitle`
$types = $modx->getOption('types', $scriptProperties, []);
$mandatoryCount = $modx->getOption('mandatoryCount', $scriptProperties, false);
$complectationCostPlaceholder = $modx->getOption('complectationCostPlaceholder', $scriptProperties, false);
$complectationAvailabilityToPlaceholder = $modx->getOption('complectationAvailabilityToPlaceholder', $scriptProperties);
$hasTelescopicComplectationPlaceholder = $modx->getOption('hasTelescopicComplectationPlaceholder', $scriptProperties, false);
$nfp = $modx->getOption('ms2_price_format', null, '[2, ".", " "]');
$nfp = json_decode($nfp, true);

// Use pdoTools if it's possible
if (class_exists('pdoTools')) {
    $pdoTools = $modx->getService('pdoTools');
    // Use $pdoTools->getChunk($tpl, $placeholders)
} else {
    // Use $modx->getChunk($tpl, $placeholders)
}

// Unformat previously formatted number
if (!function_exists('number_unformat')) {
    function number_unformat($number, $dec_point = '.', $thousands_sep = ',') {
        // Remove thousands separator
        $number = str_replace($thousands_sep, '', $number);
        // Replace decimal point to dot
        $number = str_replace($dec_point, '.', $number);
        return $number;
    }
}

// Retrieve product default count
if (!function_exists('getMandatoryCount')) {
    function getMandatoryCount($menutitle) {
        return in_array($menutitle, ['Добор']) ? 3 : 1;
    }
}

// Set empty conditions if not an array is passed
if (!is_array($conditions)) {
    $conditions = [];
}

// Remove conditions with empty values
foreach ($conditions as $key => $values) {
    if (empty($values)) {
        unset($conditions[$key]);
    }
}

// Get link with specified name
$link = $modx->getObject('msLink', ['name' => $linkName]);
if (!$link instanceof msLink) {
    return;
}

// Get slave product ids by the link and with specified main product
$slaveLinks = $link->getMany('Links', ['master' => $productID]);
if (sizeof($slaveLinks) == 0) {
    return;
}
$slaveIDs = [];
foreach ($slaveLinks as $slaveLink) {
    $slaveIDs[] = $slaveLink->get('slave');
}

// Get products with specified ids
$criteria = $modx->newQuery('msProduct');
$criteria
    // ->leftJoin('msProductData', 'msProductData', 'msProduct.id = msProductData.id')
    ->where(array_merge(
        ['msProduct.id:IN' => $slaveIDs],
        0 < count($types) ? ['msProduct.menutitle:IN' => $types] : []
    ))
    // ->sortby("FIELD(msProduct.menutitle, 'Короб', 'Наличник', 'Добор')");
    ->sortby("msProduct.pagetitle")
;

// Add conditions
foreach ($conditions as $key => $values) {
    $criteria
        ->leftJoin('msProductOption', $key, "msProduct.id = $key.product_id AND $key.`key` = '$key'")
        ->where(["$key.value:IN" => $values])
    ;
}

$selectionFields = ['msProduct.id'];

// Join product remains
$currentProductRemainTVId = $modx->getObject('modTemplateVar', ['name' => $_SESSION['cityselector.current_product_remain_tv']])->get('id');
$criteria->leftJoin('modTemplateVarResource', 'modTemplateVarResource', "msProduct.id = modTemplateVarResource.contentid AND modTemplateVarResource.tmplvarid = $currentProductRemainTVId");
$selectionFields[] = 'modTemplateVarResource.value AS remain';

// Join `isTelescopic` attribute
if ($hasTelescopicComplectationPlaceholder) {
    $criteria->leftJoin('msProductOption', 'isTelescopic', "msProduct.id = isTelescopic.product_id AND isTelescopic.`key` = 'telescopic'");
    $selectionFields[] = "IFNULL(isTelescopic.value, 'Нет') AS isTelescopic";
}

$criteria->select($selectionFields);

// $criteria->prepare();
// echo $criteria->toSQL();

// Wrap output into the chunks
$slaveProductCollection = $modx->getCollection('msProduct', $criteria);
$output = '';
// Get complectation cost and unformat if exists
if ($complectationCostPlaceholder) {
    $complectationCost = $modx->getPlaceholder($complectationCostPlaceholder);
    $complectationCost = $complectationCost ? number_unformat($complectationCost, $nfp[1], $nfp[2]) : 0;
}

if ($complectationAvailabilityToPlaceholder) {
    $complectationAvailabilitySnippetParameters = [
        'tpl' => $scriptProperties['productAvailabilityTpl'],
        'tplWrapper' => $scriptProperties['productAvailabilityTplWrapper'],
        'availabilityLevels' => $scriptProperties['availabilityLevels'],
        'availabilityDividers' => $scriptProperties['availabilityDividers'],
        'levelOptions' => $scriptProperties['levelOptions'],
    ];
    $complectationAvailabilityOutput = '';
}
foreach ($slaveProductCollection as $slaveProduct) {
    $id = $slaveProduct->get('id');
    $menutitle = $slaveProduct->get('menutitle');
    $cartKeyOfThisProduct = '';
    // Search the product in cart
    foreach ($_SESSION['minishop2']['cart'] as $cartKey => $cartItem) {
        if ($id == $cartItem['id']) {
            $cartKeyOfThisProduct = $cartKey;
            break;
        }
    }
    // Set count, price & sum if the product in cart
    if (!empty($cartKeyOfThisProduct)) {
        $price = $_SESSION['minishop2']['cart'][$cartKeyOfThisProduct]['price'];
        $count = $mandatoryCount
            ? getMandatoryCount($menutitle)
            : $_SESSION['minishop2']['cart'][$cartKeyOfThisProduct]['count'];
        $sum = $count * $price;
        $inCart = true;
    } else {
        $price = $slaveProduct->get('price');
        $count = $mandatoryCount
            ? getMandatoryCount($menutitle)
            : 0;
        $sum = 0;
        $inCart = false;
    }
    $placeholders = [
        'id' => $id,
        'productName' => $slaveProduct->get($productNameField),
        'menutitle' => $menutitle,
        'cartKey' => $cartKeyOfThisProduct,
        'price' => number_format($price, fmod($price, 1) == 0 ? 0 : $nfp[0], $nfp[1], $nfp[2]),
        'count' => $count,
        'sum' => number_format($sum, fmod($sum, 1) == 0 ? 0 : $nfp[0], $nfp[1], $nfp[2]),
        'inCart' => $inCart,
        'linkName' => $linkName,
    ];
    $output .= !empty($pdoTools)
        ? $pdoTools->getChunk($tpl, $placeholders)
        : $modx->getChunk($tpl, $placeholders);
    // Add sum to total complectation cost
    if ($complectationCostPlaceholder) {
        $complectationCost += $sum;
    }

    if ($complectationAvailabilityToPlaceholder) {
        $complectationAvailabilitySnippetParameters = array_merge($complectationAvailabilitySnippetParameters, [
            'productRemain' => $slaveProduct->get('remain'),
            $productNameField => $slaveProduct->get($productNameField),
        ]);
        $complectationAvailabilityOutput .= !empty($pdoTools)
            ? $pdoTools->runSnippet('@FILE snippets/dmProductAvailability.php', $complectationAvailabilitySnippetParameters)
            : $modx->runSnippet('@FILE snippets/dmProductAvailability.php', $complectationAvailabilitySnippetParameters);
    }

    if ($hasTelescopicComplectationPlaceholder && !$modx->getPlaceholder($hasTelescopicComplectationPlaceholder)) {
        if ('Да' === $slaveProduct->get('isTelescopic')) {
            $modx->setPlaceholder($hasTelescopicComplectationPlaceholder, true);
        }
    }
}

// Set total cost of the complectation (it should be formatted at frontend)
if ($complectationCostPlaceholder) {
    $complectationCost = number_format($complectationCost, fmod($complectationCost, 1) == 0 ? 0 : $nfp[0], $nfp[1], $nfp[2]);
    $modx->setPlaceholder($complectationCostPlaceholder, $complectationCost);
}

if ($complectationAvailabilityToPlaceholder) {
    $modx->setPlaceholder($complectationAvailabilityToPlaceholder, $complectationAvailabilityOutput);
}

return $output;
