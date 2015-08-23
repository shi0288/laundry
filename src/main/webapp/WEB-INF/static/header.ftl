<!DOCTYPE html>
<html>
<head>
    <title>林林卖卖店</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" href="${BASE_PATH}/common/css/jquery.mobile-1.4.5.min.css"/>
    <link rel="stylesheet" href="${BASE_PATH}/common/css/base.css"/>
    <script src="${BASE_PATH}/common/js/jquery-1.8.2.min.js"></script>
    <script src="${BASE_PATH}/common/js/jquery.touchslider.min.js"></script>
    <script src="${BASE_PATH}/common/js/jquery.Spinner.js"></script>
    <link rel="stylesheet" href="${BASE_PATH}/common/css/index.css"/>
    <script>

        $(document).bind("mobileinit", function () {
            //$.mobile.ajaxEnabled=false;
            // $.mobile.page.prototype.option.addBackBtn=true;
            $.mobile.page.prototype.options.domCache = true;
            $.mobile.pageLoadErrorMessage = 'Sorry, something went wrong. Please try again.';
            //$.mobile.fixedtoolbar.prototype.options.tapToggle = false;
            $.mobile.transitionFallbacks.slideout = "none";
            $.mobile.buttonMarkup.hoverDelay = "false";
        });
    </script>

    <script src="${BASE_PATH}/common/js/jquery.mobile-1.4.5.min.js"></script>

    <script>
        $(document).on("pagebeforeshow", function (event) {
            $('.com-header-area').css('width', $(window).width());
            jQuery(function ($) {
                var str = window.location.pathname;
                if (str == '/main.html') {
                    var width = document.body.clientWidth;
                    $('.touchslider-item a').css('width', width);
                    $('.touchslider-viewport').css('height', 300 * (width / 640));
                    if ($(".touchslider").data("touchslider") == undefined) {
                        $(".touchslider").touchSlider({mouseTouch: true, autoplay: false});
                        $(".touchslider").data("touchslider").start(); // stop the slider
                        $(".touchslider").touchSlider = null;
                    } else {
                        $(".touchslider").data("touchslider").start(); // stop the slider
                    }
                } else if (str == '/proDetail.html') {
                    $("#a").Spinner({value: 1, min: 1, len: 4, max: 1000});
                    var width = document.body.clientWidth - 40;
                    $('.touchslider-item a').css('width', width);
                    $('.touchslider-viewport').css('height', 500 * (width / 640));
                    if ($(".touchsliderPro").data("touchslider") == undefined) {
                        $(".touchsliderPro").touchSlider({mouseTouch: true, autoplay: false});
                        $(".touchsliderPro").data("touchslider").start(); // stop the slider
                    } else {
                        $(".touchsliderPro").data("touchslider").start(); // stop the slider
                    }
                } else if (str == '/' || str == '/index.html') {
                    $.mobile.changePage("main.html", "pop");
                } else if (str == '/cart.html') {
                    //单独选择某一个
                    $("input[name='check_item']").click(function () {
                        var index = $("input[name='check_item']").index(this);
                        $("input[name='check_item']").eq(index).toggleClass("checked");//伪复选
                    });
                    //全选
                    $("#check_all,#box_all").click(function () {
                        console.log($(this).attr("class"));
                        if ($(this).attr("class") != "checkbox") {
                            $("input[name='check_item'],#check_all,#box_all").removeClass("checked");
                        } else {
                            $("input[name='check_item'],#check_all,#box_all").addClass("checked");
                        }
                    });
                }
                else {
                    if ($(".touchsliderPro").data("touchslider") != null) {
                        $(".touchsliderPro").data("touchslider").stop(); // stop the slider
                    }
                }
            });
        });

        function goBack() {
            var previousPage = $.mobile.activePage.data('ui.prevPage');
            if (typeof previousPage.prevObject[0] != 'undefined') {
                $.mobile.changePage(previousPage.prevObject[0].id, 'slide', true, true);
            }
        }


        function nofind() {
            var img = event.srcElement;
            img.src = "../static/common/css/images/error.png";
            img.onerror = null;
        }
        ;
        function MoveBox(obj) {
            var proId = $("#proId").val();
            var price = $("#price").val();
            var oldPrice = $("#oldPrice").val();
            var fileName = $("#fileName").val();
            var numbers = $(".Amount").val();
            var product = {
                proId: proId,
                price: price,
                oldPrice: oldPrice,
                fileName: fileName,
                numbers: numbers,
                orderAmount: parseInt(price) * numbers
            };
            var order = localStorage.getItem("order");
            if (!order) {
                order = [];
            } else {
                order = order.split(",");
            }
            order.push(JSON.stringify(product));
            //localStorage.removeItem("order");
            localStorage.setItem("order", order.toString());
            $("#pro").show();
            var divTop = $(obj).offset().top;
            var divLeft = $(obj).offset().left;
            $("#pro").css({
                "position": "absolute",
                "z-index": "500",
                "left": divLeft + "px",
                "top": divTop + "px"
            });
            $("#pro").animate({
                        "left": $(window).width() - 25 + "px",
                        "top": $("#header-cart-num").offset().top + "px",
                        "width": "50px",
                        "height": "25px",
                        opacity: "0.1"
                    },
                    800, null, function () {
                        $("#toCard").html("已添加");
                        $("#toCard").css({"color": "#575757"});
                        $("#toCard").removeAttr("onclick");
                    }).hide(0);
        }

    </script>
</head>
