{$_modx->runSnippet('!mSearchForm@ScriptProperties',[
    'pageId' => $local == 1 ? $_modx->resource.id : $_modx->config.'resources.catalog',
    'element' => 'msProducts',
    'loadModels' => 'ms2gallery',
    'tplForm' => '@FILE chunks/tpl.search.form.tpl',
    'tpl' => '@FILE chunks/tpl.search.row.tpl',
    'includeThumbs' => 'card',
    'limit' => '6',
    'absolute' => $absolute,
    'faded' => $faded,
])}
