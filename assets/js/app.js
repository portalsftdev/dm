/**
 * TODO:
 * 1. Remove useless code.
 */

/**
 *
 * PHP's number_format() equivalent
 * @link https://gist.github.com/leodutra/2919561
 *
 */

function numberFormat(number, decimals, dec_point, thousands_sep)
{
    // http://kevin.vanzonneveld.net/techblog/article/javascript_equivalent_for_phps_number_format/
    number = (number + '').replace(/[^0-9+\-Ee.]/g, '');
    var n = !isFinite(+number) ? 0 : +number,
        prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
        sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
        dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
        s = '',
        toFixedFix = function (n, prec)
        {
            var k = Math.pow(10, prec);
            return '' + Math.round(n * k) / k;
        };
    // Fix for IE parseFloat(0.55).toFixed(0) = 0;
    s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
    if (s[0].length > 3)
    {
        s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
    }
    if ((s[1] || '').length < prec)
    {
        s[1] = s[1] || '';
        s[1] += new Array(prec - s[1].length + 1).join('0');
    }
    return s.join(dec);
}

$(function() {

    'use strict';

    /**
     *
     * Filter switching handler (show/hide dependent filters)
     *
     */

    var filterSwitchers = document.querySelectorAll(".filter-switcher");

    for (var i = filterSwitchers.length - 1; i >= 0; i--) {
        var filterSwitcher = filterSwitchers[i];
        filterSwitchHandler(filterSwitcher);
    }

    function filterSwitchHandler(filterSwitcher) {
        filterSwitcher.addEventListener('click', function(e) {
            var $target = $($(this).data('switch'));
            // Check -> open
            if (!$(this).siblings('input').is(':checked')) {
                $target.slideDown(); //.show();
            // Uncheck -> close
            } else {
                $target.find('input:checked').prop('checked', false);
                $target.slideUp(); //.hide();
            }
        });
    }

    /**
     *
     * Transform all checkbox inputs to CSV
     *
     */

    $(document).on('submit', '.doorSelectionForm', function(e) {
        let filterValueDelimiter = mse2Config.values_delimeter || ',';
        let checkedCheckboxes = this.querySelectorAll('input[type="checkbox"]:checked');
        // Get all checked filter values
        let checkboxValues = {};
        for (var i = checkedCheckboxes.length - 1; i >= 0; i--) {
            if (typeof checkboxValues[checkedCheckboxes[i].name] === 'undefined') {
                checkboxValues[checkedCheckboxes[i].name] = [];
            }
            checkboxValues[checkedCheckboxes[i].name].push(checkedCheckboxes[i].value);
        }
        for (var key in checkboxValues) {
            // Remove all inputs with certain name from DOM
            $(this).find('input[name="' + key + '"]').removeAttr('name');
            // Add only one input with certain name and delimiter separated values
            $(this).append($('<input />', {
              'type': 'hidden',
              'name': key,
              'value': checkboxValues[key].join(filterValueDelimiter),
            }));
        }
    });

    /**
     *
     * Switch upward/downward pointing arrows when sorting (CSS hasn't left neighbor selector)
     *
     */

    var sortLinks = document.querySelectorAll(".sort");

    for (var i = sortLinks.length - 1; i >= 0; i--) {
        var sortLink = sortLinks[i];
        sortLinkClickHandler(sortLink);
    }

    function sortLinkClickHandler(sortLink) {
        sortLink.addEventListener('click', function(e) {
            $(this).siblings('.ml-3').text('');
            var sortDirection = $(this).attr('data-dir');
            if (sortDirection === '') {
                sortDirection = $(this).attr('data-default');
            // It was ASC, now it DESC
            } else if (sortDirection == 'asc') {
                sortDirection = 'desc';
            } else if (sortDirection == 'desc') {
            // It was DESC, now it ASC
                sortDirection = 'asc';
            }
            $(this).prev().text(sortDirection == 'asc' ? '↓' : '↑');
        });
    }

    // Input mask for phones
    new Inputmask({
        'mask': '+7 (999) 999-9999'
    }).mask(document.querySelectorAll('input[type="tel"]'));

    /**
     *
     * Show notification and check mark after a form completion
     *
     */

    $(document).on('af_complete', function(event, response) {
        // Turn off jGrowl
        AjaxForm.Message.error = function() {
            return false;
        };
        AjaxForm.Message.success = function() {
            return false;
        };
        var notificationMessages = {
            servicedesk: '<strong>Сообщение отправлено!</strong> Мы свяжемся с вами в ближайшее время.',
            coupon: '<strong>Купон отправлен!</strong> Проверьте свою электронную почту.',
            'product-availability': '<strong>Сообщение отправлено!</strong> Мы свяжемся с вами в ближайшее время.',
            'product-price-order': '<strong>Сообщение отправлено!</strong> Мы свяжемся с вами в ближайшее время.',
            'measurement-order': '<strong>Сообщение отправлено!</strong> Мы свяжемся с вами в ближайшее время.',
        };
        var $form = response.form;
        var $checkMark = $('<div>', {
           'class': 'check-mark',
        });
        var formDefaultHandler = function($form, successMessage, $checkMark) {
            // Remove previously added success messages
            $form.find('.success-message').remove();
            if (response.success) {
                var $successMessage = $('<p>', {
                    class: 'success-message',
                    html: successMessage,
                });
                $checkMark.insertAfter($form.find('button'));
                $successMessage.insertAfter($checkMark);
            } else {

            }
        };
        // Remove previously added check marks
        $form.find('.check-mark').remove();
        if ($form.hasClass('servicedesk')) {
            var $p = $form.siblings('p');
            if (response.success) {
                // Save previous content
                $p.attr('data-content', $p.html());
                // Show notification
                $p.addClass('success-message').html(notificationMessages.servicedesk);
                // Show check mark
                $checkMark.insertAfter($form.find('input[name="phone"]'));
            } else {
                // Show previous content
                $p.removeClass('success-message').html($p.data('content')).removeAttr('data-content');
            }
        } else if ($form.hasClass('coupon')) {
            formDefaultHandler($form, notificationMessages.coupon, $checkMark);
        } else if ($form.hasClass('product-availability')) {
            formDefaultHandler($form, notificationMessages['product-availability'], $checkMark);
        } else if ($form.hasClass('product-price-order')) {
            formDefaultHandler($form, notificationMessages['product-price-order'], $checkMark);
        } else if ($form.hasClass('measurement-order')) {
            formDefaultHandler($form, notificationMessages['measurement-order'], $checkMark);
        }
    });

    /**
     *
     * Switch a city and show its phone
     *
     */

    $('.city').click(function() {
        // Do nothing if it's an active city
        if ($(this).hasClass('active')) {
            return false;
        }
        var onSelectCitySuccess = function () {
            $('.cities').each(function() {
                $(this).find('.city')
                    .removeClass('active')
                    .filter(function() {
                        return $(this).text() === cityData.name;
                    }).addClass('active');
                var $cityPhone = $(this).find('.city-phone');
                $cityPhone.text(cityData.phone);
                if ($cityPhone.is('a')) {
                    $cityPhone.attr('href', cityData.phoneHref);
                }
            });
        };
        var cityData = {
          name: $(this).text(),
          phone: $(this).data('phone'),
          phoneHref: 'tel:' + $(this).data('phone-href'),
        };
        var connectorURL = '/assets/components/cityselector/index.php';
        var data = {
            'selected_city': cityData.name,
        };
        let
            currentRemainTV = $(this).data('remain-tv'),
            previousRemainTV = $(this).closest('.cities').find('.active').data('remain-tv'),
            currentPriceTV = $(this).data('price-tv'),
            previousPriceTV = $(this).closest('.cities').find('.active').data('price-tv')
        ;
        $.post(connectorURL, data, function(r) {
            if (r.success) {
                onSelectCitySuccess();
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
                        return false;
                    }
                    window.location.href = url;
                }
            } else {
                alert(r.message);
            }
        }, 'json');
    });

    // Initialize Kladr API
    var $legalAddress = $('[name="legal-address"]');
    $legalAddress.kladr({
        oneString: true,
    });

    // Mask for INN
    new Inputmask({
        'mask': '9999999999' // A digit x 10
    }).mask(document.querySelectorAll('input[name="inn"]'));

    // Mask for KPP
    new Inputmask({
        'mask': '999999999' // A digit x 9
    }).mask(document.querySelectorAll('input[name="kpp"]'));

    // Turn off dropzone autodiscovering
    Dropzone.autoDiscover = false;

    // Get extension of a filename
    function getFileExtension(fileName) {
        return fileName.substring(fileName.lastIndexOf('.') + 1, fileName.length) || fileName;
    }

    // Remove dropzone file preview
    function removeFilePreview(file) {
        if (file.previewElement !== null && file.previewElement.parentNode !== null) {
            file.previewElement.parentNode.removeChild(file.previewElement);
        }
    }

    // Create dropzone programmatically
    $("#requisites").dropzone({
        url: '/assets/components/fileupload/index.php',
        autoProcessQueue: true,
        paramName: 'requisites',
        addRemoveLinks: true,
        maxFiles: 5,
        parallelUploads: 5,
        maxFilesize: 25,
        dictRemoveFile: 'Удалить',
        dictMaxFilesExceeded: 'Превышено разрешенное количество файлов',
        dictFileTooBig: 'Недопустимый размер файла. Размер файла не должен превышать 5 мб',
        dictCancelUpload: 'Отмена загрузки',
        init: function () {
            // @link https://github.com/enyo/dropzone/wiki/FAQ#how-to-show-files-already-stored-on-server
            var dz = this;
            $.post(dz.options.url, function(data) {
                $.each(data, function (key, value) {
                    var mockFile = {
                        name: value.name,
                        size: value.size,
                        type: 'image/jpg',
                    };
                    var fileExtension = getFileExtension(value.name);
                    dz.emit('addedfile', mockFile);
                    if ($.inArray(fileExtension, ['png', 'jpg', 'jpeg', 'png']) != -1) {
                        // Generating preview problem
                        // @link https://github.com/enyo/dropzone/issues/934
                        // @link https://github.com/enyo/dropzone/issues/1488
                        // dz.createThumbnailFromUrl(mockFile, value.dirname + '/' + value.name));
                        dz.emit('thumbnail', mockFile, value.dirname + '/' + value.name);
                    }
                    dz.emit('complete', mockFile);
                    dz.files.push(mockFile);
                });
            });
        },
        success: function (file, response) {
            if (response.error) {
                // file.previewElement.classList.add('dz-error');
                // $(file.previewElement).find('.dz-error-message').text(response.error);
                alert(response.error);
                removeFilePreview(file);
            } else if (response.success) {
                file.previewElement.classList.add('dz-success');
                this.emit('complete', file);
            }
        },
        removedfile: function(file) {
            var dz = this;
            var data = { fn: file.name };
            $.post(dz.options.url, data, function(r) {});
            removeFilePreview(file);
        },
        maxfilesexceeded: function(file) {
            // Handles by success handler
        },
        error: function (file, response) {
            var message = response || 'Во время загрузки файла произошла ошибка. Попробуйте позже';
            // file.previewElement.classList.add('dz-error');
            // $(file.previewElement).find('.dz-error-message').text(message);
            alert(message);
            removeFilePreview(file);
        }
    });

    function recountTotalRowCost($this) {
        var $productPrice = $this.closest('#door-complectation').length > 0
            ? $this.closest('tr').find('.ms2_product_price')
            : $this.closest('form').find('.ms2_product_price');
        var count = parseFloat($this.val());
        var price = parseInt($productPrice.text().replace( /\s+/g, ''));
        var sum = count * price;
        var numberFormatSettings = {
            decimals: sum % 1 === 0 ? 0 : 2, // No decimals if sum isn't float
            dec_point: '.',
            thousands_sep: ' ',
        };
        $this.closest('tr')
            .find('.ms2_total_row_cost')
            .text(numberFormat(
                sum,
                numberFormatSettings.decimals,
                numberFormatSettings.dec_point,
                numberFormatSettings.thousands_sep
            ));
    }

    // Change total row cost after a product count change
    $(document).on('change', ' #complectation-items input[name="count"], #door-complectation input[name="count"]', function() {
        recountTotalRowCost($(this));
    });

    // Smooth scroll
    var smoothScroll = function(elementID, duration) {
        $('html, body').animate({
            scrollTop: $(elementID).offset().top
        }, duration);
    };

    /**
     *
     * Service desk links handling
     *
     */

    var serviceDeskID = 'servicedesk',
        inputIDPrefix = 'phone-for-';

    function serviceDeskLinkHandler(anchor) {
        var path = anchor.split('/');
        smoothScroll(path[0], 500);
        $('#' + inputIDPrefix + path[1]).focus();
    }

    // Only from pages that have the service desk element
    $('.servicedesk-link').on('click', (function() {
        if ($('#' + serviceDeskID).length) {
            $('.cmn-toggle-switch').trigger('click');
            window.history.pushState('', '', window.location.pathname + $(this).attr('href'));
            serviceDeskLinkHandler($(this).attr('href'));
            return false;
        }
    }));

    // URL has anchor of service desk
    if (window.location.hash.indexOf('#' + serviceDeskID) === 0) {
        serviceDeskLinkHandler(window.location.hash);
    }

    /**
     *
     * Adding or changing cart product count in one input
     * and bilateral input switching of complectation items (options) and complectation table
     *
     */

    $(document).on('change', '#door-complectation input[type="number"], #complectation-items input[type="checkbox"]', function() {
        var $form = $(this).closest('.ms2_form');
        var $formSubmit = $form.find('[type="submit"]');
        var linkName = $form.data('link-name');
        var id = $form.data('id');
        var isDoorComplectation = !($(this).attr('id') !== undefined && $(this).attr('id').indexOf('complectation-item') === 0);
        var value = isDoorComplectation ? $(this).val() : $form.find('input[name="count"]').val();
        const minimalProductCount = 0.2;
        var $targetForm = $(
            '#' + (isDoorComplectation ? 'complectation-items' : 'door-complectation')
            + ' form[data-link-name="' + linkName + '"]'
            + '[data-id="' + id + '"]'
        );
        var $targetFormSubmit = $targetForm.find('[type="submit"]');
        var $targetFormCountInput = $targetForm.find('input[name="count"]');
        // After adding to the cart
        miniShop2.Callbacks.Cart.add.response.success = function(response) {
            $form.append($('<input>', {
              'type': 'hidden',
              'name': 'key',
              'value': response.data.key,
            }));
            $formSubmit.val(isDoorComplectation ? 'cart/change' : 'cart/remove');

            // Change state of complectation item form
            if (isDoorComplectation) {
                $targetForm.find('input[type="checkbox"]').prop('checked', true);
                $targetForm.append($('<input>', {
                  'type': 'hidden',
                  'name': 'key',
                  'value': response.data.key,
                }));
                $targetFormSubmit.val('cart/remove');
            // Change state of a complectation item in complectation form
            } else {
                $targetFormCountInput.val(value);
                recountTotalRowCost($targetFormCountInput);
                $targetForm.append($('<input>', {
                  'type': 'hidden',
                  'name': 'key',
                  'value': response.data.key,
                }));
                $targetFormSubmit.val('cart/change');
            }
        };
        // After changing count of a product in the cart
        miniShop2.Callbacks.Cart.change.response.success = function(response) {
            if (value < minimalProductCount) {
                $form.find('input[name="key"]').remove();
                $formSubmit.val('cart/add');
                // Change state of complectation item form
                if (isDoorComplectation) {
                    $targetForm.find('input[type="checkbox"]').prop('checked', false);
                    $targetForm.find('input[name="key"]').remove();
                    $targetFormSubmit.val('cart/add');
                }
            }
        };
        // After removing a product from the cart
        miniShop2.Callbacks.Cart.remove.response.success = function(response) {
            $form.find('input[name="key"]').remove();
            $formSubmit.val('cart/add');

            // Change state of a complectation item in complectation form
            if (!isDoorComplectation) {
                $targetFormCountInput.val(0);
                recountTotalRowCost($targetFormCountInput);
                $targetForm.find('input[name="key"]').remove();
                $targetFormSubmit.val('cart/add');
            }
        };
    });

    $(document).on('click', '#door-complectation [data-spin]', function() {
        let $form = $(this).closest('.ms2_form'),
            $input = $form.find('[name="count"]'),
            currentInputValue = $input.val();
        if ('plus' == $(this).data('spin')) {
            currentInputValue++;
        } else if ('minus' == $(this).data('spin')) {
            currentInputValue--;
        }
        if (0 <= currentInputValue) {
            $input.val(currentInputValue);
            $input.trigger('change');
        }
    });

    // Submit form when switching complectation items (options)
    $(document).on('click', '[id^=complectation-item]', function() {
        var $form = $(this).closest('.ms2_form').submit();
    });

    /**
     *
     * Order: change payer type variable when the payer type is switching
     * Order: prevent input elements with same names (each payer type has inputs with same names)
     *
     */

    $('[data-payer-type]').click(function() {
        $('#msOrder').find('input[name$="payer-type"]').val($(this).data('payer-type'));
        var targetHref = $(this).attr('href');
        var $links = $(this).closest('.nav').find('.nav-link');
        // Remove attr "name" from all inputs that have attr "data-name"
        $links.each(function() {
            if ($(this).attr('href') !== undefined && $(this).attr('href') != targetHref) {
                $($(this).attr('href')).find('[data-name]').removeAttr('name');
            }
        });
        // Add attr "name" for all inputs that have attr "data-name"
        $(targetHref).find('[data-name]').each(function() {
           $(this).attr('name', $(this).attr('data-name'));
        });
    });

    /**
     *
     * Order: merge name and surname into receiver
     *
     */

    $('input[name="name"], input[name="surname"]').on('input', function(e){
        var name = $('input[name="name"]').val();
        var surname = $('input[name="surname"]').val();
        var receiver;
        if (name.length === 0 && surname.length === 0) {
            receiver = 'Не указан';
        } else {
            receiver = name + ' ' + surname;
        }
        $('input[name="receiver"]').val(receiver);
    });

    /**
     *
     * Order: scroll up to the first input error
     *
     */

    // Be sure that miniShop2 is defined, otherwise 'miniShop2 is not defined' error can be occurred
    if (typeof miniShop2 != 'undefined') {
        miniShop2.Callbacks.Order.submit.response.error = function (response) {
            var $input = $('input[name="' + response.data[0] + '"]:visible');
            $('html,body').scrollTop($input.offset().top - 8);
        };
    }

    /**
     *
     * Set "data-msfavorites-mode" for wishlist links only at wishlist page
     *
     */

    if ($('#msfavorites-list').length > 0) {
        $('.msfavorites').attr('data-msfavorites-mode', 'list');
    }

    /*
     *
     * Initialize lightGallery for blog
     *
     */

    $('#blog-lightGallery').lightGallery({
        download: false,
        selector: 'img',
        exThumbImage: 'data-preview-src',
    });

    /**
     *
     * Discount coupon modal window show or hide
     *
     */

    $('#discount-coupon').on('shown.bs.modal', function (e) {
        let preformEmail = $('#discount-coupon-preform input[type="email"]').val();
        if (preformEmail) {
            $(this).find('input[type="email"]').val(preformEmail);
            // Need to check this behaviour in Safari
            // $(this).find('input[type="tel"]').focus();
        } else {
            // $(this).find('input[type="email"]').focus();
        }
    });

    $('#discount-coupon').on('hide.bs.modal', function (e) {
        $(this).find('input[type="email"]').val('');
        $(this).find('input[type="tel"]').val('');
    });

    /**
     *
     * Captcha refresh
     *
     */

    function captchaRefresh($captchaImage) {
        let src = $captchaImage.attr('src');
        if (src.indexOf('?') !== undefined) {
            src = src.split('?')[0];
        }
        $captchaImage.attr('src', src + '?r=' + Math.random());
    }

    // Manual refresh
    $('.captcha-refresh').on('click', function (e) {
        e.preventDefault();
        let $captchaImage = $(this).closest('.captcha').find('img');
        captchaRefresh($captchaImage);
    });

    // Form submit refresh
    $(document).on('af_complete', function(event, response) {
        if (response.form.find('.captcha').length == 1) {
            let $captchaImage = response.form.find('.captcha img');
            captchaRefresh($captchaImage);
        }
    });

});

