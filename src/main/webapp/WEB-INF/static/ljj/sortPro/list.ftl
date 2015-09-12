<#assign menu="sortPro">
<#include "/ljj/head.ftl">
<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <section class="panel">
            <div class="panel-body">
                <form action="../../ljj/sortPro/list.htm" method="get" id="query_form">
                    <table class="query_table">
                        <input type="hidden" name="p" id="p" value="${(p)!""}"/>
                        <tr>
                            <td>名称</td>
                            <td><input type="text" name="name" class="form-control" value="${(cond.name)!""}"/>
                            </td>
                            <td>所属主题</td>
                            <td>
                                <select name="mainProId" class="form-control">
                                    <option value="">所有</option>
                                <#list mainPro as e>
                                    <option value="${e._id}" <#if (cond.mainProId)??><#if e._id==cond.mainProId> selected </#if></#if> >${e.name}</option>
                                </#list>
                                </select>
                            </td>
                            <td>状态</td>
                            <td>
                                <select name="status" class="form-control">
                                    <option value="">所有</option>
                                    <option <#if (cond.status)??> <#if  cond.status==0>selected</#if> </#if> value="0">显示</option>
                                    <option <#if (cond.status)??> <#if  cond.status==1>selected</#if> </#if>  value="1">隐藏</option>
                                </select>
                            </td>
                            <td>推荐</td>
                            <td>
                                <select name="tip" class="form-control">
                                    <option value="">所有</option>
                                    <option <#if (cond.tip)??> <#if  cond.tip==0>selected</#if> </#if> value="0">是</option>
                                    <option <#if (cond.tip)??> <#if  cond.tip==1>selected</#if> </#if>  value="1">否</option>
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
                        <a class="btn btn-primary" style="float:right;" data-toggle="modal"
                           data-target="#myModal">增加分类</a>
                    </div>
                </div>
            </header>
            <div class="panel-body">
                <div class="adv-table">
                    <div role="grid" class="dataTables_wrapper" id="hidden-table-info_wrapper">
                        <table class="table table-striped table-advance table-hover">
                            <thead>
                            <tr>
                                <th>分类名称</th>
                                <th>所属主题</th>
                                <th>状态</th>
                                <th>推荐</th>
                                <th>创建时间</th>
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
                                ${(e.mainPro.name)!""}
                                </td>
                                <td>
                                    <#if e.status==0>
                                        显示
                                    <#else>
                                        隐藏
                                    </#if>
                                </td>
                                <td>
                                    <#if e.tip==0>
                                        是
                                    <#else>
                                        否
                                    </#if>
                                </td>
                                <td>
                                ${e.createTime?number?number_to_datetime}
                                </td>
                                <td>
                                    <a href="../../ljj/sortPro/update.htm?id=${e._id}" title="编辑">
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
                    添加新分类
                </h4>
            </div>
            <div class="modal-body">
                <!-- page start-->

                <form id="add_user_form" class="form-horizontal" action="../../ljj/sortPro/add.json"
                      autocomplete="off" method="post">
                    <div class="row">
                        <div class="col-lg-12">
                            <section class="panel">
                                <div class="panel-body">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">名称</label>

                                        <div class="col-sm-10">
                                            <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                                   name="name"
                                                   placeholder="输入分类名称" id="name">
                                            </input>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">主题</label>
                                        <div class="col-sm-10">
                                            <select name="mainProId" class="form-control">
                                                <option value="">请选择所属主题</option>
                                            <#list mainPro as e>
                                                <option value="${e._id}">${e.name}</option>
                                            </#list>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">状态</label>
                                        <div class="col-sm-10">
                                            <select name="status" class="form-control">
                                                <option value="0">显示</option>
                                                <option value="1">隐藏</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">推荐</label>
                                        <div class="col-sm-10">
                                            <select name="tip" class="form-control">
                                                <option value="1">否</option>
                                                <option value="0">是</option>
                                            </select>
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
                            beforeSubmit: function () {
                                $('#submit').button('loading');
                            },
                            success: function (data) {
                                $('#submit').button('reset');
                                if (data.result) {
                                    bootbox.alert("添加成功，将刷新页面", function () {
                                        location.href = "../../ljj/sortPro/list.htm";
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