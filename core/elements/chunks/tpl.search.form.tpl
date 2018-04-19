<form action="{$pageId | url}" method="get" class="well msearch2 w-100 {$faded == 1 ? 'search-faded' : ''} {$absolute == 1 ? 'absolute' : 'relative'}">
    {*<div class="{$faded == 1 ? 'search-faded' : 'w-100'} {$absolute == 1 ? 'absolute' : ''} toolbox mr-3">*}
        <a class="search-btn btn-icon icon-search absolute"
              data-toggle="tooltip"
              data-placement="bottom"
              title=""
              data-original-title="Поиск по сайту"
        >
        </a>
        <input type="search" class="search-input form-control form-control-sm form-control--border w-100 {$absolute == 1 ? 'absolute' : ''}"
               name="{$queryVar}" placeholder="Поиск" value="{$mse2_query}" autocomplete="off"/>
    {*</div>*}
</form>
