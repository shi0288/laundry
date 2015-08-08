package com.mcp.myself.service;


import com.mcp.myself.bean.PageVo;
import com.mcp.myself.constant.SystemConstant;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.DBObject;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by bjjg11 on 2014/8/5.
 */


public class BaseService {

    public ModelMap getAllListPage(String tableName,ModelMap modelMap,HttpServletRequest request) {

        Enumeration<String> valueNames = request.getParameterNames();
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
        int p=1;
        if (datas !=null && datas.get("p")!=null) {
            p=Integer.parseInt(datas.get("p").toString());
            datas.remove("p");
        }
        PageVo<DBObject> pageVo = new PageVo<DBObject>(p);
        pageVo.setUrlOrMethod(false);
        pageVo.setRows(SystemConstant.ROW);
        List<DBObject> list = MongoUtil.queryForPage(tableName, datas, p, pageVo.getRows());
        pageVo.setList(list);
        pageVo.setCount(MongoUtil.queryCount(tableName, datas));
        modelMap.put("pageVo", pageVo);
        modelMap.put("cond", datas);
        modelMap.put("p", p);
        return modelMap;
    }



    public DBObject getById(String tableName,String id) {
        return MongoUtil.findOne(tableName, id);
    }

}
