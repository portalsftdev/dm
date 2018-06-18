<?php

$mode = $modx->getOption('mode', $scriptProperties, null);
$defaultUserPreferences = $modx->getOption('user_preferences_by_default', $scriptProperties, []);
$key = $modx->getOption('key', $scriptProperties, '');
$value = $modx->getOption('value', $scriptProperties, '');

// FIXME: remove session key definition via constant
define('USER_PREFERENCES_SESSION_KEY', 'user_preferences');

$userPreferences = [
    'show_filters' => false,
];

// Set user preference
if ('set' == $mode) {
    if (! array_key_exists($key, $userPreferences)) {
        return [
            'success' => false,
            'message' => 'Указано несуществующее предпочтение пользователя.',
        ];
    } else {
        $_SESSION[USER_PREFERENCES_SESSION_KEY][$key] = 'true' == $value ? true : false;
        return [
            'success' => true,
        ];
    }
// Initialise user preferences by default
} elseif ('init' == $mode) {
    $userPreferences = array_merge($userPreferences, $defaultUserPreferences);
    foreach ($userPreferences as $key => $value) {
        if (!isset($_SESSION[USER_PREFERENCES_SESSION_KEY][$key])) {
            $_SESSION[USER_PREFERENCES_SESSION_KEY][$key] = $value;
        }
    }
}
