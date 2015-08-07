<#assign menu="user">
<#include "/business/head.ftl">
<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <!-- page start-->
        <form id="add_user_form" class="form-horizontal" action="${BASE_PATH}/business/user/add.json"  autocomplete="off"  method="post"
              enctype="multipart/form-data">
            <div class="row">
                <div class="col-lg-12">
                    <section class="panel">
                        <header class="panel-heading">
                            添加用户
                        </header>
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
                                <label class="col-sm-2 col-sm-2 control-label">再次输入</label>
                                <div class="col-sm-10">
                                    <input type="text" style="font-size:15px;width: 300px;" class="form-control" name="reUserName"
                                           placeholder="再次输入手机号" id="reUserName" >
                                    </input>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-offset-2 col-lg-10">
                                    <button class="btn btn-shadow btn-success" data-loading-text='稍等...' type="submit" id="submit">添加</button>
                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                                    <button class="btn btn-shadow btn-danger" type="button" id="back">返回</button>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </form>
        <!-- page end-->
    </section>
</section>

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
<#include "/business/foot.ftl">