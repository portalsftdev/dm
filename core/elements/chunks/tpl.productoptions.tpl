{if count($options) > 0}
<table class="table table-striped table-hover ">
    <tbody>
    {foreach $options as $option}
        {* Parentheses around `$option.value is array` is needed because of parse error *}
        {if
            (($option.value is array) && !isset($option.value.0) || '' === $option.value.0)
            || '' === $option.value
        }
            {continue}
        {/if}
        <tr>
            <td>{$option.caption}</td>
            <td>
                {if $option.value is array}
                    {$option.value | join : ', '}
                {else}
                    {$option.value}
                {/if}
            </td>
        </tr>
    {/foreach}
    </tbody>
</table>
{/if}
