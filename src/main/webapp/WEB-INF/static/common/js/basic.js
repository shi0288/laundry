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

String.prototype.trim = function() {
    return this.replace(/\s+/g,"");
};


var browser = {
    versions: function () {
        var u = navigator.userAgent, app = navigator.appVersion;
        return {
            trident: u.indexOf('Trident') > -1, //IE内核
            presto: u.indexOf('Presto') > -1, //opera内核
            webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
            gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
            mobile: !!u.match(/AppleWebKit.*Mobile.*/) || !!u.match(/AppleWebKit/), //是否为移动终端
            ios: !!u.match(/(i[^;]+\;(U;)? CPU.+Mac OS X)/), //ios终端
            android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
            iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器
            iPad: u.indexOf('iPad') > -1, //是否iPad
            webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
        }
    }(),
    language: (navigator.browserLanguage || navigator.language).toLowerCase()
};


function before() {
    $("body").append('<div class="cover3" id="before-cover" style="display:block"></div><img id="login-img" src="./static/common/css/images/009.gif">');
    var height = $(window).height();
    if (height < $(document).height()) {
        height = $(document).height();
    }
    $("#before-cover").height(height);
}
function after() {
    if ($("#login-img").length > 0 && $("#before-cover").length > 0) {
        $("#login-img").remove();
        $("#before-cover").remove();
    }
}


window.alert = function (mes, onClick) {
    var html = '<div class="cover3"></div><div id="alert"><div class="alert-title">提示</div><div class="alert-message">' + mes + '</div><div class="alert-ok">确定</div></div>';
    $("body").eq(0).append(html);
    var iheight = $(document).height();
    if ($(window).height() > $(document).height()) {
        iheight = $(window).height();
    }
    $(".cover3").height(iheight);
    var height = $("#alert").height();

    $("#alert").css({'margin-top': -height / 2});
    $("#alert .alert-ok").die().click(function () {
        closeAlert();
        if (onClick) {
            onClick();
        }
    });
};
function closeAlert() {
    $(".cover3").remove();
    $("#alert").remove();
}


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
    if(total>0){
        $.ajax({
            type: "POST",
            url: "manage/initPrice.json?timestamp=" + new Date().getTime(),
            dataType: "json",
            cache: false,
            data: {},
            success: function (rst) {
                if (rst.result) {
                    if (rst.object == null || rst.object == undefined) {
                    } else {
                        var initPriceObj = JSON.parse(rst.object);
                        var initPrice = initPriceObj.price * 1;
                        if (total < initPrice) {
                            var sendPrice = initPriceObj.sendPrice * 1;
                            total+=sendPrice;
                            $("#ff7").show();
                            $("#ff8").hide();
                        }else{
                            $("#ff7").hide();
                            $("#ff8").show();
                        }
                    }
                    $(".ff6").html(total.toFixed(2));
                } else {
                    alert("操作失败，请重试");
                }
            },
            error: function () {
                alert('请求出错');
            }
        });
    }else{
        $(".ff6").html(total.toFixed(2));
    }



}

function toAmount() {
    var name = localStorage.getItem("name");
    if (name) {
        $.mobile.changePage('acount.html?name=' + name);
    } else {
        $.mobile.changePage('login.html');
    }

}

function selectAddress(id) {
    var name = localStorage.getItem("name");
    $.ajax({
        type: "POST",
        url: "manage/selectAddress.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            name: name,
            id: id
        },
        success: function (rst) {
            if (rst.result) {
                $.mobile.changePage('conform.html');
            } else {
                alert("操作失败，请重试");
            }
        },
        error: function () {
            alert('请求出错');
        }
    });
}


function selectAccountAddress(id, obj) {
    var name = localStorage.getItem("name");
    $.ajax({
        type: "POST",
        url: "manage/selectAddress.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            name: name,
            id: id
        },
        success: function (rst) {
            if (rst.result) {
                $(".ia-l").remove();
                var addStr = '<div class="ia-l"></div>';
                $(obj).before(addStr);
            } else {
                alert("操作失败，请重试");
            }
        },
        error: function () {
            alert('请求出错');
        }
    });
}


