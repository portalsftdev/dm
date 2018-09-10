<?php

$name = $modx->getOption('name', $scriptProperties);

$link = $modx->getObject('msLink', ['name' => $name]);
if (!$link instanceof msLink) {
    return false;
}

return $link;
