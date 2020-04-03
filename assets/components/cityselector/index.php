<?php

function jsonResponse($data) {
    echo json_encode($data);
    header('Content-Type: application/json');
    exit;
}

// Require MODX API
require_once $_SERVER['DOCUMENT_ROOT'].'/config.core.php';
require_once MODX_CORE_PATH.'model/modx/modx.class.php';
$modx = new modX();
$modx->initialize('web');
$modx->getService('error','error.modError', '', '');

$domain = $_REQUEST['domain'] ?: null;
if (null === $domain) {
    jsonResponse([
        'success' => false,
        'message' => 'Домен не может быть пустым.',
    ]);
}

$domainExists = false;

// NOTE: `$modx->newQuery('SeodomainsCity')` produces `Could not load class: SeodomainsCity from mysql.seodomainscity.`

$tablePrefix = $modx->getOption(xPDO::OPT_TABLE_PREFIX);
$queryString = <<<EOQ
SELECT
    domain
FROM
    `{$tablePrefix}seodomains_city`
EOQ;

$query = new xPDOCriteria($modx, $queryString);
if ($query->stmt->execute()) {
    $cities = $query->stmt->fetchAll(PDO::FETCH_OBJ);

    foreach ($cities as $city) {
        if ('www' !== mb_substr($city->domain, 0, 3)) {
            $domainExists = true;
        }
    }

    if ($domainExists) {
        setcookie('redirect_to_domain', $domain, 0, '/', $_SERVER['SERVER_NAME']);

        $output = [
            'success' => true,
        ];
    } else {
        $output = [
            'success' => false,
            'message' => 'Домен не существует.',
        ];
    }
} else {
    $output = [
        'success' => false,
        'message' => 'Произошла ошибка при получении доменов. Попробуйте позже.',
    ];
}

jsonResponse($output);
