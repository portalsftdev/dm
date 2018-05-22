{if count($options) > 0}
    {foreach $options as $option}
        {$option.caption}: {if $option.value is array}
            {if 'glass' == $option.key && $option.value.0 is empty}
                нет
            {else}
                {$option.value | join : ', '}
            {/if}
        {else}
            {if 'glass' == $option.key && $option.value.0 is empty}
                нет
            {else}
                {$option.value}
            {/if}
        {/if}<br/>
    {/foreach}
{/if}
