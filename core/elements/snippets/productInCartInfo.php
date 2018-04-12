<?php

/**
 *
 * Add cart information of a product to placeholders
 *
 */

$complectationCostPlaceholder = $modx->getOption('complectationCostPlaceholder', $scriptsProperties, 'complectationCost');
$nfp = $modx->getOption('ms2_price_format', null, '[2, ".", " "]');
$nfp = json_decode($nfp, true);

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

$cartKeyOfThisProduct = '';
$count = 0;
$sum = 0;
foreach ($_SESSION['minishop2']['cart'] as $cartKey => $cartItem) {
    if ($modx->resource->id == $cartItem['id']) {
        $cartKeyOfThisProduct = $cartKey;
        $count = $cartItem['count'];
        $price = $modx->getPlaceholder('price');
        // It was formatted price
        $price = number_unformat($price, $nfp[1], $nfp[2]);
        $sum = $count * $price;
        break;
    }
}
$modx->setPlaceholder('cart.key', $cartKeyOfThisProduct);
$modx->setPlaceholder('cart.count', $count);
$modx->setPlaceholder('cart.sum', number_format($sum, fmod($sum, 1) == 0 ? 0 : $nfp[0], $nfp[1], $nfp[2]));

// Get complectation cost and unformat if exists
$complectationCost = $modx->getPlaceholder($complectationCostPlaceholder);
$complectationCost = $complectationCost ? number_unformat($complectationCost, $nfp[1], $nfp[2]) : 0;
// Add sum to total complectation cost
$complectationCost += $sum;
// Set total cost of the complectation
$complectationCost = number_format($complectationCost, fmod($complectationCost, 1) == 0 ? 0 : $nfp[0], $nfp[1], $nfp[2]);
$modx->setPlaceholder($complectationCostPlaceholder, $complectationCost);
