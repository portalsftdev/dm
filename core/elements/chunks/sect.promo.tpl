<section class="section-promo">
    {$_modx->runSnippet('!pdoResources@PropertySet', [
    'parents' => 39,
    'limit' => 3,
    'includeContent' => 1,
    'sortby' => 'menuindex',
    'tvPrefix' => '',
    'includeTVs' => 'promo_bg, promo_door',
    'tpl' => "@FILE chunks/tpl.main.promo.tpl",
    ])}
</section>
