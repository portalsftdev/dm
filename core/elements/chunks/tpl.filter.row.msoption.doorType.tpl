<div class="d-inline-block text-uppercase mr-4">
    <input type="checkbox" id="mse2_{$table}{$delimeter}{$filter}_{$idx}" name="{$filter_key}" value="{$value | escape}" {$checked}>
    <label{if $title == 'Остекленная'} class="filter-switcher" data-switch="#glass-colors"{/if} for="mse2_{$table}{$delimeter}{$filter}_{$idx}">{$title}</label>
</div>
