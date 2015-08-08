<#assign menu="mainPro">
<#include "/ljj/head.ftl">
<!--main content start-->
<style type="text/css">

</style>
<section id="main-content">
    <section class="wrapper">
        <!-- page start-->
        <form id="update_user_form" class="form-horizontal" action="${BASE_PATH}/ljj/user/update.json"
              autocomplete="off" method="post"
              enctype="multipart/form-data">
            <fieldset>
                <div class="row">
                    <input type="hidden" name="userId" value="${e._id}">
                    <div class="col-lg-12">
                        <section class="panel">
                            <header class="panel-heading">
                                修改模块信息
                            </header>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">名称</label>
                                    <div class="col-sm-10">
                                        <input type="text" disabled="disabled" style="font-size:15px;width: 300px;" class="form-control"
                                               name="userName" id="userName" value="${e.name}"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">状态</label>
                                    <div class="col-sm-10">
                                        <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                               name="status" id="status" value=" <#if e.status==0>0</#if>"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">创建时间</label>
                                    <div class="col-sm-10">
                                        <input type="text" disabled="disabled" style="font-size:15px;width: 300px;" class="form-control"
                                               name="createTime" id="createTime" value=" ${e.createTime?number?number_to_datetime}"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <button class="btn btn-shadow btn-primary" data-loading-text='稍等...' type="submit" id="submit">修改</button>
                                        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                                        <button class="btn btn-shadow btn-danger" type="button" id="back">返回</button>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>
                </div>
            </fieldset>
        </form>
        <!-- page end-->
    </section>
</section>
<!--main content end-->
<script type="text/javascript">
    $(function () {
        $('#update_user_form').ajaxForm({
            dataType: 'json',
            beforeSubmit: function(){
                $('#submit').button('loading');
            },
            success: function (data) {
                $('#submit').button('reset');
                if (data.result) {
                    bootbox.alert("修改成功，将刷新页面", function () {
                        location.href = "${BASE_PATH}/ljj/mainPro/list.htm";
                    });
                } else {
                    showErrors($('#add_user_form'), data.msg);
                }
            }
        });
        $('#back').click(function(){
            location.href = "${BASE_PATH}/ljj/mainPro/list.htm";
        })
    });
</script>
<#include "/ljj/foot.ftl">
