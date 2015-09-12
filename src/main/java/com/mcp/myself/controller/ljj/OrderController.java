package com.mcp.myself.controller.ljj;

import com.mcp.myself.bean.JsonVo;
import com.mcp.myself.service.OrderService;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.io.IOException;

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
        int waitCount = MongoUtil.queryCount(MongoConst.MONGO_ORDERS, dbObject);
        dbObject.put("status", 1000);
        int payCount = MongoUtil.queryCount(MongoConst.MONGO_ORDERS, dbObject);
        dbObject.put("status", 1101);
        int printCount = MongoUtil.queryCount(MongoConst.MONGO_ORDERS,dbObject);
        modelMap.put("waitCount", waitCount);
        modelMap.put("payCount",payCount);
        modelMap.put("printCount",printCount);
        return "ljj/torder/list";
    }

    /**
     * 进入更新
     */
    @RequestMapping(value = "update.htm", method = RequestMethod.GET)
    public String update(@RequestParam(value = "torderId") String torderId,
                         ModelMap modelMap) {
        DBObject dbObject = orderService.getById(torderId);
        JSONObject jsonObject = JSONObject.fromObject(dbObject);
        String orderStr = jsonObject.getString("orderStr");
        String s[] = orderStr.split(";");
       // JSONObject order = JSONObject.fromObject(s);
        JSONArray order = JSONArray.fromObject(s);
        System.out.println("e:"+dbObject.toString());
        System.out.println("order:" + order.toString());
        modelMap.put("e", dbObject);
        modelMap.put("order", order);
        return "ljj/torder/update";
    }


    @ResponseBody
    @RequestMapping("getDetail.json")
    public JsonVo<DBObject> getDetail(String torderId) throws
            IOException {
        JsonVo<DBObject> json = new JsonVo<DBObject>();
        DBObject dbObject = orderService.getById(torderId);
//        JSONObject jsonObject = JSONObject.fromObject(dbObject);
//        String id = jsonObject.getString("_id");
//        System.out.println("idididid:" + id);
        String str = dbObject.toString();
        json.setObject(str);
        json.setResult(true);
        DBObject upObject=new BasicDBObject();
        upObject.put("_id", new ObjectId(torderId));
        upObject.put("status", 1101);
        orderService.update(upObject);
        return json;
    }
}