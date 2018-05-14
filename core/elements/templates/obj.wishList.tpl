{extends 'template:base'}
{block 'main'}
    {block 'header'}
        {$_modx->getChunk('@FILE chunks/html.header.tpl',['style'=>'black'])}
    {/block}
    <main class="main" id="content">
        {block 'content'}
        <section class="px-3 pb-2 py-4">
            <div id="msfavorites-list" class="container-fluid">
                <h1>{$_modx->resource.longtitle}</h1>
        		<div class="row">
        		{var $wishlist = $_modx->runSnippet('!pdoPage', [
        		    'parents' => 0,
        		    'element' => 'msProducts',
        		    'resources' => $_modx->runSnippet('!msFavorites.ids', ['list' => 'default']),
                    'loadModels' => 'ms2gallery',
                    'leftJoin' => '{
                        "card0": {"class":"msProductFile","alias":"card0", "on": "card0.product_id = msProduct.id AND card0.path LIKE \'%/card/%\' AND card0.rank=0 AND card0.active = 1"}
                        ,"card1": {"class":"msProductFile","alias":"card1", "on": "card1.product_id = msProduct.id AND card1.path LIKE \'%/card/%\' AND card1.rank=1 AND card1.active = 1"}
                    }',
                    'select' => '{
                        "msProduct":"*"
                        ,"card0":"card0.url as card0"
                        ,"card1":"card1.url as card1"
                    }',
        		    'tpl' => '@FILE chunks/tpl.products.row.tpl',
        		    'ajaxMode' => 'default'
        		])}
                {if $wishlist?}
                	{$wishlist}
                {else}
                	<div id="nothing-found" style="margin: 6.5rem 0 9rem;text-align: center;font-size: 2rem;">Список избранного пуст.</div>
                {/if}
        		</div>
        		[[!+page.nav]]
            </div>
        </section>
        {$_modx->getChunk('@FILE chunks/sect.360.tpl')}
        {/block}
    </main>
{/block}
