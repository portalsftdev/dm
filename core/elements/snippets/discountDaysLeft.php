<?php

$toPlaceholder = $modx->getOption('toPlaceholder', $scriptProperties);

// The month without leading zeroes and 4-digit representation of the year
$daysInTheMonth = cal_days_in_month(CAL_GREGORIAN, date('n'), date('Y'));

// The day without leading zeros, including the current day
$monthDay = date('j');
$daysLeft = $daysInTheMonth - $monthDay + 1;

if (!empty($toPlaceholder)) {
    $modx->setPlaceholder($toPlaceholder, $daysLeft);
} else {
    return $daysLeft;
}
