{if count($options) > 0}
<h5>Характеристики</h5>
<table class="table table-striped table-hover ">
    <tbody>
    {foreach $options as $option}
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