function saveAddress() {
    var name = localStorage.getItem("name");
    if (name) {
        var userName = $("#address_uersName").val();
        var mobile = $("#address_mobile").val();
        var provice = $("#address_provice").val();
        var where = $("#address_where").val();
        var adrBtn = $("#adrBtn").attr("class");
        var first = 1;
        if (adrBtn != 'switch') {
            first = 0;
        }
        if (userName == null || userName == "") {
            alert("收货人不能为空");
            return;
        }
        if (mobile == null || mobile == "") {
            alert("手机号不能为空");
            return;
        }
        if (provice == null || provice == "") {
            alert("地址不能为空");
            return;
        }
        if (where == null || where == "") {
            alert("请输入详细地址");
            return;
        }
        $.ajax({
            type: "POST",
            url: "manage/address.json?timestamp=" + new Date().getTime(),
            dataType: "json",
            cache: false,
            data: {
                name: name,
                userName: userName,
                mobile: mobile,
                provice: provice,
                where: where,
                first: first
            },
            success: function (rst) {
                if (rst.result) {
                    $.mobile.changePage('address.html');
                } else {
                    alert("添加失败，请重试");
                }
            },
            error: function () {
                alert('请求出错');
            }
        });

    } else {
        $.mobile.changePage('login.html');
    }

}


function getTuanP(onClick) {
    var tuanP = parseInt($("#tuanP").val());
    tuanP += 1;
    var tuanStr = $("#tuanStr").val();
    if(tuanStr==null || tuanStr==undefined ||tuanStr==''){
        $(document).unbind("scroll");
        return;
    }
    var sortStr = tuanStr.split(";")[0];
    var orderBy = tuanStr.split(";")[1];
    $.ajax({
        type: "POST",
        url: "tuanP.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            p: tuanP,
            orderBy: orderBy,
            sortStr: sortStr,
            status:0
        },
        success: function (rst) {
            if (rst.result) {
                var list = rst.object;
                $.each(list, function (key, val) {
                    var obj = JSON.parse(val);
                    var funToBox="ProMoveBox(this,'"+obj._id.$oid+"@"+obj.name.trim()+"@"+obj.price+"@"+obj.oldPrice+"@"+obj.fileNames[0]+"')";
                    var buttonStr="<p style='height:100%'><a  class='hengAddBox' href='#'  onclick="+funToBox+">加入购物车</a></p>";
                    var htmlStr = '<div class="tuan-list"><div class="img120"><a href="proDetail.html?proId=' + obj._id.$oid + '"><dfn></dfn>'
                        + '<img src="../../upload/img/' + obj.fileNames[0] + '"  onerror="nofind();"/><a/></div>'
                        + '<a href="proDetail.html?proId=' + obj._id.$oid + '" class="title">' + obj.name + '</a>'
                        + '<p> <span class="pxui-color-yellow">数量：<span class="red">' + obj.num + '</span></span> </p>'
                        + ' <p> <span class="pxui-color-red">￥' + obj.price + '</span> <del class="pxui-color-gray">' + obj.oldPrice + '</del></p>'+buttonStr;
                    $("#tuan-goodlist").append(htmlStr);
                });
                if (onClick) {
                    $("#tuanP").val(tuanP);
                    onClick();
                }
            } else {
                alert("添加失败，请重试");
            }
        },
        error: function () {
            alert('请求出错');
        }
    });

}

function getTaoP(onClick) {
    var tuanP = parseInt($("#taoP").val());
    tuanP += 1;
    var tuanStr = $("#taoStr").val();
    if(tuanStr==null || tuanStr==undefined ||tuanStr==''){
        $(document).unbind("scroll");
        return;
    }
    var sortStr = tuanStr.split(";")[0];
    var orderBy = tuanStr.split(";")[1];
    $.ajax({
        type: "POST",
        url: "taoP.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            p: tuanP,
            orderBy: orderBy,
            sortStr: sortStr,
            status:0
        },
        success: function (rst) {
            if (rst.result) {
                var list = rst.object;
                $.each(list, function (key, val) {
                    var obj = JSON.parse(val);
                    var funToBox="ProMoveBox(this,'"+obj._id.$oid+"@"+obj.name.trim()+"@"+obj.price+"@"+obj.oldPrice+"@"+obj.fileNames[0]+"')";
                    var buttonStr="<p style='height:100%'><a  class='hengAddBox' href='#'  onclick="+funToBox+">加入购物车</a></p>";
                    var htmlStr = '<div class="tao-list"><div class="img120"><a href="proDetail.html?proId=' + obj._id.$oid + '"><dfn></dfn>'
                        + '<img src="../../upload/img/' + obj.fileNames[0] + '"  onerror="nofind();"/><a/></div>'
                        + '<a href="proDetail.html?proId=' + obj._id.$oid + '" class="title">' + obj.name + '</a>'
                        + '<p> <span class="pxui-color-yellow">数量：<span class="red">' + obj.num + '</span></span> </p>'
                        + ' <p> <span class="pxui-color-red">￥' + obj.price + '</span> <del class="pxui-color-gray">' + obj.oldPrice + '</del></p>'+buttonStr;
                    $("#tao-goodlist").append(htmlStr);
                });
                if (onClick) {
                    $("#taoP").val(tuanP);
                    onClick();
                }
            } else {
                alert("添加失败，请重试");
            }
        },
        error: function () {
            alert('请求出错');
        }
    });
}


