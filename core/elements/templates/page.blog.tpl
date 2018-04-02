{extends 'template:base'}
{block 'content'}
    <section class="py-4">
        <div class="container">
            <h1 class="h2">{$_modx->resource.longtitle?:$_modx->resource.pagetitle}</h1>
        </div>
        <div class="container" id="pdopage">
            <div class="rows">
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
                ])}
                {*</div>*}
                <div class="row text-center">
                    {$_modx->getPlaceholder('page.nav')}
                </div>
            </div>
        </div>
    </section>
    {$_modx->getChunk('@FILE chunks/sect.marketing.tpl')}

{/block}