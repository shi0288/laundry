<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Mosaddek">
    <meta name="keyword"
          content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
    <meta http-equiv="Page-Enter"    contect="revealTrans(duration=5.0,transtion=12)">
    <link rel="shortcut icon" href="img/favicon.png">
    <title>店主管理后台</title>
    <!-- Bootstrap core CSS -->
    <link href="../../static/ljj/common/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../static/ljj/common/css/bootstrap-reset.css"
          rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../static/ljj/common/css/gallery.css" />
    <!--external css-->
    <link
            href="../../static/ljj/common/assets/font-awesome/css/font-awesome.css"
            rel="stylesheet" />
    <link href="../../static/ljj/common/assets/fancybox/source/jquery.fancybox.css" rel="stylesheet" />
    <!-- Custom styles for this template -->
    <link href="../../static/ljj/common/css/style.css" rel="stylesheet">
    <link href="../../static/ljj/common/css/style-responsive.css" rel="stylesheet" />
    <link href="../../static/ljj/common/assets/uploadify/uploadify.css" rel="stylesheet" />
    <link href="../../static/ljj/common/assets/bootstrap.datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 tooltipss and media queries -->
    <!--[if lt IE 9]>
	<script src="../../static/ljj/common/js/html5shiv.js"></script>
	<script src="../../static/ljj/common/js/respond.min.js"></script>
    <![endif]-->
    <script src="../../static/ljj/common/js/jquery.js"></script>
    <script type="text/javascript" src="../../static/ljj/common/js/LodopFuncs.js"></script>
    <script type="text/javascript" src="../../static/ljj/common/js/print.js"></script>
</head>
<body class="boxed-page">
<div class="container" style="width: 80%;" >
    <section id="container" class="">
        <!--header start-->
        <header class="white-bg">
            <div class="container" style="background-color: #ffffff; padding: 10px;">
                <!--logo start-->
                <a href="../static/index.htm" class="logo" title="进入首页">
                    <img src="../static/common/css/images/ajax-loader.gif" style="height: 38px;" />
                </a>
                <!--logo end-->
                <div class="nav notify-row" id="top_menu">
                    <!--  notification goes here -->
                </div>
                <div class="top-nav ">

                    <ul class="nav pull-right top-menu">
                        <!-- user login dropdown start-->

                        <li class="dropdown">
                            <button  class="btn btn-info btn-shadow dropdown-toggle" data-toggle="dropdown">
                                <i class="icon-user icon-white"></i>
                                <span class="username">${SESSION_ADMIN.name}</span>
                                <b class="caret"></b>
                            </button>

                            <ul class="dropdown-menu extended logout">
                                <div class="log-arrow-up"></div>
                                <li><a href="#"><i class="icon-cog"></i> 修改密码</a></li>
                                <li><a href="../../ljj/user/logout.htm"><i class="icon-key"></i> 安全退出</a></li>
                            </ul>
                        </li>
                        <!-- user login dropdown end -->
                    </ul>

                </div>
            </div>
        </header>
        <!--header end-->
        <!--sidebar start-->
        <aside>
            <div id="sidebar" class="nav-collapse ">
                <!-- sidebar menu goes here-->
                <ul class="sidebar-menu" id="nav-accordion">
                    <li class="">
                        <a <#if menu="torder">class="active"</#if> href="../../ljj/order/list.htm"> <i class="icon-book"></i> <span>订单列表</span></a>
                    </li>
                    <li class="">
                        <a <#if menu="user">class="active"</#if> href="../../ljj/user/list.htm"> <i class="icon-book"></i> <span>用户列表</span></a>
                    </li>
                    <li class="">
                        <a <#if menu="mainPro">class="active"</#if> href="../../ljj/mainPro/list.htm"> <i class="icon-folder-open"></i> <span>主题管理</span></a>
                    </li>
                    <li class="">
                        <a <#if menu="sortPro">class="active"</#if> href="../../ljj/sortPro/list.htm"> <i class="icon-comments"></i> <span>分类管理</span></a>
                    </li>
                    <li class="">
                        <a <#if menu="brand">class="active"</#if> href="../../ljj/brand/list.htm"> <i class="icon-folder-open"></i> <span>销售点管理</span></a>
                    </li>
                    <li class="">
                        <a <#if menu="pictures">class="active"</#if> href="../../ljj/pictures/list.htm"> <i class="icon-cogs"></i> <span>轮播图管理</span></a>
                    </li>
                    <li class="">
                        <a <#if menu="product">class="active"</#if> href="../../ljj/product/list.htm?toWhat=0"> <i class="icon-cogs"></i> <span>商品管理</span></a>
                    </li>
                    <li class="">
                        <a <#if menu="initPrice">class="active"</#if> href="../../ljj/initPrice/update.htm"> <i class="icon-cogs"></i> <span>起送额度</span></a>
                    </li>
                    <li class="">
                        <a <#if menu="initPrice">class="active"</#if> href="../../ljj/action/list.htm"> <i class="icon-cogs"></i> <span>活动列表</span></a>
                    </li>
                </ul>
            </div>
        </aside>
        <!--sidebar end-->
