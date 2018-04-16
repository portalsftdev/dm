{if ($idx - 1) % 3 == 0}<div class="col-lg-4 col-md-6 text-md-left">{/if}
    <a href="{$_modx->makeUrl($id)}" class="lead no_underline--hover clearfix">{$longtitle?:$pagetitle}</a>
{if $idx == 5}<a href="{$_modx->makeUrl($_modx->config.'resources.advices')}" class="lead font-weight-bold clearfix">Все советы</a>{/if}
{if ($idx % 3 == 0) || ($last == 1) || ($idx == 5)}</div>{/if}
