<?php

$toPlaceholder = $modx->getOption('toPlaceholder', $scriptProperties);

// The month without leading zeroes and 4-digit representation of the year
$daysInTheMonth = cal_days_in_month(CAL_GREGORIAN, date('n'), date('Y'));

// The day without leading zeros, including the current day
$monthDay = date('j');
$daysLeft = $daysInTheMonth - $monthDay + 1;

// This will calculate days of this month only
$moduloFrom10 = $daysLeft % 10;
if ($daysLeft != 11 && $moduloFrom10 == 1) {
    $daysLeftPostfix = 'день';
} elseif (!in_array($daysLeft, [12, 13, 14]) && in_array($moduloFrom10, [2, 3, 4])) {
    $daysLeftPostfix = 'дня';
} else {
    $daysLeftPostfix = 'дней';
}

$output = $daysLeft . ' ' . $daysLeftPostfix;

if (!empty($toPlaceholder)) {
    $modx->setPlaceholder($toPlaceholder, $daysLeft);
} else {
    return $output;
}
