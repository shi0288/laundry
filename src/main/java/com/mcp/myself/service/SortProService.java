package com.mcp.myself.service;


import com.mcp.myself.bean.PageVo;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.DBObject;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by bjjg11 on 2014/8/5.
 */


@Service
public class SortProService extends BaseService{

    private String MONGO_NAME=MongoConst.MONGO_SORTPRO;

    public ModelMap getAllListPage(ModelMap modelMap,HttpServletRequest request) {
        modelMap=this.getAllListPage(MONGO_NAME,modelMap,request);
        PageVo<DBObject> pageVo= (PageVo<DBObject>) modelMap.get("pageVo");
        List list=pageVo.getList();
        for(int i=0;i<list.size();i++){
            DBObject dbObject= (DBObject) list.get(i);
            String mainProId= (String) dbObject.get("mainProId");
            DBObject mainPro=MongoUtil.findOne(MongoConst.MONGO_MAINPRO, mainProId);
            dbObject.put("mainPro",mainPro);
        }
        return modelMap;
    }

    public DBObject getById(String id) {
        return this.getById(MONGO_NAME, id);
    }


    public boolean update(DBObject dbObject) {
        return this.update(MONGO_NAME, dbObject);
    }


}

