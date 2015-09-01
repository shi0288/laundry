<#include "title.ftl">

    <div data-role="content">

        <div class="page-role container-fluid">
            <div class="head-img">
                <span class="my-img" style="background-image:url('${BASE_PATH}/common/css/images/defaul.png')"></span>
                <p id="acountName"></p>
                <p>铜牌用户</p>
            </div>

            <ul class="padding-list current-half-width">
                <li>
                    <a id="waite4Payment" href="#">
                        <p id="waite4PaymentSum">${(payNum)!"0"}</p>
                        <p>待付款</p>
                    </a>
                </li>
                <li>
                    <a id="waitDeliveryOrderList" href="#">
                        <p id="waitDeliveryOrderListSum">${(waitNum)!"0"}</p>
                        <p>待收货</p>
                    </a>
                </li>
            </ul>

            <ul class="menu-list">
                <li>
                    <a id="quanbudingdan" href="#">
                        <img src="${BASE_PATH}/common/css/images/order.png" alt="">
                        <p>全部订单</p>
                    </a>
                </li>


                <li>
                    <a id="shouhuodizhi" href="address.html">
                        <img src="${BASE_PATH}/common/css/images/history.png" alt="">
                        <p>收货地址</p>
                    </a>
                </li>

                <li>
                    <a id="zhanghuguanli" href="#">
                        <img src="${BASE_PATH}/common/css/images/acount.png" alt="">
                        <p>账户管理</p>
                    </a>
                </li>

                <li>
                    <a id="wodeyuyue" href="#">
                        <img src="${BASE_PATH}/common/css/images/time.png" alt="">
                        <p>最新活动</p>
                    </a>
                </li>

                <li>
                    <a id="wodeqianbao" href="#">
                        <img src="${BASE_PATH}/common/css/images/package.png" alt="">
                        <p>我的优惠</p>
                    </a>
                </li>


                <li>
                    <a id="wodeguanzhu" href="#">
                        <img src="${BASE_PATH}/common/css/images/love.png" alt="">
                        <p>我的收藏</p>
                    </a>
                </li>

                <li>
                    <a id="fuwuguanjia" href="#">
                        <img src="${BASE_PATH}/common/css/images/lingdai.png" alt="">
                        <p>服务建议</p>
                    </a>
                </li>

                <li>
                    <a id="yingyongtuijian" href="#">
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