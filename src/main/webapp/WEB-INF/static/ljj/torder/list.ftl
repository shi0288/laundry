<#assign menu="torder">
<#include "/ljj/head.ftl">
<style type="text/css">
    .pagination {
        border-radius: 4px;
        display: inline-block;
        margin: 0;
        padding-left: 0;
    }

</style>
<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <div class="row">
            <div class="col-lg-12">
                <#--<!--breadcrumbs start &ndash;&gt;-->
                <ul class="breadcrumb">
                    <li>
                        <a href="${INTER_PATH}/ljj/order/list.htm">订单列表</a>
                    </li>
                    <li>
                        <a href="${INTER_PATH}/ljj/order/list.htm?status=1100">未派送(${waitCount})</a>
                    </li>
                    <li>
                        <a href="${INTER_PATH}/ljj/order/list.htm?status=1000">未付款(${payCount})</a>
                    </li>
                </ul>
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
                                <th>账户</th>
                                <th>金额</th>
                                <th>收货人</th>
                                <th>联系</th>
                                <th>地址</th>
                                <th>时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody role="alert" aria-live="polite" aria-relevant="all">
                            <#list pageVo.list as e>
                            <tr class="gradeA odd">
                                <td>
                                  ${e.name}
                                </td>
                                <td>
                                ${e.orderPrice}
                                </td>
                                <td>
                                    ${e.conName}
                                </td>
                                <td>
                                    ${e.conMobile}
                                </td>
                                <td>
                                ${e.conAddress}
                                </td>
                                <td>
                                    ${e.createTime?number?number_to_datetime}
                                </td>
                                <td>
                                    <a href="${BASE_PATH}/business/torder/update.htm?torderId=${e._id}" title="查看详情">
                                        查看详情
                                    </a>
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
<#include "/ljj/foot.ftl">