function  printProduct(detail){
    console.log(detail);
    var order = detail[0];
    order=JSON.parse(order);
    var activity = detail[1];
    activity=JSON.parse(activity);
    LODOP=getLodop();
    LODOP.PRINT_INIT("");
    LODOP.SET_PRINT_PAGESIZE(3,1000,6,0);
    //LODOP.ADD_PRINT_SETUP_BKIMG("<img border='0' src='1231.jpg'>");
    LODOP.SET_SHOW_MODE("BKIMG_LEFT",3);
    LODOP.SET_SHOW_MODE("BKIMG_TOP",0);
    LODOP.SET_SHOW_MODE("BKIMG_WIDTH","80mm");
    //LODOP.SET_SHOW_MODE("BKIMG_HEIGHT","210mm");
    LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",true);
    LODOP.SET_SHOW_MODE("BKIMG_PRINT",false);

    //LODOP.ADD_PRINT_TEXT(38,127,43,26,"订单");
    //LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
    //LODOP.SET_PRINT_STYLEA(0,"Bold",1);
    LODOP.ADD_PRINT_TEXT(0,110,100,20,"乐小购订单");
    LODOP.ADD_PRINT_TEXT(20,6,84,20,"收货人姓名：");
    LODOP.ADD_PRINT_TEXT(20,75,83,20,order.conName);
    LODOP.ADD_PRINT_TEXT(35,6,84,20,"收货人电话：");
    LODOP.ADD_PRINT_TEXT(35,75,100,20,order.conMobile);
    LODOP.ADD_PRINT_TEXT(50,6,85,20,"收货人地址：");
    LODOP.ADD_PRINT_TEXT(50,75,186,20,order.conAddress);
    LODOP.ADD_PRINT_TEXT(85,6,79,20,"货品清单：");

    //LODOP.ADD_PRINT_TEXT(0,110,100,20,"乐小购订单");
    //LODOP.ADD_PRINT_TEXT(70,6,84,20,"收货人姓名：");//
    //LODOP.ADD_PRINT_TEXT(70,80,83,20,order.conName);//姓名
    //LODOP.ADD_PRINT_TEXT(100,6,84,20,"收货人电话：");
    //LODOP.ADD_PRINT_TEXT(100,80,100,20,order.conMobile);
    //LODOP.ADD_PRINT_TEXT(130,6,85,20,"收货人地址：");
    //LODOP.ADD_PRINT_TEXT(130,80,186,20,order.conAddress);
    //LODOP.ADD_PRINT_TEXT(170,6,79,20,"货品清单：");
    LODOP.ADD_PRINT_TEXT(100,6,46,20,"名称");
    LODOP.ADD_PRINT_TEXT(100,99,43,20,"单价");
    LODOP.ADD_PRINT_TEXT(100,156,35,20,"数量");
    LODOP.ADD_PRINT_TEXT(100,212,60,20,"单品合计");
    printDetail(order,activity);
    return  LODOP;
}

function printDetail(order,activity){
    var oArr = order.orderStr.split(';');
    var orderPrice = order.orderPrice;
    var orderId = order._id.$oid;
    var length = oArr.length;
    var str = "";
    var last = 0;
    for(var i=0;i<length;i++){
        var oAr=JSON.parse(oArr[i]);
        if(i==0){
            LODOP.ADD_PRINT_TEXT(115,6,84,20,oAr.name);
            LODOP.ADD_PRINT_TEXT(115,92,53,20,oAr.price);
            LODOP.ADD_PRINT_TEXT(115,161,38,20,oAr.numbers);
            LODOP.ADD_PRINT_TEXT(115,226,48,20,(oAr.price*1)*100*(oAr.numbers*1)/100);
            str = oAr.name;
            last = 115;
        }else{
            // var len = strLength(str);
            var len = 0;
            for (var j=0; j<str.length; j++) {
                if (str.charCodeAt(j)>127 || str.charCodeAt(j)==94) {
                    len += 2;
                } else {
                    len ++;
                }
            }
            console.log("len1:"+len);
            var num = Math.floor(len/12);
            console.log("num:"+num);
            LODOP.ADD_PRINT_TEXT(last+15+num*15,6,84,20,oAr.name);
            LODOP.ADD_PRINT_TEXT(last+15+num*15,92,53,20,oAr.price);
            LODOP.ADD_PRINT_TEXT(last+15+num*15,161,38,20,oAr.numbers);
            LODOP.ADD_PRINT_TEXT(last+15+num*15,226,48,20,(oAr.price*1)*100*(oAr.numbers*1)/100);
            str = oAr.name;
            last = last+15+num*15;
        }

    }
    var activityLength = activity.length;
    if(activityLength>0){
        for(var i=0;i<activityLength;i++){
            var oAr=activity[i];
            //var len = strLength(str);
            var len = 0;
            for (var j=0; j<str.length; j++) {
                if (str.charCodeAt(j)>127 || str.charCodeAt(j)==94) {
                    len += 2;
                } else {
                    len ++;
                }
            }
            var num =  Math.floor(len/12);
            LODOP.ADD_PRINT_TEXT(last+15+num*15,6,84,20,oAr.productName);
            LODOP.ADD_PRINT_TEXT(last+15+num*15,92,53,20,oAr.productPrice);
            LODOP.ADD_PRINT_TEXT(last+15+num*15,161,38,20,oAr.productNum);
            LODOP.ADD_PRINT_TEXT(last+15+num*15,226,48,20,0);
            str = oAr.productName;
            last = last+15+num*15;


        }
    }
    var len = 0;
    for (var j=0; j<str.length; j++) {
        if (str.charCodeAt(j)>127 || str.charCodeAt(j)==94) {
            len += 2;
        } else {
            len ++;
        }
    }
    var num =  Math.floor(len/12);
    LODOP.ADD_PRINT_TEXT(last+15+num*15,20,46,20,"合计：");
    LODOP.ADD_PRINT_TEXT(last+15+num*15,126,100,20,'人民币：'+orderPrice+'元');
    LODOP.ADD_PRINT_TEXT(last+30+num*15,91,130,20,'乐小购祝您生活愉快！');
    LODOP.ADD_PRINT_TEXT(last+45+num*15,126,100,20,'');
    var is = LODOP.PRINT();
    if(is){
        bootbox.alert("打印成功，将刷新页面", function () {
            location.href = "list.htm?status=1100";
        });
    }
}
function strLength(str){
    console.log("str:"+str);
    console.log("strlen:"+str.length);
    var len = 0;
    for (var i=0; i<str.length; i++) {
        if (str.charCodeAt(i)>127 || str.charCodeAt(i)==94) {
            len += 2;
        } else {
            len ++;
        }
    }
    return len;
}