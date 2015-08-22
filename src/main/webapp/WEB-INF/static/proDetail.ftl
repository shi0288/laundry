<#include "header.ftl">
<body>
<div data-role="page">
    <div data-role="content">
        <div class="card" id="card"><img width="60px" height="60px" src="${INTER_PATH}/static/common/css/images/cart.gif"></div>
        <div class="pro" id="pro"><img width="25px" height="25px" src="${INTER_PATH}/static/common/css/images/cart.gif"></div>
        <!-- **********************   页头  ********************** -->
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
                <a href="cart/default.htm" class="com-header-cart"><b id="header-cart-num">0</b>
                    <del></del>
                </a>
            </p>
            <div class="clear"></div>
        </div>

        <!-- **********************   导航  ********************** -->
        <div class="page-role container-fluid good-page" style="margin-top:15px">
            <div class="page-title">
                <a class="return" href="javascript:history.back();void(0)">返 回</a>
                商品详情
            </div>
            <div class="well" style="padding: 10px;">
                <h1>
                ${e.name}
                </h1>
                <div class="touchsliderPro">
                    <div class="touchslider-viewport" style="width:100%;overflow:hidden">
                        <div>
                        <#list e.fileNames as fileName>
                            <div class="touchslider-item"><a href="topic/739.html"><span class="img320"><img
                                    src="${UPLOAD_BASE_PATH}/img/${fileName}"
                                    style="vertical-align:top;width:100%"  onerror="nofind();"/></span></a></div>
                        </#list>
                        </div>
                    </div>
                    <div class="touchslider-navtag">
                    <#list e.fileNames as fileName>
                        <#if fileName_index==0>
                            <span class="touchslider-nav-item touchslider-nav-item-current"></span>
                        <#else>
                            <span class="touchslider-nav-item "></span>
                        </#if>
                    </#list>
                    </div>
                </div>
                <div class="pxui-list" data-model="radio">
                    <a>【踏青一站购】361°满99减10、199减20、299减30<i class="arrow-right"></i></a>

                    <div class="pxui-list-con" style="display:none;">
                        <!--  <strong>【踏青一站购】361°满99减10、199减20、299减30</strong><br/>-->
                        2014-04-08 09:40 到 2014-04-20 23:59<br>
                        <strong>·</strong> 满<b>99元</b>,减<b>10元</b><br><strong>·</strong>
                        满<b>199元</b>,减<b>20元</b><br><strong>·</strong> 满<b>299元</b>,减<b>30元</b><br>
                        <!--  -->
                    </div>
                    <div style="clear:both;height:4px;margin: 0;padding: 0px; width:100%;"></div>
                </div>
                <a class="pxui-gray-button" href="product/imgshowid459537.html">点击查看图文详情&nbsp;&nbsp;<i
                        class="arrow-right"></i></a>

                <ul class="goodinfo" id="js-goodinfo">
                    <li>
                        <b name="detail_mao" id="detail_mao">价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格:</b>

                        <div>
                            <p>
                                <strong class="pxui-color-red">￥${6?string("0.##")}</strong>
                            <#if e.oldPrice!=0>
                                <del class="pxui-color-gray">${e.oldPrice}</del>
                            </#if>

                            </p>
                        </div>
                    </li>
                    <li>
                        <b>运&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;费:</b>

                        <div>
                            <p>
                                <span>免运费 ,支持货到付款</span>
                            </p>
                        </div>
                    </li>
                    <li>
                        <b>服&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;务:</b>

                        <div>
                            <p>
                                由拍鞋网销售并提供售后服务。 </p>
                        </div>
                    </li>
                    <!--size-message-->
                    <li>
                        <b>尺&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:</b>

                        <div>
                            <p class="sizes">
                                <a stock="28" value="36_550" class="selected">
                                    36
                                </a>
                                <a stock="27" value="38_554">
                                    38
                                </a>
                            </p>
                        </div>
                    </li>

                    <li>
                        <b style="line-height:39px;">数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量:</b>
                        <div>
                            <div id="a" class="Spinner" style="margin-top:8px"></div>
                        </div>

                    </li>
                    <!--size-message-end-->
                </ul>
                <div class="com-footer-nav sale">
                    <a href="cart.html">立即结算</a><a id="toCard"  href="#" style="color:red" onClick="MoveBox(this)">购物车</a>
                </div>
                <h3 class="js-attrs-title">商品属性</h3>
                <ul class="attrs">
                    <li>货号：8216614</li>
                    <li>品牌：361度</li>
                    <li>款式：板鞋/休闲鞋</li>
                    <li>颜色：白/浅粉</li>
                    <li>上架时间：2012-04-06</li>
                    <li>上市年份：2012</li>
                    <li>鞋码偏差：正常</li>
                    <li>鞋底材质：RB/MD</li>
                    <li>鞋面材质：合成革</li>
                    <li>闭合方式：系带</li>
                    <li>适合季节：春季</li>
                    <li>性别：女</li>
                    <li>鞋面材料：PU/人造革</li>
                    <li>外底材料：橡胶底</li>
                </ul>
                <h3 class="js-attrs-title">服务承诺<a href="#">返回顶部<i class="arrow2-top"></i></a></h3>
                <ul class="services">
                    <li><i></i> 正品保证 假一赔十</li>
                    <li><i></i> 15天无理由免邮退换货</li>
                    <li><i></i> 10天保值 差价返还</li>
                    <li><i></i> 自营商品满 99 包邮</li>
                    <li><i></i> 货到付款 全国范围</li>
                </ul>
                <h3 class="js-attrs-title">用户评论<a href="#">返回顶部<i class="arrow2-top"></i></a></h3>

                <div id="js-comment-list">
                    <div class="comment-info">
                        <div><p>综合满意指数：<br>&nbsp;&nbsp;&nbsp;&nbsp;<b class="pxui-color-red">4.6</b> 分</p>
                            <span>评论人数：<br>&nbsp;&nbsp;&nbsp;&nbsp;206人</span></div>
                        &nbsp;大家认为：
                        <ul>
                            <li>
                                <b>尺&nbsp;&nbsp;&nbsp;&nbsp;码</b>

                                <p>合适：<i>
                                    <del style="width:100%"></del>
                                </i><span>100%</span></p>
                                <p>偏大：<i>
                                    <del style="width:76%"></del>
                                </i><span>76%</span></p>
                                <p>偏小：<i>
                                    <del style="width:0%;"></del>
                                </i><span>0%</span></p>
                            </li>
                        </ul>
                    </div>
                    <ul class="comment-list" id="js-commentlist"></ul>
                    <div class="pxui-show-more" lastid="1" template="#js-good-comment" srcproperty="commentsrc"
                         container="#js-commentlist" url="/comment/ajax?good_id=445111&amp;item_id=459537">
                        <a>查看更多 <i class="arrow2-bottom"></i></a>
                    </div>
                </div>
            </div>


        </div>


    </div>
    <!-- /content -->
</div>

</body>
</html>