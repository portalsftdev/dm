{extends 'template:base'}
{extends 'template:base'}

{block 'content'}
<article class="article py-4">
    <div class="container">
        <h1>{$_modx->resource.longtitle?:$_modx->resource.pagetitle}</h1>
        <p class="red">
        test 11
        </p>
    </div>
</article>
{/block}
