<#include "header.ftl">


<body>

<div data-role="page" id="pageone">

    <div data-role="content">

        <!-- **********************   页头  ********************** -->
        <div class="com-header-area">
            <a href="default.htm" class="com-header-logo"></a>
            <dfn></dfn>
            <p>
                <a class="com-header-search" id="js-com-header-search"><del></del></a>
                <a href="login/default.htm" class="com-header-user "><del></del></a>
                <i></i>
                <a href="cart/default.htm" class="com-header-cart "><b id="header-cart-num">0</b><del></del></a>
            </p>
            <div class="clear"></div>
        </div>

        <!-- **********************   首页轮播  ********************** -->
        <script>
            jQuery(function ($) {
                $(window).resize(function () {
                    var width = document.body.clientWidth;
                    $('.touchslider-item a').css('width', width);
                    $('.touchslider-viewport').css('height', 300 * (width / 640));
                }).resize();
                $(".touchslider").touchSlider({mouseTouch: true, autoplay: true});
            });
        </script>

        <div class="touchslider">
            <div class="touchslider-viewport" style="width:100%;overflow:hidden">
                <div>
                    <div class="touchslider-item"><a href="topic/739.html"><img
                            src="http://img-cdn2.paixie.net/newspic/20140408/1396940354243f5b.jpg"
                            style="vertical-align:top;"/></a></div>
                    <div class="touchslider-item"><a href="topic/730.html"><img
                            src="http://img-cdn2.paixie.net/newspic/20140328/1395970986accb4f.jpg"
                            style="vertical-align:top;"/></a></div>
                    <div class="touchslider-item"><a href="topic/725.html"><img
                            src="http://img-cdn2.paixie.net/newspic/20140331/1396235117d367d2.jpg"
                            style="vertical-align:top;"/></a></div>
                    <div class="touchslider-item"><a href="topic/733.html"><img
                            src="http://img-cdn2.paixie.net/newspic/20140401/13963430797a3567.jpg"
                            style="vertical-align:top;"/></a></div>
                    <div class="touchslider-item"><a href="topic/731.html"><img
                            src="http://img-cdn2.paixie.net/newspic/20140404/139657373135668e.jpg"
                            style="vertical-align:top;"/></a></div>
                    <div class="touchslider-item"><a href="topic/732.html"><img
                            src="http://img-cdn2.paixie.net/newspic/20140331/13962355233033ac.jpg"
                            style="vertical-align:top;"/></a></div>
                </div>
            </div>

            <div class="touchslider-navtag">
                <span class="touchslider-nav-item touchslider-nav-item-current"></span>
                <span class="touchslider-nav-item "></span>
                <span class="touchslider-nav-item "></span>
                <span class="touchslider-nav-item "></span>
                <span class="touchslider-nav-item "></span>
                <span class="touchslider-nav-item "></span>
            </div>
        </div>


        <!-- **********************   导航  ********************** -->

        <div class="container-fluid">
            <div class="well pxui-tab pxui-tab-nav pxui-tab-no-top">
                <a class="selected"><i></i>首页<span></span></a>
                <a href="sort.html"  data-transition="slide" ><i></i>分类<span></span></a>
                <a href="brand/default.htm"><i></i>品牌<span></span></a>
                <a href="tuan/default.htm"><i></i>团购<span></span></a>

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
        <div class="container-fluid">
            <div class="pxui-area styles">
                <h2 style="background-color: #ffaf51 ; "><a href="p-_m0001s0001_.html" style="color:#FFFFFF;">衣物清洁</a>
                </h2>
                <a class="max" href="p-anta__1.html@page=5"><img
                        src="http://img-cdn2.paixie.net/newspic/20140408/1396917342e17426.jpg" width="120" height="140"></a>

                <div>
                    <p>
                        <a href="nike/default.htm"
                           style="background-color: #ffaf51; color:#FFFFFF;border: 1px solid #ffaf51; ">蓝月亮</a>
                        <a href="adidas/default.htm">奥妙</a>
                        <a href="anta/default.htm">巴菲</a>
                        <a href="erke/default.htm"
                           style="margin-right:3px;background-color: #ffaf51; color:#FFFFFF;border: 1px solid #ffaf51; ">雕牌</a>
                        <a href="p-m0001s0029_1.html" ">威露士</a>
                        <a href="forbid/p-__25E7_25AF_25AE_25E7_2590_2583_25E9_259E_258B__1.html"
                           style="background-color: #ffaf51; color:#FFFFFF;border: 1px solid #ffaf51; ">郁美净</a>
                        <a href="p-_m0001s0064_.html" ">丽婴房</a>
                        <a href="p-_m0001s0001_.html" class="more">更多
                            <del><i class="arrow-right"></i></del>
                        </a>
                    </p>
                </div>
            </div>
        </div>

        <div class="container-fluid">
            <div class="pxui-area styles">
                <div>
                    <p>
                        <a href="moolecole/default.htm" style="margin-left:3px;margin-right:0px; ">蒂花之秀</a>
                        <a href="mingdian/default.htm"
                           style="margin-left:3px;margin-right:0px;background-color: #ff8080; color:#FFFFFF;border: 1px solid #ff8080; ">力士</a>
                        <a href="p-daphne__1.html@special=1&amp;asc=id"
                           style="margin-left:3px;margin-right:0px;background-color: #ff8080; color:#FFFFFF;border: 1px solid #ff8080; ">夏士莲</a>
                        <a href="forbid/p-__25E5_258D_2595_25E9_259E_258B__1.html"
                           style="margin-left:3px;margin-right:0px; ">飘柔</a>
                        <a href="forbid/p-__25E9_25AB_2598_25E8_25B7_259F_25E9_259E_258B__1.html"
                           style="margin-left:3px;margin-right:0px; ">霸王</a>
                        <a href="p-m0003s0080_1.html" style="margin-left:3px;margin-right:0px; ">中华</a>
                        <a href="p-_m0003s0003_.html" class="more">更多
                            <del><i class="arrow-right"></i></del>
                        </a>
                    </p>
                </div>
                <a class="max" href="moolecole/@page=5"><img
                        src="http://img-cdn2.paixie.net/newspic/20140408/13969173357d0aa6.jpg" width="120" height="140"></a>

                <h2 style="background-color: #ff8080"><a href="p-_m0003s0003_.html" style="color:#FFFFFF;">日化洁净</a></h2>
            </div>
        </div>

        <div class="container-fluid">
            <div class="pxui-area styles">
                <h2 style="background-color: #688fd0 ; "><a href="p-_m0002s0002_.html" style="color:#FFFFFF;">家庭清洁</a>
                </h2>
                <a class="max" href="playboy/default.htm"><img
                        src="http://img-cdn2.paixie.net/newspic/20140408/13969173291cedd8.jpg" width="120" height="140"></a>

                <div>
                    <p>
                        <a href="longpai/default.htm" style="margin-right:3px; ">龙派</a>
                        <a href="playboy/default.htm"
                           style="margin-right:3px;background-color: #688fd0; color:#FFFFFF;border: 1px solid #688fd0; ">青蛙王子</a>
                        <a href="fgn/default.htm"
                           style="margin-right:3px;background-color: #688fd0; color:#FFFFFF;border: 1px solid #688fd0; ">强生</a>
                        <a href="yearcon/default.htm" style="margin-right:3px; ">依必朗</a>
                        <a href="p-m0002s0119_id;1.html" style="margin-right:3px; ">宝宁</a>
                        <a href="p-m0002s0159_1.html" style="margin-right:3px; ">天莉</a>
                        <a href="forbid/p-__m000206068_1.html"
                           style="margin-right:3px;background-color: #688fd0; color:#FFFFFF;border: 1px solid #688fd0; ">清仓</a>
                        <a href="p-_m0002s0002_.html" class="more">更多
                            <del><i class="arrow-right"></i></del>
                        </a>
                    </p>
                </div>
            </div>
        </div>
        <div class="container-fluid">
            <div class="pxui-area styles">
                <div>
                    <p>
                        <a href="forbid/p-__25E6_25B5_25B7_25E6_25B3_25B0_25E5_25AE_25A2__1.html"
                           style="margin-left:3px;margin-right:0px; ">清风</a>
                        <a href="forbid/p-__25E5_25A7_258B_25E7_25A5_2596_25E9_25B8_259F__1.html"
                           style="margin-left:3px;margin-right:0px;background-color: #c49741; color:#FFFFFF;border: 1px solid #c49741; ">维达</a>
                        <a href="baopiao/default.htm"
                           style="margin-left:3px;margin-right:0px;background-color: #c49741; color:#FFFFFF;border: 1px solid #c49741; ">宝飘</a>
                        <a href="addnice/default.htm" style="margin-left:3px;margin-right:0px; ">乐宁</a>
                        <a href="p-m0290s0319_1.html"
                           style="margin-left:3px;margin-right:0px;background-color: #c49741; color:#FFFFFF;border: 1px solid #c49741; ">三仕达</a>
                        <a href="forbid/p-__25E8_2583_258C_25E5_258C_2585__1.html"
                           style="margin-left:3px;margin-right:0px; ">洁昕</a>
                        <a href="p-m0006s0046_1.html" style="margin-left:3px;margin-right:0px; ">Tempo</a>
                        <a href="p-_m0006s0006_.html" class="more">更多
                            <del><i class="arrow-right"></i></del>
                        </a>
                    </p>
                </div>
                <a class="max" href="baopiao/default.htm"><img
                        src="http://img-cdn2.paixie.net/newspic/20140408/1396917323bc9d22.jpg" width="120" height="140"></a>

                <h2 style="background-color: #c49741"><a href="p-_m0006s0006_.html" style="color:#FFFFFF;">纸制品</a></h2>
            </div>
        </div>
        <div class="container-fluid">
            <div class="pxui-area styles">
                <h2 style="background-color: #875e78 ; "><a href="p-m0178_1.html" style="color:#FFFFFF;">一次性</a></h2>
                <a class="max" href="guuka/@page=3"><img
                        src="http://img-cdn2.paixie.net/newspic/20140408/139691731865fe66.jpg" width="120" height="140"></a>

                <div>
                    <p>
                        <a href="genanx/default.htm"
                           style="margin-right:3px;background-color: #875e78; color:#FFFFFF;border: 1px solid #875e78; ">垃圾袋</a>
                        <a href="qianzhihe/default.htm" style="margin-right:3px; ">保鲜膜</a>
                        <a href="cadeau/default.htm" style="margin-right:3px; ">保鲜袋</a>
                        <a href="bindwood/default.htm"
                           style="margin-right:3px;background-color: #875e78; color:#FFFFFF;border: 1px solid #875e78; ">纸杯</a>
                        <a href="p-m0265s0267_1.html" style="margin-right:3px; ">一次性餐具</a>
                        <a href="forbid/p-__25E5_25A5_25B3_25E8_25A3_2585__1.html@asc=id"
                           style="margin-right:3px; ">牙签</a>
                        <a href="p-m0178_,s;1.html" style="margin-right:3px; ">杯托</a>
                        <a href="p-m0178_1.html" class="more">更多
                            <del><i class="arrow-right"></i></del>
                        </a>
                    </p>
                </div>
            </div>
        </div>
        <div class="container-fluid">
            <div class="pxui-area styles">
                <div>
                    <p>
                        <a href="harrypotter/default.htm" style="margin-left:3px;margin-right:0px; ">棉拖鞋</a>
                        <a href="kading/default.htm"
                           style="margin-left:3px;margin-right:0px;background-color: #94d15e; color:#FFFFFF;border: 1px solid #94d15e; ">毛巾</a>
                        <a href="snoopy/default.htm" style="margin-left:3px;margin-right:0px; ">浴巾</a>
                        <a href="bluepeelrise/default.htm"
                           style="margin-left:3px;margin-right:0px;background-color: #94d15e; color:#FFFFFF;border: 1px solid #94d15e; ">抱枕靠枕</a>
                        <a href="forbid/p-__25E7_25AB_25A5_25E8_25A3_2585__1.html"
                           style="margin-left:3px;margin-right:0px; ">沙发垫</a>
                        <a href="forbid/p-__25E7_25AB_25A5_25E9_259E_258B__1.html"
                           style="margin-left:3px;margin-right:0px; ">十字绣</a>
                        <a href="forbid/p-__m000400656_1.html" style="margin-left:3px;margin-right:0px; ">地垫</a>
                        <a href="p-_m0004s0004_.html" class="more">更多
                            <del><i class="arrow-right"></i></del>
                        </a>
                    </p>
                </div>
                <a class="max" href="snaughty/@page=10"><img
                        src="http://img-cdn2.paixie.net/newspic/20140408/1396917310ebe74c.jpg" width="120" height="140"></a>

                <h2 style="background-color: #94d15e"><a href="p-_m0004s0004_.html" style="color:#FFFFFF;">布艺用品</a></h2>
            </div>
        </div>


        <div class="container-fluid index">
            <div class="pxui-area">
                <h3><b>Top5</b> 热销推荐<a class="pxui-button" href="topic/594.html"><span>+</span> 更多 &gt;&gt;</a></h3>

                <div class="pxui-shoes">
                    <div>
                        <a href="shoe-361sport-7212220-500798.html">

                            <div class="img160" style="background-image: none;"><dfn></dfn><img
                                    src="http://img12.paixie.net/361sport/201209/05/paixienet-461516-20120905-080851-p_thumb_160160.jpg">
                            </div>
                            <span class="name">361度 男跑步鞋 蓝/浅灰 7212220</span>
                            <span class="price">￥159.00</span>
                            <del class="price">￥339.00</del>
                            <span class="tag">1</span>
                        </a>
                        <a href="shoe-anta-91315588-1-541341.html">

                            <div class="img160" style="background-image: none;"><dfn></dfn><img
                                    src="http://img9.paixie.net/anta/201305/22/c5d2e5dd32_thumb_160160.jpg"></div>
                            <span class="name">安踏  男跑步鞋 安踏白/钢灰/钻石蓝/黑 91315588-1</span>
                            <span class="price">￥169.00</span>
                            <del class="price">￥259.00</del>
                            <span class="tag">2</span>
                        </a>

                    </div>
                </div>
                <div class="pxui-list">
                    <a href="shoe-josiny-141114130-590823.html"><span class="pxui-bg-blue pxui-color-white">3</span>

                        <p>卓诗尼 休闲色拼接粗跟圆头通勤 女单鞋 绿色 141114130</p><b>￥179.00</b></a>
                    <a href="shoe-361sport-7214418-503835.html"><span class="pxui-bg-blue pxui-color-white">4</span>

                        <p>361度 男跑步鞋 黑/浅黄 7214418</p><b>￥99.00</b></a>
                    <a href="shoe-adidas-G97666-548556.html"><span class="pxui-bg-blue pxui-color-white">5</span>

                        <p>阿迪达斯 Crazy cool m 男跑步鞋 完美蓝/夜色蓝 G97666</p><b>￥499.00</b></a>
                </div>
            </div>
        </div>


        <!-- **********************   底部导航 ********************** -->

            <div class="com-footer-nav">
                <a href="default.htm">首页</a><a href="help/index.html">帮助中心</a><a href="feedback/index.html">反馈建议</a>
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
                        <a style="color:#769fbf;" href="login/default.htm">登录</a>&nbsp;&nbsp;
                        <a style="color:#769fbf;" href="register/default.htm">注册</a>
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
