<#include "header.ftl">
<body>
<div data-role="page">
    <div data-role="content">
        <!-- **********************   页头  ********************** -->
        <div class="com-header-area">
            <a href="main.htm" class="com-header-logo"></a>
            <dfn></dfn>

            <p>
                <a class="com-header-search" id="js-com-header-search">
                    <del></del>
                </a>
                <a href="login/default.htm" class="com-header-user ">
                    <del></del>
                </a>
                <i></i>
                <a href="cart/default.htm" class="com-header-cart "><b id="header-cart-num">0</b>
                    <del></del>
                </a>
            </p>
            <div class="clear"></div>
        </div>


        <div class="page-role container-fluid good-page" style="margin-top:15px">
            <div class="page-title">
                <a class="return" href="javascript:history.back();void(0)">返 回</a>
                商品详情
                <a href="list/filter.php@special=&amp;main=1&amp;style=1&amp;brand=&amp;size=&amp;sex=&amp;price=&amp;keyword=">全部清空<i></i></a>

            </div>
            <div class="well cart" style="padding: 10px;">
                <ul>
                    <li>
                        <table>
                            <tr>
                                <td width="15%"><img onerror="nofind();" src="images/cart_img.jpg" width="52" height="44"></td>
                                <td width="65%">
                                    <p>新奇士脐橙，8斤，甜中带微</p>
                                    <p><span class="lse">￥198.00</span> <span class="pl15">数量：<input data-role="none" type="text" name="num" class="num"> 包</span></p>
                                </td>
                                <td width="10%" valign="middle"><a href="#" class="del">删除</a></td>
                                <td width="10%"> <input data-role="none" type="checkbox" class="checkbox"  name="check_item" id="check_item"></td>
                            </tr>
                        </table>
                    </li>

                    <li>
                        <table>
                            <tr>
                                <td width="15%"><img onerror="nofind();" src="images/cart_img.jpg" width="52" height="44"></td>
                                <td width="65%">
                                    <p>新奇士脐橙，8斤，甜中带微</p>
                                    <p><span class="lse">￥198.00</span> <span class="pl15">数量：<input data-role="none" type="text" name="num" class="num"> 包</span></p>
                                </td>
                                <td width="10%" valign="middle"><a href="#" class="del">删除</a></td>
                                <td width="10%"> <input data-role="none" type="checkbox" class="checkbox"  name="check_item" id="check_item"></td>
                            </tr>
                        </table>
                    </li>
                </ul>

                <div class="cart_bg">
                    <table width="100%" border="0">
                        <tbody><tr>
                            <td width="3%"></td>
                            <td width="25%"><input type="checkbox" class="checkbox checked" id="box_all"> 全选</td>
                            <td width="49%">
                                <p> <span class="pl15">金额合计：</span><span class="ff6">￥198.00</span></p>
                            </td>
                            <td width="20%"><button class="submit">去结算</button></td>
                            <td width="3%"></td>
                        </tr>
                        </tbody></table>
                </div>

        </div>
    </div>
    <!-- /content -->

</div>

</body>
</html>