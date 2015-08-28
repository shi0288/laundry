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

            <div class="address02">
                <div class="s-item bdb-1px">
                    <div class="sitem-l sitem-pad">
                        <div class="sattr">收货人名：</div>
                        <div class="svalue"> <input data-role="none"  type="text" id="address_uersName"  maxlength="11" value="" class="ad-name"></div>
                    </div>
                </div>
                <div class="s-item bdb-1px">
                    <div class="sitem-l sitem-pad">
                        <div class="sattr">手机号码：</div>
                        <div id="mobileInputDiv" class="svalue">  <input data-role="none"  type="text" id="address_mobile" maxlength="11" value="" class="ad-mobile"></div>
                    </div>
                </div>
                <div class="s-item bdb-1px">
                    <select id="address_provice">
                            <option value="standard">选择地址</option>
                            <option value="正定县">正定县</option>
                            <option value="经贸学院">经贸学院</option>
                    </select>
                </div>

                <div class="s-item bdb-1px">
                    <div class="sitem-l sitem-pad">
                        <div class="sattr">详细地址：</div>
                        <div class="svalue w65">
                            <textarea data-role="none"  class="textauto" style="height:auto;"  id="address_where" maxlength="41"></textarea>
                        </div>
                    </div>

                </div>
                <div class="s-item bdb-1px">
                    <div class="sitem-m sitem-pad">
                        <div class="sattr">设为默认地址</div>
                    </div>
                    <div class="sitem-r">
                        <div id="adrBtn" class="switch"></div>
                    </div>

                </div>
                <div class="bar-btn02">


                    <a href="javascript:;" class="btn2 ctn01 confirm-del" style="color: #bfbfbf;background: #f0f0f0;border: 1px solid #f0f0f0;">删除</a>


                    <a href="javascript:saveAddress();" style="color: #fff; background: #f35656;border: 1px solid #f35656;" id="submitId" class="btn2 ctn02">保存并使用</a>
                </div>
            </div>




        <!-- /content -->
    </div>

</body>
</html>