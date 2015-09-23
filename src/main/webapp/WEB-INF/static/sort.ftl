<#include "title.ftl">

    <div data-role="content">

        <!-- **********************   导航  ********************** -->
        <div class="container-fluid" style="margin-top: 10px">
            <div class="well pxui-tab pxui-tab-nav pxui-tab-no-top">
                <a href="main.html"><i></i>首页<span></span></a>
                <a class="selected"><i></i>分类<span></span></a>
                <a href="tuan.html?status=0&sortStr=jump&orderBy=-1"><i></i>抢限量<span></span></a>
                <a href="#"><i></i>加入我们<span></span></a>
            </div>
        </div>

        <div class="container-fluid">
            <div class="well sortList" style="padding: 0">
                <div class="pxui-list">
                    <#list mainPro as e>
                        <a href="product.html?status=0&mainProId=${e._id}&sortStr=jump&orderBy=-1">
                            <span></span>
                            <b>${e.name}</b>
                            <i class="arrow-right"></i>
                        </a>
                        <p>
                        <#list e.sortList as s>
                            <a href="product.html?status=0&sortProId=${s._id}&sortStr=jump&orderBy=-1">${s.name}</a>&nbsp;
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