/**
 *
 * Set/unset product name variable when ordering a price from the product list or the product page
 *
 */

// Set product name variable
$(document).on('click', '[data-target="#product-price-order"]', function () {
    let $productNameInput = $('#product-price-order').find('input[name="product_name"]');
    let productName;
    // Order from product list
    if ($('#mse2_results').length > 0) {
        productName = $(this).closest('.card-block').find('.card-title').text();
    // Order from product page
    } else {
        productName = $('input[name="pagetitle"]').val();
    }
    $productNameInput.val(productName);
});

// Unset product name variable to prevent unnecessary behaviour
$(document).on('hide.bs.modal', '#product-price-order', function (e) {
    let $productNameInput = $('#product-price-order').find('input[name="product_name"]').val('');
});

/**
 *
 * Remove error or success message after a modal window closing
 *
 */

$(document).on('hide.bs.modal', '#expo_available, #discount-coupon, #product-price-order', function (e) {
    $(this).find('.check-mark').remove();
    $(this).find('.success-message').remove();
    $(this).find('.error > .error').remove();
    $(this).find('.error').removeClass('error');
});

/**
 *
 * Set stars count in product review form on mouseover
 *
 */

$(document).on('mouseenter touchstart', '.rating-stars input + label', function() {
    let $stars = $(this).closest('div').find('[class*="icon-"]'); // [class^="icon-"] doesn't work properly
    let ratingValue = $('#'+$(this).attr('for')).val();
    $stars.each(function(key, value) {
        if (ratingValue >= key + 1) {
            $(this).removeClass('icon-star-o').addClass('icon-star');
        } else {
            $(this).removeClass('icon-star').addClass('icon-star-o');
        }
    });
});

