 $(function(){
          var r_h = $("#round").width()*2;
          $("#round").css("height", r_h + "px");
          var a_p = $("#round").width()*3/8;
          $("#arrow").css("width", a_p + "px");
          var p_t = ($("#round").width()/2) - (a_p/2);
          $("#arrow").css("padding-top", p_t + "px");
          $(".tool-button").css("padding-top", p_t + "px");
          $("#begin").click(function(){
              var d=0;
              sessionStorage.setItem("name","123");
              //sessionStorage.setItem("passWord","123456");
              var body={
                  activeId:"1003",
                  actitityType:"zhuanpan",
                  userName: sessionStorage.getItem("name")
                  //passWord: sessionStorage.getItem("passWord")
              }
              $.ajax({
                  type: "POST",
                  url: "/laundry/activity/zhuanpan.json?timestamp="+ new Date().getTime(),
                  dataType: "json",
                  cache: false,
                  async: false,
                  data: {
                      body: JSON.stringify(body)
                  },
                  success: function (result) {
                      var repCode = result.result;
                      //console.log(result.object);
                      if (repCode) {
                          if(result.object.check){
                              d=result.object.num;
                              info=result.object.activeDes;
                          }else{
                              d=12;
                              info="话说这次活动只能参加一次哦，亲下次活动再来";
                          }
                      }else{
                          d=13;
                          info="亲，先登录，才能参加活动的";
                      }
                      getResult(d,info);
                  }
              });
          });

          $("body").on("click", "#close", function(){
              $("#result").hide();
              $("#ad").show();      
              $("#content").show();                 
          });

          $("#share").click(function(){
              var info = $("#info").text();         
          });
      })

 function getResult(d,info){
     var result_arr = ['手撕牛肉一袋','猫耳仔一袋','黑白配一袋','大大泡泡糖两块','真知棒一个',
         '阿尔卑斯棒棒糖','舒肤佳香皂一块','心心相印纸巾一包','堵嘴薯片一袋','洗衣皂一块','卫龙面筋两个',
         '馋大嘴巴一袋','',''];

     var msg  = result_arr[d];
     if(d<=11){
         d = d * 30 + 15;
         $('#arrow-img').stopRotate();
         $("#arrow-img").rotate({
             angle:0,
             duration: 5000,
             animateTo: d+1440,
             callback:function(){
                 var w = $(document).width();
                 var l;
                 var r_w = $("#result").width();
                 l = w/2 - (r_w/2);
                 $("#result").css("left", l + "px");
                 $("#info").text(msg);
                 $("#t-info").text(info);
                 document.title = msg.replace("你", "我");
                 $("#result").show();
             }
         });
     }else if(d==12){
         msg = "您已参加过此次活动";
         var w = $(document).width();
         var l;
         var r_w = $("#result").width();
         l = w/2 - (r_w/2);
         $("#result").css("left", l + "px");
         $("#info").text(msg);
         $("#t-info").text(info);
         document.title = msg.replace("你", "我");
         $("#result").show();
     }else if(d==13){
         msg = info;
         var w = $(document).width();
         var l;
         var r_w = $("#result").width();
         l = w/2 - (r_w/2);
         $("#result").css("left", l + "px");
         $("#info").text(msg);
         $("#t-info").text(info);
         document.title = msg.replace("你", "我");
         $("#result").show();
     }

 }