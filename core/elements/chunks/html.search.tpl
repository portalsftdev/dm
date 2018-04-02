{$_modx->runSnippet('!mSearchForm@ScriptProperties',[
'pageId' => $local == 1 ? $_modx->resource.id : 5,
'element' => 'msProducts',
'loadModels' => 'gallery',
'leftJoin' => '{
                "card0": {"class":"msProductFile","alias":"card0", "on": "card0.product_id = msProduct.id AND card0.path LIKE \'%/card/%\' AND card0.rank=0"}
                ,"card1": {"class":"msProductFile","alias":"card1", "on": "card1.product_id = msProduct.id AND card1.path LIKE \'%/card/%\' AND card1.rank=1"}
            }',
'select' => '{
                "msProduct":"*"
                ,"card0":"card0.url as card0"
                ,"card1":"card1.url as card1"
            }',
'tplForm' => '@FILE chunks/tpl.search.form.tpl',
'tpl' => '@FILE chunks/tpl.search.row.tpl',
'includeThumbs' => 'card',
'limit' => '6',
'absolute' => $absolute,
'faded' => $faded,
])}