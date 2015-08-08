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

    public ModelMap getAllListPageMainPro(ModelMap modelMap,HttpServletRequest request) {
        return this.getAllListPage(MongoConst.MONGO_MAINPRO, modelMap, request);
    }


    public DBObject getByIdMainPro(String id) {
        return this.getById(MongoConst.MONGO_MAINPRO,id);
    }



}
