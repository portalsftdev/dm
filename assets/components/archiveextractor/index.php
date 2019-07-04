<?php

define('START_TIME', microtime(true));

const ARCHIVE_FORMAT = 'zip';
const TEMPORARY_FOLDER = __DIR__.DIRECTORY_SEPARATOR.'tmp';
const EXTRACT_PATHS = [
    'assets/images',
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
        'error_code' => 'archive_extractor.access_denied',
        'error_desc' => 'Access denied.',
    ]);
}

// Create temporary folder if it does not exist
if (!is_dir(TEMPORARY_FOLDER)) {
    if (!mkdir(TEMPORARY_FOLDER)) {
        output([
            'error_code' => 'archive_extractor.temporary_directory_create_error',
            'error_desc' => 'Unable to create temporary directory.',
        ]);
    }
}

// Determine parameters
$extractTo = $_REQUEST['extract-to'] ?? null;
$clearBeforeExtract = $_REQUEST['clear-before-extract'] ?? null;

// Check for target directory validity
if (!in_array($extractTo, EXTRACT_PATHS)) {
    output([
        'error_code' => 'archive_extractor.invalid_extract_path',
        'error_desc' => 'Invalid extract path.',
    ]);
}

// Set absolute path
$originalExtractTo = $extractTo;
$extractTo = $_SERVER['DOCUMENT_ROOT'].DIRECTORY_SEPARATOR.$extractTo;

// Clear temporary folder
if (!removeDirectory(TEMPORARY_FOLDER, true)) {
    output([
        'error_code' => 'archive_extractor.temporary_directory_clear_error',
        'error_desc' => 'Unable to clear temporary directory.',
    ]);
}

// Save the archive
$archiveFileName = uniqid().'.'.ARCHIVE_FORMAT;
$archiveFilePath = TEMPORARY_FOLDER.DIRECTORY_SEPARATOR.$archiveFileName;
$fh = fopen($archiveFilePath, 'a');
fwrite($fh, file_get_contents('php://input'));
fclose($fh);

// TODO: Check hash sum of the archive and compare it with hash sum of the source

// Remove content of the target directory if it is necessary
if ($clearBeforeExtract) {
    // FIXME: Set the directories to be removed for each extract path explicitly.
    if ('assets/images' === $originalExtractTo) {
        foreach ([
            'assets/images/brands',
            'assets/images/colors',
            'assets/images/products',
        ] as $directoryToRemove) {
            if (!removeDirectory($_SERVER['DOCUMENT_ROOT'].DIRECTORY_SEPARATOR.$directoryToRemove, true)) {
                output([
                    'error_code' => 'archive_extractor.target_directory_clear_error',
                    'error_desc' => 'Unable to clear target directory.',
                ]);
            }
        }
    } else {
        if (!removeDirectory($extractTo, true)) {
            output([
                'error_code' => 'archive_extractor.target_directory_clear_error',
                'error_desc' => 'Unable to clear target directory.',
            ]);
        }
    }
}

// Extract the archive into the target directory
$commandToExtract = sprintf(
    'unzip -o %s -d %s',
    escapeshellarg($archiveFilePath),
    escapeshellarg($extractTo)
);
exec(sprintf('%s 2>&1', $commandToExtract), $output, $exitStatus);
if (0 !== $exitStatus) {
    output([
        'error_code' => 'archive_extractor.archive_extraction_error',
        'error_desc' => sprintf('Unable to extract the archive. Exit status: %s.', $exitStatus),
    ]);
}

// Return the success message
output([
    'error_code' => 'archive_extractor.success',
    'error_desc' => 'Success.',
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

function removeDirectory(string $directoryPath, bool $keepDirectoryAlive = false): bool
{
    if (!is_dir($directoryPath)) {
        return true;
    }

    $directoryItems = new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator(
            $directoryPath,
            RecursiveDirectoryIterator::SKIP_DOTS
        ),
        RecursiveIteratorIterator::CHILD_FIRST
    );

    foreach ($directoryItems as $directoryItem) {
        $function = $directoryItem->isDir() ? 'rmdir' : 'unlink';
        if (!$function($directoryItem->getRealPath())) {
            return false;
        }
    }

    if (!$keepDirectoryAlive) {
        rmdir($directoryPath);
    }

    return true;
}
