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

function before(){
    $("body").append('<div class="cover3" id="before-cover" style="display:block"></div><img id="login-img" src="../static/common/css/images/009.gif">');
    var height=$(window).height();
    if(height<$(document).height()){
        height=	$(document).height();
    }
    $("#before-cover").height(height);
}
function after(){
    if($("#login-img").length>0&&$("#before-cover").length>0){
        $("#login-img").remove();
        $("#before-cover").remove();
    }
}


window.alert = function(mes, onClick){
    var html='<div class="cover3"></div><div id="alert"><div class="alert-title">提示</div><div class="alert-message">'+mes+'</div><div class="alert-ok">确定</div></div>';
    $("body").eq(0).append(html);
    var iheight=$(document).height();
    if($(window).height()>$(document).height()){
        iheight=$(window).height();
    }
    $(".cover3").height(iheight);
    var height = $("#alert").height();

    $("#alert").css({'margin-top': -height/2});
    $("#alert .alert-ok").die().click(function() {
        closeAlert();
        if (onClick) {
            onClick();
        }
    });
};
function closeAlert(){
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
    $(".ff6").html(total.toFixed(2));
}

function toAmount() {
    var name = localStorage.getItem("name");
    if (name) {
        $.mobile.changePage('acount.html?name=' + name, 'slide');
    } else {
        $.mobile.changePage('login.html', 'slide');
    }

}

function selectAddress(id) {
    var name = localStorage.getItem("name");
    $.ajax({
        type: "POST",
        url: "/manage/selectAddress.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            name: name,
            id: id
        },
        success: function (rst) {
            if (rst.result) {
                $.mobile.changePage('conform.html', 'slide');
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
            url: "/manage/address.json?timestamp=" + new Date().getTime(),
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
                    alert("添加成功");
                    $.mobile.changePage('address.html', 'slide');
                } else {
                    alert("添加失败，请重试");
                }
            },
            error: function () {
                alert('请求出错');
            }
        });

    } else {
        $.mobile.changePage('login.html', 'slide');
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
            url: "/manage/updateAddress.json?timestamp=" + new Date().getTime(),
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
                    alert("更新成功");
                    $.mobile.changePage('address.html', 'slide');
                } else {
                    alert("更新失败，请重试");
                }
            },
            error: function () {
                alert('请求出错');
            }
        });

    } else {
        $.mobile.changePage('login.html', 'slide');
    }
}

function delAddress() {
    var name = localStorage.getItem("name");
    if (name) {
        var id = $("#update_id").val();
        $.ajax({
            type: "POST",
            url: "/manage/delAddress.json?timestamp=" + new Date().getTime(),
            dataType: "json",
            cache: false,
            data: {
                id: id
            },
            success: function (rst) {
                if (rst.result) {
                    alert("删除成功");
                    $.mobile.changePage('address.html', 'slide');
                } else {
                    alert("删除失败，请重试");
                }
            },
            error: function () {
                alert('请求出错');
            }
        });

    } else {
        $.mobile.changePage('login.html', 'slide');
    }
}


function commitOrder() {
    var name = localStorage.getItem("name");
    if (name) {
        var conName = $("#conName").html();
        var conMobile = $("#conMobile").html();
        var conAddress = $("#conAddress").html();
        var orderStr = localStorage.getItem("conform");
        var orderPrice = localStorage.getItem("orderPrice");
        $.ajax({
            type: "POST",
            url: "/manage/commitOrder.json?timestamp=" + new Date().getTime(),
            dataType: "json",
            cache: false,
            data: {
                name: name,
                conName: conName,
                conMobile: conMobile,
                conAddress: conAddress,
                orderStr: orderStr,
                orderPrice: orderPrice
            },
            success: function (rst) {
                if (rst.result) {
                    alert("下单成功");
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
                    $.mobile.changePage('main.html', 'slide');
                } else {
                    alert("提交失败，请重试");
                }
            },
            error: function () {
                alert('请求出错');
            }
        });

    } else {
        $.mobile.changePage('login.html', 'slide');
    }
}


function login() {
    var name = $("#l_mobile").val();
    var password = $("#l_password").val();
    var captcha = $("#l_captcha").val();
    if(name==null ||name==""){
        alert("用户名不能为空");
        return;
    }
    if(password==null ||password==""){
        alert("密码不能为空");
        return;
    }
    if(captcha==null ||captcha==""){
        alert("验证码不能为空");
        return;
    }
    $.ajax({
        type: "POST",
        url: "/manage/login.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            name: name,
            password: password,
            captcha:captcha
        },
        success: function (rst) {
            if (rst.result) {
                alert("登录成功");
                localStorage.setItem("name", name);
                $.mobile.changePage('main.html', 'slide');
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
    if(name==null ||name==""){
        alert("用户名不能为空");
        return;
    }
    if(password==null ||password==""){
        alert("密码不能为空");
        return;
    }
    if(captcha==null ||captcha==""){
        alert("验证码不能为空");
        return;
    }
    $.ajax({
        type: "POST",
        url: "/manage/register.json?timestamp=" + new Date().getTime(),
        dataType: "json",
        cache: false,
        data: {
            name: name,
            password: password,
            captcha:captcha
        },
        success: function (rst) {
            if (rst.result) {
                alert("注册成功");
                localStorage.setItem("name", name);
                $.mobile.changePage('main.html', 'slide');
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

    var name = localStorage.getItem("name");
    if (!name) {
        $.mobile.changePage('login.html', 'slide');
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
        url = url.replace(url.split("timestamp=")[1],timestamp);
    } else {
        url = url + "?timestamp=" + timestamp;
    }
    return url;
}