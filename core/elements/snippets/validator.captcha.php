<?php

$validated = false;

if (empty($value)) {
  $validator->addError($key, 'Это поле обязательно для заполнения.');
} else {
    if ($value == $_SESSION['captcha_code']) {
        $validated = true;
    } else {
       $validator->addError($key, 'Неверный код.');
    }
}

return $validated;