function getPP(onClick) {
    var pP = parseInt($("#pP").val());
    pP += 1;
    var pStr = $("#pStr").val();
    if(pStr==null || pStr==undefined ||pStr==''){
        $(document).unbind("scroll");
        return;
    }
    var sortStr = pStr.split(";")[0];
    var orderBy = pStr.split(";")[1];
    var mainProId = pStr.split(";")[2];
    var sortProId = pStr.split(";")[3];
    var brandId = pStr.split(";")[4];
    $.ajax({
        type: "POST",
        url: "pP.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            p: pP,
            orderBy: orderBy,
            sortStr: sortStr,
            mainProId: mainProId,
            sortProId: sortProId,
            brandId: brandId,
            status:0
        },
        success: function (rst) {
            if (rst.result) {
                var list = rst.object;
                $.each(list, function (key, val) {
                    var obj = JSON.parse(val);
                    var funToBox="ProMoveBox(this,'"+obj._id.$oid+"@"+obj.name.trim()+"@"+obj.price+"@"+obj.oldPrice+"@"+obj.fileNames[0]+"')";
                    var buttonStr="<p style='margin-left:16px' class='hengAddBox'  onclick="+funToBox+">加入购物车</p>";
                    var onclickStr="$.mobile.changePage('proDetail.html?proId="+obj._id.$oid+"');"
                    var htmlStr = '<a href="#" style="width:33%;min-width: 0px;height:203px; height:100% ">'
                        + '<div  onclick="'+onclickStr+'"  class="img160" style="background-image: none;width:100%;height: 120px"><dfn></dfn>'
                        + '<img style="max-height: 90px;" src="../../upload/img/' + obj.fileNames[0] + '"onerror="nofind();"/></div>'
                        + '<span style="padding-top: 0px;" class="name">' + obj.name + '</span>'
                        + '<span class="price">￥' + obj.price + '</span><br/>'
                        + '<del class="price">￥' + obj.oldPrice + '</del><br/>'+buttonStr+'</a>';
                    $("#js-goodlist").append(htmlStr);
                    $('#button').button();//动态刷新代码
                });
                if (onClick) {
                    $("#pP").val(pP);
                    onClick();
                }
            } else {
                alert("添加失败，请重试");
            }
        },
        error: function () {
            alert('请求出错');
        }
    });
}


function testMobile() {
    var r_mobile = $("#r_mobile").val();
    var re = /^1\d{10}$/;
    if (re.test(r_mobile)) {
        $("#r_mobileBut").removeClass("btn-retransmit-disabled");
        $("#r_mobileBut").attr("onclick", "sendMsg()");
    }
}

function testPassWordMobile() {
    var r_mobile = $("#z_mobile").val();
    var re = /^1\d{10}$/;
    if (re.test(r_mobile)) {
        $("#z_mobileBut").removeClass("btn-retransmit-disabled");
        $("#z_mobileBut").attr("onclick", "sendPassWordMsg()");
    }
}


