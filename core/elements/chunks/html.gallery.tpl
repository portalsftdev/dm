{$_modx->runSnippet('!ms2Gallery@PropertySet', [
'resources' => $id?:$_modx->resource.id,
'limit' => $limit?:0,
'tpl' => '@FILE chunks/tpl.gallery.row.tpl',
'frontend_css=' => '',
'frontend_js' => '',
])}
