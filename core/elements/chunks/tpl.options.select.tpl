{foreach $options as $name => $values}
    <div class="form-group">
        <label class="control-label" for="option_{$name}">{('ms2_product_' ~ $name) | lexicon}:</label>
        <div class="mb-3">
            <select class="form-control form-control--border w-rem-11" name="options[{$name}]" id="option_{$name}">
                {foreach $values as $value}
                    <option value="{$value | escape}">{$value}</option>
                {/foreach}
            </select>
        </div>
    </div>
{/foreach}
