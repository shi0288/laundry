<#include "title.ftl">

<div data-role="content">
    <div class="page-role container-fluid good-page" style="margin-top:15px">
        <div class="page-title">
            <a data-rel="back" class="return">返 回</a>
            订单列表
        </div>
    <#if (e?size==0)>
        <div class="well cart" style="padding: 5px;margin-top: 10px">
            <p style="text-align: center">当前订单列表是空滴。</p>
        </div>
    </#if>


    <#list e as o>
        <div class="well cart" style="padding: 5px;margin-top: 10px">
            <ul id="userOrderList">
                <li class="proThree">
                    <table>
                        <tr>
                            <td colspan="3" style="font-size: 14px;font-weight:bold;">订单信息：<span
                                    style="color:red"><#if o.status==1100>派送中<#elseif o.status==1200>
                                已完成<#elseif o.status==1000><a href="#" onclick="goToPay('${(o._id)!""}')">继续付款</a></#if></span>，${(o.orderPrice)!""}
                                元，${(o.createTime?number?number_to_datetime)!""}</td>
                        </tr>
                        <tr>
                            <td colspan="3" style="font-size: 14px;">收货信息：${(o.conName)!""}，${(o.conMobile)!""}
                                ，${(o.conAddress)!""}</td>
                        </tr>
                    </table>
                </li>
                <#list  o.orderStr?split(";") as p>
                    <#assign json=p?eval />
                    <li class="proThree">
                        <table>
                            <tr>
                                <td width="50%" id="_content"> ${(json.name)!""}</td>
                                <td width="20%" valign="middle">￥${(json.price)!""}</td>
                                <td width="20%" id="_check">${(json.numbers)!""} 件</td>
                            </tr>
                        </table>
                    </li>
                </#list>
            </ul>
        </div>
    </#list>
    </div>
    <!-- /content -->
</div>
</body>
</html>