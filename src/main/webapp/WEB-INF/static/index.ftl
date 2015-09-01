<#include "title.ftl">

<div data-role="content"  >
    <!-- **********************   首页轮播  ********************** -->
    <div class="touchslider">
        <div class="touchslider-viewport" style="width:100%;overflow:hidden">
            <div>
            <#list pictures as p>
                <div class="touchslider-item"><a href="topic/739.html"><img
                        src="${UPLOAD_BASE_PATH}/img/${p.fileName}"
                        style="vertical-align:top;width:100%"/></a></div>
            </#list>
            </div>
        </div>

        <div class="touchslider-navtag">
        <#list pictures as p>
            <#if p_index==0>
                <span class="touchslider-nav-item touchslider-nav-item-current"></span>
            <#else>
                <span class="touchslider-nav-item "></span>
            </#if>
        </#list>
        </div>
    </div>


    <!-- **********************   导航  ********************** -->

    <div class="container-fluid">
        <div class="well pxui-tab pxui-tab-nav pxui-tab-no-top">
            <a class="selected"><i></i>首页<span></span></a>
            <a href="sort.html"><i></i>分类<span></span></a>
            <a href="brand.html"><i></i>品牌<span></span></a>
            <a href="tuan.html"><i></i>团购<span></span></a>
        </div>
    </div>

    <!-- **********************   推荐 ********************** -->
    <div class="container-fluid" style="margin-bottom: 10px;">
        <div class="tags">
            <table border="0" cellspacing="5" cellpadding="0">
                <tbody>
                <tr>
                    <td colspan="2"><a href="help/app.html"><i></i>立家净APP<br>总能找到你的至爱</a></td>
                    <td><a href="topic/612.html"><i></i>3折封顶</a></td>
                    <td rowspan="2"><a href="topic/612.html"><i></i>限<br>时<br>促<br>销</a></td>
                </tr>
                <tr>
                    <td><a href="topic/612.html"><b>最新</b><br>上架</a></td>
                    <td colspan="2"><a href="help/weixin.html">立家净微信<br>你的随身好帮手<i></i></a></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- **********************   栏目 ********************** -->

<#list mainPro as e>
    <#if e_index%2==0>
        <div class="container-fluid">
            <div class="pxui-area styles">
                <h2 style="background-color: ${(e.colorTip)!""} ; "><a
                        href="${INTER_PATH}/product.html?mainProId=${e._id}&sortStr=jump&orderBy=-1"
                        style="color:#FFFFFF;">${(e.name)!""}</a>
                </h2>
                <a class="max" href="${INTER_PATH}/product.html?mainProId=${e._id}&sortStr=jump&orderBy=-1"><img
                        src="${UPLOAD_BASE_PATH}/img/${e.fileName}" width="120" height="140"></a>

                <div>
                    <p>
                        <#list e.sortList as s>
                            <#if s.tip==0>
                                <a href="${INTER_PATH}/product.html?sortProId=${s._id}&sortStr=jump&orderBy=-1"
                                   style="background-color: ${(e.colorTip)!""} ; color:#FFFFFF;border: 1px solid ${(e.colorTip)!""}; ">${s.name}</a>
                            <#else>
                                <a href="${INTER_PATH}/product.html?sortProId=${s._id}&sortStr=jump&orderBy=-1">${s.name}</a>
                            </#if>
                        </#list>
                        <a href="${INTER_PATH}/product.html?mainProId=${e._id}&sortStr=jump&orderBy=-1" class="more">更多
                            <del><i class="arrow-right"></i></del>
                        </a>
                    </p>
                </div>
            </div>
        </div>
    <#else>
        <div class="container-fluid">
            <div class="pxui-area styles">
                <div>
                    <p>
                        <#list e.sortList as s>
                            <#if s.tip==0>
                                <a href="${INTER_PATH}/product.html?sortProId=${s._id}&sortStr=jump&orderBy=-1"
                                   style="margin-left:3px;margin-right:0px;background-color: ${(e.colorTip)!""}; color:#FFFFFF;border: 1px solid ${(e.colorTip)!""}; ">${s.name}</a>
                            <#else>
                                <a href="${INTER_PATH}/product.html?sortProId=${s._id}&sortStr=jump&orderBy=-1">${s.name}</a>
                            </#if>
                        </#list>
                        <a href="${INTER_PATH}/product.html?mainProId=${e._id}&sortStr=jump&orderBy=-1" class="more">更多
                            <del><i class="arrow-right"></i></del>
                        </a>
                    </p>
                </div>
                <a class="max" href="${INTER_PATH}/product.html?mainProId=${e._id}&sortStr=jump&orderBy=-1"><img
                        src="${UPLOAD_BASE_PATH}/img/${e.fileName}" width="120"
                        height="140"></a>

                <h2 style="background-color: ${(e.colorTip)!""}"><a
                        href="${INTER_PATH}/product.html?mainProId=${e._id}&sortStr=jump&orderBy=-1"
                        style="color:#FFFFFF;">${(e.name)!""}</a>
                </h2>
            </div>
        </div>

    </#if>

