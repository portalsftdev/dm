<?php

$templates = $modx->getOption('templates', $scriptProperties);

$templates = explode(',', $templates);

if (!is_array($templates)) {
    return false;
}

if (in_array($modx->resource->template, $templates)) {
    if (empty($_SESSION['previousURL'])) {
        $_SESSION['previousURL'] = $_SERVER['HTTP_REFERER'];
    }
    return $_SESSION['previousURL'];
} else {
    unset($_SESSION['previousURL']);
}
