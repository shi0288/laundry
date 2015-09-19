package com.mcp.myself.service;


import com.mcp.myself.bean.PageVo;
import com.mcp.myself.constant.SystemConstant;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.WriteResult;
import org.bson.types.ObjectId;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by bjjg11 on 2014/8/5.
 */


public class BaseService {


    public ModelMap getAllListPage(String tableName, ModelMap modelMap, HttpServletRequest request) {
            Enumeration<String> valueNames = request.getParameterNames();
            Map<String, Object> datas = null;
            if (!valueNames.hasMoreElements()) {
            } else {
                datas = new HashMap<String, Object>();
                while (valueNames.hasMoreElements()) {
                    String name = valueNames.nextElement().toString();
                    Object value = request.getParameter(name);
                    if (value != null && !"".equals(value.toString())) {
                        if ("status".equals(name)) {
                            value = Integer.parseInt(value.toString());
                        }else if("tip".equals(name)){
                            value = Integer.parseInt(value.toString());
                        }else if("jump".equals(name)){
                            value = Integer.parseInt(value.toString());
                        }else if("oldPrice".equals(name)){
                            value = Integer.parseInt(value.toString());
                        }else if("price".equals(name)){
                            value = Integer.parseInt(value.toString());
                        }else if("clickNum".equals(name)){
                            value = Integer.parseInt(value.toString());
                        }else if("saleNum".equals(name)){
                            value = Integer.parseInt(value.toString());
                        }else if("orderBy".equals(name)){
                            value = Integer.parseInt(value.toString());
                        }else if("toWhat".equals(name)){
                            value = Integer.parseInt(value.toString());
                        }else if("num".equals(name)){
                            value = Integer.parseInt(value.toString());
                        } else if("payType".equals(name)){
                            value = Integer.parseInt(value.toString());
                        }else if("timestamp".equals(name)){
                            continue;
                        }
                        datas.put(name, value);
                    }
                }
                if(request.getAttribute("toWhat")!=null){
                    datas.put("toWhat", request.getAttribute("toWhat"));
                }
            }
            int p = 1;
            if (datas != null && datas.get("p") != null) {
                p = Integer.parseInt(datas.get("p").toString());
                datas.remove("p");
            }
            Map cond=new HashMap();
            PageVo<DBObject> pageVo = new PageVo<DBObject>(p);
            pageVo.setUrlOrMethod(false);
            pageVo.setRows(SystemConstant.ROW);
            List<DBObject> list = null;
            if (datas == null) {
                list = MongoUtil.queryForPage(tableName, datas, p, pageVo.getRows());
            } else {
                cond.putAll(datas);
                if (datas.get("sortStr") == null) {
                    list = MongoUtil.queryForPage(tableName, datas, p, pageVo.getRows());
                } else {
                    String sortStr = (String) datas.get("sortStr");
                    datas.remove("sortStr");
                    int orderBy = (int) datas.get("orderBy");
                    datas.remove("orderBy");
                    list = MongoUtil.queryForPage(tableName, datas, p, pageVo.getRows(), sortStr, orderBy);
                }
            }
            pageVo.setList(list);
            pageVo.setCount(MongoUtil.queryCount(tableName, datas));
            modelMap.put("pageVo", pageVo);
            modelMap.put("cond", cond);
            modelMap.put("p", p);
        return modelMap;
    }


    public DBObject getById(String tableName, String id) {
        return MongoUtil.findOne(tableName, id);
    }

    public boolean update(String tableName, DBObject dbObject) {
        DBObject query = new BasicDBObject();
        query.put("_id", dbObject.get("_id"));
        dbObject.removeField("_id");
        BasicDBObject set = new BasicDBObject("$set", dbObject);
        DBCollection collection = MongoUtil.getDb().getCollection(tableName);
        WriteResult writeResult = collection.update(query,
                set,
                false,
                false);
        int i = writeResult.getN();
        if (i != 1) {
            return false;
        }
        return true;
    }


}
