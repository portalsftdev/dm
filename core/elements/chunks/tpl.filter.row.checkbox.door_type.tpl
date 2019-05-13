<div class="d-inline-block text-uppercase mr-4">
    <input type="checkbox" id="mse2_{$table}{$delimeter}{$filter}_{$idx}" name="{$filter_key}" value="{$value | escape}" {$checked} {$disabled}>
    <label class="{$disabled}{if $title == 'Остекленная'} filter-switcher{/if}"{if $title == 'Остекленная'} data-switch="#glass-colors"{/if} for="mse2_{$table}{$delimeter}{$filter}_{$idx}">{$title}</label>
</div>
