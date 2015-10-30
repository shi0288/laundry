<#include "title.ftl">
    <div data-role="content">
        <div class="page-role container-fluid good-page" style="margin-top:15px;">
            <div class="page-title">
                <a data-rel="back" class="return">返 回</a>
                更新地址
            </div>
            <input  type="hidden" id="update_id" value="${(e._id)!""}" />
            <div class="address02">
                <div class="s-item bdb-1px">
                    <div class="sitem-l sitem-pad">
                        <div class="sattr">收货人名：</div>
                        <div class="svalue"> <input data-role="none"  type="text" id="update_uersName"  maxlength="11" value="${(e.userName)!""}" class="ad-name"></div>
                    </div>
                </div>
                <div class="s-item bdb-1px">
                    <div class="sitem-l sitem-pad">
                        <div class="sattr">手机号码：</div>
                        <div id="mobileInputDiv" class="svalue">  <input data-role="none"  type="text" id="update_mobile" maxlength="11" value="${(e.mobile)!""}" class="ad-mobile"></div>
                    </div>
                </div>
                <div class="s-item bdb-1px">
                    <select id="update_provice">
                            <option value="经贸学院" <#if e.provice=='经贸学院'> selected</#if>>经贸学院</option>
                            <option value="河北经贸大学" <#if e.provice=='河北经贸大学'> selected</#if>>河北经贸大学</option>
                            <option value="铁路职业学院" <#if e.provice=='铁路职业学院'> selected</#if>>铁路职业学院</option>
                            <option value="石家庄学院" <#if e.provice=='石家庄学院'> selected</#if>>石家庄学院</option>
                    </select>
                </div>

                <div class="s-item bdb-1px">
                    <div class="sitem-l sitem-pad">
                        <div class="sattr">详细地址：</div>
                        <div class="svalue w65">
                            <textarea data-role="none"  class="textauto" style="height:auto;"  id="update_where" maxlength="41">${(e.where)!""}</textarea>
                        </div>
                    </div>

                </div>
                <div class="s-item bdb-1px">
                    <div class="sitem-m sitem-pad">
                        <div class="sattr">设为默认地址</div>
                    </div>
                    <div class="sitem-r">
                        <div id="updateBtn" class="switch <#if e.status==0>switched</#if> "></div>
                    </div>

                </div>
                <div class="bar-btn02">
                    <a href="javascript:delAddress();" class="btn2 ctn01 confirm-del" style="color: #bfbfbf;background: #f0f0f0;border: 1px solid #f0f0f0;">删除</a>
                    <a href="javascript:updateAddress();" style="color: #fff; background: #f35656;border: 1px solid #f35656;" id="submitId" class="btn2 ctn02">更新</a>
                </div>
            </div>




        <!-- /content -->
    </div>
    </div>
</body>
</html>