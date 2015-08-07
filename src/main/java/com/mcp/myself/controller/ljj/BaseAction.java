package com.mcp.myself.controller.ljj;

import com.mcp.myself.constant.SystemConstant;
import com.mongodb.DBObject;
import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.HashMap;
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


    protected Map packageDatas(Enumeration<String> valueNames,
                                    HttpServletRequest request) {
        Map<String,Object> datas = null;
        if (!valueNames.hasMoreElements()) {
        } else {
            datas = new HashMap<String,Object>();
            while (valueNames.hasMoreElements()) {
                String name = valueNames.nextElement().toString();
                Object value = request.getParameter(name);
                if (value!=null&&!"".equals(value.toString())) {
                    datas.put(name, value);
                }
            }
        }
        return datas;
    }

}