/**
 * Show product with another property (e.g. color)
 * History must not be changed
 */

function getProduct(url) {
    $('#product, #product-tabs, #joint-products, .product-complectation').css('opacity', '.5');
    let productSizesAreExpanded = $('#product-sizes').hasClass('expanded'),
        activeProductTabSelector = $('#product-tabs').find('[data-toggle="tab"].active').attr('href');
    $.ajax({
        url: url,
        type: 'get',
        dataType: 'html',
        success: function(response) {
            let title = $(response).filter('title').text(),
                $productInfo = $(response).find('#product'),
                $productTabs = $(response).find('#product-tabs'),
                $jointProducts = $(response).find('#joint-products'),
                $productComplectation = $(response).find('.product-complectation')
            ;
            // Expand product sizes
            if (productSizesAreExpanded) {
                let $productSizeToggle = $productInfo.find('.product-size-toggle');
                $productInfo.find('.product-size-toggle').attr('aria-expanded', 'true');
                $productInfo.find($productSizeToggle.attr('data-show')).css('display', 'block').addClass('expanded');
                $productInfo.find($productSizeToggle.attr('data-hide')).css('display', 'none');
            }
            // Set active product tab
            $productTabs.find('[data-toggle="tab"].active').removeClass('active');
            $productTabs.find('.tab-pane.active').removeClass('active');
            $productTabs.find('[data-toggle="tab"][href="'+activeProductTabSelector+'"]').addClass('active');
            $productTabs.find(activeProductTabSelector).addClass('active');
            // Set edited HTML
            let productInfoHTML = $productInfo.html(),
                productTabsHTML = $productTabs.html()
            ;
            if (undefined === title || undefined === productInfoHTML || undefined === productTabsHTML) {
                alert('Произошла ошибка. Попробуйте позже.');
            } else {
                // Update title & nodes
                document.title = title;
                $('#product').html(productInfoHTML);
                $('#product-tabs').html(productTabsHTML);
                // Process product complectation
                if (0 === $productComplectation.length) {
                    $('.product-complectation').remove();
                } else {
                    if (0 < $('.product-complectation').length) {
                        $('.product-complectation').html($productComplectation.html());
                    } else {
                        $('#product').after($productComplectation);
                    }
                }
                // Process joint products (FIXME: Place joint products after product complectation if last is present.)
                if (0 == $jointProducts.length) {
                    $('#joint-products').remove();
                } else {
                    if (0 < $('#joint-products').length) {
                        $('#joint-products').html($jointProducts.html());
                    } else {
                        $('#product').after($jointProducts);
                    }
                    initialiseJointProducts();
                }
                // Remove tooltip
                $('[role="tooltip"]').remove();
                // Reinitialise tooltips
                $('[data-toggle="tooltip"]').tooltip();
                // Reinitialise Fotorama
                let $gallery = $('.fotorama');
                if ($gallery.length) {
                    $('.fotorama').fotorama();
                }
                // Reinitialise input mask
                new Inputmask({
                    'mask': '+7 (999) 999-9999'
                }).mask(document.querySelectorAll('input[type="tel"]'));
            }
            $('#product').attr('data-url', url);
            $('#product, #product-tabs, #joint-products, .product-complectation').css('opacity', '1');
        }
    });
}

