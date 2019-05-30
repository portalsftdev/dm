<?php

if (!defined('_') && 'cli' !== php_sapi_name()) {
    echo 'Access denied.';
    exit;
}

// For avoidance of out of memory
define('TABLE_OPERATION_MAX_ENTRIES', 50000);

/**
 * TODO: Add description.
 */
function errorHandler(...$arguments) {
    if (function_exists('output')) {
        output([
            'error_code' => '1c_exchange_postprocessing.seo.update_dictionary_and_urls',
            'error_desc' => 'An error occurred while trying to update SEO dictionary and URLs',
        ]);
    } else {
        ;
    }
}

/**
 * TODO: Add description.
 */
function findByConditions(array $items, array $conditions) {
    foreach ($items as $item) {
        foreach ($conditions as $conditionKey => $conditionValue) {
            if (!isset($item[$conditionKey])) {
                continue(2);
            } elseif (is_array($conditionValue)) {
                foreach ($conditionValue as $oneConditionValue) {
                    $valueExists = false;
                    if ($oneConditionValue == $item[$conditionKey]) {
                        $valueExists = true;
                        break;
                    }
                }
                if (!$valueExists) {
                    continue(2);
                }
            } elseif ($conditionValue != $item[$conditionKey]) {
                continue(2);
            }
        }

        yield $item;
    }
}

$_SERVER['DOCUMENT_ROOT'] = $_SERVER['DOCUMENT_ROOT'] ?: realpath(__DIR__.'/../../../..');
if (!isset($modx) || !$modx instanceof modX) {
    require_once $_SERVER['DOCUMENT_ROOT'] . '/config.core.php';
    require_once MODX_CORE_PATH . 'model/modx/modx.class.php';
    $modx = new modX();
    $modx->initialize('mgr');
    $modx->getService('error','error.modError', '', '');
}

$tablePrefix = $modx->getOption(xPDO::OPT_TABLE_PREFIX);

/**
 * NOTE: `$modx->getCollection('sfField')` returns `null` and produces errors
 * (see error log for details).
 * NOTE: Processor `mgr/field/getlist` returns 0 items and produces errors (see
 * error log for details).
 * NOTE: `$modx->newQuery('sfField')` also doesn't work.
 */

$queryString = "SELECT * FROM `{$tablePrefix}seofilter_fields`";
$query = $modx->query($queryString);
$fields = $query->fetchAll(PDO::FETCH_ASSOC);

$queryString = "SELECT * FROM `{$tablePrefix}seofilter_dictionary`";
$query = $modx->query($queryString);
$dictionary = $query->fetchAll(PDO::FETCH_ASSOC);

/**
 * Clean up unused SeoFilter dictionary items. I.e. remove all nonexistent
 * filter values (e.g. miniShop2 product options or miniShop2 vendors) from
 * dictionary.
 */
$dictionaryItemsToDelete = [];

/**
 * NOTE: Another possible way to select unused dictionary items is to select
 * from dictionary by field (`field_id` field) and by value (`input` field) that
 * not in of list of filter values. Exemplary pseudoquery:
 *
 * SELECT *
 * FROM `dictionary`
 * WHERE
 * `field_id` = 1
 *  AND `input` NOT IN (
 *    SELECT `value`
 *    FROM `product_options`
 *    WHERE `key` = 'anyOptionKey'
 *    GROUP BY `value`
 *  )
 */
foreach ($fields as $field) {
    if ('msProductOption' === $field['class']) {
        $filterValueColumn = 'value';
        $errorMessage = '[Clean up unused SeoFilter data] An error occurred while trying to fetch product options.';

        $query = $modx->newQuery('msProductOption');
        $query
            ->where(['key' => $field['key']])
            ->groupby('value')
            ->select(['value'])
        ;
    } elseif (
        'msProductData' === $field['class']
        && 'vendor' === $field['key']
    ) {
        $filterValueColumn = 'id';
        $errorMessage = '[Clean up unused SeoFilter data] An error occurred while trying to fetch vendors.';

        $query = $modx->newQuery('msVendor');
        $query
            ->select('id')
        ;
    } elseif ('msocColor' === $field['class']) {
        $filterValueColumn = 'value';
        // TODO: Write more informative message.
        $errorMessage = '[Clean up unused SeoFilter data] An error occurred while trying to fetch product options.';

        $query = $modx->newQuery('msocColor');
        $query
            ->where(['key' => $field['key']])
            /**
             * NOTE: It will work properly only if **value and pattern is
             * used**. Otherwise it won't work as expected.
             */
            ->select(["DISTINCT CONCAT(value, '~', pattern) AS value"])
        ;
    } else {
        continue;
    }

    $query->prepare();
    if ($query->stmt->execute()) {
        $filterValues = $query->stmt->fetchAll(PDO::FETCH_ASSOC);
    } else {
        $modx->log(modX::LOG_LEVEL_ERROR, $errorMessage);
        errorHandler();
        continue;
    }

    $dictionaryItems = iterator_to_array(findByConditions(
        $dictionary,
        ['field_id' => $field['id']]
    ));

    // Case-insensitive diff is needed
    $dictionaryItemInputsToDelete = array_udiff(
        array_column($dictionaryItems, 'input'),
        array_column($filterValues, $filterValueColumn),
        'strcasecmp'
    );

    if (empty($dictionaryItemInputsToDelete)) {
        continue;
    }

    $conditions = ['field_id' => $field['id']];
    foreach ($dictionaryItemInputsToDelete as $dictionaryItemInputToDelete) {
        $conditions['input'][] = $dictionaryItemInputToDelete;
    }
    $dictionaryItemsToDelete = array_merge(
        $dictionaryItemsToDelete,
        iterator_to_array(findByConditions($dictionary, $conditions))
    );

}

