<div class="d-inline-block model-property" role="link" data-uri="{$productID | url}">
  <input class="color-checkbox" type="radio" name="{$key}" value="{$optionValue | htmlentities}" id="expo-color-{$key}-{$id}"{if $optionValue == $currentOptionValue} checked{/if}>
  <label for="expo-color-{$key}-{$id}" data-toggle="tooltip" data-placement="top" data-html="true" title="<img class='h-rem-10 mt-1' src='{$optionImage}' alt='{$optionValue | htmlentities}'><div>{$optionValue}</div>"><img src="{$optionImage}" alt="{$optionValue | htmlentities}" />
  </label>
</div>
