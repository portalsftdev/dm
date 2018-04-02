<section id="servicedesk">
    {set $ids=$id?:$_modx->config.id_servicedesk}
    <div class="container-fluid">
        <div class="row mt-4">
            <div class="col-12 px-0 wow fadeIn" data-wow-delay="0.4s" style="visibility: visible; animation-delay: 0.4s; animation-name: fadeIn;">
                <!--<div class="card card-overlay card-overlay&#45;&#45;marketing hover-effect-control text-white mb-4" style="background-image: url('/assets/i/bg-leaf-dark.jpg')">-->
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
                            <!--<div class="col-xl-6 col-lg-4 col-sm-12 hidden-md-down">
                                <div class="h-rem-11"></div>
                                <div class="align-bottom float-right text-white">
                                    <h2 class=" font-calligraphic mb-0">{$ids | pdoField : 'introtext'}</h2>
                                    <p class="text-right"><i>{$ids | pdoField : 'description'}</i></p>
                                </div>
                            </div>-->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
