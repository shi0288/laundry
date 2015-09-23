<!DOCTYPE html >
<head>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>今日销量</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0 , maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" type="text/css" href="../../static/sale/common/css/base.css">
    <link rel="stylesheet" type="text/css" href="../../static/sale/common/css/order.css">
    <script type="text/javascript" src="../../static/sale/common/js/jquery-1.10.1.min.js"></script>

</head>

<body>


<div id="warp" class="mg-auto overflow">
    <!--头部开始-->
    <div id="header">
        <div class="menu">
            <div class="bt-name"><a href="waitOrder.htm">等待送货</a></div>
        </div><!--menu-->

        <div class="menu">
            <div class="bt-name"><a href="dealOrder.htm">已处理订单</a></div>
        </div><!--menu-->

        <div class="menu selected">
            <div class="bt-name"><a href="javascript:;">今日销量</a></div>
        </div><!--menu-->

        <div class="menu">
            <div class="bt-name"><a href="javascript:;">昨日销量</a></div>
        </div><!--menu-->
    </div>
    <!--头部结束-->

    <div class="well">
        <table>
            <tr>
                <td>待送订单：${one}</td>
                <td>金额：￥${oneNum/100}</td>
            </tr>
            <tr>
                <td>成功订单：${two}</td>
                <td>金额：￥${twoNum/100}</td>
            </tr>
            <tr>
                <td>取消订单：${three}</td>
                <td>金额：￥${threeNum/100}</td>
            </tr>
        </table>
    </div>



    <!--菜单end-->
</div>
</body>
</html>
