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
                        <a href="../../ljj/order/list.htm">订单列表</a>
                    </li>
                    <li>
                        <a href="../../ljj/order/list.htm?status=1100">派送中(${waitCount})</a>
                    </li>
                    <li>
                        <a href="../../ljj/order/list.htm?status=1101">已打印(${printCount})</a>
                    </li>
                    <li>
                        <a href="../../ljj/order/list.htm?status=1000">未付款(${payCount})</a>
                    </li>
                    <li>
                        <a href="../../ljj/order/list.htm?status=1200">派送成功(${sendCount})</a>
                    </li>
                </ul>
                <#--<!--breadcrumbs end &ndash;&gt;-->
            </div>
        </div>
        <section class="panel">
            <div class="panel-body">
                <form action="../../ljj/order/list.htm" method="get" id="query_form">
                    <table class="query_table">
                        <input type="hidden" name="p" id="p" value="${(p)!""}"/>
                        <input type="hidden" name="toWhat" id="toWhat" value="${(cond.toWhat)!""}"/>
                        <tr>
                            <td>用户名</td>
                            <td><input type="text" name="name" class="form-control" value="${(cond.name)!""}"/>
                            </td>
                            <td>收货人姓名</td>
                            <td><input type="text" name="conName" class="form-control" value="${(cond.conName)!""}"/>
                            </td>
                            <td>联系电话</td>
                            <td><input type="text" name="conMobile" class="form-control" value="${(cond.conMobile)!""}"/>
                            </td>
                            <td>支付方式</td>
                            <td>
                                <select name="payType" class="form-control">
                                    <option value="">所有</option>
                                    <option <#if (cond.payType)??> <#if  cond.payType==0>selected</#if> </#if> value="0">货到付款</option>
                                    <option <#if (cond.payType)??> <#if  cond.payType==1>selected</#if> </#if>  value="1">微信支付</option>
                                </select>
                            </td>
                            <td>订单状态</td>
                            <td>
                                <select name="status" class="form-control">
                                    <option value="">所有</option>
                                    <option <#if (cond.status)??> <#if  cond.status==1100>selected</#if> </#if> value="1100">派送中</option>
                                    <option <#if (cond.status)??> <#if  cond.status==1101>selected</#if> </#if>  value="1101">已经打印</option>
                                    <option <#if (cond.status)??> <#if  cond.status==1200>selected</#if> </#if>  value="1200">确认收货</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                        </tr>
                        <tr>
                            <td>
                                <a class="btn btn-primary" id="query_button">查询</a>
                            </td>
                        </tr>
                    </table>
                </form>
        </section>
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
                                <th>付款方式</th>
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
                                <#if  '${e.payType}'=="0">货到付款<#elseif  '${e.payType}'=="1">微信支付</#if>
                                </td>
                                <td>
                                    <a href="../../ljj/order/update.htm?torderId=${e._id}" title="查看详情">
                                        查看详情
                                    </a>
                                    <#if  '${e.status}'=='1100'><a href="javascript:void(0)" onclick="printOrder('${e._id}',1101)" title="打印">打印</a>
                                    <#elseif  '${e.status}'=='1101'> <a href="javascript:void(0)" onclick="printOrder('${e._id}',1200)" title="派送成功">派送成功</a>
                                    </#if>


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
<script type="text/javascript">
    $(function () {
        $('#update_user_form').ajaxForm({
            beforeSubmit: function(){
                $('#submit').button('loading');
            },
            success: function (data) {
                $('#submit').button('reset');
                if (data.result) {
                    bootbox.alert("修改成功，将刷新页面", function () {
                        location.href = "../../ljj/sortPro/list.htm";
                    });
                } else {
                    bootbox.alert(data.msg, function () {
                    });
                }
            }
        });
        $('#back').click(function(){
            location.href = "../../ljj/torder/list.htm";
        })
        $('#query_button').click(function () {
            $('#p').val(1);
            $('#query_form').submit();
        });
    });
    function printOrder(id,orderType){
        $.ajax({
            type: "POST",
            url: "../../ljj/order/getDetail.json?timestamp=" + new Date().getTime(),
            dataType: "json",
            cache: false,
            data: {
                torderId: id,
                status:orderType
            },
            success: function (result) {
                var res = result.result;
                if (res) {
                    if(orderType==1101){
                        printProduct(result.object);
                    }else if(orderType==1200){
                        bootbox.alert("修改成功，将刷新页面", function () {
                            location.href = "list.htm?status=1101";
                        });
                    }
                } else {
                    alert('查询请求出错');
                }
            },
            error: function () {
                alert('请求出错');
            }
        });
    }
</script>
<#include "/ljj/foot.ftl">