$(document).on('click', '.model-property', function(e) {
    e.preventDefault();
    getProduct($(this).attr('data-uri'));
});

/**
 * Show/hide product sizes
 */

$(document).on('click', '.product-size-toggle', function() {
    let $elementsToShow = $($(this).data('show')),
        $elementsToHide = $($(this).data('hide'));
    if ('false' == $(this).attr('aria-expanded')) {
        $('.product-size-toggle').attr('aria-expanded', 'true');
    } else {
        $('.product-size-toggle').attr('aria-expanded', 'false');
    }
    $elementsToShow.toggleClass('expanded');
    if ('none' == $elementsToShow.css('display')) {
        $elementsToShow.slideDown();
        $elementsToHide.slideUp();
    } else {
        $elementsToShow.slideUp();
        $elementsToHide.slideDown();
    }
});

/**
 * Adding/changing/removing a product with certain size
 */

function processProductCountChange($form, $input)
{
    let $formSubmit = $form.find('[type="submit"]');
    $form.submit();
    miniShop2.Callbacks.Cart.add.response.success = function(response) {
        $form.append($('<input>', {
          'type': 'hidden',
          'name': 'key',
          'value': response.data.key,
        }));
        $formSubmit.val('cart/change');
    };
    miniShop2.Callbacks.Cart.change.response.success = function(response) {
        if (0 == $input.val()) {
            $form.find('input[name="key"]').remove();
            $formSubmit.val('cart/add');
        }
    };
    miniShop2.Callbacks.Cart.remove.response.success = function(response) {
        $form.find('input[name="key"]').remove();
        $formSubmit.val('cart/add');
    };
}

