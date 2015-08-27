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
            $.mobile.transitionFallbacks.slideout = "none";
            $.mobile.buttonMarkup.hoverDelay = "false";
        });
    </script>

    <script src="${BASE_PATH}/common/js/jquery.mobile-1.4.5.min.js"></script>

    <script>

        Array.prototype.remove = function (obj) {
            for (var i = 0; i < this.length; i++) {
                var temp = this[i];
                if (!isNaN(obj)) {
                    temp = i;
                }
                if (temp == obj) {
                    for (var j = i; j < this.length; j++) {
                        this[j] = this[j + 1];
                    }
                    this.length = this.length - 1;
                }
            }
        };

        $(document).on("pagebeforeshow", function (event) {
            $('.com-header-area').css('width', $(window).width());
            var order = localStorage.getItem("order");
            if (!order) {
            } else {
                order = order.split(";");
                $("b[name='header-cart-num']").each(function (index) {
                    $(this).html(order.length);
                });
            }

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

                    var proId = $("#proId").val();
                    var order = localStorage.getItem("order");
                    if (!order) {
                        order = [];
                    } else {
                        order = order.split(";");
                    }
                    for (var i = 0; i < order.length; i++) {
                        var jsonStr = order[i];
                        var obj = JSON.parse(jsonStr);
                        if (obj.proId == proId) {
                            $("#toCard").html("已添加");
                            $("#toCard").css({"color": "#575757"});
                            $("#toCard").removeAttr("onclick");
                            break;
                        }
                    }

                } else if (str == '/' || str == '/index.html') {
                    $.mobile.changePage("main.html", "pop");
                } else if (str == '/cart.html') {
                    var order = localStorage.getItem("order");
                    if (!order) {
                        //没有内容
                    } else {
                        order = order.split(";");
                        for (var i = 0; i < order.length; i++) {
                            var o = order[i];
                            o = JSON.parse(o);
                            var str = '<li class="proOne">' +
                                    '<input  type="hidden"  name="proId"  value="' + o.proId + '"  />' +
                                    '<table><tr>' +
                                    '<td width="15%"><img onerror="nofind();" src="images/cart_img.jpg" width="52" height="44"></td>' +
                                    '<td width="65%" id="_content">' +
                                    '<p>' + o.name + '</p>' +
                                    '<p><span class="lse">￥' + o.price + '</span>' +
                                    '<span class="pl15">数量：<div class="Spinner" id="' + o.proId + '" style="margin-top:8px"></div></span></p>' +
                                    '</td>' +
                                    '<td width="10%" valign="middle"><a href="#" data-id="' + o.proId + '" class="del">删除</a></td>' +
                                    '<td width="10%" id="_check"> <input data-role="none" type="checkbox" class="checkbox checked"  name="check_item" id="check_item"></td>' +
                                    '</tr></table></li>'
                            $("#proList").append(str);
                            $("#" + o.proId).Spinner({value: o.numbers, min: 1, len: 4, max: 1000});
                        }
                    }
                    dealPrice();
                    //单独选择某一个
                    $("input[name='check_item']").click(function () {
                        if ($(this).attr("class") != "checkbox") {
                            $(this).removeClass("checked");
                            $("#box_all").removeClass("checked");
                        } else {
                            $(this).addClass("checked");
                            var is = true;
                            $("input[name='check_item']").each(function (index) {
                                if ($(this).attr("class") == "checkbox") {
                                    is = false;
                                    return false;
                                }
                            });
                            if (is) {
                                $("#box_all").addClass("checked");
                            }
                        }
                        dealPrice();
                    });
                    $(".del").click(function () {
                        var proId = $(this).attr("data-id");
                        removeStorage(proId);
                        $(this).parents('.proOne').remove();
                        var num = parseInt($("#header-cart-num").html()) - 1;
                        $("b[name='header-cart-num']").each(function (index) {
                            $(this).html(num);
                        });
                        var is = true;
                        $("input[name='check_item']").each(function (index) {
                            if ($(this).attr("class") == "checkbox") {
                                is = false;
                                return false;
                            }
                        });
                        if (is) {
                            $("#box_all").addClass("checked");
                        }
                        dealPrice();
                    });
                    //全选
                    $("#check_all,#box_all").click(function () {
                        if ($(this).attr("class") != "checkbox") {
                            $("input[name='check_item'],#check_all,#box_all").removeClass("checked");
                        } else {
                            $("input[name='check_item'],#check_all,#box_all").addClass("checked");
                        }
                        dealPrice();
                    })
                } else if (str == '/conform.html') {
                    var conform = localStorage.getItem("conform");
                    var orderPrice=localStorage.getItem("orderPrice");
                    if(orderPrice){
                        $("#payMoney").html("￥"+localStorage.getItem("orderPrice"));
                    }else{
                        alert("订单信息为空");
                        $.mobile.changePage('index.html', 'slide');
                        return;
                    }
                    if (!conform) {
                        //没有内容
                    } else {
                        conform = conform.split(";");
                        for (var i = 0; i < conform.length; i++) {
                            var o = conform[i];
                            o = JSON.parse(o);
                            var str = '<li class="proTwo"><table><tr>' +
                                    '<td width="50%" id="_content">' + o.name + '</td>' +
                                    '<td width="20%" valign="middle">￥' + o.price + '</td>' +
                                    '<td width="20%" id="_check">' + o.numbers + ' 件</td>' +
                                    '</tr></table></li>'
                            $("#orderList").append(str);
                        }
                    }
                }else if (str == '/login.html') {
                    $(".tp-btn").click(function(){
                        var classStr=$(this).attr("class");
                        if(classStr=='tp-btn btn-off'){
                            $(".tp-btn").addClass("btn-on");
                            $(".txt-password")[0].type = 'text';
                        }else{
                            $(".tp-btn").removeClass("btn-on");
                            $(".txt-password")[0].type = 'password';
                        }
                    })
                }else if (str == '/regest.html') {
                    $(".tp-btn").click(function(){
                        var classStr=$(this).attr("class");
                        if(classStr=='tp-btn btn-off'){
                            $(".tp-btn").addClass("btn-on");
                            $(".txt-password")[0].type = 'text';
                        }else{
                            $(".tp-btn").removeClass("btn-on");
                            $(".txt-password")[0].type = 'password';
                        }
                    })
                }
                else {
                    if ($(".touchsliderPro").data("touchslider") != null) {
                        $(".touchsliderPro").data("touchslider").stop(); // stop the slider
                    }
                }
            });
        });

        function dealPrice() {
            var total = 0;
            $(".proOne").each(function (index) {
                var ev = $(this).find("#_check").find(".checkbox");
                if (ev.attr("class") == "checkbox") {
                } else {
                    var number = ev.parent().prevAll("#_content").find("input[class='Amount']").val();
                    number = number * 1;
                    var price = ev.parent().prevAll("#_content").find(".lse").html().split("￥")[1];
                    price = price * 1;
                    var totalPrice = price * 100 * number / 100;
                    total += totalPrice;
                }
            });
            $(".ff6").html(total.toFixed(2));
        }

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


        function removeAll() {
            localStorage.removeItem("order");
            var o = $("#proList");
            o.find(".proOne").remove();
            $("b[name='header-cart-num']").each(function (index) {
                $(this).html(0);
            });
            dealPrice();
        }

        function removeStorage(proId) {
            var order = localStorage.getItem("order");
            if (!order) {
                alert("购物车为空");
                return;
            } else {
                order = order.split(";");
            }
            for (var i = 0; i < order.length; i++) {
                var jsonStr = order[i];
                var obj = JSON.parse(jsonStr);
                if (obj.proId == proId) {
                    order.remove(i);
                    break;
                }
            }
            order = order.join(";");
            localStorage.setItem("order", order.toString());
        }

        function toConform() {
            var order = localStorage.getItem("order");
            if (!order) {
                alert("购物车为空");
                return;
            } else {
                order = order.split(";");
            }
            var conform=[];
            $(".proOne").each(function (index) {
                var ev = $(this).find("#_check").find(".checkbox");
                if (ev.attr("class") == "checkbox") {
                } else {
                    var proId = $(this).find("input[name='proId']").val();
                    var numbers = ev.parent().prevAll("#_content").find("input[class='Amount']").val();
                    for (var i = 0; i < order.length; i++) {
                        var jsonStr = order[i];
                        var obj = JSON.parse(jsonStr);
                        if (obj.proId == proId) {
                            obj.numbers = numbers;
                            var objStr=JSON.stringify(obj);
                            conform.push(objStr);
                            order[i]=objStr;
                            break;
                        }
                    }

                }
            });
            conform = conform.join(";");
            var orderPrice=$(".ff6").html();
            localStorage.setItem("conform", conform.toString());
            localStorage.setItem("orderPrice", orderPrice);
            order = order.join(";");
            localStorage.setItem("order", order.toString());
            $.mobile.changePage('conform.html', 'slide');
        }

        function MoveBox(obj) {
            var proId = $("#proId").val();
            var name = $("#name").val();
            var price = $("#price").val();
            var oldPrice = $("#oldPrice").val();
            var fileName = $("#fileName").val();
            var numbers = $(".Amount").val();
            var product = {
                proId: proId,
                name: name,
                price: price,
                oldPrice: oldPrice,
                fileName: fileName,
                numbers: numbers,
            };
            var order = localStorage.getItem("order");
            if (!order) {
                order = [];
            } else {
                order = order.split(";");
            }
            order.push(JSON.stringify(product));
            order = order.join(";");
            localStorage.setItem("order", order.toString());
            var num = parseInt($("#header-cart-num").html()) + 1;
            $("b[name='header-cart-num']").each(function (index) {
                $(this).html(num);
            });
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
                    500, null, function () {
                        $("#toCard").html("已添加");
                        $("#toCard").css({"color": "#575757"});
                        $("#toCard").removeAttr("onclick");
                    }).hide(0);
        }

    </script>
</head>
