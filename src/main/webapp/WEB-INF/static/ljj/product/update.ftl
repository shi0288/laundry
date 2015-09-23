<#assign menu="product">
<#include "/ljj/head.ftl">
<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <!-- page start-->
        <form id="update_user_form" class="form-horizontal" action="../../ljj/product/update.json"
              autocomplete="off" method="post"
              enctype="multipart/form-data">
            <fieldset>
                <div class="row">
                    <input type="hidden" name="id" value="${p._id}">
                    <div class="col-lg-12">
                        <section class="panel">
                            <header class="panel-heading">
                                修改模块信息
                            </header>
                            <div class="panel-body">

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">栏目</label>
                                    <div class="col-sm-10">
                                        <select id="inToWhat"  name="toWhat" class="form-control">
                                            <option value="0" <#if p.toWhat==0>selected</#if> >商品</option>
                                            <option value="1" <#if p.toWhat==1>selected</#if> >限量</option>
                                            <option value="2" <#if p.toWhat==2>selected</#if> >套餐</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">名称</label>
                                    <div class="col-sm-10">
                                        <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                               name="name"
                                               placeholder="输入商品名称" id="name" value="${(p.name)!''}">
                                        </input>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">主题</label>
                                    <div class="col-sm-10">
                                        <select name="mainProId" class="form-control">
                                            <option value="">请选择所属主题</option>
                                        <#list mainPro as e>
                                            <option value="${e._id}" <#if e._id==p.mainProId>selected</#if> >${e.name}</option>
                                        </#list>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">分类</label>
                                    <div class="col-sm-10">
                                        <select name="sortProId" class="form-control">
                                            <option value="">请选择所属分类</option>
                                        <#list sortPro as e>
                                            <option value="${e._id}" <#if e._id==p.sortProId>selected</#if>  >${e.name}</option>
                                        </#list>
                                        </select>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-sm-2 control-label">原价</label>
                                    <div class="col-sm-10">
                                        <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                               name="oldPrice"
                                               placeholder="输入商品原价" value="${(p.oldPrice)!''}"  id="oldPrice">
                                        </input>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">现价</label>
                                    <div class="col-sm-10">
                                        <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                               name="price"
                                               placeholder="输入商品现价" value="${(p.price)!''}" id="price">
                                        </input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">状态</label>
                                    <div class="col-sm-10">
                                        <select name="status" class="form-control">
                                            <option value="0"  <#if p.status==0>selected</#if>   >显示</option>
                                            <option value="1"  <#if p.status==1>selected</#if> >隐藏</option>
                                            <option value="2"  <#if p.status==2>selected</#if> >补货中</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">首页</label>
                                    <div class="col-sm-10">
                                        <select name="tip" class="form-control">
                                            <option value="0" <#if p.tip==0>selected</#if> >不显示</option>
                                            <option value="1" <#if p.tip==1>selected</#if> >显示</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">推荐</label>
                                    <div class="col-sm-10">
                                        <select name="jump" class="form-control">
                                            <option value="0"   <#if p.jump==0>selected</#if> >否</option>
                                            <option value="1"   <#if p.jump==1>selected</#if> >是</option>
                                        </select>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-sm-2 control-label">图片上传</label>
                                    <div class="col-sm-10">
                                        <input type="file"  class="form-control" name="files" id="inputFile"/>
                                    </div>
                                <#list p.fileNames as fileName>
                                  <#if fileName_index==0>
                                      <img style="margin-left: 200px" width="100px" height="100px" src="../../../upload/img/${fileName}" />
                                  </#if>
                                </#list>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">图片上传</label>
                                    <div class="col-sm-10">
                                        <input type="file"  class="form-control" name="files" id="inputFile"/>
                                    </div>
                                <#list p.fileNames as fileName>
                                    <#if fileName_index==1>
                                        <img style="margin-left: 200px"  width="100px" height="100px" src="../../../upload/img/${fileName}" />
                                    </#if>
                                </#list>
                                </div>


                                <div class="form-group">
                                    <label class="col-sm-2 control-label">属性描述</label>
                                    <div class="col-sm-10">
                                        <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                               name="desc"
                                               placeholder="输入商品描述" value="${(p.desc)!''}" id="desc">
                                        </input>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">库存</label>
                                    <div class="col-sm-10">
                                        <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                               name="num"
                                               placeholder="输入库存" value="${(p.num)!''}"  id="num">
                                        </input>
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
                        var inToWhat=$("#inToWhat").val();
                        location.href = "../../ljj/product/list.htm?toWhat="+inToWhat;
                    });
                } else {
                    bootbox.alert(data.msg, function () {
                    });
                }
            }
        });
        $('#back').click(function(){
            location.href = "../../ljj/product/list.htm";
        })
    });
</script>
<#include "/ljj/foot.ftl">
