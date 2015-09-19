package com.mcp.myself.controller.ljj;

import com.mcp.myself.bean.JsonVo;
import com.mcp.myself.service.OrderService;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mcp.myself.util.WeixinMessage;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
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
import java.util.*;

@Controller
@RequestMapping("ljj/order")
public class OrderController extends BaseAction {

    private static Logger logger = Logger.getLogger(OrderController.class);


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
        int printCount = MongoUtil.queryCount(MongoConst.MONGO_ORDERS, dbObject);
        dbObject.put("status", 1200);
        int sendCount = MongoUtil.queryCount(MongoConst.MONGO_ORDERS, dbObject);
        modelMap.put("waitCount", waitCount);
        modelMap.put("payCount",payCount);
        modelMap.put("printCount",printCount);
        modelMap.put("sendCount",sendCount);
        return "ljj/torder/list";
    }

    /**
     * 进入详情
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
        modelMap.put("e", dbObject);
        modelMap.put("order", order);
        return "ljj/torder/update";
    }


    @ResponseBody
    @RequestMapping("getDetail.json")
    public JsonVo<DBObject> getDetail(String torderId,int status) throws
            IOException {
        JsonVo<DBObject> json = new JsonVo<DBObject>();
        DBObject dbObject = orderService.getById(torderId);
        String str = dbObject.toString();
        DBObject upObject = new BasicDBObject();
        upObject.put("_id", new ObjectId(torderId));
        upObject.put("status", status);
        boolean update = orderService.update(upObject);
        if(status==1200){
            String openId= (String) dbObject.get("name");
            String orderPrice= (String) dbObject.get("orderPrice");
            BasicDBObject query = new BasicDBObject();
            query.put("name", openId);
            DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_MEMBER);
            java.util.List userList = collection.find(query).toArray();
            DBObject userDeil = (DBObject) userList.get(0);
            int rechage = (int) userDeil.get("recharge");
            int tempRecharge = (int) (Double.parseDouble(orderPrice) * 100);
            rechage += tempRecharge;
            BasicDBObject set = new BasicDBObject("$set", new BasicDBObject("recharge", rechage));
            logger.info("增加积分:"+openId+"更新为："+rechage);
            collection.update(query, set, false, false);
            if(openId.length()>15){
                WeixinMessage.sendOrderFinish(openId,torderId);
            }
        }
        json.setObject(str);
        json.setResult(update);
        return json;
    }

}