// @link https://gist.github.com/ericchen/947727
var delay = (function(){
  var timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})();

// Input direct change with 750 ms delay
$(document).on('keyup', '#product-sizes input[name="count"]', function() {
    let $this = $(this);
    delay(function() {
        let $form = $this.closest('.ms2_form'),
            $input = $form.find('[name="count"]'),
            currentInputValue = $input.val();
        if ('' === currentInputValue)  {
            currentInputValue = 0;
        } else {
            currentInputValue = parseInt(currentInputValue);
        }
        if (! isNaN(currentInputValue) && 0 <= currentInputValue) {
            processProductCountChange($form, $input);
        }
    }, 750 );
});

// Input plus/minus
$(document).on('click', '#product-sizes [data-spin], #joint-products [data-spin]', function() {
    let $form = $(this).closest('.ms2_form'),
        $input = $form.find('[name="count"]'),
        currentInputValue = $input.val();
    if ('plus' == $(this).data('spin')) {
        currentInputValue++;
    } else if ('minus' == $(this).data('spin')) {
        currentInputValue--;
    }
    if (0 <= currentInputValue) {
        $input.val(currentInputValue);
        processProductCountChange($form, $input);
    }
});

/**
 * Open a tab manually
 */

$(document).on('click', '.tab-open', function() {
    let selector = $(this).attr('data-target');
    $('[href="'+selector+'"]').tab('show');
    $('html, body').animate({
        scrollTop: $('[href="'+selector+'"]').offset().top - 32
    }, 250);
});

