<#include "title.ftl">

    <div data-role="content">
        <div class="page-role container-fluid good-page" style="margin-top:15px;">
            <div class="page-title">
                <a data-rel="back" class="return">返 回</a>
                填写订单
            </div>
            <div>
                <div class="step1 border-1px">
                    <div class="m step1-in ">
                        <a href="address.html" class="s-href">
                            <div class="mt_new"><div class="s1-name">
                                <i></i><span id="conName"></span>
                            </div>
                                <div class="s1-phone">
                                    <i></i><span id="conMobile"></span>
                                </div>
                            </div>
                            <div class="mc step1-in-con" id="conAddress">
                            </div>
                            <p style="font-size: 12px;color: #0000cc">(点击选择收货地址)</p>
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

            <div class="well" style="padding: 5px;">
                <fieldset data-role="controlgroup">
                    <legend><span style="font-size: 14px;font-weight:bold;">送货时间:</span><br/>11:00至14:00&nbsp&nbsp,&nbsp&nbsp17:00至21:30</legend>
                </fieldset>
            </div>

<input  type="hidden"  id="proWhere"  />
            <div class="well" style="padding: 10px;margin-bottom: 100px">
                <fieldset data-role="controlgroup">
                    <legend>支付方式:</legend>
                    <input type="radio" name="radio-choice-1" value="1" id="radio-choice-2" data-cacheval="false"  checked="checked">
                    <label for="radio-choice-2">微信支付</label>
                    <input type="radio" name="radio-choice-1" value="0" id="radio-choice-1" data-cacheval="true" >
                    <label for="radio-choice-1">货到付款</label>
                </fieldset>
            </div>

            <div class="pay-bar" id="pay-bar">
                <div class="payb-con">实付款：<span id="payMoney">￥1309.00</span>
                </div>
                <a class="payb-btn" onclick="commitOrder()" href="javascript:;">
                    提交订单
                </a>
            </div>
        </div>
        <!-- /content -->
    </div>

</body>
</html>