<#include "title.ftl">

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
                            <p><span class="pl15">金额合计：</span><span class="ff6">￥0.00</span><span id="ff7" style="display: none">(含外送费)</span>
                                <span id="ff8" style="display: none;color: red">(免外送费)</span></p>
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