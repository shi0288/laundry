<html>
<!DOCTYPE html>
<html lang="en" class="no-js">

<head>

    <meta charset="utf-8">
    <title>店主登陆</title>
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" CONTENT="0">
    <meta name="format-detection" content="telephone=no"/>

    <!-- CSS -->
    <link rel="stylesheet" href="../static/sale/common/assets/css/reset.css">
    <link rel="stylesheet" href="../static/sale/common/assets/css/supersized.css">
    <link rel="stylesheet" href="../static/sale/common/assets/css/style.css">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="../../static/sale/common/assets/js/html5.js"></script>
    <![endif]-->

</head>

<body>

<div class="page-container">
    <h1>店主登陆</h1>
    <form  action="../manage/saleAdmin.json" id="adminForm" method="post">
        <input type="text" id="username" name="username" class="username" placeholder="请输入您的用户名！">
        <input type="password" id="password" name="password" class="password" placeholder="请输入您的用户密码！">
        <button type="submit" class="submit_button">登录</button>
        <div class="error"><span>+</span></div>
    </form>
</div>



<!-- Javascript -->
<script src="../static/sale/common/assets/js/jquery-1.8.2.min.js" ></script>
<script src="../static/sale/common/assets/js/supersized.3.2.7.min.js" ></script>
<script src="../static/sale/common/assets/js/supersized-init.js" ></script>
<script src="../static/sale/common/assets/js/scripts.js" ></script>
<script src="../static/sale/common/assets/js/jquery.form.min.js" ></script>

<script type="text/javascript">
    $(function () {
        var username = localStorage.getItem("username");
        var password = localStorage.getItem("password");
        if (username) {
            $.ajax({
                type: "POST",
                url: "../manage/saleAdmin.json?timestamp=" + new Date().getTime(),
                dataType: "json",
                cache: false,
                data: {
                    username: username,
                    password: password
                },
                success: function (rst) {
                    if (rst.result) {
                        location.href = "../sale/order/waitOrder.htm";
                    } else {
                        alert("用户名或密码错误");
                    }
                },
                error: function () {
                    alert('请求出错');
                }
            });

        }
        $('#adminForm')
                .ajaxForm(
                {
                    dataType: 'json',
                    success: function (data) {
                        if (data.result) {
                            var username=$("#username").val();
                            var password=$("#password").val();
                            localStorage.setItem("username",username);
                            localStorage.setItem("password",password);
                            location.href = "../sale/order/waitOrder.htm";
                        } else {
                            alert("用户名或密码错误");
                        }
                    }
                });
    });
</script>


</body>
</html>