function updateAddress() {
    var name = localStorage.getItem("name");
    if (name) {
        var userName = $("#update_uersName").val();
        var mobile = $("#update_mobile").val();
        var provice = $("#update_provice").val();
        var where = $("#update_where").val();
        var id = $("#update_id").val();
        var adrBtn = $("#updateBtn").attr("class");
        var first = 1;
        if (adrBtn != 'switch') {
            first = 0;
        }
        if (userName == null || userName == "") {
            alert("收货人不能为空");
            return;
        }
        if (mobile == null || mobile == "") {
            alert("手机号不能为空");
            return;
        }
        if (provice == null || provice == "") {
            alert("地址不能为空");
            return;
        }
        if (where == null || where == "") {
            alert("请输入详细地址");
            return;
        }
        $.ajax({
            type: "POST",
            url: "manage/updateAddress.json?timestamp=" + new Date().getTime(),
            dataType: "json",
            cache: false,
            data: {
                name: name,
                id: id,
                userName: userName,
                mobile: mobile,
                provice: provice,
                where: where,
                first: first
            },
            success: function (rst) {
                if (rst.result) {
                    $.mobile.changePage('address.html');
                } else {
                    alert("更新失败，请重试");
                }
            },
            error: function () {
                alert('请求出错');
            }
        });

    } else {
        $.mobile.changePage('login.html');
    }
}

function delAddress() {
    var name = localStorage.getItem("name");
    if (name) {
        var id = $("#update_id").val();
        $.ajax({
            type: "POST",
            url: "manage/delAddress.json?timestamp=" + new Date().getTime(),
            dataType: "json",
            cache: false,
            data: {
                id: id
            },
            success: function (rst) {
                if (rst.result) {
                    $.mobile.changePage('address.html');
                } else {
                    alert("删除失败，请重试");
                }
            },
            error: function () {
                alert('请求出错');
            }
        });

    } else {
        $.mobile.changePage('login.html');
    }
}

function goToPay(id) {
    before();
    $.ajax({
        type: "POST",
        url: "manage/goToPay.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            id: id
        },
        success: function (rst) {
            if (rst.result) {
                WeixinJSBridge.invoke('getBrandWCPayRequest', JSON.parse(rst.object), function (res) {
                    //支付成功或失败前台判断
                    after();
                    if (res.err_msg == 'get_brand_wcpay_request:ok') {
                        alert('恭喜您，支付成功!');
                        toAmount();
                    } else {
                        alert('支付失败');
                    }
                });
            } else {
                after();
                alert(rst.msg);
            }
        },
        error: function () {
            after();
            alert('请求出错');
        }
    })
}

function commitOrder() {

    before();
    var name = localStorage.getItem("name");
    if (name) {
        var conName = $("#conName").html();
        var conMobile = $("#conMobile").html();
        var conAddress = $("#conAddress").html();
        if (conName == null || conName == '') {
            alert("送货信息不能为空", function () {
                after();
            });
            return;
        }
        if (conMobile == null || conMobile == '') {
            alert("送货信息不能为空", function () {
                after();
            });
            return;
        }
        if (conAddress == null || conAddress == '') {
            alert("送货信息不能为空", function () {
                after();
            });
            return;
        }
        var orderStr = localStorage.getItem("conform");
        var orderPrice = localStorage.getItem("orderPrice");
        var payType = 0;
        $("input[name='radio-choice-1']").each(function () {
            var is = $(this).attr("data-cacheval");
            if (is == 'false') {
                payType = $(this).val();
                return false;
            }
        });
        $.ajax({
            type: "POST",
            url: "manage/commitOrder.json?timestamp=" + new Date().getTime(),
            dataType: "json",
            cache: false,
            data: {
                name: name,
                conName: conName,
                conMobile: conMobile,
                conAddress: conAddress,
                orderStr: orderStr,
                orderPrice: orderPrice,
                payType: payType
            },
            success: function (rst) {
                if (rst.result) {
                    if (payType == 1) {
                        var commitOrder = orderStr.split(";");
                        var order = localStorage.getItem("order");
                        order = order.split(";");
                        for (var j = 0; j < commitOrder.length; j++) {
                            var jsonCommitStr = commitOrder[j];
                            var objCommit = JSON.parse(jsonCommitStr);
                            for (var i = 0; i < order.length; i++) {
                                var jsonStr = order[i];
                                var obj = JSON.parse(jsonStr);
                                if (obj.proId == objCommit.proId) {
                                    order.remove(i);
                                    break;
                                }
                            }
                        }
                        localStorage.removeItem("conform");
                        localStorage.removeItem("orderPrice");
                        $("b[name='header-cart-num']").each(function (index) {
                            $(this).html(order.length);
                        });
                        if (order.length == 0) {
                            localStorage.removeItem("order");
                        } else {
                            order = order.join(";");
                            localStorage.setItem("order", order.toString());
                        }
                        WeixinJSBridge.invoke('getBrandWCPayRequest', JSON.parse(rst.object), function (res) {
                            //支付成功或失败前台判断
                            if (res.err_msg == 'get_brand_wcpay_request:ok') {
                                after();
                                alert('恭喜您，支付成功!');
                            } else {
                                after();
                                alert('支付失败');
                            }
                            toAmount();
                        });
                    } else {
                        after();
                        var commitOrder = orderStr.split(";");
                        var order = localStorage.getItem("order");
                        order = order.split(";");
                        for (var j = 0; j < commitOrder.length; j++) {
                            var jsonCommitStr = commitOrder[j];
                            var objCommit = JSON.parse(jsonCommitStr);
                            for (var i = 0; i < order.length; i++) {
                                var jsonStr = order[i];
                                var obj = JSON.parse(jsonStr);
                                if (obj.proId == objCommit.proId) {
                                    order.remove(i);
                                    break;
                                }
                            }
                        }
                        localStorage.removeItem("conform");
                        localStorage.removeItem("orderPrice");
                        $("b[name='header-cart-num']").each(function (index) {
                            $(this).html(order.length);
                        });
                        if (order.length == 0) {
                            localStorage.removeItem("order");
                        } else {
                            order = order.join(";");
                            localStorage.setItem("order", order.toString());
                        }
                        alert('恭喜您，下单成功!');
                        $.mobile.changePage('zhuanpan.html', 'slide');
                    }
                } else {
                    after();
                    alert(rst.msg);
                }
            },
            error: function () {
                after();
                alert('请求出错');
            }
        });

    } else {
        after();
        $.mobile.changePage('login.html');
    }
}


