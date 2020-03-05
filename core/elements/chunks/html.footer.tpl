<footer id="footer" class="page-footer center-on-small-only text-white">
    <div class="container pt-5 pb-4">
        <div class="row wow fadeIn" data-wow-delay="0.2s" style="visibility: visible; animation-delay: 0.2s; animation-name: fadeIn;">
            <div class="col-12 text-center">
                {$_modx->runSnippet('!pdoMenu@PropertySet', [
                'parents' => $_modx->config.'resources.footer_menu',
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
                {$_modx->RunSnippet('@FILE snippets/dmCities.php', [
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
                <div class="column-content" id="social-networks">
                    <a href="https://vk.com/dveriportal" rel="nofollow" title="Мы в VK" target="_blank">
                        <img src="assets/i/icons/vk.com.png" alt="VK" />
                    </a>
                    <a href="https://www.instagram.com/dveri_nvkz/" rel="nofollow" title="Мы в Instagram" target="_blank">
                        <img src="assets/i/icons/instagram.com.png" alt="Instagram" />
                    </a>
                    <a href="whatsapp://send/?phone=79235107000" rel="nofollow" title="WhatsApp: 8 923 510-70-00" target="_blank">
                        <img src="assets/i/icons/WhatsApp.png" alt="WhatsApp: 8 923 510-70-00" />
                    </a>
                </div>
            </div>
        </div>
    </div>
</footer>

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

        $_modx->config.assets_url ~ 'js/slick.min.js' ~  ', ' ~

        $_modx->config.assets_url ~ 'js/app.js' ~  ', '
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

{if 1 != $.cookie.city_was_chosen}
<div id="city-selection" class="modal fade" tabindex="-1" role="dialog" >
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Выбор города</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Закрыть"><span aria-hidden="true">×</span></button>
            </div>
            <form id="city-selection-form">
                <div class="modal-body">
                    {set $cities = $_modx->runSnippet('@FILE snippets/dmCities.php', [
                        'mode' => 'shortInfo',
                    ])}
                    {set $i = 0}
                    {foreach $cities as $city => $cityInfo}
                        {set $cityId = 'city-selection-city'~($i + 1)}
                        <div>
                            <input id="{$cityId}" name="selected-city" type="radio" value="{$city}">
                            <label for="{$cityId}">{$city}</label>
                        </div>
                        {set $i = $i + 1}
                    {/foreach}
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary">Ок</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    {ignore}
        // Really sorry for the bad code, but there is no time for a good one
        $('#city-selection').modal('show');
        $('#city-selection-form').on('submit', function (event) {
            event.preventDefault();

            var
                selectedCity = $('#city-selection-form input:checked')[0],
                previousRemainTV = $('.city.active').data('remain-tv'),
                currentRemainTV,
                previousPriceTV = $('.city.active').data('price-tv'),
                currentPriceTV
            ;
            if (undefined !== selectedCity) {
                $.post(
                    '/assets/components/cityselector/index.php',
                    { selected_city: selectedCity.value },
                    function(response) {
                        response = JSON.parse(response);
                        if (response.success) {
                            $('.cities').each(function () {
                                var cityData;
                                $(this).find('.city')
                                    .removeClass('active')
                                    .filter(function() {
                                        if ($(this).text() === selectedCity.value) {
                                            currentRemainTV = $(this).data('remain-tv');
                                            currentPriceTV = $(this).data('price-tv');
                                            cityData = {
                                                phone: $(this).data('phone'),
                                                phoneHref: 'tel:' + $(this).data('phone-href'),
                                            };
                                            return true;
                                        }

                                        return false;
                                    })
                                    .addClass('active')
                                ;
                                var $cityPhone = $(this).find('.city-phone');
                                $cityPhone.text(cityData.phone);
                                if ($cityPhone.is('a')) {
                                    $cityPhone.attr('href', cityData.phoneHref);
                                }
                            });
                            // Reload if it's a page that should be reloaded
                            if (
                                $('#contacts').length ||
                                $('#mse2_results').length ||
                                $('#product').length
                            ) {
                                let url = window.location.href;
                                // Replace city remain template variable
                                if ($('#mse2_results').length) {
                                    if (-1 !== url.indexOf('tv|'+previousRemainTV)) {
                                        url = url.replace('tv|'+previousRemainTV, 'tv|'+currentRemainTV);
                                    }
                                    if (-1 !== url.indexOf('tv|'+previousPriceTV)) {
                                        url = url.replace('tv|'+previousPriceTV, 'tv|'+currentPriceTV);
                                    }
                                } else if ($('#product').length) {
                                    getProduct($('#product').attr('data-url'));
                                    $('#city-selection').modal('hide');
                                    return false;
                                }
                                window.location.href = url;
                            }
                        }
                        $('#city-selection').modal('hide');
                    }
                )
            } else {
                $('#city-selection').modal('hide');
            }
        });
    {/ignore}
</script>
{/if}


{if $_modx->config.site_debug_info}
<!--
{$_modx->getInfo()}
-->
{/if}
