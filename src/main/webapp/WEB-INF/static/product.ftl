<body>
<div data-role="page">

    <div data-role="header" data-position="fixed">
        <div class="com-header-area">
            <a href="main.html" class="com-header-logo"></a>
            <dfn></dfn>
            <p>
                <a class="com-header-search" id="js-com-header-search">
                    <del></del>
                </a>
                <a href="login/default.htm" class="com-header-user ">
                    <del></del>
                </a>
                <i></i>
                <a  href="cart/default.htm" class="com-header-cart"><b id="header-cart-num">1</b>
                    <del></del>
                </a>
            </p>
            <div class="clear"></div>
        </div>
    </div>

    <div data-role="content">

        <!-- **********************   导航  ********************** -->
        <div class="page-role container-fluid" style="margin-top:15px">
            <div class="page-title">
                <a data-rel="back"  class="return">返 回</a>
                商品浏览
                <a href="list/filter.php@special=&amp;main=1&amp;style=1&amp;brand=&amp;size=&amp;sex=&amp;price=&amp;keyword=">高级筛选<i></i></a>
            </div>
            <div class="pxui-tab product-tab" style="margin-bottom:10px;">
                <a href="${INTER_PATH}/product.html" class="selected" style="width: 24.4%;">推  荐</a>
                <a href="${INTER_PATH}/product.html?sortStr=price&orderBy=<#if cond.orderBy?? && cond.orderBy==1>-1<#elseif cond.orderBy?? && cond.orderBy==-1>1<#else>-1</#if>" style="width: 24.4%;">
                    价 格
                    <i class="arrow2-top <#if cond.sortStr?? && cond.sortStr=='price'><#if cond.orderBy==-1>gray</#if></#if> "></i>
                    <i class="arrow2-bottom <#if cond.sortStr?? && cond.sortStr=='price'><#if cond.orderBy==1>gray</#if></#if> "></i>
                </a>
                <a href="${INTER_PATH}/product.html?sortStr=saleNum&orderby=-1" style="width: 24.4%;">销 量</a>
                <a href="${INTER_PATH}/product.html" style="width: 24.4%;">最 新</a>
            </div>
            <div class="pxui-area">
                <div class="pxui-shoes">
                    <div id="js-goodlist" style="position: relative;">
                        <#list pageVo.list as e >
                            <a href="${INTER_PATH}/proDetail.html?proId=${e._id}"  data-transition="slide"  >
                                <#list e.fileNames as f>
                                  <#if f_index==0>
                                      <div class="img160" style="background-image: none;"><dfn></dfn><img src="${UPLOAD_BASE_PATH}/img/${f}"   onerror="nofind();" /></div>
                                  </#if>
                                </#list>
                                <span class="name">${e.name}</span>
                                <span class="price">￥${e.price}</span>
                                <del class="price">￥${e.oldPrice}</del>
                            </a>
                        </#list>
                    </div>
                </div>
            </div>
        </div>


    </div>
    <!-- /content -->
</div>

</body>
</html>