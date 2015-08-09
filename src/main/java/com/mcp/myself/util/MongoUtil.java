package com.mcp.myself.util;

import com.mongodb.*;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by bjjg11 on 2014/11/7.
 */
public class MongoUtil {



    public static DB getDb(){
        return MongoManager.getDB(MongoConst.MONGO_NAME);
    }

    public static int queryCount(String table,Map<String,Object> map){
        DBCollection collection = MongoUtil.getDb().getCollection(table);
        BasicDBObject query=new BasicDBObject();
        if(map!=null){
            for(String key:map.keySet()){
                query.append(key,map.get(key));
            }
        }
        int cur = collection.find(query).count();
        return cur;
    }

    public static int queryCount(String table,DBObject query){
        DBCollection collection = MongoUtil.getDb().getCollection(table);
        int cur = collection.find(query).count();
        return cur;
    }

    public static List<DBObject> queryAll(String table,DBObject query,String sort,int seq){
        DBCollection collection = MongoUtil.getDb().getCollection(table);
        DBCursor cur = collection.find(query).sort(new BasicDBObject(sort, seq));
        if(cur.count()==0){
            return new ArrayList<>();
        }
        return cur.toArray();
    }


    public static List<DBObject> queryForPage(String table,Map<String,Object> map,int curPage,int pageSize){
        DBCollection collection = MongoUtil.getDb().getCollection(table);
        BasicDBObject query=new BasicDBObject();
        if(map!=null){
            for(String key:map.keySet()){
                System.out.println(key+"   "+map.get(key));
                query.append(key,map.get(key));
            }
        }
        int skip = (curPage-1) * pageSize;
        String sortStr ="createTime";
        DBCursor cur = collection.find(query).skip(skip).limit(pageSize).sort(new BasicDBObject(sortStr, -1));
        if(cur.count()==0){
            return new ArrayList<>();
        }
        return cur.toArray();
    }

    public static int insert(String table,DBObject dbObject){
        DBCollection collection = MongoUtil.getDb().getCollection(table);
        return collection.insert(dbObject).getN();
    }

    public static int save(String table,DBObject dbObject){
        DBCollection collection = MongoUtil.getDb().getCollection(table);
        return collection.save(dbObject).getN();
    }

    public static DBObject findOne(String table,String id){
        DBCollection collection = MongoUtil.getDb().getCollection(table);
        DBObject query=new BasicDBObject();
        query.put("_id", new ObjectId(id));
        return collection.findOne(query);
    }


}
