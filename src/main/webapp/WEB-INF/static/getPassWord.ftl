<#include "title.ftl">

    <div data-role="content">

        <div class="page-role container-fluid good-page" style="margin-top:15px">
            <div class="main">

                <div class="item item-captcha">
                    <div class="input-info" style="display:;">
                        <input data-role="none" class="txt-input txt-captcha"  id="z_captcha" type="text" size="11" maxlength="6"
                               autocomplete="off" placeholder="    请输入验证码">
                        <span id="captcha-img" onclick="changeImg(this)" ><img src="manage/code.img" width="65" height="30"
                                                    alt=""></span>
                    </div>
                </div>
                <div class="item item-phone">
                    <input data-role="none" id="z_mobile"  class="txt-input txt-phone" type="tel" placeholder="    请输入手机号" maxlength="11" onkeyup="testPassWordMobile()" />
                    <a href="javascript:;" id="z_mobileBut" class="btn-retransmit btn-retransmit-disabled" >获取短信验证码</a>
                </div>

                <div class="item item-username">
                    <input data-role="none" class="txt-input txt-sms-captcha" type="text"
                           placeholder="    请输入短信验证码"
                           required="" id="z_msgCode">

                </div>
                <div class="item item-password">
                    <input data-role="none" class="txt-input txt-password" type="password" autocomplete="off"
                           id="z_password"    placeholder="     请输入新密码" required="">
                    <b class="tp-btn btn-off"></b>
                </div>

                <div class="item item-btns">
                    <a class="btn-login" href="javascript:getPassWord();">确认</a>
                </div>
            </div>

        </div>
        <!-- /content -->
    </div>

</body>
</html>