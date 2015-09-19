package com.mcp.myself.controller.ljj;

import com.mcp.myself.bean.JsonVo;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import org.apache.log4j.Logger;
import org.bson.types.ObjectId;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.DecimalFormat;
import java.util.List;

@Controller
@RequestMapping("ljj/initPrice")
public class IninPriceController extends BaseAction {



    private static Logger logger =Logger.getLogger(IninPriceController.class);

    /**
     * 进入更新
     */
    @RequestMapping(value = "update.htm", method = RequestMethod.GET)
    public String update(ModelMap modelMap) {
        DBCursor dbCursor= MongoUtil.getDb().getCollection(MongoConst.MONGO_INITPRICE).find();
        List list=dbCursor.toArray();
        if(list.size()==1){
            DBObject dbObject= (DBObject) list.get(0);
            modelMap.put("e", dbObject);
        }
        return "ljj/initPrice/update";
    }

    /**
     * 更新
     */
    @ResponseBody
    @RequestMapping("update.json")
    public JsonVo<DBObject> update(String id,double price,double sendPrice){
        JsonVo jsonVo=new JsonVo();
        DecimalFormat df = new DecimalFormat("######0.00");
        //获取文件 存储位置
        if("9999".equals(id)){
            //添加
            DBObject dbObject = new BasicDBObject();
            dbObject.put("price", df.format(price));
            dbObject.put("sendPrice", df.format(sendPrice));
            MongoUtil.getDb().getCollection(MongoConst.MONGO_INITPRICE).insert(dbObject);
            jsonVo.setResult(true);
            return jsonVo;
        }
        //更新
        DBObject dbObject = new BasicDBObject();
        dbObject.put("price", df.format(price));
        dbObject.put("initPrice", df.format(sendPrice));
        DBObject query = new BasicDBObject();
        query.put("_id", new ObjectId(id));
        BasicDBObject tempSet = new BasicDBObject("$set", dbObject);
        MongoUtil.getDb().getCollection(MongoConst.MONGO_INITPRICE).update(query, tempSet, false, false);
        jsonVo.setResult(true);
        return jsonVo;
    }


}