function login() {
    var name = $("#l_mobile").val();
    var password = $("#l_password").val();
    var captcha = $("#l_captcha").val();
    if (name == null || name == "") {
        alert("用户名不能为空");
        return;
    }
    if (password == null || password == "") {
        alert("密码不能为空");
        return;
    }
    if (captcha == null || captcha == "") {
        alert("验证码不能为空");
        return;
    }
    $.ajax({
        type: "POST",
        url: "manage/login.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            name: name,
            password: password,
            captcha: captcha
        },
        success: function (rst) {
            if (rst.result) {
                localStorage.setItem("name", name);
                $.mobile.changePage('main.html');
            } else {
                alert(rst.msg);
            }
        },
        error: function () {
            alert('请求出错');
        }
    });
}

function register() {
    var name = $("#r_mobile").val();
    var password = $("#r_password").val();
    var captcha = $("#r_captcha").val();
    var msgCode = $("#r_msgCode").val();
    if (name == null || name == "") {
        alert("用户名不能为空");
        return;
    }
    if (password == null || password == "") {
        alert("密码不能为空");
        return;
    }
    if (captcha == null || captcha == "") {
        alert("验证码不能为空");
        return;
    }
    if (msgCode == null || msgCode == "") {
        alert("短信验证码不能为空");
        return;
    }
    $.ajax({
        type: "POST",
        url: "manage/register.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            name: name,
            password: password,
            captcha: captcha,
            msgCode: msgCode
        },
        success: function (rst) {
            if (rst.result) {
                localStorage.setItem("name", name);
                $.mobile.changePage('main.html');
            } else {
                alert(rst.msg);
            }
        },
        error: function () {
            alert('请求出错');
        }
    });
}


function bangding() {
    var name = $("#r_mobile").val();
    var captcha = $("#r_captcha").val();
    var msgCode = $("#r_msgCode").val();
    if (name == null || name == "") {
        alert("用户名不能为空");
        return;
    }
    if (captcha == null || captcha == "") {
        alert("验证码不能为空");
        return;
    }
    if (msgCode == null || msgCode == "") {
        alert("短信验证码不能为空");
        return;
    }
    $.ajax({
        type: "POST",
        url: "manage/bangding.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            name: name,
            captcha: captcha,
            msgCode: msgCode
        },
        success: function (rst) {
            if (rst.result) {
                toAmount();
            } else {
                alert(rst.msg);
            }
        },
        error: function () {
            alert('请求出错');
        }
    });
}



