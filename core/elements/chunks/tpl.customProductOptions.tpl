{foreach $options as $option}
    <div class="form-group">
        <div class="col-md-10 form-control-static">
            {if $option.value is array}
                {$option.value | join : ', '}
            {else}
                {$option.value}
            {/if}
        </div>
    </div>
{/foreach}
