<body>
<div data-role="page" data-dom-cache="false" data-fullscreen="false">

    <div data-role="header" data-position="fixed" data-fullscreen="false">
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
                <a  href="cart.html" class="com-header-cart"><b name="header-cart-num" id="header-cart-num">0</b>
                    <del></del>
                </a>
            </p>
            <div class="clear"></div>
        </div>
    </div>

    <div data-role="content">
        <!-- **********************   导航  ********************** -->
        <div class="page-role container-fluid good-page" style="margin-top:15px">
            <div class="page-title">
                <a class="return"  data-rel="back" href="#"  >返 回</a>
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

                <ul class="goodinfo" id="js-goodinfo">
                    <li>
                        <b name="detail_mao" id="detail_mao">价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格:</b>

                        <div>
                            <p>
                                <strong class="pxui-color-red">￥${e.price}</strong>
                            <#if e.oldPrice?number!=0>
                                <del class="pxui-color-gray">${e.oldPrice}</del>
                            </#if>

                            </p>
                        </div>
                    </li>
                    <li>
                        <b>运&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;费:</b>
                        <div>
                            <p>
                                <span>免运费,支持货到付款。</span>
                            </p>
                        </div>
                    </li>
                    <li>
                        <b>服&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;务:</b>

                        <div>
                            <p>
                                由本网站自营销售并提供售后服务。 </p>
                        </div>
                    </li>
                    <!--size-message-->


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
                <#list e.desc?split(";") as s>
                    <li>${s?replace(":","：")} </li>
                </#list>
                </ul>
                <h3 class="js-attrs-title">服务承诺<a href="#">返回顶部<i class="arrow2-top"></i></a></h3>
                <ul class="services">
                    <li><i></i> 正品保证 假一赔十</li>
                    <li><i></i> 15天无理由免邮退换货</li>
                    <li><i></i> 10天保值 差价返还</li>
                    <li><i></i> 自营商品 免费配送</li>
                    <li><i></i> 货到付款 全校范围</li>
                </ul>
                <h3 class="js-attrs-title">用户评论<a href="#">返回顶部<i class="arrow2-top"></i></a></h3>

                <div id="js-comment-list">
                    <div class="comment-info">
                        <div><p>综合满意指数：<br>&nbsp;&nbsp;&nbsp;&nbsp;<b class="pxui-color-red">4.6</b> 分</p>
                            <span>评论人数：<br>&nbsp;&nbsp;&nbsp;&nbsp;206人</span></div>
                        &nbsp;大家认为：
                        <ul>
                            <li>
                                <b>评&nbsp;&nbsp;&nbsp;&nbsp;分</b>
                                <p>速度：<i>
                                    <del style="width:100%"></del>
                                </i><span>100%</span></p>
                                <p>质量：<i>
                                    <del style="width:76%"></del>
                                </i><span>76%</span></p>
                                <p>欢迎：<i>
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
        <input type="hidden" id="proId" value="${e._id}" />
        <input type="hidden" id="name" value="${e.name}" />
        <input type="hidden" id="price" value="${e.price}" />
        <input type="hidden" id="oldPrice" value="${e.oldPrice}" />
        <input type="hidden" id="fileName" value="${e.fileNames[0]}" />

        <div class="pro" id="pro"><img width="25px" height="25px" src="${INTER_PATH}/static/common/css/images/cart.gif"></div>

    </div>
    <!-- /content -->
</div>

</body>
</html>