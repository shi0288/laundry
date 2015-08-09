package com.mcp.myself.service;


import com.mcp.myself.bean.PageVo;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import org.bson.types.ObjectId;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

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
        return modelMap;
    }


}

