<?php

/**
 * Set product groups, product group city remains and product group city prices
 *
 * Migration: ALTER TABLE `modx_ms2_products` ADD `is_group` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' AFTER `source`, ADD `group_remain` JSON NULL DEFAULT NULL AFTER `is_group`, ADD `group_price` JSON NULL DEFAULT NULL AFTER `group_remain`, ADD INDEX `is_group` (`is_group`);
 */

if (!defined('_')) {
    echo 'Access denied.';
    exit;
}

require_once __DIR__.'/../output.php';

const VARIATIONAL_OPTION_VALUE_SEPARATOR = '-';

// Require MODX API
if (!isset($modx) || !$modx instanceof modX) {
    require_once $_SERVER['DOCUMENT_ROOT'] . '/config.core.php';
    require_once MODX_CORE_PATH . 'model/modx/modx.class.php';
    $modx = new modX();
    $modx->initialize('mgr');
    $modx->getService('error', 'error.modError', '', '');
}

$tablePrefix = $modx->getOption(xPDO::OPT_TABLE_PREFIX);

// Config
$productGroupingConfig = [
    [
        'id' => $modx->getOption('resources.room_doors'),
        'option_keys' => [
            'model',
            'mscolor',
            'glass',
        ],
        'variational_option_values' => [
            'width' => 800,
            'height' => 2000,
        ],
    ],
    [
        'id' => $modx->getOption('resources.steel_doors'),
        'option_keys' => [
            'model',
            'steel_door_color',
            'shield_color',
            'glass',
        ],
    ],
];

// Retrieve city price and remain template variable ids
$cityContainerResourceId = $modx->getOption('resources.cities');
$cities = $modx->getIterator('modResource', ['parent' => $cityContainerResourceId]);
$cityTvs = [];
foreach ($cities as $city) {
    $cityTvs[$city->get('pagetitle')] = [
        'remain' =>
            $modx->getObject(
                'modTemplateVar',
                [
                    'name' => json_decode(
                        $city->getTVValue('remain_template_variable')
                    )[0]->remain_template_variable,
                ]
            )
                ->get('id')
        ,
        'price' =>
            $modx->getObject(
                'modTemplateVar',
                [ 'name' => $city->getTVValue('price_template_variable'), ]
            )
                ->get('id')
        ,
    ];
}

