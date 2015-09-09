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

function before() {
    $("body").append('<div class="cover3" id="before-cover" style="display:block"></div><img id="login-img" src="../static/common/css/images/009.gif">');
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
        url: "manage/selectAddress.json?timestamp=" + new Date().getTime(),
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
                    alert("添加成功", function () {
                        $.mobile.changePage('address.html', 'slide');
                    });
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


function getTuanP(onClick) {
    var tuanP = parseInt($("#tuanP").val());
    tuanP += 1;
    var tuanStr = $("#tuanStr").val();
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
            sortStr: sortStr
        },
        success: function (rst) {
            if (rst.result) {
                var list = rst.object;
                $.each(list, function (key, val) {
                    var obj = JSON.parse(val);
                    var htmlStr = '<div class="tuan-list"><div class="img120"><a href="proDetail.html?proId=' + obj._id.$oid + '"><dfn></dfn>'
                        + '<img src="upload/img/' + obj.fileNames[0] + '"  onerror="nofind();"/><a/></div>'
                        + '<a href="proDetail.html?proId=' + obj._id.$oid + '" class="title">' + obj.name + '</a>'
                        + '<p> <span class="pxui-color-yellow">数量：<span class="red">' + obj.num + '</span></span> </p>'
                        + ' <p> <span class="pxui-color-red">￥' + obj.price + '</span> <del class="pxui-color-gray">' + obj.oldPrice + '</del></p>';
                    $("#tuan-goodlist").append(htmlStr);
                });
                onClick = null;
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


function getPP(onClick) {
    var pP = parseInt($("#pP").val());
    pP += 1;
    var pStr = $("#pStr").val();
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
            brandId: brandId
        },
        success: function (rst) {
            if (rst.result) {
                var list = rst.object;
                $.each(list, function (key, val) {
                    var obj = JSON.parse(val);
                    var htmlStr = '<a href="${INTER_PATH}/proDetail.html?proId=' + obj._id.$oid + '" data-transition="slide" style="width:33%;min-width: 0px;height:203px; ">'
                        + '<div class="img160" style="background-image: none;width:100%;height: 120px"><dfn></dfn>'
                        + '<img style="max-height: 90px;" src="upload/img/' + obj.fileNames[0] + '"onerror="nofind();"/></div>'
                        + '<span style="padding-top: 0px;" class="name">' + obj.name + '</span>'
                        + '<span class="price">￥' + obj.price + '</span>'
                        + '<del class="price">￥' + obj.oldPrice + '</del></a>';

                    $("#js-goodlist").append(htmlStr);
                });
                onClick = null;
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
                    alert("更新成功", function () {
                        $.mobile.changePage('address.html', 'slide');
                    });
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
            url: "manage/delAddress.json?timestamp=" + new Date().getTime(),
            dataType: "json",
            cache: false,
            data: {
                id: id
            },
            success: function (rst) {
                if (rst.result) {
                    alert("删除成功", function () {
                        $.mobile.changePage('address.html', 'slide');
                    });
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
            if (is=='false') {
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
                    if(payType==1){
                        WeixinJSBridge.invoke('getBrandWCPayRequest',JSON.parse(rst.object),function(res){
                                //支付成功或失败前台判断
                                if(res.err_msg=='get_brand_wcpay_request:ok'){
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
                                    after();
                                    alert('恭喜您，支付成功!', function () {
                                        $.mobile.changePage('main.html', 'slide');
                                    });
                                }else{
                                    alert('支付失败');
                                }
                            });

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
        $.mobile.changePage('login.html', 'slide');
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
    console.log(z_captcha);
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
                alert("修改成功", function () {
                    $.mobile.changePage('main.html', 'slide');
                });
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
    $.mobile.changePage('conform.html?showwxpaytitle=1', 'slide');
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
            order.push(JSON.stringify(product));
            order = order.join(";");
            localStorage.setItem("order", order.toString());
            var num = parseInt($("#header-cart-num").html()) + 1;
            $("b[name='header-cart-num']").each(function (index) {
                $(this).html(num);
            });
            $.mobile.changePage('cart.html', 'slide');
        } else {
            alert("该商品暂缺，正在补货");
        }
        after();
    });
}

function MoveBox(obj) {
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
        } else {
            alert("该商品暂缺，正在补货");
        }
        after();
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