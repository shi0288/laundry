package com.mcp.myself.service;


import com.mcp.myself.util.MongoConst;
import com.mongodb.DBObject;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by bjjg11 on 2014/8/5.
 */


@Service
public class MainProService extends BaseService{


    private String MONGO_NAME=MongoConst.MONGO_MAINPRO;


    public ModelMap getAllListPage(ModelMap modelMap,HttpServletRequest request) {
        return this.getAllListPage(MONGO_NAME,modelMap,request);
    }

    public DBObject getById(String id) {
        return this.getById(MONGO_NAME, id);
    }


    public boolean update(DBObject dbObject) {
        return this.update(MONGO_NAME, dbObject);
    }



}
