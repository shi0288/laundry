<#include "title.ftl">

<div data-role="content">

    <div class="page-role container-fluid good-page" style="margin-top:15px">
        <div class="page-title">
            <a data-rel="back" class="return">返 回</a>
            抢限量
        </div>
        <div class="pxui-tab product-tab" style="margin-bottom:10px;">
            <input  type="hidden"  id="tuanP"  value="${(p)!"1"}" />
            <input  type="hidden"  id="tuanStr"  value="${(cond.sortStr)!""};${(cond.orderBy)!""}" />
            <a href="tuan.html?sortStr=jump&orderBy=-1" <#if cond.sortStr=='jump'>
               class="selected" </#if> style="width: 24.4%;">推 荐</a>
            <a href="tuan.html?sortStr=price&orderBy=<#if cond.sortStr=='price' && cond.orderBy==1>-1<#elseif cond.sortStr=='price' && cond.orderBy==-1>1<#else>-1</#if>" <#if cond.sortStr=='price'>
               class="selected" </#if> style="width: 24.4%;">
                价 格
                <i class="arrow2-top <#if cond.sortStr?? && cond.sortStr=='price'><#if cond.orderBy==-1>gray</#if></#if> "></i>
                <i class="arrow2-bottom <#if cond.sortStr?? && cond.sortStr=='price'><#if cond.orderBy==1>gray</#if></#if> "></i>
            </a>
            <a  <#if cond.sortStr=='saleNum'> class="selected" </#if>
                                              href="tuan.html?sortStr=saleNum&orderBy=-1"
                                              style="width: 24.4%;">销 量</a>
            <a  <#if cond.sortStr=='createTime'> class="selected" </#if>
                                                 href="tuan.html?sortStr=createTime&orderBy=-1"
                                                 style="width: 24.4%;">最 新</a>
        </div>
        <div id="tuan-goodlist" style="position: relative;">
        <#list pageVo.list as e >
            <div class="tuan-list">
                <div class="img120">
                    <a href="proDetail.html?proId=${e._id}"><dfn></dfn>
                        <#list e.fileNames as f>
                            <#if f_index==0>
                                <img src="${UPLOAD_BASE_PATH}/img/${f}"  onerror="nofind();"/>>
                            </#if>
                        </#list>
                    </a>
                </div>

                <a href="proDetail.html?proId=${e._id}" class="title">${e.name}</a>
                <p> <span class="pxui-color-yellow">数量：<span class="red">${e.num}</span></span> </p>
                <p>
                    <span class="pxui-color-red">￥${e.price}</span>
                    <del class="pxui-color-gray">￥${e.oldPrice}</del>
                </p>
            </div>
        </#list>
        </div>
    </div>
    <!-- /content -->
</div>

</body>
</html>