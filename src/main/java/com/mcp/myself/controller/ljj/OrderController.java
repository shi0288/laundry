package com.mcp.myself.controller.ljj;

import com.mcp.myself.service.OrderService;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("ljj/order")
public class OrderController extends BaseAction {



    @Autowired
    private OrderService orderService;

    @RequestMapping(value = "list.htm", method = RequestMethod.GET)
    public String list(
            HttpServletRequest request, ModelMap modelMap) {
        modelMap = orderService.getAllListPage(modelMap, request);
        DBObject dbObject=new BasicDBObject();
        dbObject.put("status",1100);
        int waitCount = MongoUtil.queryCount(MongoConst.MONGO_ORDERS,dbObject);
        dbObject.put("status", 1000);
        int payCount = MongoUtil.queryCount(MongoConst.MONGO_ORDERS,dbObject);
        modelMap.put("waitCount",waitCount);
        modelMap.put("payCount",payCount);
        return "ljj/torder/list";
    }


}