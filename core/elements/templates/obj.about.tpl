{extends 'template:base'}
{extends 'template:base'}

{block 'content'}
<article class="article py-4">
    <div class="container">
        <h1>{$_modx->resource.longtitle?:$_modx->resource.pagetitle}</h1>
         <div class = "row-x">
          <div class = "cell cell-first sm-4 h-center no-padding">
            <img alt="фото сотрудников портрет" title="Корпоративный портрет" src="/assets/images/zoya.jpeg" width="300">
          </div>
        </div>
    </div>
</article>
{/block}
