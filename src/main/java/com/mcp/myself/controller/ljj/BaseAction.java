package com.mcp.myself.controller.ljj;

import com.mcp.myself.constant.SystemConstant;
import com.mongodb.DBObject;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by Administrator on 2015/4/22.
 */
public class BaseAction {


    /**
     * 从session中获得商户的信息
     *
     * @param request
     * @return
     */
    protected DBObject getAdmin(HttpServletRequest request) {
        DBObject dbObject = (DBObject) request.getSession().getAttribute(
                SystemConstant.SESSION_ADMIN);
        return dbObject;
    }

    protected Map checkMap(Map map){
        if(map==null){
            return null;
        }
        if(map.size()==0){
            return null;
        }
        return map;
    }


}
