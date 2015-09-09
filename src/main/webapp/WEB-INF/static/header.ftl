<!DOCTYPE html>
<html>
<head>
    <title>林林卖卖店</title>
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" href="${BASE_PATH}/common/css/jquery.mobile-1.4.5.min.css"/>
    <link rel="stylesheet" href="${BASE_PATH}/common/css/base.css"/>
    <script src="${BASE_PATH}/common/js/jquery-1.8.2.min.js"></script>
    <script src="${BASE_PATH}/common/js/jquery.touchslider.min.js"></script>
    <script src="${BASE_PATH}/common/js/jquery.Spinner.js"></script>
    <script src="${BASE_PATH}/common/js/basic.js?v=0.3.5"></script>
    <link rel="stylesheet" href="${BASE_PATH}/common/css/index.css"/>
    <script>

        $(document).bind("mobileinit", function () {
            //$.mobile.ajaxEnabled=false;
            //$.mobile.page.prototype.option.addBackBtn=true;
            $.mobile.page.prototype.options.domCache = true;
            $.mobile.pageLoadErrorMessage = '功能正在完善，敬请期待';
            $.mobile.transitionFallbacks.slideout = "none";
            $.mobile.buttonMarkup.hoverDelay = "false";
        });
    </script>

    <script src="${BASE_PATH}/common/js/jquery.mobile-1.4.5.min.js"></script>

    <script>

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
                var temp=str.split('/');
                if(temp.length>2){
                    var splitStr=temp[1];
                    str=str.split(splitStr)[1];
                }
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
                } else if (str == '/product.html') {
                    var height = document.body.clientHeight;
                    $(".ui-panel-inner").height(height);
                    var is = true;
                    $("#js-goodlist").on("scrollstart", function () {
                        var dheight = $(document).height();
                        var wheight = $(window).height();
                        var sctop = $(window).scrollTop();
                        if (is) {
                            if (sctop >= dheight - wheight) {
                                is = false;
                                getPP(function () {
                                    is = true;
                                });
                            }
                        }
                    });
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
                    $.mobile.changePage("main.html?showwxpaytitle=1", "pop");
                } else if (str == '/cart.html') {
                    var order = localStorage.getItem("order");
                    if (!order) {
                        var str = '<p style="text-align: center">购物车里是空的，请去挑选<a style="color: #003399;text-decoration: underline" href="main.html">需要的商品</a>吧！</p>';
                        //没有内容
                        $("#proList").append(str);
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
                    var orderPrice = localStorage.getItem("orderPrice");
                    if (orderPrice) {
                        $("#payMoney").html("￥" + localStorage.getItem("orderPrice"));
                    } else {
                        alert("订单信息为空");
                        $.mobile.changePage('main.html', 'slide');
                        return;
                    }
                    var name = localStorage.getItem("name");
                    $.ajax({
                        type: "POST",
                        url: "manage/addressPro.json?timestamp=" + new Date().getTime(),
                        dataType: "json",
                        cache: false,
                        data: {
                            name: name
                        },
                        success: function (rst) {
                            if (rst.result) {
                                if (rst.datas == undefined) {
                                    return;
                                }
                                var obj = JSON.parse(rst.datas);
                                $("#conName").html(obj.userName);
                                $("#conMobile").html(obj.mobile);
                                $("#conAddress").html(obj.provice + obj.where);
                                $("#proWhere").val(rst.datas);
                            } else {
                                alert("获取收货地址失败，请重试");
                            }
                        },
                        error: function () {
                            alert('请求出错');
                        }
                    });

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
                } else if (str == '/tuan.html') {
                    var is = true;
                    $("#tuan-goodlist").on("scrollstart", function () {
                        var dheight = $(document).height();
                        var wheight = $(window).height();
                        var sctop = $(window).scrollTop();
                        if (is) {
                            if (sctop >= dheight - wheight) {
                                is = false;
                                getTuanP(function () {
                                    is = true;
                                });
                            }
                        }
                    });
                } else if (str == '/login.html') {
                    $(".tp-btn").click(function () {
                        var classStr = $(this).attr("class");
                        if (classStr == 'tp-btn btn-off') {
                            $(".tp-btn").addClass("btn-on");
                            $(".txt-password")[0].type = 'text';
                        } else {
                            $(".tp-btn").removeClass("btn-on");
                            $(".txt-password")[0].type = 'password';
                        }
                    })
                } else if (str == '/address.html') {
                    var name = localStorage.getItem("name");
                    if (name) {
                        $.ajax({
                            type: "POST",
                            url: "manage/addressList.json?timestamp=" + new Date().getTime(),
                            dataType: "json",
                            cache: false,
                            data: {
                                name: name
                            },
                            success: function (rst) {
                                if (rst.result) {
                                    $.each(rst['datas'], function (key, val) {
                                        var obj = JSON.parse(val);
                                        var checkStr = '';
                                        if (obj.status == 0) {
                                            checkStr = '<div class="ia-l"></div>';
                                        }
                                        var subFun = "selectAddress('" + obj._id.$oid + "')";
                                        var stackObj = $.mobile.navigate.history.getPrev();
                                        if (stackObj.pageUrl == '/acount.html') {
                                            subFun = "void(0);";
                                        }
                                        var str = '<div class="item-addr bdb-1px">' + checkStr +
                                                '<div class="ia-m m ia-m78" onclick=' + subFun + '>' +
                                                '<div class="mt_new">' + '<span>' + obj.userName + '</span>&nbsp&nbsp&nbsp' + '<strong>' + obj.mobile + '</strong></div><div class="mc">' +
                                                '<p>' + obj.provice + obj.where + '</p> </div></div><a class="ia-r" href="updateAddress.html?id=' + obj._id.$oid + '"><span class="iar-icon"></span> </a></div>';
                                        $(".address").append(str);
                                    });
                                } else {
                                    alert("获取收货地址失败，请重试");
                                }
                            },
                            error: function () {
                                alert('请求出错');
                            }
                        });
                    } else {
                        $.mobile.changePage('login.html', 'slide');
                    }

                } else if (str == '/editAddress.html') {
                    $("#adrBtn").click(function () {
                        var classStr = $(this).attr("class");
                        if (classStr == 'switch') {
                            $(this).addClass("switched");
                        } else {
                            $(this).removeClass("switched");
                        }
                    })
                } else if (str == '/updateAddress.html') {
                    $("#updateBtn").click(function () {
                        var classStr = $(this).attr("class");
                        if (classStr == 'switch') {
                            $(this).addClass("switched");
                        } else {
                            $(this).removeClass("switched");
                        }
                    })
                } else if (str == '/regest.html') {
                    $(".tp-btn").click(function () {
                        var classStr = $(this).attr("class");
                        if (classStr == 'tp-btn btn-off') {
                            $(".tp-btn").addClass("btn-on");
                            $(".txt-password")[0].type = 'text';
                        } else {
                            $(".tp-btn").removeClass("btn-on");
                            $(".txt-password")[0].type = 'password';
                        }
                    });

                }else if (str == '/getPassWord.html') {
                    $(".tp-btn").click(function () {
                        var classStr = $(this).attr("class");
                        if (classStr == 'tp-btn btn-off') {
                            $(".tp-btn").addClass("btn-on");
                            $(".txt-password")[0].type = 'text';
                        } else {
                            $(".tp-btn").removeClass("btn-on");
                            $(".txt-password")[0].type = 'password';
                        }
                    });

                } else if (str == '/acount.html') {
                    var name = localStorage.getItem("name");
                    $("#acountName").html(name);
                    $("#quanbudingdan").attr("href", "orders.html?name=" + name + "&status=9999");
                    $("#waitDeliveryOrderList").attr("href", "orders.html?name=" + name + "&status=1100");
                    $("#waite4Payment").attr("href", "orders.html?name=" + name + "&status=1000");
                } else {
                    if ($(".touchsliderPro").data("touchslider") != null) {
                        $(".touchsliderPro").data("touchslider").stop(); // stop the slider
                    }
                }
            });
        });


    </script>
</head>
