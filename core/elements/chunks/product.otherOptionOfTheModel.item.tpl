<fieldset class="d-inline-block mr-3 model-property" role="link" data-uri="{$productID | url}">
    <input name="{$key}" type="radio" id="radio-{$key}-{$id}"{if $optionValue == $currentOptionValue} checked{/if}>
    <label for="radio-{$key}-{$id}">{$optionValue}</label>
</fieldset>
