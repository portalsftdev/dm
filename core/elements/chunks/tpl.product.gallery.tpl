<div class="expo-interior col-xl-6 px-0">
    <div id="msGallery">
        {if $files?}
            <div class="fotorama"
                 data-nav="thumbs"
                 data-width="100%"
                 data-height="540"
                 data-thumbheight="64"
                 data-allowfullscreen="true"
                 data-swipe="true"
                 data-autoplay="5000">
                {foreach $files as $file}
                    <a href="{$file['url']}" target="_blank">
                        <img src="{$file['small']}" alt="{$_modx->getPlaceholder('productImageTitle') | escape}" title="{$_modx->getPlaceholder('productImageTitle') | escape}">
                    </a>
                {/foreach}
            </div>
        {else}
            <img src="{('assets_url' | option) ~ 'components/minishop2/img/web/ms2_medium.png'}"
                 srcset="{('assets_url' | option) ~ 'components/minishop2/img/web/ms2_medium@2x.png'} 2x"
                 alt="{$_modx->getPlaceholder('productImageTitle') | escape}" title="{$_modx->getPlaceholder('productImageTitle') | escape}"/>
        {/if}
    </div>
</div>
