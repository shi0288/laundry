<!DOCTYPE html >
<head>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>待发货订单</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0 , maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" type="text/css" href="../../static/sale/common/css/base.css">
    <link rel="stylesheet" type="text/css" href="../../static/sale/common/css/order.css">

    <script type="text/javascript" src="../../static/sale/common/js/jquery-1.10.1.min.js"></script>
    <script type="text/javascript" src="../../static/sale/common/js/iscroll.js"></script>
    <script type="text/javascript" charset="utf-8">
        $(function() {
            //菜单框架自动获取高度
            var doc_H=$(document).height();
            $('.Menu_box').height(doc_H);
            window.onresize=function(){
                var doc_H=$(document).height();
                $('.Menu_box').height(doc_H);
            }
        });


        var myScroll_left;
        var myScroll_right;
        function loaded () {
            myScroll_left = new IScroll('#left_Menu', { mouseWheel: true, click: true });
            myScroll_right = new IScroll('#right_Menu', { mouseWheel: true, click: true });
        }
        document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
    </script>

</head>

<body onLoad="loaded()">


<div id="warp" class="mg-auto overflow">
    <!--头部开始-->
    <div id="header">
        <div class="menu">
            <div class="bt-name"><a href="waitOrder.htm">等待送货</a></div>
        </div><!--menu-->

        <div class="menu selected">
            <div class="bt-name"><a href="javascript:;">已处理订单</a></div>
        </div><!--menu-->

        <div class="menu">
            <div class="bt-name"><a href="saleNumbers.htm">今日销量</a></div>
        </div><!--menu-->

        <div class="menu">
            <div class="bt-name"><a href="javascript:;">昨日销量</a></div>
        </div><!--menu-->
    </div>
    <!--头部结束-->

    <div class="order_tab">
        <ul>
            <li style="width:30%;" class="on">已处理</li>
            <li style="width:70%">订单详情</li>
        </ul>
    </div>

    <!--菜单-->
    <div class="Menu_box">
        <!---------左侧菜单---------->
        <div id="left_Menu">
            <div id="scroller">
                <ul>
                 <#if idStr??>
                     <#list  e as p>
                         <#if p._id==idStr>
                             <li class="on">
                                 <a href="#"><h2>￥${p.orderPrice}</h2></a>
                             </li>
                         <#else>
                             <li>
                                 <a href="dealOrder.htm?id=${p._id}"><h2>￥${p.orderPrice}</h2></a>
                             </li>
                         </#if>
                     </#list>

                 <#else>
                     <#list  e as p>
                         <#if p_index==0>
                             <li class="on">
                                 <a href="#"><h2>￥${p.orderPrice}</h2></a>
                             </li>
                         <#else>
                             <li>
                                 <a href="dealOrder.htm?id=${p._id}"><h2>￥${p.orderPrice}</h2></a>
                             </li>
                         </#if>
                     </#list>
                 </#if>
                </ul>
            </div>
        </div>

        <!---------右侧侧菜单---------->
        <div id="right_Menu">
            <#if order??>
                <div id="scroller2">
                    <ul>
                        <li>
                            <bdo>金额：${order.orderPrice}元</bdo>
                            <p>状态:<#if order.status==1200>送货成功<#else>取消订单</#if></p>
                            <p>支付方式:<#if order.payType==0>货到付款<#else>微信支付</#if></p>
                            <p>下单时间:${order.createTime?number?number_to_datetime}</p>
                        </li>
                        <li>
                            <bdo>收货信息</bdo>
                            <p>收货人：${order.conName}</p>
                            <p>手机号：${order.conMobile}</p>
                            <p>收货地址：${order.conAddress}</p>
                        </li>
                        <li  style="border-bottom: 0px solid #dddddd;">
                            <bdo>商品清单</bdo>
                            <table id="proList" style="font-size: 13px;" width="100%">
                                <tr>
                                    <td>名称</td>
                                    <td>单价</td>
                                    <td>数量</td>
                                </tr>

                                <#list  order.orderStr?split(";") as p>
                                    <#assign json=p?eval />
                                    <tr>
                                        <td>${(json.name)!""}</td>
                                        <td>￥${(json.price)!""}</td>
                                        <td>${(json.numbers)!""} 件</td>
                                    </tr>
                                </#list>
                            </table>
                        </li>
                    </ul>
                </div>
            </div>
            </#if>
    </div>
    <!--菜单end-->
</div>
</body>
</html>