foreach ($productGroupingConfig as $configValue) {
    $hasMandatoryOptionValue = isset($configValue['variational_option_values']);
    $selectionFields = [ 'msProduct.id', ];
    $whereConditions = [ "msProduct.parent = {$configValue['id']}", ];

    $query = $modx->newQuery('msProduct')
        ->groupby(implode(', ', array_map(function ($value) {
            return "$value.value";
        }, $configValue['option_keys'])))
    ;

    foreach ($configValue['option_keys'] as $optionKey) {
        $query->leftJoin(
            'msProductOption',
            $optionKey,
            "$optionKey.product_id = msProduct.id AND $optionKey.`key` = '$optionKey'"
        );
    }

    $query->leftJoin(
        'msProductData',
        'msProductData',
        'msProductData.id = msProduct.id'
    );
    $selectionFields[] = "CONCAT('[', GROUP_CONCAT(JSON_OBJECT('id', msProduct.id, 'is_group', msProductData.is_group)), ']') AS group_items";

    if ($hasMandatoryOptionValue) {
        foreach ($configValue['variational_option_values'] as $optionKey => $optionValue) {
            $query->leftJoin(
                'msProductOption',
                $optionKey,
                "$optionKey.product_id = msProduct.id AND $optionKey.`key` = '$optionKey'"
            );
        }

        $groupConcatArguments = [ "'id'", 'msProduct.id', "'option_value'"];
        $groupConcatArguments[] = "CONCAT_WS('".VARIATIONAL_OPTION_VALUE_SEPARATOR."', "
            .implode(', ', array_map(function ($value) {
                return "$value.value";
            }, array_keys($configValue['variational_option_values'])))
        .")";
    }

    if ($hasMandatoryOptionValue) {
        $jsonObjectArguments = [];
    }
    foreach ($cityTvs as $city => $cityTv) {
        foreach ($cityTv as $tvKey => $tvId) {
            $tableAlias = "{$city}_$tvKey";
            $query->leftJoin(
                'modTemplateVarResource',
                $tableAlias,
                "$tableAlias.contentid = msProduct.id AND $tableAlias.tmplvarid = $tvId"
            );
            if ('remain' === $tvKey) {
                $selectionFields[] = "SUM(CAST($tableAlias.value AS UNSIGNED)) AS $tableAlias";
            } elseif ('price' === $tvKey) {
                if ($hasMandatoryOptionValue) {
                    $jsonObjectArguments[] = "'$city'";
                    $jsonObjectArguments[] = "CAST($tableAlias.value AS DECIMAL(12,2))";
                    // There is no sense to select min group price if mandatory
                    // option value is present
                } else {
                    $selectionFields[] = "MIN(CAST($tableAlias.value AS DECIMAL(12,2))) AS $tableAlias";
                }
            }
        }
    }
    if ($hasMandatoryOptionValue) {
        $groupConcatArguments[] = "'prices'";
        $groupConcatArguments[] = 'JSON_OBJECT('.implode(', ', $jsonObjectArguments).')';
        $selectionFields[] = "CONCAT('[', GROUP_CONCAT(JSON_OBJECT("
            .implode(', ', $groupConcatArguments)
        .")), ']') AS group_variational_option_values";
    }

    $query
        ->select($selectionFields)
        ->where($whereConditions)
        ->prepare()
    ;

    // echo $query->toSQL();
    // exit;

    if ($query->stmt->execute()) {
        $productGroups = $query->stmt->fetchAll(PDO::FETCH_ASSOC);

        if ($hasMandatoryOptionValue) {
            $mandatoryOptionValue = implode(
                '-',
                $configValue['variational_option_values']
            );
            foreach ($productGroups as $productGroupKey => $productGroup) {
                // Replace id and set price
                $variationalOptionValues = json_decode($productGroup['group_variational_option_values']);
                foreach ($variationalOptionValues as $variationalOptionValue) {
                    if ($variationalOptionValue->option_value === $mandatoryOptionValue) {
                        $productGroups[$productGroupKey]['id'] = $variationalOptionValue->id;
                        $productGroups[$productGroupKey]['prices'] = (array) $variationalOptionValue->prices;
                        break;
                    }
                }

                // Set price in case of nonexistent mandatory option value
                if (!isset($productGroups[$productGroupKey]['prices'])) {
                    $variationalOptionValue = array_filter($variationalOptionValues, function ($value) use ($productGroup) {
                        return $productGroup['id'] == $value->id;
                    })[0];

                    $productGroups[$productGroupKey]['prices'] = (array) $variationalOptionValue->prices;
                }
            }
        }

        $keyRegexPattern = '/remain'.($hasMandatoryOptionValue ? '' : '|price').'/';
        $invalidGroupIds = [];
        foreach ($productGroups as $productGroupKey => $productGroup) {
            $productGroupItems = json_decode($productGroup['group_items']);
            foreach ($productGroupItems as $productGroupItem) {
                if (
                    $productGroupItem->is_group
                    && $productGroup['id'] != $productGroupItem->id
                ) {
                    $invalidGroupIds[] = $productGroupItem->id;
                }
            }

            foreach ($productGroup as $key => $value) {
                if (preg_match($keyRegexPattern, $key, $matches)) {
                    $newKey = "{$matches[0]}s";
                    if (!isset($productGroups[$productGroupKey][$newKey])) {
                        $productGroups[$productGroupKey][$newKey] = [];
                    }
                    $productGroups
                        [$productGroupKey]
                        [$newKey]
                        [explode('_', $key)[0]] = $value
                    ;
                    unset($productGroups[$productGroupKey][$key]);
                }
            }

            $productGroups[$productGroupKey]['prices'] = json_encode(
                $productGroups[$productGroupKey]['prices']
            );
            $productGroups[$productGroupKey]['remains'] = json_encode(
                $productGroups[$productGroupKey]['remains']
            );

            $queryString = <<<EOQ
UPDATE
    `{$tablePrefix}ms2_products`
SET
    `is_group` = 1,
    `group_remain` = :group_remain,
    `group_price` = :group_price
WHERE
    `id` = :id
EOQ;

            $query = new xPDOCriteria($modx, $queryString);

            $query->stmt->bindValue(':group_remain', $productGroups[$productGroupKey]['remains']);
            $query->stmt->bindValue(':group_price', $productGroups[$productGroupKey]['prices']);
            $query->stmt->bindValue(':id', $productGroups[$productGroupKey]['id']);

            if ($query->stmt->execute()) {
                ;
            } else {
                $modx->log(
                    modX::LOG_LEVEL_ERROR,
                    '[ProductGroupResolver] Unable to set product group. SQL query: '
                    .$query->toSQL()
                    ."\nremains: ".var_export($productGroups[$productGroupKey]['remains'], true)
                    ."\nprices: ".var_export($productGroups[$productGroupKey]['prices'], true)
                    ."\nid: ".var_export($productGroups[$productGroupKey]['id'], true)
                );
                output([
                    'error_code' => '1c_exchange_postprocessing.product_group_resolver.sql_query_error',
                    'error_desc' => 'SQL query error',
                ], defined('START_TIME') ? START_TIME : 0);
            }
        }

        if (0 < count($invalidGroupIds)) {
            $invalidGroupIdCommaSeparatedList = implode(',', $invalidGroupIds);
            $queryString = <<<EOQ
UPDATE
    `{$tablePrefix}ms2_products`
SET
    `is_group` = 0,
    `group_remain` = NULL,
    `group_price` = NULL
WHERE
    `id` IN ($invalidGroupIdCommaSeparatedList)
EOQ;

            $query = new xPDOCriteria($modx, $queryString);

            if ($query->stmt->execute()) {
                ;
            } else {
                $modx->log(
                    modX::LOG_LEVEL_ERROR,
                    '[ProductGroupResolver] Unable to invalidate product groups. SQL query: '.$query->toSQL()
                );
                output([
                    'error_code' => '1c_exchange_postprocessing.product_group_resolver.sql_query_error',
                    'error_desc' => 'SQL query error',
                ], defined('START_TIME') ? START_TIME : 0);
            }
        }
    }
}

return true;
