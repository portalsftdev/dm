<?php

function output($output, $startTime = 0)
{
    header('Content-Type: application/json; charset=UTF-8');
    $output = array_merge($output,
        [
            'total_time' => (string) (microtime(true) - $startTime . ' sec.'),
            'memory_usage' => memory_get_usage() / 1024 / 1024 . ' mb',
        ]
    );
    echo json_encode($output);
    exit;
}
