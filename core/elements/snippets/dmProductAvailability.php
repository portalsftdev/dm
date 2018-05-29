<?php

// Retrive options
$availabilityDividers = $modx->getOption('availabilityDividers', $scriptProperties);
$availabilityLevels = $modx->getOption('availabilityLevels', $scriptProperties);
$productRemain = $modx->getOption('productRemain', $scriptProperties);
$tpl = $modx->getOption('tpl', $scriptProperties);
$levelOptions = $modx->getOption('levelOptions', $scriptProperties);

// Default options
$defaultLevelOptions = [
    0 => [
        'title' => 'Под заказ',
    ],
    1 => [
        'dividersCount' => '1',
        'class' => 'level-1',
        'min' => '1',
        'max' => '2',
        'title' => 'Мало',
    ],
    2 => [
        'dividersCount' => '3',
        'class' => 'level-2',
        'min' => '3',
        'max' => '5',
        'title' => 'Средне',
    ],
    3 => [
        'dividersCount' => '5',
        'class' => 'level-3',
        'min' => '6',
        'title' => 'Много',
    ],
];

// Use pdoTools if it's possible
if (class_exists('pdoTools')) {
    $pdoTools = $modx->getService('pdoTools');
    // Using $pdoTools->getChunk($tpl, $placeholders)
} else {
    // Using $modx->getChunk($tpl, $placeholders)
}

// Use default level options instead of invalid passed options
$levelOptions = json_decode($levelOptions, true);
if (! is_array($levelOptions)) {
    $levelOptions = $defaultLevelOptions;
}

// Sort by keys in descending order
krsort($levelOptions);

// Check for min and max values
$level = 0;
foreach ($levelOptions as $levelKey => $levelOption) {
    if ($levelKey == 0) {
        continue;
    }
    $condition = false;
    if (isset($levelOption['min'])) {
        $condition = (int) $levelOption['min'] <= (int) $productRemain;
    }
    if (isset($levelOption['max'])) {
        $condition = $condition && (int) $levelOption['max'] >= (int) $productRemain;
    }
    if ($condition) {
        $level = $levelKey;
        break;
    }
}

// Set dividers and fill them
$output = '';
for ($i = 0; $i < $availabilityDividers; $i++) {
    $class = '';
    if ($i + 1 <= $levelOptions[$level]['dividersCount']) {
        $class = $levelOptions[$level]['class'];
    }
    $placeholders = [
        'class' => $class,
    ];
    $output .= !empty($pdoTools)
        ? $pdoTools->getChunk($tpl, $placeholders)
        : $modx->getChunk($tpl, $placeholders);
}

// Wrap the dividers
$placeholders = [
    'items' => $output,
    'title' => $levelOptions[$level]['title'],
];
$placeholders = array_merge($placeholders, $scriptProperties);
$output = !empty($pdoTools)
    ? $pdoTools->getChunk($tplWrapper, $placeholders)
    : $modx->getChunk($tplWrapper, $placeholders);

return $output;
