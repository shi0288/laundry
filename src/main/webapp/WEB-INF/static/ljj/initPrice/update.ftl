<#assign menu="initPrice">
<#include "/ljj/head.ftl">
<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <!-- page start-->
        <form id="update_user_form" class="form-horizontal" action="../../ljj/initPrice/update.json"
              autocomplete="off" method="post" enctype="multipart/form-data">
            <fieldset>
                <div class="row">
                    <input type="hidden" name="id" value="<#if (e._id)?? >${e._id}<#else>9999</#if>">
                    <div class="col-lg-12">
                        <section class="panel">
                            <header class="panel-heading">
                                修改起送金额信息
                            </header>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">起送金额</label>
                                    <div class="col-sm-10">
                                        <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                               name="price" id="price" value="<#if (e.price)?? >${e.price}</#if>"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">不满起送收取的外送费</label>
                                    <div class="col-sm-10">
                                        <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                               name="sendPrice" id="sendPrice" value="<#if (e.sendPrice)?? >${e.sendPrice}</#if>"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <button class="btn btn-shadow btn-primary" data-loading-text='稍等...' type="submit" id="submit">修改</button>
                                        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
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
                        location.href = "../../ljj/initPrice/update.htm";
                    });
                } else {
                    bootbox.alert(data.msg, function () {
                    });
                }
            }
        });
    });
</script>
<#include "/ljj/foot.ftl">
