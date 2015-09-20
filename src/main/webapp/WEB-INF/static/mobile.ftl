<#include "title.ftl">

    <div data-role="content">

        <div class="page-role container-fluid good-page" style="margin-top:15px">
            <div class="page-title">
                <a data-rel="back" class="return">返 回</a>
                绑定手机号
            </div>
            <div class="form-group">
                <label class="col-sm-2 col-sm-2 control-label">当前绑定：${(e.mobile)!"无绑定"}</label>
            </div>
            <div class="main">
                <div class="item item-captcha">
                    <div class="input-info" >
                        <input data-role="none" class="txt-input txt-captcha"  id="r_captcha" type="text" size="11" maxlength="6"
                               autocomplete="off" placeholder="    请输入验证码">
                        <span id="captcha-img" onclick="changeImg(this)" ><img src="manage/code.img" width="65" height="30"
                                                    alt=""></span>
                    </div>
                </div>
                <div class="item item-phone">
                    <input data-role="none" id="r_mobile"  class="txt-input txt-phone" type="tel" placeholder="    请输入手机号" maxlength="11" onkeyup="testMobile()" />
                    <a href="javascript:;" id="r_mobileBut" class="btn-retransmit btn-retransmit-disabled" >获取短信验证码</a>
                </div>

                <div class="item item-username">
                    <input data-role="none" class="txt-input txt-sms-captcha" type="text"
                           placeholder="    请输入短信验证码"
                           required="" id="r_msgCode">

                </div>

                <div class="item item-btns">
                    <a class="btn-login" href="javascript:bangding();">绑定</a>
                </div>
            </div>

        </div>
        <!-- /content -->
    </div>

</body>
</html>