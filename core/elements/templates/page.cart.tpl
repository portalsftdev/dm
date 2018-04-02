{extends 'template:base'}
{block 'main'}
    {block 'header'}
        {$_modx->getChunk('@FILE chunks/html.header.tpl',['style'=>'black'])}
    {/block}
    <main class="main" id="content">
        {block 'content'}
            {$_modx->RunSnippet('!msCart', [
                'tpl' => '@FILE chunks/form.cart.tpl',
            ])}
            {$_modx->RunSnippet('!msOrder', [
                'tpl' => '@FILE chunks/form.order.tpl',
            ])}
            {$_modx->RunSnippet('!msGetOrder', [
                'tpl' => '@FILE chunks/form.orderCompleted.tpl',
            ])}
            {$_modx->getChunk('@FILE chunks/sect.360.tpl')}
        {/block}
    </main>
{/block}