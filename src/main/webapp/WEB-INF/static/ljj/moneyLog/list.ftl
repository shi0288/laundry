<#assign menu="moneyLog">
<#include "/business/head.ftl">
<style type="text/css">
    .pagination {
        border-radius: 4px;
        display: inline-block;
        margin: 0;
        padding-left: 0;
    }

    .howto, .nonessential, #edit-slug-box, .form-input-tip, .subsubsub {
        color: #666666;
    }

    .subsubsub {
        float: left;
        font-size: 12px;
        list-style: none outside none;
        margin: 8px 0 5px;
        padding: 0;
    }

    .form-group{
        width:100%;
    }

    .count{
        position:absolute ;
        right:0px;
    }

    .arrticle_status{
        float:left;
    }
</style>
<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <div class="row">
            <div class="col-lg-12">
                <#--<!--breadcrumbs start &ndash;&gt;-->
                <#--<ul class="breadcrumb">-->
                    <#--<li>-->
                        <#--<a href="${BASE_PATH}/business/user/list.htm">用户列表(${allCount})</a>-->
                    <#--</li>-->
                    <#--<li>-->
                        <#--<a href="${BASE_PATH}/business/user/list.htm?status=1">冻结中(${checkCount})</a>-->
                    <#--</li>-->
                <#--</ul>-->
                <#--<!--breadcrumbs end &ndash;&gt;-->
            </div>
        </div>
        <!-- page start-->
        <section class="panel">
            <header class="panel-heading">
                <div class="row">
                    <div class="col-lg-4">

                    </div>
                    <div class="col-lg-8">
                        <#--<a class="btn btn-primary" style="float:right;" data-toggle="modal" data-target="#myModal">增加用户</a>-->
                    </div>
                </div>
            </header>
            <div class="panel-body">
                <div class="adv-table">
                    <div role="grid" class="dataTables_wrapper" id="hidden-table-info_wrapper">
                        <table class="table table-striped table-advance table-hover">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>用户名</th>
                                <th>订单</th>
                                <th>金额</th>
                                <th>投注站</th>
                                <th>投注时间</th>
                            </tr>
                            </thead>
                            <tbody role="alert" aria-live="polite" aria-relevant="all">
                            <#list pageVo.list as e>
                            <tr class="gradeA odd">
                                <td>
                                    ${e.id}
                                </td>
                                <td>
                                    ${e.userId}
                                </td>
                                <td>
                                    ${e.businessId}
                                </td>
                                <td>
                                    ${e.amount}
                                </td>
                                <td>
                                    ${e.type}
                                </td>
                                <td>
                                    ${e.createTime?string("yyyy-MM-dd hh:mm:ss")}
                                </td>
                            </tr>
                            </#list>
                            </tbody>
                        </table>
                        <div style="height: 30px;">
                            <div class="pagination">${pageVo.pageNumHtml} </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- page end-->
    </section>
</section>
<!--main content end-->
<#include "/business/foot.ftl">