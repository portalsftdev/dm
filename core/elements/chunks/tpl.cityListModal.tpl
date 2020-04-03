<div class="modal fade modal-city-list" id="city-selection" role="dialog" tabindex="-1">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Выбор города</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Закрыть"><span aria-hidden="true">×</span></button>
            </div>
            <form id="city-selection-form">
                <div class="modal-body">
                    <ul class="pl-3 mb-0 list-unstyled">
                        {foreach $rows as $row}
                            {if 'www' !== $.php.mb_substr($row.domain, 0, 3)}
                                <li class="sd-city-item">
                                    {if $row.active}
                                        <span class="{$row.active}">{$row.city}</span>
                                    {else}
                                        <a href="{$row.link}" rel="nofollow" class="no_underline" data-domain="{$row.domain}">{$row.city}</a>
                                    {/if}
                                </li>
                            {/if}
                        {/foreach}
                    </ul>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary">Ок</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $('#city-selection .sd-city-item a').on('click', function (event) {
        event.preventDefault();

        var href = this.href;
        $.post(
            '/assets/components/cityselector/index.php',
            { domain: event.currentTarget.dataset.domain },
            function(response) {
                if (!response.success) {
                    alert(response.message);
                } else {
                    window.location.href = href;
                }
            }
        );
    });

    // TODO: Add change of `#city-selection .sd-city-item a` `href` after
    // `mSearch2` filtering
</script>

{if 'www' === $.php.mb_substr($.server.HTTP_HOST, 0, 3)}
<script>
    $('#city-selection').modal('show');
</script>
{/if}
