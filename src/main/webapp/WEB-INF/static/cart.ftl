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

        <div class="page-role container-fluid good-page" style="margin-top:15px">
            <div class="page-title">
                <a data-rel="back" class="return">返 回</a>
                商品详情
                <a href="#" onclick="removeAll()">全部清空<i></i></a>
            </div>
            <div class="well cart" style="padding: 10px;">
                <ul id="proList">
                </ul>
            </div>

            <div class="cart_bg">
                <table width="100%" border="0">
                    <tbody>
                    <tr>
                        <td width="3%"></td>
                        <td width="25%"><input data-role="none" type="checkbox" class="checkbox checked" id="box_all">
                            全选
                        </td>
                        <td width="49%">
                            <p><span class="pl15">金额合计：</span><span class="ff6">￥0.00</span></p>
                        </td>
                        <td width="20%">
                            <button onclick="toConform()" data-role="none"
                                    class="submit">结算
                            </button>
                        </td>
                        <td width="3%"></td>
                    </tr>
                    </tbody>
                </table>
            </div>

        </div>
        <!-- /content -->
    </div>

</body>
</html>