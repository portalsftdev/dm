<?php
$validated = false;

if (!preg_match('/^\+7 \(\d{3}\) \d{3}-\d{4}$/', $value)) {
    $validator->addError($key, 'Неверный формат номера телефона.');
} else {
    $validated = true;
}

return $validated;