if (0 < count($dictionaryItemsToDelete)) {
    $dictionaryItemIds = array_column($dictionaryItemsToDelete, 'id');

    $wordIdCommaSeparatedList = implode(',', $dictionaryItemIds);
    $offset = 0;
    $limit = TABLE_OPERATION_MAX_ENTRIES;
    while (true) {
        // QUESTION: Should `GROUP BY url_id` be here?
        $queryString = <<<EOT
SELECT `url_id`
FROM `{$tablePrefix}seofilter_urlwords`
WHERE `word_id` IN ($wordIdCommaSeparatedList)
LIMIT :offset, :limit
EOT;
        $query = $modx->prepare($queryString);
        $query->bindParam('offset', $offset, PDO::PARAM_INT);
        $query->bindParam('limit', $limit, PDO::PARAM_INT);
        if ($query->execute()) {
            $urls = $query->fetchAll(PDO::FETCH_ASSOC);
            $urlCount = count($urls);
            if (0 === $urlCount) {
                break;
            }

            $urlIds = array_column($urls, 'url_id');
            $urlIdCommaSeparatedList = implode(',', $urlIds);
            $queryString = <<<EOT
DELETE FROM `{$tablePrefix}seofilter_urls`
WHERE `id` IN ($urlIdCommaSeparatedList)
EOT;
            $query = $modx->prepare($queryString);
            if ($query->execute()) {
                ;
            } else {
                $modx->log(
                    modX::LOG_LEVEL_ERROR,
                    '[Clean up unused SeoFilter data] Unable to delete URLs.'
                );
                errorHandler();
                break;
            }
        } else {
            $modx->log(
                modX::LOG_LEVEL_ERROR,
                '[Clean up unused SeoFilter data] Unable to fetch URLs.'
            );
            errorHandler();
            break;
        }

        $offset += $limit;
    }

    $queryString = <<<EOF
DELETE FROM `{$tablePrefix}seofilter_urlwords`
WHERE `word_id` IN ($wordIdCommaSeparatedList)
EOF;
    $query = $modx->prepare($queryString);
    if ($query->execute()) {
        ;
    } else {
        $modx->log(
            modX::LOG_LEVEL_ERROR,
            '[Clean up unused SeoFilter data] Unable to delete URL words.'
        );
        errorHandler();
    }

    $queryString = <<<EOF
DELETE FROM `{$tablePrefix}seofilter_dictionary`
WHERE `id` IN ($wordIdCommaSeparatedList)
EOF;
    $query = $modx->prepare($queryString);
    if ($query->execute()) {
        ;
    } else {
        $modx->log(
            modX::LOG_LEVEL_ERROR,
            '[Clean up unused SeoFilter data] Unable to delete dictionary items.'
        );
        errorHandler();
    }
}

/**
 * Add SeoFilter dictionary items and SEO URLs.
 */
$seoFilterCorePath = $modx->getOption(
    'seofilter_core_path',
    null,
    $modx->getOption('core_path').'components/seofilter/'
);
$seoFilterProcessorPath = $seoFilterCorePath.'processors/';

foreach ($fields as $field) {
    $processorResult = $modx->runProcessor(
        'mgr/field/update',
        $field,
        ['processors_path' => $seoFilterProcessorPath]
    );
    if (!$processorResult->response['success']) {
        $modx->log(
            modX::LOG_LEVEL_ERROR,
            '[Add SeoFilter dictionary items and SEO URLs] Unsuccessful processor response.'
        );
        errorHandler();
        break;
    }
}
