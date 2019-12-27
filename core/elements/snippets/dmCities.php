<?php

// Use pdoTools if it's possible
if (class_exists('pdoTools')) {
    $pdoTools = $modx->getService('pdoTools');
    // Using $pdoTools->getChunk($tpl, $placeholders)
} else {
    // Using $modx->getChunk($tpl, $placeholders)
}

// Prepare city structures
$cityResourceIds = $modx->getChildIds($modx->getOption('resources.cities'));
$citySaleDepartments = [];
$cityStorages = [];
$citiesShortInfo = [];
foreach ($cityResourceIds as $cityResourceId) {
    $cityResource = $modx->getObject('modResource', $cityResourceId);
    // Set city department list
    $citySaleDepartments[$cityResource->get('pagetitle')] = json_decode($cityResource->getTVValue('city_sale_departments'), true);
    // Set cities short info list
    $citiesShortInfo[$cityResource->get('pagetitle')] = [
        'phone' => $citySaleDepartments[$cityResource->get('pagetitle')][0]['phone'],
        'phone_href' => $citySaleDepartments[$cityResource->get('pagetitle')][0]['phone_href'],
    ];
    // Set city storage list
    $cityStorages[$cityResource->get('pagetitle')] = json_decode($cityResource->getTVValue('city_storages'), true);
    // Set city product remain template variables
    $remainTemplateVariableTVArray = json_decode($cityResource->getTVValue('remain_template_variable'), true);
    if (is_array($remainTemplateVariableTVArray)) {
        $citiesShortInfo[$cityResource->get('pagetitle')]['product_remain_tv'] = $remainTemplateVariableTVArray[0]['remain_template_variable'];
    }
}

// Set the current city and its phones
if (!empty($_SESSION['cityselector.current_city'])) {
    $currentCity = $_SESSION['cityselector.current_city'];
} else {
    $currentCity = $modx->getOption('default_city');
    $_SESSION['cityselector.current_city'] = $currentCity;
    $_SESSION['cityselector.current_phone'] = $citiesShortInfo[$currentCity]['phone'];
    $_SESSION['cityselector.current_phone_href'] = $citiesShortInfo[$currentCity]['phone_href'];
    $_SESSION['cityselector.current_product_remain_tv'] = $citiesShortInfo[$currentCity]['product_remain_tv'];
}

$mode = $modx->getOption('mode', $scriptProperties);
$tpl = $modx->getOption('tpl', $scriptProperties);

if ($mode == 'shortInfo') {
    return $citiesShortInfo;
} elseif (in_array($mode, ['contacts', 'storages'])) {
    switch ($mode) {
        case 'contacts':
            foreach ($citySaleDepartments[$currentCity] as $citySaleDepartment) {
                if ('да' !== mb_strtolower($citySaleDepartment['hide_at_contacts_page'])) {
                    $list[] = $citySaleDepartment;
                }
            }
            break;
        case 'storages':
            $list = $cityStorages[$currentCity];
            break;
    }
    $output = '';
    foreach ($list as $item) {
        // Add current city to output
        $item = array_merge($item, ['city' => $currentCity]);
        $output .= !empty($pdoTools)
            ? $pdoTools->getChunk($tpl, $item)
            : $modx->getChunk($tpl, $item);
    }
    return $output;
} elseif ($mode == 'locations') {
    $list = [];
    foreach ($citySaleDepartments[$currentCity] as $citySaleDepartment) {
        if ('да' !== mb_strtolower($citySaleDepartment['hide_at_contacts_page'])) {
            $list[] = [
                'lat' => $citySaleDepartment['lat'],
                'lng' => $citySaleDepartment['lng'],
            ];
        }
    }
    foreach ($cityStorages[$currentCity] as $cityStorage) {
        $list[] = [
            'lat' => $cityStorage['lat'],
            'lng' => $cityStorage['lng'],
        ];
    }
    $output = '';
    foreach ($list as $item) {
        $output .= !empty($pdoTools)
            ? $pdoTools->getChunk($tpl, $item)
            : $modx->getChunk($tpl, $item);
    }
    return $output;
}

$phoneTpl = $modx->getOption('phoneTpl', $scriptProperties);
$cityTpl = $modx->getOption('cityTpl', $scriptProperties);

$modx->setPlaceholder('cityselector.current_city', $currentCity);
$modx->setPlaceholder('cityselector.current_phone', $_SESSION['cityselector.current_phone']);
$modx->setPlaceholder('cityselector.current_phone_href', $_SESSION['cityselector.current_phone_href']);

$placeholders = [
    'cityselector.current_phone' => $_SESSION['cityselector.current_phone'],
    'cityselector.current_phone_href' => $_SESSION['cityselector.current_phone_href'],
];
$output['cityselector.phone'] = !empty($pdoTools)
    ? $pdoTools->getChunk($phoneTpl, $placeholders)
    : $modx->getChunk($phoneTpl, $placeholders);

$output['cityselector.cities'] = '';
foreach ($citiesShortInfo as $city => $cityShortInfo) {
    $placeholders = [
        'current_city' => $currentCity,
        'city' => $city,
        'city_phone' => $cityShortInfo['phone'],
        'city_phone_href' => $cityShortInfo['phone_href'],
        'city_remain_tv' => $cityShortInfo['product_remain_tv'],
    ];
    $output['cityselector.cities'] .= !empty($pdoTools)
        ? $pdoTools->getChunk($cityTpl, $placeholders)
        : $modx->getChunk($cityTpl, $placeholders);
}

$modx->setPlaceholder('cityselector.phone', $output['cityselector.phone']);
$modx->setPlaceholder('cityselector.cities', $output['cityselector.cities']);
