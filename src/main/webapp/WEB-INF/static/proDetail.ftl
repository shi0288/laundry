<#include "title.ftl">


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
                            <div class="touchslider-item"><a href="#"><span class="img320"><img
                                    src="../../upload/img/${fileName}"
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
                <#--<div class="pxui-list" data-model="radio">-->
                    <#--<a>【踏青一站购】361°满99减10、199减20、299减30<i class="arrow-right"></i></a>-->

                    <#--<div class="pxui-list-con" style="display:none;">-->
                        <#--<!--  <strong>【踏青一站购】361°满99减10、199减20、299减30</strong><br/>&ndash;&gt;-->
                        <#--2014-04-08 09:40 到 2014-04-20 23:59<br>-->
                        <#--<strong>·</strong> 满<b>99元</b>,减<b>10元</b><br><strong>·</strong>-->
                        <#--满<b>199元</b>,减<b>20元</b><br><strong>·</strong> 满<b>299元</b>,减<b>30元</b><br>-->
                        <#--<!--  &ndash;&gt;-->
                    <#--</div>-->
                    <#--<div style="clear:both;height:4px;margin: 0;padding: 0px; width:100%;"></div>-->
                <#--</div>-->
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
                                <span>15.8免运费,支持货到付款。</span>
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
                    <a href="#" onclick="goToCart()">立即结算</a><a id="toCard"  href="#" style="color:red" onClick="MoveBox(this)">购物车</a>
                </div>
                <h3 class="js-attrs-title">商品属性</h3>
                <ul class="attrs">
                <#list e.desc?split(";") as s>
                    <li>${s?replace(":","：")} </li>
                </#list>
                </ul>
                <h3 class="js-attrs-title">服务承诺</h3>
                <ul class="services">
                    <li><i></i> 正品保证 假一赔十</li>
                    <li><i></i> 3天无理由免邮退换货</li>
                    <li><i></i> 10天保值 差价返还</li>
                    <li><i></i> 自营商品 免费配送</li>
                    <li><i></i> 货到付款 全校范围</li>
                </ul>
            </div>


        </div>
        <input type="hidden" id="proId" value="${e._id}" />
        <input type="hidden" id="name" value="${e.name}" />
        <input type="hidden" id="price" value="${e.price}" />
        <input type="hidden" id="oldPrice" value="${e.oldPrice}" />
        <input type="hidden" id="fileName" value="${e.fileNames[0]}" />

        <div class="pro" id="pro"><img width="25px" height="25px" src="./static/common/css/images/cart.gif"></div>

    </div>
    <!-- /content -->
</div>

</body>
</html>