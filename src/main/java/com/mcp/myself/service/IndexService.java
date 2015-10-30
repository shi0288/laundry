package com.mcp.myself.service;


import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import org.bson.types.ObjectId;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by bjjg11 on 2014/8/5.
 */


@Service
public class IndexService extends BaseService {


    public ModelMap getIndexMainPro(ModelMap modelMap) {
        List mainPro = MongoUtil.queryAll(MongoConst.MONGO_MAINPRO, new BasicDBObject().append("status", 0), "createTime", 1);
        for (int i = 0; i < mainPro.size(); i++) {
            DBObject dbObject = (DBObject) mainPro.get(i);
            ObjectId _id = (ObjectId) dbObject.get("_id");
            String mainProId=_id.toString();
            List sortList = MongoUtil.queryAll(MongoConst.MONGO_SORTPRO, new BasicDBObject().append("mainProId", mainProId).append("status", 0), "createTime", 1);
            dbObject.put("sortList", sortList);
        }
        modelMap.put("mainPro",mainPro);

        List pictures = MongoUtil.queryAll(MongoConst.MONGO_PICTURES, new BasicDBObject().append("status", 0), "sort", 1);
        modelMap.put("pictures",pictures);


        Map queryValues =new HashMap();
        queryValues.put("tip",1);
        queryValues.put("status",0);
        List tuijian = MongoUtil.queryForPage(MongoConst.MONGO_PRODUCT, queryValues, 1, 10, "createTime", 1);
        if(tuijian.size()!=10){
            queryValues.remove("tip");
            tuijian=MongoUtil.queryForPage(MongoConst.MONGO_PRODUCT, queryValues, 1, 10, "createTime", 1);
        }
        modelMap.put("tuijian",tuijian);
        return modelMap;
    }



    public ModelMap getIndexBrand(ModelMap modelMap){
        List marks = MongoUtil.queryByGroup(MongoConst.MONGO_SCHOOLS, "mark", new BasicDBObject().append("status", 0));
        modelMap.put("marks", marks);
        Collections.sort(marks);
        for(int i=0;i<marks.size();i++){
            String mark= (String) marks.get(i);
            DBObject dbObject=new BasicDBObject();
            dbObject.put("key", mark);
            List brandList = MongoUtil.queryAll(MongoConst.MONGO_SCHOOLS, new BasicDBObject().append("status", 0).append("mark",mark), "createTime", -1);
            dbObject.put("brandList", brandList);
            marks.remove(i);
            marks.add(i,dbObject);
        }
        return modelMap;
    }

    public ModelMap getIndexAction(ModelMap modelMap){
        DBObject dbObject=new BasicDBObject();
        dbObject.put("status", 0);
        List list=MongoUtil.getDb().getCollection(MongoConst.MONGO_ACTIONS).find(dbObject).toArray();
        modelMap.put("list",list);
        return modelMap;
    }


    public ModelMap getIndexProduct(ModelMap modelMap,HttpServletRequest request){
        modelMap=this.getAllListPage(MongoConst.MONGO_PRODUCT,modelMap,request);
        return modelMap;
    }



}

