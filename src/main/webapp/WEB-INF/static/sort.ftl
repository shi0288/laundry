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

        <!-- **********************   导航  ********************** -->
        <div class="container-fluid" style="margin-top: 10px">
            <div class="well pxui-tab pxui-tab-nav pxui-tab-no-top">
                <a href="main.html"><i></i>首页<span></span></a>
                <a class="selected"><i></i>分类<span></span></a>
                <a href="brand.html"><i></i>品牌<span></span></a>
                <a href="tuan.html"><i></i>团购<span></span></a>
            </div>
        </div>

        <div class="container-fluid">
            <div class="well sortList" style="padding: 0">
                <div class="pxui-list">
                    <#list mainPro as e>
                        <a href="${INTER_PATH}/product.html?mainProId=${e._id}">
                            <span></span>
                            <b>${e.name}</b>
                            <i class="arrow-right"></i>
                        </a>
                        <p>
                        <#list e.sortList as s>
                            <a href="${INTER_PATH}/product.html?sortProId=${s._id}">${s.name}</a>&nbsp;
                         </#list>
                        </p>
                    </#list>
                </div>
            </div>
        </div>
    </div>
    <!-- /content -->

</div>

</body>
</html>