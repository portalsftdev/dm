{extends 'template:base'}
{block 'main'}
    {block 'header'}
        {$_modx->getChunk('@FILE chunks/html.header.tpl',['style'=>'black'])}
    {/block}
    {$_modx->getChunk('@FILE chunks/sect.promo.tpl')}
    <main class="main">
        {block 'content'}
            {$_modx->getChunk('@FILE chunks/sect.360.tpl')}
            {$_modx->getChunk('@FILE chunks/sect.products.new.tpl')}
            {$_modx->getChunk('@FILE chunks/sect.products.hits.tpl')}
            {$_modx->getChunk('@FILE chunks/sect.servicedesk.tpl')}
            {$_modx->getChunk('@FILE chunks/sect.about.tpl')}
            {$_modx->getChunk('@FILE chunks/sect.marketing.tpl')}
            {$_modx->getChunk('@FILE chunks/sect.miniblog.tpl',['pnt'=>7])}
            {$_modx->getChunk('@FILE chunks/sect.sale.tpl')}
            {$_modx->getChunk('@FILE chunks/sect.brands.tpl')}
        {/block}
    </main>
{/block}
