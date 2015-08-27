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
        <div class="page-role container-fluid good-page" style="margin-top:15px;">
            <div class="page-title">
                <a data-rel="back" class="return">返 回</a>
                填写订单
            </div>
            <div>
                <div class="step1 border-1px">
                    <div class="m step1-in ">
                        <a href="/norder/address.action?sid=15bc93e0ec38707af83754f69fef2ef5" class="s-href">
                            <div class="mt_new">                      <div class="s1-name">
                                <i></i><span>石清茂</span>
                            </div>
                                <div class="s1-phone">
                                    <i></i><span> 133****6503</span>
                                </div>

                            </div>
                            <div class="mc step1-in-con">
                                河北石家庄市正定县正定镇正华花园8号楼
                            </div>
                        </a>
                    </div>
                    <b class="s1-borderT"></b>
                    <b class="s1-borderB"></b>
                </div>
            </div>

            <div class="well cart" style="padding: 5px;margin-top: 10px">
                <ul id="orderList">
                    <li class="proTwo">
                        <table>
                            <tr>
                                <td colspan="3" style="font-size: 14px;font-weight:bold;">订单信息</td>
                            </tr>
                        </table>
                    </li>
                </ul>
            </div>

            <div class="well" style="padding: 10px;margin-bottom: 100px">
                <fieldset data-role="controlgroup">
                    <legend>支付方式:</legend>
                    <input type="radio" name="radio-choice-1" id="radio-choice-1" value="choice-1" checked="checked">
                    <label for="radio-choice-1">货到付款</label>
                    <input type="radio" name="radio-choice-1" id="radio-choice-2" value="choice-2">
                    <label for="radio-choice-2">支付宝</label>
                </fieldset>
            </div>

            <div class="pay-bar" id="pay-bar">
                <div class="payb-con">实付款：<span id="payMoney">￥1309.00</span>
                </div>
                <a class="payb-btn" onclick="submitOrder('true')" href="javascript:;">
                    提交订单
                </a>
            </div>
        </div>
        <!-- /content -->
    </div>

</body>
</html>