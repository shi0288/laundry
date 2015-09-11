 $(function(){
          var r_h = $("#round").width();
          $("#round").css("height", r_h + "px");
          var a_p = r_h*3/8;
          $("#arrow").css("width", a_p + "px");
          var p_t = (r_h/2) - (a_p/2);
          $("#arrow").css("padding-top", p_t + "px");

          $("#begin").click(function(){
              var d=0;
              //sessionStorage.setItem("name","haha");
              //sessionStorage.setItem("passWord","123456");
              var body={
                  activeId:"1003",
                  actitityType:"zhuanpan",
                  userName: sessionStorage.getItem("name"),
                  passWord: sessionStorage.getItem("passWord")
              }
              $.ajax({
                  type: "POST",
                  url: "/laundry/activity/zhuanpan.json"+ new Date().getTime(),
                  dataType: "json",
                  cache: false,
                  async: false,
                  data: {
                      body: JSON.stringify(body)
                  },
                  success: function (result) {
                      var repCode = result.result;
                      console.log(result.object);
                      if (repCode) {
                          if(result.object.check){
                              d=result.object.num;
                              info=result.object.activeDes;
                          }else{
                              d=12;
                              info="易经说每天算命不能超过三次哦，明天再来";
                          }
                      }else{
                          d=13;
                          info="亲，先登录，结果才会更准";
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
     var result_arr = ['你的前世是和尚','你的前世是财主','你的前世是嫔妃','你的前世是将军','你的前世是书生',
         '你的前世是皇帝','你的前世是名妓','你的前世是老鸨','你的前世是丞相','你的前世是诗人','你的前世是佳人',
         '你的前世是土匪','',''];

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
         msg = "你的前世明日来测";
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