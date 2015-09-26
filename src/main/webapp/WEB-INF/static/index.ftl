<#include "header.ftl">
<#include "title.ftl">

<div data-role="content"  >
    <!-- **********************   首页轮播  ********************** -->
    <div class="touchslider">
        <div class="touchslider-viewport" style="width:100%;overflow:hidden">
            <div>
            <#list pictures as p>
                <div class="touchslider-item"><a href="${p.urlName!"#"}"><img
                        src="../../upload/img/${p.fileName}"
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
            <a href="tuan.html?status=0&sortStr=jump&orderBy=-1"><i></i>抢限量<span></span></a>
            <a href="join.html"><i></i>加入我们<span></span></a>
        </div>
    </div>

    <!-- **********************   板块 ********************** -->
    <div class="container-fluid" style="margin-bottom: 10px;">
        <div class="tags">
            <table border="0" cellspacing="5" cellpadding="0">
                <tbody>
                <tr>
                    <td colspan="2"><a href="tao.html?status=0&sortStr=jump&orderBy=-1"><i></i>套餐专区<br>实惠方便价更优</a></td>
                    <td><a href="action.html"><i></i>更多好玩</a></td>
                    <td rowspan="2"><a href="tuan.html?status=0&sortStr=jump&orderBy=-1"><i></i>限<br>时<br>促<br>销</a></td>
                </tr>
                <tr>
                    <td><a href="topic/612.html"><b>最新</b><br>上架</a></td>
                    <td colspan="2"><a href="zhuanpan.html">幸运大抽奖<br>下单抽礼品<i></i></a></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>


    <!-- **********************   推荐 ********************** -->


    <div class="container-fluid index">
        <div class="pxui-area">
            <h3><b>Top5</b> 热销推荐<a class="pxui-button" href="product.html?status=0&sortStr=jump&orderBy=-1"><span>+</span> 全部商品 &gt;&gt;</a>
            </h3>
            <div class="pxui-shoes">
                <div>
                <#list tuijian as tui>
                    <#if (tui_index<2)>
                        <a href="proDetail.html?proId=${tui._id}">
                            <div class="img160" style="background-image: none;"><dfn></dfn>
                                <#list tui.fileNames as f>
                                    <#if f_index==0>
                                        <img src="../../upload/img/${f}">
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
                    <a href="proDetail.html?proId=${tui._id}"><span
                            class="pxui-bg-blue pxui-color-white">${tui_index+1}</span>

                        <p>${tui.name}</p><b>￥${tui.price}</b></a>
                </#if>
            </#list>
            </div>
        </div>
    </div>




    <!-- **********************   栏目 ********************** -->

<#list mainPro as e>
    <#if e_index%2==0>
        <div class="container-fluid">
            <div class="pxui-area styles">
                <h2 style="background-color: ${(e.colorTip)!""} ; "><a
                        href="product.html?status=0&mainProId=${e._id}&sortStr=jump&orderBy=-1"
                        style="color:#FFFFFF;">${(e.name)!""}</a>
                </h2>
                <a class="max" href="product.html?status=0&mainProId=${e._id}&sortStr=jump&orderBy=-1"><img
                        src="../../upload/img/${e.fileName}" width="120" height="140"></a>

                <div>
                    <p>
                        <#list e.sortList as s>
                            <#if s.tip==0>
                                <a href="product.html?status=0&sortProId=${s._id}&sortStr=jump&orderBy=-1"
                                   style="background-color: ${(e.colorTip)!""} ; color:#FFFFFF;border: 1px solid ${(e.colorTip)!""}; ">${s.name}</a>
                            <#else>
                                <a href="product.html?status=0&sortProId=${s._id}&sortStr=jump&orderBy=-1">${s.name}</a>
                            </#if>
                        </#list>
                        <a href="product.html?status=0&mainProId=${e._id}&sortStr=jump&orderBy=-1" class="more">更多
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
                                <a href="product.html?status=0&sortProId=${s._id}&sortStr=jump&orderBy=-1"
                                   style="margin-left:3px;margin-right:0px;background-color: ${(e.colorTip)!""}; color:#FFFFFF;border: 1px solid ${(e.colorTip)!""}; ">${s.name}</a>
                            <#else>
                                <a href="product.html?status=0&sortProId=${s._id}&sortStr=jump&orderBy=-1">${s.name}</a>
                            </#if>
                        </#list>
                        <a href="product.html?status=0&mainProId=${e._id}&sortStr=jump&orderBy=-1" class="more">更多
                            <del><i class="arrow-right"></i></del>
                        </a>
                    </p>
                </div>
                <a class="max" href="product.html?status=0&mainProId=${e._id}&sortStr=jump&orderBy=-1"><img
                        src="../../upload/img/${e.fileName}" width="120"
                        height="140"></a>

                <h2 style="background-color: ${(e.colorTip)!""}"><a
                        href="product.html?status=0&mainProId=${e._id}&sortStr=jump&orderBy=-1"
                        style="color:#FFFFFF;">${(e.name)!""}</a>
                </h2>
            </div>
        </div>

    </#if>

</#list>




    <!-- **********************   底部导航 ********************** -->

    <div class="com-footer-nav">
        <a href="main.html">首页</a><a href="#">帮助中心</a><a href="#">反馈建议</a>
    </div>

    <!-- **********************   页尾  ********************** -->
    <div class="com-footer">
        <p class="com-policy">
            <strong>
                <a class="pxui-color-white" href="javascript:void(0)">
                    <i></i>
							<span>自营商品<br>
							满15.8包邮</span>
                </a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a class="pxui-color-white" href="javascript:void(0)">
                    <i style="background-position:-40px -108px;"></i>
							<span>3天无理由<br>
							免邮退换货</span>
                </a>
            </strong>
        </p>
        <br>
        <br>
        <#--<p>-->
            <#--<strong>-->
                <#--<a style="color:#769fbf;" href="#">登录</a>&nbsp;&nbsp;-->
                <#--<a style="color:#769fbf;" href="#">注册</a>-->
            <#--</strong>-->
        <#--</p>-->
        <br>

        <p>
            <strong>
                <a href="#">极速版</a>&nbsp;&nbsp;
                <a href="#">触屏版</a>&nbsp;&nbsp;
                <a href="#">客户端</a>
            </strong>
        </p>
        <br>
        © 2015-2020 YunCai All Rights Reserved<br>
        <br>
    </div>

</div>

</div>


</body>
</html>
