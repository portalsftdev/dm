<div class="expo-interior expo-interior--dark col-xl-6 px-0">
    {if count($files) > 0}
        <div class="expo-door card-wrapper">
            <div id="expo-door" class="card-rotating effect__click">
                {foreach $files as $file index=$idx}
                    <div class="face {$idx > 0?'back':'front'}">
                        <img src="{$file.expo}" alt="{$_modx->getPlaceholder('productImageTitle') | escape}" title="{$_modx->getPlaceholder('productImageTitle') | escape}" itemprop="image" />
                    </div>
                {/foreach}
            </div>
        </div>
        {if count($files) > 1}
        <button class="btn btn-dvmk expo-rotate rotate-btn" data-card="expo-door"><i class="icon-rotate"></i> Другая сторона</button>
        {/if}
    {else}

    {/if}
    <div class="expo-selector">
        <div><input class="expo-checkbox" type="radio" name="expo-interior" value="expo-interior--dark" id="expo-interior-dark" checked><label for="expo-interior-dark" data-toggle="tooltip" data-placement="left" title="Тёмный интерьер"><img src="/assets/images/expo/icon-expo-dark.jpg" alt="Тёмный интерьер" /></label></div>
        <div><input class="expo-checkbox" type="radio" name="expo-interior" value="expo-interior--white" id="expo-interior-white"><label for="expo-interior-white" data-toggle="tooltip" data-placement="left" title="Светлый интерьер"><img src="/assets/images/expo/icon-expo-white.jpg" alt="Светлый интерьер" /></label></div>
        <div><input class="expo-checkbox" type="radio" name="expo-interior" value="expo-interior--green" id="expo-interior-green"><label for="expo-interior-green" data-toggle="tooltip" data-placement="left" title="Коричневый интерьер"><img src="/assets/images/expo/icon-expo-green.jpg" alt="Коричневый интерьер" /></label></div>
    </div>
</div>
