{var $title = $title|split:'~'}
<div class="d-inline-block">
  <input id="mse2_{$table}{$delimeter}{$filter}_{$idx}" class="color-checkbox" type="checkbox" name="{$filter_key}" value="{$value | escape}" {$checked} {$disabled}>
  <label for="mse2_{$table}{$delimeter}{$filter}_{$idx}" class="{$disabled}" data-toggle="tooltip" data-placement="top" data-html="true" title="<img class='h-rem-10 mt-1' src='/{$title[1]}' alt='{$title[0] | escape}'><div>{$title[0] | escape}</div>">
    <img src="/{$title[1]}" alt="{$title[0] | escape}">
  </label>
</div>
