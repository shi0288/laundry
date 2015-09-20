package com.mcp.myself.service;


import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by bjjg11 on 2014/8/5.
 */


@Service
public class OrderService extends BaseService{

    private String MONGO_NAME=MongoConst.MONGO_ORDERS;


    public ModelMap getAllListPage(ModelMap modelMap,HttpServletRequest request) {
        return this.getAllListPage(MONGO_NAME, modelMap, request);
    }
    public DBObject getById(String id) {
        return this.getById(MONGO_NAME, id);
    }
    public boolean update(DBObject dbObject) {
        return this.update(MONGO_NAME, dbObject);
    }
    public List<DBObject> getByName(String name) {
        DBObject findObject = new BasicDBObject();
        findObject.put("userName", name);
        findObject.put("activeState", 1);
        return MongoUtil.query(MongoConst.MONGO_ACTIVITY,findObject);
    }


}

