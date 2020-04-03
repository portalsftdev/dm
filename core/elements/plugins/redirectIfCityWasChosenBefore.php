<?php

if (!function_exists('build_url')) {
/**
 * @link https://www.php.net/manual/en/function.parse-url.php#106731
 * @see (another possible solution): https://gist.github.com/Ellrion/f51ba0d40ae1d62eeae44fd1adf7b704
 */
function build_url($parsed_url) {
  $scheme   = isset($parsed_url['scheme']) ? $parsed_url['scheme'] . '://' : '';
  $host     = isset($parsed_url['host']) ? $parsed_url['host'] : '';
  $port     = isset($parsed_url['port']) ? ':' . $parsed_url['port'] : '';
  $user     = isset($parsed_url['user']) ? $parsed_url['user'] : '';
  $pass     = isset($parsed_url['pass']) ? ':' . $parsed_url['pass']  : '';
  $pass     = ($user || $pass) ? "$pass@" : '';
  $path     = isset($parsed_url['path']) ? $parsed_url['path'] : '';
  $query    = isset($parsed_url['query']) ? '?' . $parsed_url['query'] : '';
  $fragment = isset($parsed_url['fragment']) ? '#' . $parsed_url['fragment'] : '';
  return "$scheme$user$pass$host$port$path$query$fragment";
}
}

if ('OnWebPageInit' === $modx->event->name) {
    if ('www' === mb_substr($_SERVER['HTTP_HOST'], 0, 3) && isset($_COOKIE['redirect_to_domain'])) {
        // @link https://stackoverflow.com/a/6768831
        $url = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";

        $parsedUrl = parse_url($url);
        $parsedUrl['host'] = $_COOKIE['redirect_to_domain'];
        $location = build_url($parsedUrl);

        header("Location: $location");
    }
}
