{extends 'template:base'}
{block 'content'}
    <section class="py-4">
        <div class="container">
            <h1 class="h2">{$_modx->resource.longtitle?:$_modx->resource.pagetitle}</h1>
        </div>
        <div class="container" id="pdopage">
            <div class="rows" itemscope itemtype="http://schema.org/Blog">
                {*<div class="row">*}
                {$_modx->runSnippet('!pdoPage@PropertySet', [
                'parents' => $_modx->resource.id,
                'element' => 'ms2GalleryResources',
                'includeThumbs' => 'card',
                'typeOfJoin' => 'left',
                'ajaxMode' => 'default',
                'limit' => 9,
                'includeContent' => 0,
                'sortby' => 'createdon',
                'sortdir' => 'DESC',
                'tvPrefix' => '',
                'includeTVs' => 'color_class,bg_class,want_label',
                'tpl' => "@FILE chunks/tpl.blog.row.tpl",
                'where' => ['template' => 11],
                'tplPageWrapper' => '@INLINE <ul class="pagination text-center">{$first}{$prev}{$pages}{$next}{$last}</ul>',
                'tplPage' => '@INLINE <li class="page-item"><a class="page-link waves-effect waves-effect" href="{$href}">{$pageNo}</a></li>',
                'tplPageActive' => '@INLINE <li class="page-item active"><a class="page-link waves-effect waves-effect" href="{$href}">{$pageNo}</a></li>',
                'tplPagePrev' => '@INLINE <li class="page-item"><a class="page-link waves-effect waves-effect" aria-label="Previous" href="{$href}"><span aria-hidden="true">←</span><span class="sr-only">Предыдущая</span></a></li>',
                'tplPageNext' => '@INLINE <li class="page-item"><a class="page-link waves-effect waves-effect" aria-label="Next" href="{$href}"><span aria-hidden="true">→</span><span class="sr-only">Следующая</span></a></li>',
                'tplPageFirst' => '@INLINE',
                'tplPageLast' => '@INLINE',
                'tplPagePrevEmpty' => '@INLINE',
                'tplPageNextEmpty' => '@INLINE',
                'tplPageFirstEmpty' => '@INLINE',
                'tplPageLastEmpty' => '@INLINE',
                ])}
                {*</div>*}
            </div>
            <div class="row mt-4">
                <nav class="m-auto pagination">
                    {$_modx->getPlaceholder('page.nav')}
                </nav>
            </div>
        </div>
    </section>
    {$_modx->getChunk('@FILE chunks/sect.marketing.tpl')}

{/block}
