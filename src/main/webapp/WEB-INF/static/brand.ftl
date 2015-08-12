<#include "header.ftl">
<body>
<div data-role="page">
    <div data-role="content">
        <!-- **********************   页头  ********************** -->
        <div class="com-header-area">
            <a href="default.htm" class="com-header-logo"></a>
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

        <!-- **********************   导航  ********************** -->
        <div class="container-fluid" style="margin-top: 10px">
            <div class="well pxui-tab pxui-tab-nav pxui-tab-no-top">
                <a href="index.html"><i></i>首页<span></span></a>
                <a href="sort.html"><i></i>分类<span></span></a>
                <a class="selected"><i></i>品牌<span></span></a>
                <a href="product.html"><i></i>团购<span></span></a>
            </div>
        </div>
        <div class="brand-tab">
            <a class="selected" style="width: 49.5%;">按首字母找品牌</a>
        </div>
        <div class="tab-box" id="js-letter" style="display: block;">
            <p>
                <#list marks as m>
                <#if m.key=='ZZ'>
                    <a href="#0-9">0-9</a>
                <#else>
                    <a href="#${m.key}">${m.key}</a>
                </#if>
                </#list>
            </p>
        <#list marks as m>
            <#if m.key=='ZZ'>
                <div id="0-9" name="0-9" class="letter-title">
                    <b>0-9</b>
                    <a href="#">返回顶部<i class="arrow2-top"></i></a>
                </div>
                <div class="brands">
                    <div class="brandbox">
                        <#list m.brandList as b>
                            <a href="${INTER_PATH}/product.html?brandId=${b._id}"><i><img src="http://img-cdn2.paixie.net/newspic/20130225/1361773160886805.jpg" onerror="this.src='http://ued.paixie.net/images/brandlist/no-brand-logo.png?1'" alt="${b.name}" width="100" height="50"></i></a>
                        </#list>
                    </div>
                </div>
            <#else>
                <div id="${m.key}" name="${m.key}" class="letter-title">
                    <b>${m.key}</b>
                    <a href="#">返回顶部<i class="arrow2-top"></i></a>
                </div>
                <div class="brands">
                    <div class="brandbox">
                        <#list m.brandList as b>
                            <a href="${INTER_PATH}/product.html?brandId=${b._id}"><i><img src="http://img-cdn2.paixie.net/newspic/20130225/1361773160886805.jpg" onerror="this.src='http://ued.paixie.net/images/brandlist/no-brand-logo.png?1'" alt="${b.name}" width="100" height="50"></i></a>
                        </#list>
                    </div>
                </div>
            </#if>
        </#list>
        </div>
    </div>
    <!-- /content -->
</div>

</body>
</html>