</#list>

    <div class="container-fluid index">
        <div class="pxui-area">
            <h3><b>Top5</b> 热销推荐<a class="pxui-button" href="${INTER_PATH}/product.html?sortStr=jump&orderBy=-1"><span>+</span> 更多 &gt;&gt;</a>
            </h3>

            <div class="pxui-shoes">
                <div>
                <#list tuijian as tui>

                    <#if (tui_index<2)>
                        <a href="${INTER_PATH}/proDetail.html?proId=${tui._id}">
                        <div class="img160" style="background-image: none;"><dfn></dfn>
                            <#list tui.fileNames as f>
                                <#if f_index==0>
                                    <img src="${UPLOAD_BASE_PATH}/img/${f}">
                                </#if>
                            </#list>
                        </div>
                        <span class="name">${tui.name}</span>
                        <span class="price">￥${tui.price}</span>
                        <del class="price">￥${tui.oldPrice}</del>
                        <span class="tag">${tui_index+1}</span>
                        </a>
                    </#if>
                </#list>
                </div>
            </div>
            <div class="pxui-list">
            <#list tuijian as tui>
                <#if (tui_index>1) >
                    <a href="${INTER_PATH}/proDetail.html?proId=${tui._id}"><span
                            class="pxui-bg-blue pxui-color-white">${tui_index+1}</span>

                        <p>${tui.name}</p><b>￥${tui.price}</b></a>
                </#if>
            </#list>
            </div>
        </div>
    </div>


    <!-- **********************   底部导航 ********************** -->

    <div class="com-footer-nav">
        <a href="index.html">首页</a><a href="help/index.html">帮助中心</a><a href="feedback/index.html">反馈建议</a>
    </div>

    <!-- **********************   页尾  ********************** -->
    <div class="com-footer">
        <p class="com-policy">
            <strong>
                <a class="pxui-color-white" href="javascript:void(0)">
                    <i></i>
							<span>自营商品<br>
							满99包邮</span>
                </a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a class="pxui-color-white" href="javascript:void(0)">
                    <i style="background-position:-40px -108px;"></i>
							<span>15天无理由<br>
							免邮退换货</span>
                </a>
            </strong>
        </p>
        <br>
        <br>

        <p>
            <strong>
                <a style="color:#769fbf;" href="login.html">登录</a>&nbsp;&nbsp;
                <a style="color:#769fbf;" href="regest.html">注册</a>
            </strong>
        </p>
        <br>

        <p>
            <strong>
                <a href="../wap.paixie.net/default.htm">极速版</a>&nbsp;&nbsp;
                <a href="default.htm">触屏版</a>&nbsp;&nbsp;
                <a href="help/app.html">客户端</a>
            </strong>
        </p>
        <br>
        © 2007-2013 Paixie All Rights Reserved<br>
        闽B2-20110084
        <br>
    </div>

</div>

</div>


</body>
</html>