/**
 * Reinitialise tooltips after mSearch2 has finished loading
 */

$(document).on('mse2_load', function(e, data) {
    // Reinitialise tooltips
    $('[data-toggle="tooltip"]').tooltip();
});

/**
 * Show/hide filters at product list page
 */

function toggleFilters($filters, $toggler)
{
    let duration = $filters.attr('data-duration');
    if ($filters.hasClass('expanded')) {
        $filters.slideUp(duration);
        $toggler.text($toggler.attr('data-hidden-text'));
    } else {
        $filters.slideDown(duration, function() {
            $(this).css('display', 'flex');
        });
        $toggler.text($toggler.attr('data-shown-text'));
    }
    setTimeout(function(){
        $filters.toggleClass('expanded');
    }, duration);
}

let userPreferencesConnectorURL = '/assets/components/userpreferences/index.php';
$(document).on('click', '.user-preference', function() {
    let $this = $(this),
        $target = $($this.attr('data-target')),
        data = {
            'key': $this.attr('data-user-preference-key'),
            'value': $this.attr('data-user-preference-value') == 'true' ? 'false' : 'true'
        }
    ;
    $.post(userPreferencesConnectorURL, data, function(response) {
        if (response.success) {
            $this.attr('data-user-preference-value', data.value);
            toggleFilters($target, $this);
        } else {
            alert(response.message);
        }
    }, 'json');
});

