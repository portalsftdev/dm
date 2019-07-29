<?php

define('START_TIME', microtime(true));

const ALLOWED_DIRECTORIES = [
    'assets/images/brands',
    'assets/images/colors',
    'assets/images/products',
];
const MODX_SYSTEM_SETTING_ARCHIVE_EXTRACTOR_PASSWORD = '1c_exchange_postprocessing_password';

// Require MODX
require_once $_SERVER['DOCUMENT_ROOT'].'/config.core.php';
require_once MODX_CORE_PATH.'model/modx/modx.class.php';
$modx = new modX();
$modx->initialize('mgr');
$modx->getService('error','error.modError', '', '');

// Authentication
$token = $_REQUEST['token'] ?? null;
if ($modx->getOption(MODX_SYSTEM_SETTING_ARCHIVE_EXTRACTOR_PASSWORD) !== $token) {
    output([
        'error_code' => 'directoryentries.access_denied',
        'error_desc' => 'Access denied.',
    ]);
}

$directory = $_REQUEST['directory'] ?? null;

if (!$directory) {
    output([
        'error_code' => 'directoryentries.no_directory_specified',
        'error_desc' => 'No directory specified.',
    ]);
}

if (!in_array($directory, ALLOWED_DIRECTORIES)) {
    output([
        'error_code' => 'directoryentries.directory_is_not_allowed',
        'error_desc' => 'Directory is not allowed.',
    ]);
}

$directory = $_SERVER['DOCUMENT_ROOT'].DIRECTORY_SEPARATOR.$directory;

if (!is_dir($directory)) {
    output([
        'error_code' => 'directoryentries.directory_not_found',
        'error_desc' => 'Directory not found.',
    ]);
}

$directoryEntryStartPosition = mb_strlen($_SERVER['DOCUMENT_ROOT']);
$directoryEntries = [];
foreach (
    new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator(
            $directory,
            FilesystemIterator::SKIP_DOTS |
            FilesystemIterator::CURRENT_AS_PATHNAME
        ),
        RecursiveIteratorIterator::SELF_FIRST
    )
as $directoryEntry) {
    $directoryEntries[] = true
        ? mb_substr($directoryEntry, $directoryEntryStartPosition)
        : $directoryEntry
    ;
}

output([
    'error_code' => 'directoryentries.success',
    'error_desc' => 'Success.',
    'directory_entries' => $directoryEntries,
]);

function output($output)
{
    header('Content-Type: application/json; charset=UTF-8');
    $output = array_merge($output,
        [
            'total_time' => (string) (microtime(true) - START_TIME . ' sec.'),
            'memory_usage' => memory_get_usage() / 1024 / 1024 . ' mb',
        ]
    );
    echo json_encode($output);
    exit;
}
