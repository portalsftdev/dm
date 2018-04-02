/**
 * Created by spira on 21.02.2017.
 */

$(function() {

    "use strict";

    var toggles = document.querySelectorAll(".cmn-toggle-switch");

    for (var i = toggles.length - 1; i >= 0; i--) {
        var toggle = toggles[i];
        toggleHandler(toggle);
    };

    function toggleHandler(toggle) {
        toggle.addEventListener( "click", function(e) {
            e.preventDefault();
            if (this.classList.contains("active") === true) {
                this.classList.remove("active");
                $('#mainMenu').removeClass("open");
                //this.classList.add("normal");
                //$('.cmn-toggle-switch').find("i").html($('.cmn-toggle-switch').data("caption"));
                $('.cmn-toggle-switch').animate({
                    letterSpacing: "-8px"
                }, 300, function() {
                    $('.cmn-toggle-switch').find("i").html($('.cmn-toggle-switch').data("caption"));
                }).animate({
                    letterSpacing: "0"
                }, 300);


            } else {
                //this.classList.remove("normal");
                this.classList.add("active");
                $('#mainMenu').addClass("open");
                //$('.cmn-toggle-switch').find("i").html($('.cmn-toggle-switch').data("caption-active"));
                $('.cmn-toggle-switch').animate({
                    letterSpacing: "-8px"
                }, 300, function() {
                    $('.cmn-toggle-switch').find("i").html($('.cmn-toggle-switch').data("caption-active"));
                }).animate({
                    letterSpacing: "0"
                }, 300);
            }
        });
    }

    var promos = document.querySelectorAll(".promo-switch");

    for (var i = promos.length - 1; i >= 0; i--) {
        var promo = promos[i];
        promoHandler(promo);
    };

    function promoHandler(promo) {
        promo.addEventListener( "click", function(e) {
            e.preventDefault();
            var obj = $(this);
            if ($(obj.data("promo")).hasClass('open') === true) {
                $(".promo-container").removeClass('close');
                $(".promo-container").removeClass('open');
                //$(obj.data("promo")).removeClass('open');

            } else {
                $(".promo-container").addClass('close');
                $(".promo-container").removeClass('open');
                $(obj.data("promo")).removeClass('close');
                $(obj.data("promo")).addClass('open');
            }
            var mq = window.matchMedia( "(max-width: 992px)" );
            if (mq.matches) {
                $('html, body').animate({ scrollTop: $(obj.data("promo")).offset().top }, 700);
            }
        });
    }


    var expo_selectors = document.querySelectorAll(".expo-checkbox");

    for (var i = expo_selectors.length - 1; i >= 0; i--) {
        var expo_selector = expo_selectors[i];
        expoCheckboxHandler(expo_selector);
    };

    function expoCheckboxHandler(expo_selector) {
        expo_selector.addEventListener( "click", function(e) {
            //e.preventDefault();
            var obj = $(this);
            $('.expo-interior').removeClass('expo-interior--dark').removeClass('expo-interior--green').removeClass('expo-interior--white').addClass(obj.val());

        });
    }



    $( document ).ready(function() {
        $(".rotate-btn").on("click",function(){
            var t=$(this).attr("data-card");
            $("#"+t).toggleClass("flipped");
        });
    });

});
