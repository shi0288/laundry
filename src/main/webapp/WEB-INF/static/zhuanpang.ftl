<!DOCTYPE html>
<html>
<head>
        <title>算命得奖品</title>
        <meta charset="utf-8">
        <script src="static/ljj/common/js/jquery.js"></script>
		<script src="static/ljj/common/js/zhuanpan.js"></script>
        <script src="static/ljj/common/js/jQueryRotateCompressed.js"></script>
        <meta name="viewport" content="target-densitydpi=320,width=640,user-scalable=no">
        <style type="text/css">
            body{
                padding: 0;
                margin: 0;
                background: #fff;
            }
          #content{
              padding: 0;
              margin: 0 auto;
              width: 100%;
              height: 90%;
              /*background: #170220;*/
              background:#fff;
          }
          label{
          font-size:24px;
          }
          #name{
               height:28px;
               margin-top:12px;
               font-size:18px;
          }
        .tool-button{
            text-align: center;
            margin-top: 1em;
            margin-bottom: 1em;
        }
        .tool-button span{
            display: inline-block;
            width: 5em;
            height: 2em;
            line-height: 2em;
            background: #da4f49;
            border-radius: 1em;
            color: #ffffff;
            margin: 0 2em;
            padding: 0.2em 1.5em;
            font-size: 1.5em;
        }
          #marry-who{
              margin: 0 auto;
              padding-top: 10px;
              width: 100%;
              height: 128px;
              background-image: url(static/ljj/common/activityImg/zhuanpan/damuzhi.jpg);
              background-repeat: no-repeat;
              background-position: bottom;
              filter:"progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
              -moz-background-size:100% 100%;
              background-size:100% 100%;
          }
          #marry-form{
              padding-top: 17px;
              padding-left: 20px;
              width:85%;
              margin:0 auto;
              text-align:center;
          }
          #ad{
              margin:0 auto;
              text-align:center;
          }
          #marry-form .form-one{
              float:left;
          }
          #display_head img{
             width:5px;
             height:5px;
          }
        .tool-button{
            text-align: center;
            margin-top: 1em;
            margin-bottom: 1em;
        }
        .tool-button span{
            display: inline-block;
            width: 5em;
            height: 2em;
            line-height: 2em;
            background: #da4f49;
            border-radius: 1em;
            color: #ffffff;
            margin: 0 2em;
            padding: 0.2em 1.5em;
            font-size: 1.5em;
        }
          #round{
              width: 90%;
              height: auto;
              margin: 0 auto;
              margin-top: 10px;
              background-image: url(static/ljj/common/activityImg/zhuanpan/zhuanpan.jpg);
              filter:"progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
              -moz-background-size:100% 100%;
              background-size:100% 100%;
          }
          #arrow{
              margin: 0 auto;
              padding-top: 10em;
              text-align: center;
          }
          #arrow-img{
            width: 100%;
            height: auto;
          }
          #result{
              width: 80%;
              height: 158px;
              margin: 0 auto;
              position: fixed;
              top:40%;
              background-image: url(static/ljj/common/activityImg/zhuanpan/jieguo.png);
              background-repeat: no-repeat;
              filter:"progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
              -moz-background-size:100% 100%;
              background-size:100% 100%;
              display: none;
              z-index: 999;
              padding-left:30px;
          }
          #info{
              padding-top: 40px;
              font-weight:800;
              padding-bottom: 8px;
              padding-left: 10px;
              font-size:24px;
              width:95%;
              z-index: 999;
          }
          #tools{
              padding-left: 10px;
              font-size:24px;
          }
          #share{
              font-size:20px;
              margin-top:2px;
              color:red;
           }
            #close{
              position: absolute;
              width: 46px;
              height: 46px;
              right: 0;
              margin-top: -5px;
              margin-right: -5px;
            }

            .guanzhu a{
                font-size:24px;
            }
                #tip {
                    display: none;
                    position: absolute;
                    width: 100%;
                    top: 10px;
                    left: 15px;
                }
                #tip img{
                    width:90%;
                    margin:0 auto;
                    text-align:center;
                }
      </style>
    </head>
    <body>
<div id="display_head">  
</div>
<!--结果提示-->
<div id="result">
  <div id="close">
    <img src="static/ljj/common/activityImg/zhuanpan/close.png" alt=""/>
  </div>
  <div id="info">    
  </div>

  <div id="tools">
      <span id="share">
      <img src="static/ljj/common/activityImg/zhuanpan/damuzhi.gif" /><span id="t-info"></span>
    </span>
  </div>
</div>
<div id="content">
   <div id="bg">
      <div id="round">
        <div id="arrow">
           <img src="static/ljj/common/activityImg/zhuanpan/zhizhen.png" id="arrow-img" alt=""/>
       </div>
    </div>
  </div>
<div class="tool-button">
  <span id="begin">
    转起来
  </span>
</div>
</div>
</body>
</html>
