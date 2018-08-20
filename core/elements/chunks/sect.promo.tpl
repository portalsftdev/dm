<section class="section-promo">
    {$_modx->runSnippet('!pdoResources@PropertySet', [
    'parents' => $_modx->config.'resources.promo',
    'limit' => 3,
    'includeContent' => 1,
    'sortby' => 'menuindex',
    'sortdir' => 'asc',
    'tvPrefix' => '',
    'includeTVs' => 'promo_bg, promo_door',
    'tpl' => "@FILE chunks/tpl.main.promo.tpl",
    ])}
</section>
