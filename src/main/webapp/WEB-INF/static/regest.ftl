<#include "title.ftl">

    <div data-role="content">

        <div class="page-role container-fluid good-page" style="margin-top:15px">
            <div class="main">

                <div class="item item-captcha">
                    <div class="input-info" style="display:;">
                        <input data-role="none" class="txt-input txt-captcha"  id="r_captcha" type="text" size="11" maxlength="6"
                               autocomplete="off" placeholder="    请输入验证码" autofocus="">
                        <span id="captcha-img" onclick="changeImg(this)" ><img src="${INTER_PATH}/manage/code.img" width="65" height="30"
                                                    alt=""></span>
                    </div>
                </div>
                <div class="item item-phone">
                    <input data-role="none" id="r_mobile"  class="txt-input txt-phone" type="tel" placeholder="    请输入手机号">
                    <a href="javascript:;" class="btn-retransmit btn-retransmit-disabled">获取短信验证码</a>
                </div>

                <div class="item item-username">
                    <input data-role="none" class="txt-input txt-sms-captcha" type="text"
                           placeholder="    请输入短信验证码"
                           required="">

                </div>
                <div class="item item-password">
                    <input data-role="none" class="txt-input txt-password" type="password" autocomplete="off"
                           id="r_password"    placeholder="     请输入密码" required="">
                    <b class="tp-btn btn-off"></b>
                    <div class="login-free login-free-selected"><b></b>注册即视为同意《XXXXX》</div>
                </div>

                <div class="item item-btns">
                    <a class="btn-login" href="javascript:register();">注册</a>
                </div>
            </div>

        </div>
        <!-- /content -->
    </div>

</body>
</html>