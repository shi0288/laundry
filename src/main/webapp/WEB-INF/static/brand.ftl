<#include "title.ftl">
    <div data-role="content">
        <!-- **********************   导航  ********************** -->
        <div class="container-fluid" style="margin-top: 10px">
            <div class="well pxui-tab pxui-tab-nav pxui-tab-no-top">
                <a href="main.html"><i></i>首页<span></span></a>
                <a href="sort.html"><i></i>分类<span></span></a>
                <a class="selected"><i></i>品牌<span></span></a>
                <a href="tuan.html?sortStr=jump&orderBy=-1"><i></i>团购<span></span></a>
            </div>
        </div>
        <div class="brand-tab">
            <a class="selected" style="width: 49.5%;">按首字母找品牌</a>
        </div>
        <div class="tab-box" id="js-letter" style="display: block;">
            <p>
                <#list marks as m>
                <#if m.key=='ZZ'>
                    <a href="#0-9">0-9</a>
                <#else>
                    <a href="#${m.key}">${m.key}</a>
                </#if>
                </#list>
            </p>
        <#list marks as m>
            <#if m.key=='ZZ'>
                <div id="0-9" name="0-9" class="letter-title">
                    <b>0-9</b>
                    <a href="#"   onclick="gotoTop();">返回顶部<i class="arrow2-top"></i></a>
                </div>
                <div class="brands">
                    <div class="brandbox">
                        <#list m.brandList as b>
                            <a href="product.html?brandId=${b._id}&sortStr=jump&orderBy=-1"><i><img src="../../upload/img/${b.fileName}" onerror="nofind()" alt="${b.name}" width="100" height="50"></i></a>
                        </#list>
                    </div>
                </div>
            <#else>
                <div id="${m.key}" name="${m.key}" class="letter-title">
                    <b>${m.key}</b>
                    <a href="#"  onclick="gotoTop();">返回顶部<i class="arrow2-top"></i></a>
                </div>
                <div class="brands">
                    <div class="brandbox">
                        <#list m.brandList as b>
                            <a href="product.html?brandId=${b._id}&sortStr=jump&orderBy=-1"><i><img src="../../upload/img/${b.fileName}" onerror="nofind()" alt="${b.name}" width="100" height="50"></i></a>
                        </#list>
                    </div>
                </div>
            </#if>
        </#list>
        </div>
    </div>
    <!-- /content -->
</div>

</body>
</html>