<#include "title.ftl">

<div data-role="content">

    <div class="page-role container-fluid good-page" style="margin-top:15px">
        <div class="page-title">
            <a data-rel="back" class="return">返 回</a>
            活动列表
        </div>

        <#list list as e>
            <div class="pxui-area" style="margin-bottom:10px;">
                <img src="../../upload/img/${e.fileName}"  width="100%">
                <h3 style="font-size: 18px;font-weight: bold ; color: #575757;border-bottom: 0px;" >活动介绍：</h3>
                <p style="margin: 0 12px;">${(e.des)!""}</p>
            </div>
        </#list>




    </div>
    <!-- /content -->
</div>

</body>
</html>