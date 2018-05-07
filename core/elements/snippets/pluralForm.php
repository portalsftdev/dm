<?php

/**
 * @link https://gist.github.com/fomigo/2382775
 */

/*
echo plural_form(42, array('арбуз', 'арбуза', 'арбузов'));
*/
if (!function_exists('plural_form')) {
    function plural_form($n, $forms)
    {
      return $n%10==1&&$n%100!=11?$forms[0]:($n%10>=2&&$n%10<=4&&($n%100<10||$n%100>=20)?$forms[1]:$forms[2]);
    }
}

$count = $modx->getOption('count', $scriptProperties);
$wordForms = $modx->getOption('wordForms', $scriptProperties);

return plural_form($count, $wordForms);
