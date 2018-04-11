<section id="servicedesk">
    {set $ids=$id?:$_modx->config.id_servicedesk}
    <div class="container-fluid">
        <div class="row mt-4">
            <div class="col-12 px-0 wow fadeIn" data-wow-delay="0.4s" style="visibility: visible; animation-delay: 0.4s; animation-name: fadeIn;">
                <div class="card card-overlay card-overlay--marketing hover-effect-control mb-4" style="background-image: url({$ids | pdoField : 'bg'})">
                    <div class="card-block text-xs-center gr-white-r">
                        <h2 class="card-title">{$ids | pdoField : 'pagetitle'}</h2>
                        <hr>
                        <div class="clearfix"></div>
                        <div class="row">
                            {$_modx->runSnippet('!pdoResources@PropertySet', [
                            'parents' => $ids,
                            'limit' => 3,
                            'includeContent' => 1,
                            'sortby' => 'menuindex',
                            'sortdir' => 'asc',
                            'tvPrefix' => '',
                            'tpl' => "@FILE chunks/tpl.servicedesk.form.tpl",
                            ])}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
