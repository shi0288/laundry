<#include "title.ftl">

    <div data-role="content">

        <div class="page-role container-fluid good-page" style="margin-top:15px">
            <div class="main">
                <div class="item item-username">
                    <input data-role="none" class="txt-input txt-username" id="l_mobile" type="text" placeholder="    请输入用户名/邮箱/已验证手机"
                           autofocus="" required="">
                </div>
                <div class="item item-password">
                    <input data-role="none" class="txt-input txt-password" id="l_password" type="password" autocomplete="off"
                           placeholder="    请输入密码" required="">
                    <b class="tp-btn btn-off"></b>
                </div>
                <div class="item item-captcha">
                    <div class="input-info" style="display:;">
                        <input data-role="none" class="txt-input txt-captcha"  id="l_captcha"  type="text" size="11" maxlength="6"
                               autocomplete="off" placeholder="    请输入验证码">
                        <span onclick="changeImg(this)" id="captcha-img"><img src="${INTER_PATH}/manage/code.img" width="65" height="30"
                                                    alt=""></span>
                    </div>
                    <div class="login-free login-free-selected"><b></b>一个月内免登录</div>
                </div>
                <div class="item item-btns">
                    <a class="btn-login" href="javascript:login();">登录</a>
                </div>
                <div class="item item-login-option">
            <span class="register-free">
                <a href="regest.html" style="font-size:16px">免费注册</a>
            </span>
            <span class="retrieve-password">
                <a href="https://passport.m.jd.com/findloginpassword/fillAccountName.action" style="font-size:16px">找回密码</a>
            </span>
                </div>
            </div>

        </div>
        <!-- /content -->
    </div>

</body>
</html>