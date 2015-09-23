<#assign menu="product">
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

        <section class="panel">
            <div class="col-lg-12">
            <#--<!--breadcrumbs start &ndash;&gt;-->
                <ul class="breadcrumb">
                    <li>
                        <a href="../../ljj/product/list.htm?toWhat=0">商品</a>
                    </li>
                    <li>
                        <a href="../../ljj/product/list.htm?toWhat=1">限量</a>
                    </li>
                    <li>
                        <a href="../../ljj/product/list.htm?toWhat=2">套餐</a>
                    </li>
                </ul>
            <#--<!--breadcrumbs end &ndash;&gt;-->
            </div>

        </section>
        <section class="panel">
            <div class="panel-body">
                <form action="../../ljj/product/list.htm" method="get" id="query_form">
                    <table class="query_table">
                        <input type="hidden" name="p" id="p" value="${(p)!""}"/>
                        <input type="hidden" name="toWhat" id="toWhat" value="${(cond.toWhat)!""}"/>
                        <tr>
                            <td>名称</td>
                            <td><input type="text" name="name" class="form-control" value="${(cond.name)!""}"/>
                            </td>
                            <td>状态</td>
                            <td>
                                <select name="status" class="form-control">
                                    <option value="">所有</option>
                                    <option <#if (cond.status)??> <#if  cond.status==0>selected</#if> </#if> value="0">显示</option>
                                    <option <#if (cond.status)??> <#if  cond.status==1>selected</#if> </#if>  value="1">隐藏</option>
                                    <option <#if (cond.status)??> <#if  cond.status==2>selected</#if> </#if>  value="2">补货中</option>
                                </select>
                            </td>

                            <td>首页</td>
                            <td>
                                <select name="tip" class="form-control">
                                    <option value="">所有</option>
                                    <option <#if (cond.tip)??> <#if  cond.tip==0>selected</#if> </#if> value="0">否</option>
                                    <option <#if (cond.tip)??> <#if  cond.tip==1>selected</#if> </#if>  value="1">是</option>
                                </select>
                            </td>

                            <td>推荐</td>
                            <td>
                                <select name="jump" class="form-control">
                                    <option value="">所有</option>
                                    <option <#if (cond.jump)??> <#if  cond.jump==0>selected</#if> </#if> value="0">不推荐</option>
                                    <option <#if (cond.jump)??> <#if  cond.jump==1>selected</#if> </#if>  value="1">推荐</option>
                                </select>
                            </td>

                            <td>主题</td>
                            <td>
                                <select name="mainProId" class="form-control">
                                    <option value="">所有</option>
                                   <#list mainPro as e>
                                       <option <#if (cond.mainProId)??> <#if  cond.mainProId==e._id>selected</#if> </#if> value="${e._id}">${e.name}</option>
                                   </#list>
                                </select>
                            </td>
                            <td>分类</td>
                            <td>
                                <select name="sortProId" class="form-control">
                                    <option value="">所有</option>
                                    <#list sortPro as e>
                                    <option <#if (cond.sortProId)??> <#if  cond.sortProId==e._id>selected</#if> </#if> value="${e._id}">${e.name}</option>
                                    </#list>
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
                           data-target="#myModal">增加商品</a>
                    </div>
                </div>
            </header>
            <div class="panel-body">
                <div class="adv-table">
                    <div role="grid" class="dataTables_wrapper" id="hidden-table-info_wrapper">
                        <table class="table table-striped table-advance table-hover">
                            <thead>
                            <tr>
                                <th>商品名称</th>
                                <th>主题</th>
                                <th>分类</th>
                                <th>状态</th>
                                <th>首页</th>
                                <th>推荐</th>
                                <th>原价</th>
                                <th>现价</th>
                                <th>库存</th>
                                <th>销量</th>
                                <th>点击量</th>
                                <th>描述</th>
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
                                ${e.mainPro.name}
                                </td>
                                <td>
                                ${e.sortPro.name}
                                </td>
                                <td>
                                    <#if e.status==0>
                                      显示
                                    <#elseif e.status==1>
                                       隐藏
                                    <#else>
                                        补货中
                                    </#if>
                                </td>
                                <td>
                                    <#if e.tip==0>
                                        否
                                    <#else>
                                        是
                                    </#if>
                                </td>
                                <td>
                                    <#if e.jump==0>
                                        不推荐
                                    <#else>
                                        推荐
                                    </#if>
                                </td>
                                <td>
                                ${e.oldPrice}
                                </td>
                                <td>
                                ${e.price}
                                </td>
                                <td>
                                ${e.num!"0"}
                                </td>
                                <td>
                                ${e.saleNum!"0"}
                                </td>
                                <td>
                                ${e.clickNum!"0"}
                                </td>
                                <td>
                                ${e.desc!""}
                                </td>
                                <td>
                                ${e.createTime?number?number_to_datetime}
                                </td>
                                <td>
                                    <a href="../../ljj/product/update.htm?id=${e._id}" title="编辑">
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
                    添加新商品
                </h4>
            </div>
            <div class="modal-body">
                <!-- page start-->
                <form id="add_user_form" class="form-horizontal" action="../../ljj/product/add.json"
                      autocomplete="off" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-lg-12">
                            <section class="panel">
                                <div class="panel-body">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">栏目</label>
                                        <div class="col-sm-10">
                                            <select id="inToWhat" name="toWhat" class="form-control">
                                                <option value="0">商品</option>
                                                <option value="1">限量</option>
                                                <option value="2">套餐</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">名称</label>
                                        <div class="col-sm-10">
                                            <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                                   name="name"
                                                   placeholder="输入商品名称" id="name">
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
                                        <label class="col-sm-2 control-label">分类</label>
                                        <div class="col-sm-10">
                                            <select name="sortProId" class="form-control">
                                                <option value="">请选择所属分类</option>
                                            <#list sortPro as e>
                                                <option value="${e._id}">${e.name}</option>
                                            </#list>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">原价</label>
                                        <div class="col-sm-10">
                                            <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                                   name="oldPrice"
                                                   placeholder="输入商品原价" value="0"  id="oldPrice">
                                            </input>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">现价</label>
                                        <div class="col-sm-10">
                                            <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                                   name="price"
                                                   placeholder="输入商品现价" value="0" id="price">
                                            </input>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">状态</label>
                                        <div class="col-sm-10">
                                            <select name="status" class="form-control">
                                                <option value="0">显示</option>
                                                <option value="1">隐藏</option>
                                                <option value="2">补货中</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">首页</label>
                                        <div class="col-sm-10">
                                            <select name="tip" class="form-control">
                                                <option value="0">不显示</option>
                                                <option value="1">显示</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">推荐</label>
                                        <div class="col-sm-10">
                                            <select name="jump" class="form-control">
                                                <option value="0">否</option>
                                                <option value="1">是</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">图片上传</label>
                                        <div class="col-sm-10">
                                            <input type="file"  class="form-control" name="files" id="inputFile"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">图片上传</label>
                                        <div class="col-sm-10">
                                            <input type="file"  class="form-control" name="files" id="inputFile"/>
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">属性描述</label>
                                        <div class="col-sm-10">
                                            <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                                   name="desc"
                                                   placeholder="输入商品描述" id="desc">
                                            </input>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">库存</label>
                                        <div class="col-sm-10">
                                            <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                                   name="num"
                                                   placeholder="输入库存" value="0"  id="num">
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
                            beforeSubmit: function () {
                                $('#submit').button('loading');
                            },
                            success: function (data) {
                                $('#submit').button('reset');
                                if (data.result) {
                                    bootbox.alert("添加成功，将刷新页面", function () {
                                        var inToWhat=$("#inToWhat").val();
                                        location.href = "../../ljj/product/list.htm?toWhat="+inToWhat;
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