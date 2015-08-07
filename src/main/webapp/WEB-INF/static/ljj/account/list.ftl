<#assign menu="account">
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
                        <a class="btn btn-primary" style="float:right;" data-toggle="modal" data-target="#myModal">充值</a>
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

<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    充值
                </h4>
            </div>
            <div class="modal-body">
                <!-- page start-->
                <form id="add_user_form" class="form-horizontal" action="${BASE_PATH}/business/account/update.json"  autocomplete="off"  method="post"
                      enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-lg-12">
                            <section class="panel">
                                <div class="panel-body">
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">手机号</label>
                                        <div class="col-sm-10">
                                            <input type="text" style="font-size:15px;width: 300px;" class="form-control" name="userName"
                                                   placeholder="输入手机号" id="userName" >
                                            </input>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">充值金额</label>
                                        <div class="col-sm-10">
                                            <input type="text" style="font-size:15px;width: 300px;" class="form-control" name="reUserName"
                                                   placeholder="再次输入手机号" id="reUserName" >
                                            </input>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-offset-2 col-lg-10">
                                            <button class="btn btn-shadow btn-success" data-loading-text='稍等...' type="submit" id="submit">充值</button>
                                            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                                            <button class="btn btn-shadow btn-danger" type="button" data-dismiss="modal">返回</button>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                </form>
                <!-- page end-->
                <!--main content end-->
                <script type="text/javascript">
                    $(function(){
                        $('#add_user_form').ajaxForm({
                            dataType : 'json',
                            beforeSubmit: function(){
                                $('#submit').button('loading');
                            },
                            success : function(data) {
                                $('#submit').button('reset');
                                if (data.result) {
                                    bootbox.alert("添加成功，将刷新页面", function() {
                                        location.href = "${BASE_PATH}/business/user/list.htm";
                                    });
                                }else{
                                    bootbox.alert(data.msg, function() {
                                    });
                                }
                            }
                        });
                        $('#back').click(function(){
                            location.href = "${BASE_PATH}/business/user/list.htm";
                        })
                    });
                </script>

            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


<#include "/business/foot.ftl">