function nofind() {
    var img = event.srcElement;
    img.src = "./static/common/css/images/error.png";
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

function sendMsg() {
    $("#r_mobileBut").removeAttr("onclick");
    $("#r_mobileBut").html(120);
    $("#r_mobileBut").addClass("btn-retransmit-disabled");
    var task_num = self.setInterval(function () {
        var temp = $("#r_mobileBut").html();
        temp = parseInt(temp);
        if (temp == 0) {
            //重置按钮
            clearInterval(task_num);//取消第一个
            $("#r_mobileBut").html('获取短信验证码');
            $("#r_mobileBut").attr("onclick", "sendMsg()");
            $("#r_mobileBut").removeClass("btn-retransmit-disabled");
        } else {
            temp = temp - 1;
            $("#r_mobileBut").html(temp);
        }
    }, 1000);

    var r_captcha = $("#r_captcha").val();
    var r_mobile = $("#r_mobile").val();
    $.ajax({
        type: "POST",
        url: "sendMsg.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            r_captcha: r_captcha,
            r_mobile: r_mobile
        },
        success: function (rst) {
            if (rst.result) {

            } else {
                clearInterval(task_num);//取消第一个
                $("#r_mobileBut").html('获取短信验证码');
                $("#r_mobileBut").attr("onclick", "sendMsg()");
                $("#r_mobileBut").removeClass("btn-retransmit-disabled");
                alert(rst.msg);
            }
        },
        error: function () {
            alert('请求出错');
        }
    });
}


function sendPassWordMsg() {
    //发送成功
    $("#z_mobileBut").removeAttr("onclick");
    $("#z_mobileBut").html(120);
    $("#z_mobileBut").addClass("btn-retransmit-disabled");
    var task_num = self.setInterval(function () {
        var temp = $("#z_mobileBut").html();
        temp = parseInt(temp);
        if (temp == 0) {
            //重置按钮
            clearInterval(task_num);//取消第一个
            $("#z_mobileBut").html('获取短信验证码');
            $("#z_mobileBut").attr("onclick", "sendPassWordMsg()");
            $("#z_mobileBut").removeClass("btn-retransmit-disabled");
        } else {
            temp = temp - 1;
            $("#z_mobileBut").html(temp);
        }
    }, 1000);

    var z_captcha = $("#z_captcha").val();
    var z_mobile = $("#z_mobile").val();
    $.ajax({
        type: "POST",
        url: "sendMsg.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            r_captcha: z_captcha,
            r_mobile: z_mobile
        },
        success: function (rst) {
            if (rst.result) {

            } else {
                clearInterval(task_num);//取消第一个
                $("#z_mobileBut").html('获取短信验证码');
                $("#z_mobileBut").attr("onclick", "sendPassWordMsg()");
                $("#z_mobileBut").removeClass("btn-retransmit-disabled");
                alert(rst.msg);
            }
        },
        error: function () {
            alert('请求出错');
        }
    });
}


function getPassWord() {
    var name = $("#z_mobile").val();
    var password = $("#z_password").val();
    var captcha = $("#z_captcha").val();
    var msgCode = $("#z_msgCode").val();
    if (name == null || name == "") {
        alert("用户名不能为空");
        return;
    }
    if (password == null || password == "") {
        alert("密码不能为空");
        return;
    }
    if (captcha == null || captcha == "") {
        alert("验证码不能为空");
        return;
    }
    if (msgCode == null || msgCode == "") {
        alert("短信验证码不能为空");
        return;
    }
    $.ajax({
        type: "POST",
        url: "manage/updatePassWord.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            name: name,
            password: password,
            captcha: captcha,
            msgCode: msgCode
        },
        success: function (rst) {
            if (rst.result) {
                localStorage.setItem("name", name);
                alert("修改成功");
                $.mobile.changePage('main.html');
            } else {
                alert(rst.msg);
            }
        },
        error: function () {
            alert('请求出错');
        }
    });


}


function toConform() {

    var name = localStorage.getItem("name");
    if (!name) {
        $.mobile.changePage('login.html');
        return;
    }
    var order = localStorage.getItem("order");
    if (!order) {
        alert("购物车为空");
        return;
    } else {
        order = order.split(";");
    }
    var conform = [];
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
                    var objStr = JSON.stringify(obj);
                    conform.push(objStr);
                    order[i] = objStr;
                    break;
                }
            }
        }
    });
    conform = conform.join(";");
    var orderPrice = $(".ff6").html();
    localStorage.setItem("conform", conform.toString());
    localStorage.setItem("orderPrice", orderPrice);
    order = order.join(";");
    localStorage.setItem("order", order.toString());
    $.mobile.changePage('conform.html?showwxpaytitle=1');
}


