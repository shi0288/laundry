<!DOCTYPE html>
<html>
<head>
    <title>林林卖卖店</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" href="${BASE_PATH}/common/css/jquery.mobile-1.4.5.min.css"/>
    <link rel="stylesheet" href="${BASE_PATH}/common/css/base.css"/>
    <script src="${BASE_PATH}/common/js/jquery-1.8.2.min.js"></script>
    <script src="${BASE_PATH}/common/js/jquery.touchslider.min111.js"></script>
    <link rel="stylesheet" href="${BASE_PATH}/common/css/index.css"/>

    <script src="${BASE_PATH}/common/js/jquery.mobile-1.4.5.min.js"></script>
    <script>
        $(document).on("pagebeforeshow", function (event) {
            jQuery(function ($) {
                var str = window.location.pathname;
                console.log(str);
                if (str == '/' || str == '/index.html') {
                    console.log($(".touchslider"));
                    var width = document.body.clientWidth;
                    $('.touchslider-item a').css('width', width);
                    $('.touchslider-viewport').css('height', 300 * (width / 640));
                    $(".touchslider").touchSlider({mouseTouch: true, autoplay: true});

                } else if (str == '/proDetail.html') {
                    console.log($(".touchsliderPro"));
                    var width = document.body.clientWidth - 40;
                    $('.touchslider-item a').css('width', width);
                    $('.touchslider-viewport').css('height', 500 * (width / 640));
                    $(".touchsliderPro").touchSlider({mouseTouch: true, autoplay: true});
                } else {
                    //$(".touchslider").data("touchslider").stop(); // stop the slider
//                    //$(".touchsliderPro").data("touchslider").stop(); // stop the slider
                    console.log($(".touchslider"));
                    $(".touchslider").remove();
                    console.log($(".touchslider"));
                    console.log("====================");
                    console.log($(".touchsliderPro"));
                    $(".touchsliderPro").remove();
                    console.log($(".touchsliderPro"));
                    console.log("===================================================");
                }
            });
        });
    </script>
</head>
