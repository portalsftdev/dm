<section>
    <div class="container-fluid">
        <div class="row card-overlay row--marketing" style="background-image: url('/assets/i/bg-catalog-dariano.jpg')">
            <div class="container">
                <div class="row pt-4 pb-3">
                    <div class="col-lg-4 text-lg-left"><h2 class="card-title pt-4 pt-lg-0 mb-3">Советы <br class="hidden-md-down"><strong>Двери</strong> Маркет</h2></div>
                    {$_modx->runSnippet('!pdoResources@PropertySet', [
                    'parents' => 17,
                    'limit' => 5,
                    'includeContent' => 0,
                    'sortby' => 'createdon',
                    'sortdir' => 'DESC',
                    'tvPrefix' => '',
                    'includeTVs' => 'color_class,bg_class,want_label',
                    'tpl' => "@FILE chunks/tpl.miniblog.row.tpl",
                    'where' => ['template' => 11],
                    ])}
                </div>
                <!--<div class="row pt-5 pb-3 text-center">-->
                <!--<div class="col-lg-4 text-lg-left"><h2 class="card-title mb-0">Выставочный <strong>зал</strong></h2></div>-->
                <!--<div class="col-lg-4 pt-3"><p>Любите выбирать руками, не глазами?<br>Ждем вас в нашем просторном выставочном зале</p></div>-->
                <!--<div class="col-lg-4 text-lg-right"><p><a href="" class="btn-icon btn-icon-dvmk icon-map-point"></a> г. Кемерово, Ленинградский проспект, 21</p></div>-->
                <!--</div>-->
            </div>
        </div>
    </div>
</section>