function testProduct(id, numbers, errFun) {
    $.ajax({
        type: "POST",
        url: "testProduct.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            id: id,
            numbers: numbers
        },
        success: function (rst) {
            if (rst.result) {
                errFun(true);
            } else {
                errFun(false);
            }
        },
        error: function () {
            errFun(false);

        }
    });
}


function goToCart() {
    before();
    var proId = $("#proId").val();
    var numbers = $(".Amount").val();
    testProduct(proId, numbers, function (is) {
        if (is) {
            var name = $("#name").val();
            var price = $("#price").val();
            var oldPrice = $("#oldPrice").val();
            var fileName = $("#fileName").val();
            var product = {
                proId: proId,
                name: name,
                price: price,
                oldPrice: oldPrice,
                fileName: fileName,
                numbers: numbers
            };
            var order = localStorage.getItem("order");
            if (!order) {
                order = [];
            } else {
                order = order.split(";");
            }
            var is = true;
            for (var i = 0; i < order.length; i++) {
                var jsonStr = order[i];
                var obj = JSON.parse(jsonStr);
                if (obj.proId == proId) {
                    var tempNumbers = parseInt(obj.numbers);
                    tempNumbers = tempNumbers + parseInt(numbers);
                    obj.numbers = tempNumbers;
                    order.remove(i);
                    order.push(JSON.stringify(obj));
                    order = order.join(";");
                    localStorage.setItem("order", order.toString());
                    is = false;
                    break;
                }
            }
            if (is) {
                order.push(JSON.stringify(product));
                order = order.join(";");
                localStorage.setItem("order", order.toString());
                var num = parseInt($("#header-cart-num").html()) + 1;
                $("b[name='header-cart-num']").each(function (index) {
                    $(this).html(num);
                });
            }
            $.mobile.changePage('cart.html');
        } else {
            alert("该商品暂缺，正在补货");
        }
        after();
    });
}

function MoveBox(objRu) {
    var proId = $("#proId").val();
    var numbers = $(".Amount").val();
    testProduct(proId, numbers, function (is) {
        if (is) {
            var name = $("#name").val();
            var price = $("#price").val();
            var oldPrice = $("#oldPrice").val();
            var fileName = $("#fileName").val();
            var product = {
                proId: proId,
                name: name,
                price: price,
                oldPrice: oldPrice,
                fileName: fileName,
                numbers: numbers
            };
            var order = localStorage.getItem("order");
            if (!order) {
                order = [];
            } else {
                order = order.split(";");
            }


            var panduan = true;
            for (var i = 0; i < order.length; i++) {
                var jsonStr = order[i];
                var obj = JSON.parse(jsonStr);
                if (obj.proId == proId) {
                    var tempNumbers = parseInt(obj.numbers);
                    tempNumbers = tempNumbers + parseInt(numbers);
                    obj.numbers = tempNumbers;
                    order.remove(i);
                    order.push(JSON.stringify(obj));
                    order = order.join(";");
                    localStorage.setItem("order", order.toString());
                    panduan = false;
                    break;
                }
            }
            if (panduan) {
                order.push(JSON.stringify(product));
                order = order.join(";");
                localStorage.setItem("order", order.toString());
                var num = parseInt($("#header-cart-num").html()) + 1;
                $("b[name='header-cart-num']").each(function (index) {
                    $(this).html(num);
                });
            }
            $("#pro").show();
            var divTop = $(objRu).offset().top;
            var divLeft = $(objRu).offset().left;
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
        } else {
            alert("该商品暂缺，正在补货");
        }
    });
}


