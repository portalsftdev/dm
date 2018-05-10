{$_modx->runSnippet('!ecThreadRating', [
    'tpl' => '@INLINE <div class="expo-rating-stars" title="{$rating_simple}">
    <span style="width: {$rating_simple_percent}%"></span>
</div>
{$_modx->setPlaceholder("productRating", $rating_simple|round:1)}
<div class="expo-rating-info">{$rating_simple|round:1} из {$rating_max} ',
])}
{set $reviewsCountPluralForm = $_modx->runSnippet(
    '@FILE snippets/pluralForm.php',
    [
        'count' => $reviewsCount,
        'wordForms' => ['голос', 'голоса', 'голосов'],
    ]
)}
 ({$reviewsCount} {$reviewsCountPluralForm})</div>
<meta itemprop="ratingValue" content="{$_modx->getPlaceholder('productRating')}" />
<meta itemprop="ratingCount" content="{$reviewsCount}" />
<meta itemprop="reviewCount" content="{$reviewsCount}" />
