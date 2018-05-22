{foreach $options as $option}
    <div class="form-group">
        <div class="col-md-10 form-control-static"{if $_modx->resource.parent in [$_modx->config.'resources.room_doors', $_modx->config.'resources.steel_doors']} style="line-height:1"{/if}>
            {if $option.value is array}
                {$option.value | join : ', '}
            {else}
                {$option.value}
            {/if}
        </div>
    </div>
{/foreach}
