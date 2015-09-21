<#assign menu="user">
<#include "/ljj/head.ftl">
<style type="text/css">
    .pagination {
        border-radius: 4px;
        display: inline-block;
        margin: 0;
        padding-left: 0;
    }

    .form-group {
        width: 100%;
    }

</style>
<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <section class="panel">
            <div class="panel-body">
                <form action="../../ljj/user/list.htm" method="get" enctype="multipart/form-data"
                      id="query_form">
                    <table class="query_table">
                        <input type="hidden" name="status" value="${(cond.status)!""}"/>
                        <input type="hidden" name="p" id="p" value="${(p)!""}"/>
                        <tr>
                            <td>手机号</td>
                            <td><input type="text" name="userName" class="form-control" value="${(cond.userName)!""}"/>
                            </td>
                            <td>姓名</td>
                            <td><input type="text" name="realName" class="form-control" value="${(cond.realName)!""}"/>
                            </td>
                            <td>证件号码</td>
                            <td><input type="text" name="cardNum" class="form-control" value="${(cond.cardNum)!""}"/>
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
                        <a class="btn btn-primary" style="float:right;" data-toggle="modal"
                           data-target="#myModal">增加用户</a>
                    </div>
                </div>
            </header>
            <div class="panel-body">
                <div class="adv-table">
                    <div role="grid" class="dataTables_wrapper" id="hidden-table-info_wrapper">
                        <table class="table table-striped table-advance table-hover">
                            <thead>
                            <tr>
                                <th>用户名</th>
                                <th>微信名称</th>
                                <th>手机号</th>
                                <th>积分</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody role="alert" aria-live="polite" aria-relevant="all">
                                <#list pageVo.list as e>
                                <tr class="gradeA odd">
                                    <td>
                                    ${(e.name)!""}
                                    </td>
                                    <td>
                                    ${(e.nickName)!"无"}
                                    </td>
                                    <td>
                                    ${(e.moible)!"未填写"}
                                    </td>
                                    <td>
                                    ${(e.recharge)!"0"}
                                    </td>
                                    <td>
                                    ${(e.createTime)!""}
                                    </td>
                                    <td>
                                        <!-- Icons -->
                                        <a href="#" title="编辑">
                                            编辑
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
                    添加用户
                </h4>
            </div>
            <div class="modal-body">
                <!-- page start-->
                <form id="add_user_form" class="form-horizontal" action="../../ljj/user/add.json"
                      autocomplete="off" method="post">
                    <div class="row">
                        <div class="col-lg-12">
                            <section class="panel">
                                <div class="panel-body">
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">手机号</label>
                                        <div class="col-sm-10">
                                            <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                                   name="userName"
                                                   placeholder="输入手机号" id="userName">
                                            </input>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">再次输入</label>

                                        <div class="col-sm-10">
                                            <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                                   name="reUserName"
                                                   placeholder="再次输入手机号" id="reUserName">
                                            </input>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-offset-2 col-lg-10">
                                            <button class="btn btn-shadow btn-success" data-loading-text='稍等...'
                                                    type="submit" id="submit">添加
                                            </button>
                                            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                                            <button class="btn btn-shadow btn-danger" type="button"
                                                    data-dismiss="modal">返回
                                            </button>
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
                    $(function () {
                        $('#add_user_form').ajaxForm({
                            dataType: 'json',
                            beforeSubmit: function () {
                                $('#submit').button('loading');
                            },
                            success: function (data) {
                                console.log(data);
                                $('#submit').button('reset');
                                if (data.result) {
                                    bootbox.alert("添加成功，将刷新页面", function () {
                                        location.href = "../../ljj/user/list.htm";
                                    });
                                } else {
                                    bootbox.alert(data.msg, function () {
                                    });
                                }
                            }
                        });
                        $('#query_button').click(function () {
                            $('#p').val(1);
                            $('#query_form').submit();
                        });
                    });
                    function pageRun(num) {
                        $('#p').val(num);
                        $('#query_form').submit();
                    }
                </script>

            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
<#include "/ljj/foot.ftl">