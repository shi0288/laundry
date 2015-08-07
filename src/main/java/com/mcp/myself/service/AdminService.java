package com.mcp.myself.service;


import com.mcp.myself.constant.SystemConstant;
import com.mcp.myself.util.MD5;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
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
            DBObject dbObject = (DBObject)list.get(0);
            HttpSession session = request.getSession();
            dbObject.removeField("password");
            session.setAttribute(SystemConstant.SESSION_ADMIN,
                    dbObject);
            return true;
        }
        return false;
    }


}
