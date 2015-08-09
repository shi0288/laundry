<#assign menu="sortPro">
<#include "/ljj/head.ftl">
<!--main content start-->
<style type="text/css">

</style>
<section id="main-content">
    <section class="wrapper">
        <!-- page start-->
        <form id="update_user_form" class="form-horizontal" action="${INTER_PATH}/ljj/sortPro/update.json"
              autocomplete="off" method="post">
            <fieldset>
                <div class="row">
                    <input type="hidden" name="id" value="${e._id}">
                    <div class="col-lg-12">
                        <section class="panel">
                            <header class="panel-heading">
                                修改分类信息
                            </header>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">名称</label>
                                    <div class="col-sm-10">
                                        <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                               name="name" id="name" value="${e.name}"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">所属主题</label>
                                    <div class="col-sm-10">
                                        <select name="mainProId" class="form-control">
                                        <#list mainPro as b>
                                            <option value="${b._id}" <#if e.mainProId==b._id> selected </#if> >${b.name}</option>
                                        </#list>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">状态</label>
                                    <div class="col-sm-10">
                                        <select name="status" class="form-control">
                                            <option  <#if e.status==0>selected</#if> value="0">显示</option>
                                            <option  <#if e.status==1>selected</#if>  value="1">隐藏</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">推荐</label>
                                    <div class="col-sm-10">
                                        <select name="tip" class="form-control">
                                            <option  <#if e.tip==0>selected</#if> value="0">是</option>
                                            <option  <#if e.tip==1>selected</#if>  value="1">否</option>
                                        </select>
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
            beforeSubmit: function(){
                $('#submit').button('loading');
            },
            success: function (data) {
                $('#submit').button('reset');
                if (data.result) {
                    bootbox.alert("修改成功，将刷新页面", function () {
                        location.href = "${INTER_PATH}/ljj/sortPro/list.htm";
                    });
                } else {
                    showErrors($('#add_user_form'), data.msg);
                }
            }
        });
        $('#back').click(function(){
            location.href = "${INTER_PATH}/ljj/sortPro/list.htm";
        })
    });
</script>
<#include "/ljj/foot.ftl">
