function  printProduct(order){
    order = JSON.parse(order);
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

    LODOP.ADD_PRINT_TEXT(38,127,43,26,"订单");
    //LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
    //LODOP.SET_PRINT_STYLEA(0,"Bold",1);
    LODOP.ADD_PRINT_TEXT(3,91,100,20,"乐小购网上商城");
    LODOP.ADD_PRINT_TEXT(70,6,84,20,"收货人姓名：");//
    LODOP.ADD_PRINT_TEXT(70,80,83,20,order.conName);//姓名
    LODOP.ADD_PRINT_TEXT(100,6,84,20,"收货人电话：");
    LODOP.ADD_PRINT_TEXT(100,80,100,20,order.conMobile);
    LODOP.ADD_PRINT_TEXT(130,6,85,20,"收货人地址：");
    LODOP.ADD_PRINT_TEXT(130,80,186,20,order.conAddress);
    LODOP.ADD_PRINT_TEXT(170,6,79,20,"货品清单：");
    LODOP.ADD_PRINT_TEXT(200,6,46,20,"名称");
    LODOP.ADD_PRINT_TEXT(200,99,43,20,"单价");
    LODOP.ADD_PRINT_TEXT(200,156,35,20,"数量");
    LODOP.ADD_PRINT_TEXT(200,212,60,20,"单品合计");

    printDetail(order);
    return  LODOP;
}


function printDetail(order){
    //order = JSON.parse(order);
    var oArr = order.orderStr.split(';');
    console.log(oArr[0]);
    var orderPrice = order.orderPrice;
    var orderId = order._id.$oid;
    //orderId = JSON.parse(orderId);
    //orderId = JSON.stringify(orderId);
    var length = oArr.length;
    console.log(orderPrice);
    console.log(orderId);
    console.log(length);
    for(var i=0;i<length;i++){
        var oAr=JSON.parse(oArr[i]);
        console.log("gggg:"+oAr.numbers);
        LODOP.ADD_PRINT_TEXT(230+i*30,6,84,20,oAr.name);
        LODOP.ADD_PRINT_TEXT(230+i*30,92,53,20,oAr.price);
        LODOP.ADD_PRINT_TEXT(230+i*30,161,38,20,oAr.numbers);
        LODOP.ADD_PRINT_TEXT(230+i*30,226,48,20,(oAr.price*1)*(oAr.numbers*1));
    }
    LODOP.ADD_PRINT_TEXT(230+length*30,20,46,20,"合计：");
    LODOP.ADD_PRINT_TEXT(230+length*30,126,100,20,'人民币：'+orderPrice+'元');
    LODOP.ADD_PRINT_TEXT(230+(length+1)*30,91,130,20,'乐小购祝您生活愉快！');
    LODOP.ADD_PRINT_TEXT(230+(length+2)*30,126,100,20,'');
    var is = LODOP.PRINT();
    if(is){
        bootbox.alert("打印成功，将刷新页面并更新订单状态", function () {
            //location.href = "afterupdate.htm?torderId="+orderId+"";
            location.href = "list.htm?status=1100";
        });
    }
}