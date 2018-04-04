<!DOCTYPE html>
<html lang="ru">
	<head>
        {block 'head'}
        {$_modx->getChunk('@FILE chunks/html.head.tpl')}
        {/block}
    </head>
    <body>
        {$_modx->config.metric_google}
        {$_modx->config.metric_yandex}

        {block 'main'}
        <main class="main">
            {block 'header'}
            {$_modx->getChunk('@FILE chunks/html.header.tpl')}
            {/block}
            {block 'content'}
            <article class="article py-4">

                <div class="container">
                    <h1>{$_modx->resource.longtitle?:$_modx->resource.pagetitle}</h1>
                    {$_modx->resource.content}
                    {$_modx->getChunk('@FILE chunks/html.gallery.tpl')}
                </div>
            </article>
            {/block}
        </main>
        {/block}
        {block 'footer'}
        {$_modx->getChunk('@FILE chunks/html.footer.tpl')}
        {/block}
	</body>
</html>
