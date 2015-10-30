package com.mcp.myself.controller.sale;

import com.mcp.myself.bean.JsonVo;
import com.mcp.myself.controller.ljj.BaseAction;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.*;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.bson.types.ObjectId;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("sale/order")
public class WaitOrderController extends BaseAction {

    private static Logger logger = Logger.getLogger(WaitOrderController.class);


    @RequestMapping(value = "waitOrder.htm", method = RequestMethod.GET)
        public String list(
            HttpServletRequest request, ModelMap modelMap,String id) {

        DBObject query=new BasicDBObject();
        String saleId= (String) request.getSession().getAttribute("saleId");
        query.put("schoolId", saleId);
        query.put("status", 1101);
        List list = MongoUtil.getDb().getCollection(MongoConst.MONGO_ORDERS).find(query).skip(0).limit(20).toArray();
        modelMap.put("e", list);
        if(id !=null){
            DBObject dbObject= MongoUtil.findOne(MongoConst.MONGO_ORDERS, id);
            modelMap.put("order",dbObject);
            modelMap.put("idStr",id);
        }else{
            if(list.size()>0){
                modelMap.put("order",list.get(0));
            }
        }
        return "sale/orders/waitOrder";
    }

    @RequestMapping(value = "dealOrder.htm", method = RequestMethod.GET)
    public String dealOrder(
            HttpServletRequest request, ModelMap modelMap, String id) {
        DBObject query=new BasicDBObject();
        BasicDBList values = new BasicDBList();
        values.add(new BasicDBObject("status", 1200));
        values.add(new BasicDBObject("status", 1300));
        String saleId= (String) request.getSession().getAttribute("saleId");
        query.put("schoolId", saleId);
        query.put("$or", values);
        List list = MongoUtil.getDb().getCollection(MongoConst.MONGO_ORDERS).find(query).skip(0).limit(20).sort(new BasicDBObject("createTime", -1)).toArray();
        modelMap.put("e", list);
        if(id !=null){
            DBObject dbObject= MongoUtil.findOne(MongoConst.MONGO_ORDERS, id);
            modelMap.put("order",dbObject);
            modelMap.put("idStr",id);
        }else{
            if(list.size()>0){
                modelMap.put("order",list.get(0));
            }
        }
        return "sale/orders/dealOrder";
    }


    @RequestMapping(value = "saleNumbers.htm", method = RequestMethod.GET)
    public String saleNumbers(
            HttpServletRequest request, ModelMap modelMap) {
        DBObject query=new BasicDBObject();
        String saleId= (String) request.getSession().getAttribute("saleId");
        query.put("schoolId", saleId);
        query.put("status", 1101);
        MongoUtil.queryCount(MongoConst.MONGO_ORDERS, query);
        List one=MongoUtil.query(MongoConst.MONGO_ORDERS, query);
        int oneNum=0;
        for(int i=0;i<one.size();i++){
            DBObject dbObject= (DBObject) one.get(i);
            String temp= (String) dbObject.get("orderPrice");
            double tempDouble=Double.parseDouble(temp);
            int tempInt= (int) (tempDouble*100);
            oneNum+=tempInt;
        }
        modelMap.put("one",one.size());
        modelMap.put("oneNum",oneNum);

        query.put("status", 1200);
        MongoUtil.queryCount(MongoConst.MONGO_ORDERS, query);
        List two=MongoUtil.query(MongoConst.MONGO_ORDERS, query);
        int twoNum=0;
        for(int i=0;i<two.size();i++){
            DBObject dbObject= (DBObject) two.get(i);
            String temp= (String) dbObject.get("orderPrice");
            double tempDouble=Double.parseDouble(temp);
            int tempInt= (int) (tempDouble*100);
            twoNum+=tempInt;
        }
        modelMap.put("two",two.size());
        modelMap.put("twoNum",twoNum);

        query.put("status", 1300);
        MongoUtil.queryCount(MongoConst.MONGO_ORDERS, query);
        List three=MongoUtil.query(MongoConst.MONGO_ORDERS, query);
        int threeNum=0;
        for(int i=0;i<three.size();i++){
            DBObject dbObject= (DBObject) three.get(i);
            String temp= (String) dbObject.get("orderPrice");
            double tempDouble=Double.parseDouble(temp);
            int tempInt= (int) (tempDouble*100);
            threeNum+=tempInt;
        }
        modelMap.put("three",three.size());
        modelMap.put("threeNum",threeNum);

        return "sale/orders/saleNumbers";
    }


    /**
     * 更新
     */
    @ResponseBody
    @RequestMapping("updateStatus.json")
    public JsonVo<DBObject> updateEntity(String id,int status,HttpServletRequest request) throws
            IOException {
        //获取文件 存储位置
        JsonVo<DBObject> json = new JsonVo<DBObject>();
        //校验
        if (StringUtils.isBlank(id)) {
            json.setMsg("id不能为空");
            json.setResult(false);
            return json;
        }
        DBObject query = new BasicDBObject();
        query.put("_id", new ObjectId(id));
        DBObject dbObject = new BasicDBObject();
        dbObject.put("status", status);
        BasicDBObject set = new BasicDBObject("$set", dbObject);
        DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_ORDERS);
        WriteResult writeResult = collection.update(query, set, false, false);
        int i = writeResult.getN();
        if (i != 1) {
            json.setResult(false);
            return json;
        }
        json.setResult(true);
        return json;
    }





}