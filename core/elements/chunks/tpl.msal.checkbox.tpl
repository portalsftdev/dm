<input type="hidden" id="msal_price_original" value="{$_modx->getPlaceholder('price')}">
<input type="hidden" id="msal_hash" value="{$hash}" name="msal_key">
{foreach $inputs as $input}
    <div>
        <input type="{$input.input_type}"
               name="options[{$var}][{$input.id}]"
               id="msal_{$input.id}"
               class="price-option msal_input"
               data-price="{$input.price}"
               data-discount="{$input.discount}"
               {if $input.input_type != 'checkbox'}value="{$input.value}"{/if}
               {if $input.input_type == 'checkbox' and $input.value !== ''}checked{/if}><label for="msal_{$input.id}">{$input.menutitle?:$input.pagetitle} <strong>+{$input.price}<span class="icon-rub"></span></strong></label>
    </div>
{/foreach}
