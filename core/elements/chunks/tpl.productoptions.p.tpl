{if count($options) > 0}
    {foreach $options as $option}
        {$option.caption}: {if $option.value is array}
            {$option.value | join : ', '}
        {else}
            {$option.value}
        {/if}<br/>
    {/foreach}
{/if}