function ProMoveBox(objRu,str) {
    var valArr=str.split("@");
    var proId = valArr[0];
    var name = valArr[1];
    var price = valArr[2];
    var oldPrice = valArr[3];
    var fileName = valArr[4];
    var numbers = 1;
    testProduct(proId, numbers, function (is) {
        if (is) {
            var product = {
                proId: proId,
                name: name,
                price: price,
                oldPrice: oldPrice,
                fileName: fileName,
                numbers: numbers
            };
            var order = localStorage.getItem("order");
            if (!order) {
                order = [];
            } else {
                order = order.split(";");
            }
            var panduan = true;
            for (var i = 0; i < order.length; i++) {
                var jsonStr = order[i];
                var obj = JSON.parse(jsonStr);
                if (obj.proId == proId) {
                    var tempNumbers = parseInt(obj.numbers);
                    tempNumbers = tempNumbers + parseInt(numbers);
                    obj.numbers = tempNumbers;
                    order.remove(i);
                    order.push(JSON.stringify(obj));
                    order = order.join(";");
                    localStorage.setItem("order", order.toString());
                    panduan = false;
                    break;
                }
            }
            if (panduan) {
                order.push(JSON.stringify(product));
                order = order.join(";");
                localStorage.setItem("order", order.toString());
                var num = parseInt($("#header-cart-num").html()) + 1;
                $("b[name='header-cart-num']").each(function (index) {
                    $(this).html(num);
                });
            }
            $("#pro").show();
            var divTop = $(objRu).offset().top;
            var divLeft = $(objRu).offset().left;
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
                    $("#pro").attr("style","display: 123");
                }).hide(0);
        } else {
            alert("该商品暂缺，正在补货");
        }
    });
}



function changeImg(obj) {
    var imgSrc = $(obj).find("img");
    var src = imgSrc.attr("src");
    imgSrc.attr("src", chgUrl(src));
}
//时间戳
//为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳
function chgUrl(url) {
    var timestamp = new Date().getTime();
    if ((url.indexOf("timestamp=") >= 0)) {
        url = url.replace(url.split("timestamp=")[1], timestamp);
    } else {
        url = url + "?timestamp=" + timestamp;
    }
    return url;
}

/**
 * JavaScript脚本实现回到页面顶部示例
 * @param acceleration 速度
 * @param stime 时间间隔 (毫秒)
 **/
function gotoTop(acceleration, stime) {
    acceleration = acceleration || 0.1;
    stime = stime || 10;
    var x1 = 0;
    var y1 = 0;
    var x2 = 0;
    var y2 = 0;
    var x3 = 0;
    var y3 = 0;
    if (document.documentElement) {
        x1 = document.documentElement.scrollLeft || 0;
        y1 = document.documentElement.scrollTop || 0;
    }
    if (document.body) {
        x2 = document.body.scrollLeft || 0;
        y2 = document.body.scrollTop || 0;
    }
    var x3 = window.scrollX || 0;
    var y3 = window.scrollY || 0;

    // 滚动条到页面顶部的水平距离
    var x = Math.max(x1, Math.max(x2, x3));
    // 滚动条到页面顶部的垂直距离
    var y = Math.max(y1, Math.max(y2, y3));

    // 滚动距离 = 目前距离 / 速度, 因为距离原来越小, 速度是大于 1 的数, 所以滚动距离会越来越小
    var speeding = 1 + acceleration;
    window.scrollTo(Math.floor(x / speeding), Math.floor(y / speeding));

    // 如果距离不为零, 继续调用函数
    if (x > 0 || y > 0) {
        var run = "gotoTop(" + acceleration + ", " + stime + ")";
        window.setTimeout(run, stime);
    }
}

//活动
function getResult(d,info){
    var result_arr = ['手撕牛肉一袋','猫耳仔一袋','黑白配一袋','大大泡泡糖两块','真知棒一个',
        '阿尔卑斯棒棒糖','舒肤佳香皂一块','心心相印纸巾一包','堵嘴薯片一袋','洗衣皂一块','卫龙面筋一个',
        '馋大嘴巴一袋','',''];

    var msg  = result_arr[d];
    if(d<=11){
        d = d * 30 + 15;
        $('#arrow-img').stopRotate();
        $("#arrow-img").rotate({
            angle:0,
            duration: 5000,
            animateTo: d+1440,
            callback:function(){
                var w = $(document).width();
                var l;
                var r_w = $("#result").width();
                l = w/2 - (r_w/2);
                $("#result").css("left", l + "px");
                $("#info").text(msg);
                $("#t-info").text(info);
                $("#result").show();
            }
        });
    }else if(d==12){
        msg = "您已完成一次抽奖";
        var w = $(document).width();
        var l;
        var r_w = $("#result").width();
        l = w/2 - (r_w/2);
        $("#result").css("left", l + "px");
        $("#info").text(msg);
        $("#t-info").text(info);
        $("#result").show();
    }else if(d==13){
        msg = info;
        var w = $(document).width();
        var l;
        var r_w = $("#result").width();
        l = w/2 - (r_w/2);
        $("#result").css("left", l + "px");
        $("#info").text(msg);
        $("#t-info").text(info);
        $("#result").show();
    }

}