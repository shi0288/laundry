<body>
<div data-role="page" data-dom-cache="false">

    <div data-role="header" data-position="fixed">
        <div class="com-header-area">
            <a href="main.html" class="com-header-logo"></a>
            <dfn></dfn>

            <p>
                <a class="com-header-search" id="js-com-header-search">
                    <del></del>
                </a>
                <a href="login/default.htm" class="com-header-user ">
                    <del></del>
                </a>
                <i></i>
                <a href="cart/default.htm" class="com-header-cart"><b name="header-cart-num" id="header-cart-num">0</b>
                    <del></del>
                </a>
            </p>
            <div class="clear"></div>
        </div>
    </div>

    <div data-role="content">

        <div class="page-role container-fluid">
            <div class="head-img">
                <span class="my-img" style="background-image:url('${BASE_PATH}/static/common/css/images/html5/defaul.png')"></span>
                <p id="acountName"></p>
                <p>铜牌用户</p>
            </div>

            <ul class="padding-list current-half-width">
                <li>
                    <a id="waite4Payment" href="/user/waite4Payment.action?sid=4ac04a98d532655bbe1ce06c5f3c498b">
                        <p id="waite4PaymentSum">0</p>
                        <p>待付款</p>
                    </a>
                </li>
                <li>
                    <a id="waitDeliveryOrderList" href="/user/waitDeliveryOrderList.action?sid=4ac04a98d532655bbe1ce06c5f3c498b">
                        <p id="waitDeliveryOrderListSum">0</p>
                        <p>待收货</p>
                    </a>
                </li>
            </ul>

            <ul class="menu-list">
                <li>
                    <a id="quanbudingdan" href="/user/allOrders.action?functionId=quanbudingdan&amp;sid=4ac04a98d532655bbe1ce06c5f3c498b">
                        <img src="${BASE_PATH}/common/css/images/order.png" alt="">
                        <p>全部订单</p>
                    </a>
                </li>


                <li>
                    <a id="liulanjilu" href="/myJd/history/wareHistory.action?functionId=liulanjilu&amp;sid=4ac04a98d532655bbe1ce06c5f3c498b">
                        <img src="${BASE_PATH}/common/css/images/history.png" alt="">
                        <p>收货地址</p>
                    </a>
                </li>

                <li>
                    <a id="zhanghuguanli" href="/user/accountCenter.action?functionId=zhanghuguanli&amp;sid=4ac04a98d532655bbe1ce06c5f3c498b">
                        <img src="${BASE_PATH}/common/css/images/acount.png" alt="">
                        <p>账户管理</p>
                    </a>
                </li>

                <li>
                    <a id="wodeyuyue" href="/user/preSells.action?functionId=wodeyuyue&amp;sid=4ac04a98d532655bbe1ce06c5f3c498b">
                        <img src="${BASE_PATH}/common/css/images/time.png" alt="">
                        <p>最新活动</p>
                    </a>
                </li>

                <li>
                    <a id="wodeqianbao" href="/wallet/wallet.action?functionId=wodeqianbao&amp;sid=4ac04a98d532655bbe1ce06c5f3c498b">
                        <img src="${BASE_PATH}/common/css/images/package.png" alt="">
                        <p>我的优惠</p>
                    </a>
                </li>


                <li>
                    <a id="wodeguanzhu" href="/myJd/myFocus/focusWare.action?functionId=wodeguanzhu&amp;sid=4ac04a98d532655bbe1ce06c5f3c498b">
                        <img src="${BASE_PATH}/common/css/images/love.png" alt="">
                        <p>我的收藏</p>
                    </a>
                </li>

                <li>
                    <a id="fuwuguanjia" href="/user/services.action?functionId=fuwuguanjia&amp;sid=4ac04a98d532655bbe1ce06c5f3c498b">
                        <img src="${BASE_PATH}/common/css/images/lingdai.png" alt="">
                        <p>服务建议</p>
                    </a>
                </li>

                <li>
                    <a id="yingyongtuijian" href="//m.jd.com/download/downApp.html?functionId=yingyongtuijian&amp;sid=4ac04a98d532655bbe1ce06c5f3c498b">
                        <img src="${BASE_PATH}/common/css/images/app.png" alt="">
                        <p>咱滴应用</p>
                    </a>
                </li>

            </ul>

        </div>
        <!-- /content -->

        <div class="com-footer" style="margin-top:40px ">
            <p class="com-policy">
                <strong>
                    <a class="pxui-color-white" href="javascript:void(0)">
                        <i></i>
							<span>自营商品<br>
							满99包邮</span>
                    </a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="pxui-color-white" href="javascript:void(0)">
                        <i style="background-position:-40px -108px;"></i>
							<span>15天无理由<br>
							免邮退换货</span>
                    </a>
                </strong>
            </p>
            <br>
            <br>
            <p>
                <strong>
                    <a href="../wap.paixie.net/default.htm">极速版</a>&nbsp;&nbsp;
                    <a href="default.htm">触屏版</a>&nbsp;&nbsp;
                    <a href="help/app.html">客户端</a>
                </strong>
            </p>
            <br>
            © 2007-2013 Paixie All Rights Reserved<br>
            闽B2-20110084
            <br>
        </div>


    </div>

</body>
</html>