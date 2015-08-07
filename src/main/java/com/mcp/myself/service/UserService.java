package com.mcp.myself.service;


import com.mcp.myself.bean.PageVo;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by bjjg11 on 2014/8/5.
 */


@Service
public class UserService {

    /**
     * 获得所有的分页
     */
    public PageVo<DBObject> getAllListPage(int pageNum,Map map) {
        PageVo<DBObject> pageVo = new PageVo<DBObject>(pageNum);
        pageVo.setUrlOrMethod(false);
        pageVo.setRows(5);
        Map<String,Object> params=new HashMap<String, Object>();
        params.put("relationMap", map);
        params.put("offset", pageVo.getOffset());
        params.put("rows", pageVo.getRows());
        List<DBObject> list = MongoUtil.queryForPage(MongoConst.MONGO_MEMBER, map, pageNum, pageVo.getRows());
        pageVo.setList(list);
        pageVo.setCount(MongoUtil.queryCount(MongoConst.MONGO_MEMBER,map));
        return pageVo;
    }

}
