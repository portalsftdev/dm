{if count($files) > 0}
    <div class="mt-3 flex-images lightgallery{$_modx->resource.id}">{$_pls["rows"]}
    {foreach $files as $file}
        <div class="item wow fadeIn"
             data-w="{$file.properties.width}"
             data-h="{$file.properties.height}"
             data-responsive="{$file.w480} 480, {$file.w800} 800, {$file.w1200} 1200"
             data-src="{$file.url}" {$file.description? "data-sub-html='<h4>$file.description</h4>'" : ""}
            >
            {*<img class="img-responsive" alt="{$file.alt}" src="{$file.preview}">*}
            <img class="img-responsive" alt="{$file.alt}" src="assets/i/blank.gif" data-src="{$file.preview}">
        </div>
    {/foreach}
    </div>
{/if}
