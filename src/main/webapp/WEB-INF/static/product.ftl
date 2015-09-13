<#include "title.ftl">

<div data-role="content">

    <!-- **********************   导航  ********************** -->
    <div class="page-role container-fluid" style="margin-top:15px">
        <div class="page-title">
            <a href="javascript:$.mobile.changePage('sort.html', 'slide');" class="return">分 类</a>
            商品浏览
            <a href="#nav-panel">高级筛选<i></i></a>
        </div>
        <div class="pxui-tab product-tab" style="margin-bottom:10px;">
            <input  type="hidden"  id="pP"  value="${(p)!"1"}" />
            <input  type="hidden"  id="pStr"  value="${(cond.sortStr)!""};${(cond.orderBy)!""};${(cond.mainProId)!""};${(cond.sortProId)!""};${(cond.brandId)!""}" />
            <a href="product.html?mainProId=${(cond.mainProId)!""}&sortProId=${(cond.sortProId)!""}&brandId=${(cond.brandId)!""}&sortStr=jump&orderBy=-1" <#if cond.sortStr=='jump'>
               class="selected" </#if> style="width: 24.4%;">推 荐</a>
            <a href="product.html?mainProId=${(cond.mainProId)!""}&sortProId=${(cond.sortProId)!""}&brandId=${(cond.brandId)!""}&sortStr=price&orderBy=<#if cond.sortStr=='price' && cond.orderBy==1>-1<#elseif cond.sortStr=='price' && cond.orderBy==-1>1<#else>-1</#if>" <#if cond.sortStr=='price'>
               class="selected" </#if> style="width: 24.4%;">
                价 格
                <i class="arrow2-top <#if cond.sortStr?? && cond.sortStr=='price'><#if cond.orderBy==-1>gray</#if></#if> "></i>
                <i class="arrow2-bottom <#if cond.sortStr?? && cond.sortStr=='price'><#if cond.orderBy==1>gray</#if></#if> "></i>
            </a>
            <a  <#if cond.sortStr=='saleNum'> class="selected" </#if>
                                              href="product.html?mainProId=${(cond.mainProId)!""}&sortProId=${(cond.sortProId)!""}&brandId=${(cond.brandId)!""}&sortStr=saleNum&orderBy=-1"
                                              style="width: 24.4%;">销 量</a>
            <a  <#if cond.sortStr=='createTime'> class="selected" </#if>
                                                 href="product.html?mainProId=${(cond.mainProId)!""}&sortProId=${(cond.sortProId)!""}&brandId=${(cond.brandId)!""}&sortStr=createTime&orderBy=-1"
                                                 style="width: 24.4%;">最 新</a>
        </div>
        <div class="pxui-area">
            <div class="pxui-shoes product-list">
                <div id="js-goodlist" style="position: relative;">
                <#list pageVo.list as e >
                    <a href="proDetail.html?proId=${e._id}" data-transition="slide"
                       style="width:33%;min-width: 0px;height:203px; ">
                        <#list e.fileNames as f>
                            <#if f_index==0>
                                <div class="img160" style="background-image: none;width:100%;height: 120px">
                                    <dfn></dfn><img style="max-height: 90px;" src="../../upload/img/${f}"
                                                    onerror="nofind();"/></div>
                            </#if>
                        </#list>
                        <span style="padding-top: 0px;" class="name">${e.name}</span>
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

<div data-role="panel" style="background-color: #f8f8f8;margin-top: 52px" data-position="left"
     data-display="overlay" id="nav-panel"
     data-theme="a">
    <ul data-role="none" data-theme="a" data-divider-theme="a" class="nav-search">
        <li data-icon="delete" style="background-color:#111;text-align: center">
            <a href="#" data-rel="close" style="color:#fff;text-shadow:0 0px 0 #f3f3f3">关闭菜单</a>
        </li>

    <#list mainPro as e>
        <li>
            <a href="product.html?mainProId=${e._id}&sortStr=jump&orderBy=-1">${e.name}</a>
        </li>
        <li>
            <#list e.sortList as s>
                <a href="product.html?sortProId=${s._id}&sortStr=jump&orderBy=-1" class="ui-btn ui-btn-inline"
                   style="font-size: 12px;">${s.name}</a>
            </#list>
        </li>
    </#list>

    </ul>
    <!-- panel content goes here -->
</div><!-- /panel -->


</div>


</body>
</html>