/**
  * Joint products at product card slider
  */
function initialiseJointProducts() {
    $('#joint-products .slider-items').slick({
        slidesToShow: 4,
        prevArrow: '.slider-btn-prev',
        nextArrow: '.slider-btn-next',
        // autoplay: true,
        touchThreshold: 25,
        responsive: [
            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 1
                }
            },
            {
                breakpoint: 992,
                settings: {
                    slidesToShow: 2
                }
            },
            {
                breakpoint: 1200,
                settings: {
                    slidesToShow: 3
                }
            }
        ]
    });
}

initialiseJointProducts();

/**
 * Cart button animation.
 */

$(document).on('click',
    'button[name="ms2_action"][value="cart/add"], ' +
    'button[name="ms2_action"][value="cart/change"], ' +
    'button[name="ms2_action"][value="cart/remove"]'
, function() {
    $(this)
        .addClass('animated bounceIn')
        .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
            $(this).removeClass('animated bounceIn');
        });
    ;
});

/**
 * Fake number input.
 */

function processFakeNumberInput(input, operation) {
    if ('+' !== operation && '-' !== operation) {
        return;
    }

    // TODO: Check if min, step or max is NaN.
    var min = null !== input.getAttribute('min') ? parseFloat(input.getAttribute('min')) : -Infinity,
        step = null !== input.getAttribute('step') ? parseFloat(input.getAttribute('step')) : 1,
        max = null !== input.getAttribute('max') ? parseFloat(input.getAttribute('max')) : Infinity,
        value = parseFloat(input.value),
        result
    ;

    if (isNaN(value)) {
        value = 0;
    }

    if ('+' === operation) {
        // Custom requirement
        if (input.classList.contains('increase-from-0-to-1') && 0 === value) {
            result = 1;
        // Normal flow
        } else {
            result = value + step;
        }
        if (result > max) {
            return;
        }
    } else if ('-' === operation) {
        result = value - step;
        if (result < min) {
            return;
        }
    }

    result = Math.round(result * 100) / 100;
    input.value = result
}

function processFakeNumberInputSpinner(el) {
    var input = $(el).closest('.input-spinnerable').find('[data-spinnerable]')[0];
    if (el.classList.contains('plus')) {
        processFakeNumberInput(input, '+')
    } else if (el.classList.contains('minus')) {
        processFakeNumberInput(input, '-')
    }
}

$(document).on('mousedown', '.input-spinnerable .minus, .input-spinnerable .plus', function(event) {
    var _this = this,
        intervalId = setInterval(function () { processFakeNumberInputSpinner(_this); }, 100);
    $(this).on('mouseup mouseout', function() {
        clearInterval(intervalId);
    });
});

$(document).on('click', '.input-spinnerable .minus, .input-spinnerable .plus', function() {
    processFakeNumberInputSpinner(this);
    $(this).closest('.input-spinnerable').find('[data-spinnerable]').trigger('change');
});

/**
 * Counting of product complectation item sum, complectation sum and total sum.
 */

function countTableItemCost(input, rowSelector) {
    var count = parseFloat($(input).val()) || 0,
        price = parseFloat($(input).closest(rowSelector).find('.ms2_product_price').attr('data-value')),
        sum = count * price
    ;
    return sum;
}

