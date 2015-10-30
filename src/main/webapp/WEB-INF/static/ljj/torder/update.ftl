<#assign menu="torder">
<#include "/ljj/head.ftl">
<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <!-- page start-->
        <form id="update_user_form" class="form-horizontal" action="../../ljj/torder/update.json"
              autocomplete="off" method="post">
            <fieldset>
                <div class="row">
                    <input type="hidden" id="orderId" value="${e._id}">
                    <input type="hidden" id="orderStr" value='${e.orderStr}'>
                    <div class="col-lg-12">
                        <section class="panel">
                            <header class="panel-heading">
                                订单详情
                            </header>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">售卖点：</label>
                                    <div class="col-sm-10">
                                        <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                               name="schoolName" id="schoolName" value="${(e.schoolName)!'无'}"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">收货人姓名：</label>
                                    <div class="col-sm-10">
                                        <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                               name="name" id="conName" value="${e.conName}"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">收货人电话：</label>
                                    <div class="col-sm-10">
                                        <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                               name="name" id="conMobile" value="${e.conMobile}"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">收货人地址：</label>
                                    <div class="col-sm-10">
                                        <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                               name="name" id="conAddress" value="${e.conAddress}"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">合计：</label>
                                    <div class="col-sm-10">
                                        <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                               name="name" id="orderPrice" value="${e.orderPrice}"/>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>
                </div>
            </fieldset>
        </form>
        <!-- page end-->
        <section class="panel">
            <header class="panel-heading">
                <div class="row">
                    <div class="col-lg-4">
                    </div>
                   <!-- <div class="col-lg-8">
                        <a class="btn btn-primary" id="order-print" style="float:right;" data-toggle="modal" data-target="#myModal" onclick="orderPrint()">打印</a>
                    </div>-->
                </div>
            </header>
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
                                <th>名称</th>
                                <th>单价</th>
                                <th>数量</th>
                            </tr>
                            </thead>
                            <tbody role="alert" aria-live="polite" aria-relevant="all">
                            <#list order as e>
                            <tr class="gradeA odd">
                                <td>
                                ${e.name}
                                </td>
                                <td>
                                ${e.price}
                                </td>
                                <td>
                                ${e.numbers}
                                </td>
                            </tr>
                            </#list>
                            </tbody>
                        </table>
                        <div style="height: 30px;">
                        </div>
                    </div>
                </div>
            </div>


            <div class="panel-body">
                <div class="adv-table">
                    <div role="grid" class="dataTables_wrapper" id="hidden-table-info_wrapper">
                        <table class="table table-striped table-advance table-hover">
                            <thead>
                            <tr>
                                <th>活动ID</th>
                                <th>赠品名称</th>
                                <th>活动描述</th>
                                <th>数量</th>
                            </tr>
                            </thead>
                            <tbody role="alert" aria-live="polite" aria-relevant="all">
                            <#list activity as e>
                            <tr class="gradeA odd">
                                <td>
                                ${e.activeId}
                                </td>
                                <td>
                                ${e.productName}
                                </td>
                                <td>
                                ${e.activeName}
                                </td>
                                <td>
                                ${e.productNum}
                                </td>
                            </tr>
                            </#list>
                            </tbody>
                        </table>
                        <div style="height: 30px;">
                        </div>
                    </div>
                </div>
            </div>


        </section>
    </section>
</section>
<!--main content end-->
<script type="text/javascript">
    $(function () {
        $('#back').click(function(){
            location.href = "../../ljj/torder/list.htm";
        })
    });
    function orderPrint(){
        var id = $("#orderId").val();
        var name = $("#conName").val();
        var phone = $("#conMobile").val();
        var address = $("#conAddress").val();
        var amount = $("#orderPrice").val();
        var order = $("#orderStr").val();
        order = order.split(';');
        console.log('e:');
        var order = {
            orderId:id,
            conName:name,
            conMobile:phone,
            conAddress:address,
            orderPrice:amount,
            orderStr:order
        };
        printProduct(order);
    }
</script>
<#include "/ljj/foot.ftl">
