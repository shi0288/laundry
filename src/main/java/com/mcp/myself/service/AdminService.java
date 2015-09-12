package com.mcp.myself.service;


import com.mcp.myself.constant.SystemConstant;
import com.mcp.myself.util.MD5;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.WriteResult;
import org.bson.types.ObjectId;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Created by bjjg11 on 2014/8/5.
 */


@Service
public class AdminService {

    /**
     * @param name
     * @param password
     * @param request
     */
    public boolean adminLogin(String name, String password,
                              HttpServletRequest request) {
        DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_ADMIN);
        BasicDBObject query = new BasicDBObject();
        query.put("name", name);
        query.put("password", MD5.MD5Encode(password));
        List list = collection.find(query).toArray();
        if (list.size() == 1) {
            DBObject dbObject = (DBObject) list.get(0);
            HttpSession session = request.getSession();
            dbObject.removeField("password");
            session.setAttribute(SystemConstant.SESSION_ADMIN,
                    dbObject);
            return true;
        }
        return false;
    }

    public boolean register(String name, String password) {
        DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_MEMBER);
        BasicDBObject query = new BasicDBObject();
        query.put("name", name);
        List list = collection.find(query).toArray();
        if (list.size() == 0) {
            query.put("password", MD5.MD5Encode(password));
            collection.insert(query);
            return true;
        }
        return false;
    }


    public boolean updatePassWord(String name, String password) {
        DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_MEMBER);
        BasicDBObject query = new BasicDBObject();
        query.put("name", name);
        List list = collection.find(query).toArray();
        if (list.size() == 1) {
            BasicDBObject set = new BasicDBObject("$set", new BasicDBObject("password",  MD5.MD5Encode(password)));
            collection.update(query, set, false, false);
            return true;
        }
        return false;
    }


    public boolean updateNum(String id, int num,boolean is) {
        DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_PRODUCT);
        BasicDBObject query = new BasicDBObject();
        query.put("_id", new ObjectId(id));
        List list = collection.find(query).toArray();
        if (list.size() == 1) {
            DBObject dbObject= (DBObject) list.get(0);
            int numTemp= (int) dbObject.get("num");
            int saleNum= (int) dbObject.get("saleNum");
            BasicDBObject set =null;
            if(is){
                set= new BasicDBObject("$set", new BasicDBObject("num", numTemp+num));
            }else{
                set= new BasicDBObject("$set", new BasicDBObject("num", numTemp-num).append("saleNum",saleNum+num));
            }
            collection.update(query, set, false, false);
            return true;
        }
        return false;
    }


    public boolean address(String name, String userName, String mobile, String provice, String where, int first) {
        DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_ADDRESS);
        BasicDBObject query = new BasicDBObject();
        query.put("name", name);
        long i=collection.count(query);
        if(i==0){
            query.put("status", 0);
            query.put("userName", userName);
            query.put("mobile", mobile);
            query.put("provice", provice);
            query.put("where", where);
            query.put("createTime", System.currentTimeMillis());
            collection.insert(query);
            return true;
        }
        if (first == 0) {
            query.put("status", 0);
            BasicDBObject set = new BasicDBObject("$set", new BasicDBObject("status", 1));
            collection.update(query, set, false, false);
        }
        query.put("status", first);
        query.put("userName", userName);
        query.put("mobile", mobile);
        query.put("provice", provice);
        query.put("where", where);
        query.put("createTime", System.currentTimeMillis());
        collection.insert(query);
        return true;
    }

    public boolean updateAddress(String name, String id,String userName, String mobile, String provice, String where, int first) {
        DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_ADDRESS);
        BasicDBObject query = new BasicDBObject();
        query.put("_id", new ObjectId(id));
        long i=collection.count(query);
        if (i==1) {
            if (first == 0) {
                DBObject temp=new BasicDBObject();
                temp.put("status", 0);
                temp.put("name", name);
                BasicDBObject set = new BasicDBObject("$set", new BasicDBObject("status", 1));
                collection.update(temp, set, false, false);
            }
            DBObject setObj=new BasicDBObject();
            setObj.put("status", first);
            setObj.put("userName", userName);
            setObj.put("mobile", mobile);
            setObj.put("provice", provice);
            setObj.put("where", where);
            BasicDBObject set = new BasicDBObject("$set", setObj);
            collection.update(query, set, false, false);
            return true;
        }
        return false;
    }

    public boolean removeAddress(String name, String id,String userName, String mobile, String provice, String where, int first) {
        DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_ADDRESS);
        BasicDBObject query = new BasicDBObject();
        query.put("_id", new ObjectId(id));
        long i=collection.count(query);
        if (i==1) {
            DBObject setObj=new BasicDBObject();
            setObj.put("status", first);
            setObj.put("userName", userName);
            setObj.put("mobile", mobile);
            setObj.put("provice", provice);
            setObj.put("where", where);
            BasicDBObject set = new BasicDBObject("$set", setObj);
            collection.update(query, set, false, false);
            return true;
        }
        return false;
    }


    public boolean selectAddress(String name,String id) {
        DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_ADDRESS);
        BasicDBObject query = new BasicDBObject();
        query.put("name", name);
        query.put("status", 0);
        BasicDBObject set = new BasicDBObject("$set", new BasicDBObject("status", 1));
        collection.update(query, set, false, false);
        BasicDBObject tempQuery = new BasicDBObject();
        tempQuery.put("_id", new ObjectId(id));
        BasicDBObject tempSet = new BasicDBObject("$set", new BasicDBObject("status", 0));
        collection.update(tempQuery, tempSet, false, false);
        return true;
    }

    public boolean login(String name, String password) {
        DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_MEMBER);
        BasicDBObject query = new BasicDBObject();
        query.put("name", name);
        query.put("password", MD5.MD5Encode(password));
        List list = collection.find(query).toArray();
        if (list.size() == 1) {
            return true;
        }
        return false;
    }


}