function setSum(selector, sum) {
    $(selector)
        .attr('data-value', sum)
        .text(
            numberFormat(
                sum,
                0 === sum % 1 ? 0 : 2, // No decimals if sum isn't float
                '.',
                ' ',
            )
        )
    ;
}

function getProductPrice() {
    return parseFloat($('#product-price').attr('data-value'));
}

$(document).on('change', '.product-complectation [data-spinnerable]', function() {
    var
        // rowSelector = 'tr',
        rowSelector = '.product-complectation-list-item',
        itemSum = countTableItemCost($(this), rowSelector)
    ;

    // Set item sum
    $(this).closest(rowSelector)
        .find('.ms2_total_row_cost')
        .attr('data-value', itemSum)
        .text(numberFormat(
            itemSum,
            0 === itemSum % 1 ? 0 : 2, // No decimals if sum isn't float
            '.',
            ' ',
        ))
    ;

    // Set complectation sum and total sum
    var complectationSum = 0,
        totalSum = getProductPrice()
    ;
    $(this).closest('.product-complectation').find('.ms2_total_row_cost').each(function(index, item) {
        complectationSum += parseFloat($(item).attr('data-value'));
    });
    totalSum += complectationSum;

    setSum('.complectation-sum', complectationSum);
    setSum('.total-sum', totalSum);
});

/**
 * Add a product and its complectation (if present) to cart.
 */

$(document).on('click', '[data-action="add-to-cart"]', function() {
    var count = 0,
        totalCount = 0,
        queryStrings = []
    ;
    $('form.custom-ms2-form').each(function(key, form) {
        count = $(form).find('input[name*=count]').val()
        if (0 < count) {
            totalCount += count;
            queryStrings.push($(form).serialize());
        }
    });

    if (queryStrings.length) {
        $.ajax({
            url: '/assets/components/minishop2/h.php',
            type: 'post',
            data: queryStrings.join('&'),
            dataType: 'json',
            success: function(response) {
                if (response.cartStatus) {
                    var notificationBody = 1 < totalCount
                        ? 'Товары добавлены в корзину.'
                        : 'Товар добавлен в корзину.'
                    ;
                    $('#added-to-cart').find('.modal-body').html(notificationBody);
                    $('#added-to-cart').modal('show');
                    $('.ms2_total_count').text(response.cartStatus.total_count);
                    $('.ms2_total_cost').text(response.cartStatus.total_cost);
                } else if (response.error) {
                    alert(response.error);
                }
            }
        });
    }
});

/**
 * Disable filter capability during filtering (i.e. next filtration should be
 * **after** previous).
 */

var mSearchFilterSelectors = '#mse2_filters input[type="checkbox"], #mse2_filters input[type="radio"], #mse2_filters select, #mse2_filters input[type="reset"]';
$(document).on('change', mSearchFilterSelectors, function() {
    document.getElementById('mse2_filters').style.opacity = .5;
    document.getElementById('mse2_filters').style.pointerEvents = 'none';
});

$(document).on('mse2_load', function(event, response) {
    document.getElementById('mse2_filters').style.pointerEvents = 'auto';
    document.getElementById('mse2_filters').style.opacity = 1;
});

/**
 * ...
 */

$(document).on('change', 'form#product-complectation-telescopic-and-non-telescopic input[type="checkbox"]', function() {
    var
        // complectationListSelector = '#product-complectation-non-specific tbody',
        // totalRowSelector = complectationListSelector + ' tr.total',
        complectationListSelector = '#product-complectation-non-specific',
        totalRowSelector = complectationListSelector + ' .product-complectation-total-sum',
        $form = $(this).closest('form'),
        $totalRow = $(totalRowSelector)
    ;
    $totalRow = 0 < $totalRow.length ? $totalRow.clone(true) : null;
    $.ajax({
        url: '/assets/components/productcomplectation/index.php',
        type: $form.attr('method'),
        data: $form.serialize(),
        dataType: 'html',
        beforeSend: function() {
            document.getElementById('product-complectation-non-specific').style.opacity = .5;
        },
        complete: function() {
            document.getElementById('product-complectation-non-specific').style.opacity = 1;
        },
        success: function(response) {
            if (0 < response.length) {
                $(complectationListSelector).html(response);
                if ($totalRow) {
                    $(complectationListSelector).append($totalRow);
                }
                // Reset all counts and sums of another complectation lists
                $('.product-complectation [data-spinnerable]').val(0);
                setSum('.product-complectation .ms2_total_row_cost', 0);
                // Reset complectation sum and total sum
                setSum('.complectation-sum', 0);
                setSum('.total-sum', getProductPrice());
            }
        }
    });
});
