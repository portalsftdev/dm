<?php

define('DOCUMENT_ROOT', realpath(__DIR__.'/../..'));
$tasks = [
    'assets/components/1cexchangepostprocessing/SeoFilter/DictionaryAndSeoUrlUpdater.php',
    'core/components/seofilter/recount.php',
    'assets/components/1cexchangepostprocessing/CacheCleaner/index.php',
];

if ('cli' !== php_sapi_name()) {
    echo 'Access denied.';
    exit;
}

foreach ($tasks as $task) {
    /**
     * Included scripts may produce errors because they are running in the same
     * process.
     */
    // require_once DOCUMENT_ROOT.DIRECTORY_SEPARATOR.$task;
    shell_exec(PHP_BINARY.' '.DOCUMENT_ROOT.DIRECTORY_SEPARATOR.$task);
}
