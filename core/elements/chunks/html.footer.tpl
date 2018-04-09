<footer id="footer" class="page-footer center-on-small-only text-white">
    <div class="container pt-5 pb-4">
        <div class="row wow fadeIn" data-wow-delay="0.2s" style="visibility: visible; animation-delay: 0.2s; animation-name: fadeIn;">
            <div class="col-12 text-center">
                {$_modx->runSnippet('!pdoMenu@PropertySet', [
                'parents' => 23,
                'level' => 1,
                'firstClass' => '',
                'lastClass' => '',
                'hereClass' => 'active',
                'tpl' => '@INLINE <a href="{$_pls["link"]}">{$_pls["menutitle"]}</a>',
                'tplOuter' => '@INLINE <div class="footer-menu"><nav>{$_pls["wrapper"]}</nav></div>',
                'countChildren' => 0,
                ])}
                <hr class="hidden-md-up">
            </div>
        </div>
        <div class="row wow fadeIn" data-wow-delay="0.2s" style="visibility: visible; animation-delay: 0.2s; animation-name: fadeIn;">
            <div class="col-md-6 text-center text-md-left cities">
                {$_modx->RunSnippet('!citySelector', [
                    'phoneTpl' => '@FILE chunks/footer.phone.tpl',
                    'cityTpl' => '@FILE chunks/footer.city.tpl',
                ])}
                {$_modx->getPlaceholder('cityselector.phone')}
                <div class="column-content">
                    <p class="thin-300">
                        {$_modx->getPlaceholder('cityselector.cities')}
                    </p>
                </div>
                <hr class="hidden-md-up">
            </div>
            <div class="col-md-6 text-center text-md-right">
                <!-- <h5>&nbsp;</h5> -->
                <div class="column-content" id="social-networks">
                    <!-- <p class="text-muted text-uppercase">© {$_modx->config.info_copyright}</p> -->
                    <a href="https://vk.com/dveriportal" rel="nofollow" title="Мы в VK" target="_blank">
                        <img src="assets/images/icons/vk.com.png" alt="VK" />
                    </a>
                    <a href="https://www.instagram.com/dveri_nvkz/" rel="nofollow" title="Мы в Instagram" target="_blank">
                        <img src="assets/images/icons/instagram.com.png" alt="Instagram" />
                    </a>
                </div>
            </div>

        </div>
    </div>
</footer>

<!--<script src="/assets/js/jquery-3.1.1.slim.min.js" ></script>-->

{$_modx->RunSnippet('!MinifyX', [
    'jsSources' =>
        $_modx->config.assets_url ~ 'js/jquery.min.js' ~ ', ' ~
        $_modx->config.assets_url ~ 'js/tether.min.js' ~ ', ' ~
        $_modx->config.assets_url ~ 'js/popper.js' ~ ', ' ~
        $_modx->config.assets_url ~ 'js/bootstrap.min.js' ~ ', ' ~
        $_modx->config.assets_url ~ 'js/masonry.pkgd.min.js' ~ ', ' ~
        $_modx->config.assets_url ~ 'js/screen.js' ~  ', ' ~

        $_modx->config.assets_url ~ 'js/jquery.flex-images.min.js' ~  ', ' ~
        $_modx->config.assets_url ~ 'js/lightgallery/lightgallery.js' ~  ', ' ~
        $_modx->config.assets_url ~ 'js/lightgallery/lg-fullscreen.js' ~  ', ' ~
        $_modx->config.assets_url ~ 'js/lightgallery/lg-thumbnail.js' ~  ', ' ~
        $_modx->config.assets_url ~ 'js/lightgallery/lg-hash.js' ~  ', ' ~
        $_modx->config.assets_url ~ 'js/lightgallery/lg-pager.js' ~  ', ' ~

        $_modx->config.assets_url ~ 'js/jquery.kladr.min.js' ~  ', ' ~
        $_modx->config.assets_url ~ 'js/dropzone.js' ~  ', ' ~

        $_modx->config.assets_url ~ 'js/inputmask.js' ~  ', ' ~
        $_modx->config.assets_url ~ 'js/inputmask.phone.extensions.js' ~  ', ' ~

        $_modx->config.assets_url ~ 'js/app.js' ~  ', ' ~
    ,
    'minifyJs' => true,
    'jsFilename' => 'app',
])}

{$_modx->getPlaceholder('MinifyX.javascript')}

<script>
    {ignore}
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
        $('input[role="tab"]').change( function (e) {
            $(this).tab('show');
            $(this).removeClass('active');
        });

        $('.grid-brands').masonry({
            columnWidth: '.grid-sizer',
            itemSelector: '.card-brand',
            originTop: false,
            resize: true,
            transitionDuration: '.3s',
            percentPosition: true
        });

    })
    {/ignore}
</script>

<script type="text/javascript">
    var resource_id = {$_modx->resource.id};
    {ignore}
    $(document).ready(function() {

        $(".lightgallery"+window.resource_id).flexImages({
            rowHeight: 220,
            truncate:true
        });
        $(".lightgallery"+window.resource_id).lightGallery();

        // Inputmask().mask(document.querySelectorAll("input"));


        $('#go').attr('disabled','disabled');
        $('#af_tel').on('keyup',function() {
            var phone = $('#af_tel').val().replace(/[^0-9]/g, '');
            //console.log(phone.length);
            if (phone.length==11) {
                $('#go').removeAttr('disabled');
            } else {
                $('#go').attr('disabled','disabled');
            }
        });
    });
    {/ignore}
</script>

{if $_modx->config.site_debug_info}
<!--
{$_modx->getInfo()}
-->
{/if}
