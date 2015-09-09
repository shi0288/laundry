package com.mcp.myself.service;

import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by ChubChen on 2015/6/3.
 */

@Service
public class WeiXinService {



    private static final String TOKENID = "TOKEN";

    public static void updateToken (String token){
        DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_WEIXINCONF);
        DBObject find = new BasicDBObject(); //mongodb bean
        find.put("_id",TOKENID);
        DBObject set = new BasicDBObject(); //mongodb bean
        set.put("_id", TOKENID);
        set.put("value", token);
        set.put("updateTime", new Date().getTime());
        collection.findAndModify(find, null, null, false, set, true, true);
    }

    public static void saveToken (String token){
        DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_WEIXINCONF);
        DBObject tokenObj = new BasicDBObject();
        tokenObj.put("_id", TOKENID);
        tokenObj.put("value", token);
        tokenObj.put("updateTime", new Date().getTime());
        collection.save(tokenObj);
    }

    public static Map findToken (){
        DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_WEIXINCONF);
        DBObject find = new BasicDBObject(); //mongodb bean
        find.put("_id",TOKENID);
        DBObject token = collection.findOne(find);
        if (token != null){
            return  token.toMap();
        }else{
            return new HashMap<>();
        }
    }
}
