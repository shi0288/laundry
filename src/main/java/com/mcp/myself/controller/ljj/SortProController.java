package com.mcp.myself.controller.ljj;

import com.mcp.myself.bean.JsonVo;
import com.mcp.myself.constant.SystemConstant;
import com.mcp.myself.service.MainProService;
import com.mcp.myself.service.SortProService;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import org.apache.commons.lang3.StringUtils;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("ljj/sortPro")
public class SortProController extends BaseAction {


    @Autowired
    private SortProService sortProService;

    @RequestMapping(value = "list.htm", method = RequestMethod.GET)
    public String list(
            HttpServletRequest request, ModelMap modelMap) {
        modelMap = sortProService.getAllListPage(modelMap, request);
        List mainPro= MongoUtil.queryAll(MongoConst.MONGO_MAINPRO,null,"createTime",1);
        modelMap.put("mainPro", mainPro);
        return "ljj/sortPro/list";
    }

    @ResponseBody
    @RequestMapping("add.json")
    public JsonVo<DBObject> add(String name,String mainProId,int status,int tip) {
        JsonVo<DBObject> json = new JsonVo<DBObject>();
        //校验
        if (StringUtils.isBlank(name)) {
            json.setMsg("名字不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(mainProId)) {
            json.setMsg("所属主题不能为空");
            json.setResult(false);
            return json;
        }
        DBObject dbObject = new BasicDBObject();
        dbObject.put("name", name);
        dbObject.put("mainProId", mainProId);
        dbObject.put("status", status);
        dbObject.put("tip", tip);
        dbObject.put("createTime",System.currentTimeMillis());
        MongoUtil.getDb().getCollection(MongoConst.MONGO_SORTPRO).insert(dbObject);
        json.setResult(true);
        return json;
    }


    /**
     * 进入更新
     */
    @RequestMapping(value = "update.htm", method = RequestMethod.GET)
    public String update(@RequestParam(value = "id") String id,
                         ModelMap modelMap) {
        DBObject dbObject = sortProService.getById(id);
        List mainPro= MongoUtil.queryAll(MongoConst.MONGO_MAINPRO, null, "createTime", 1);
        modelMap.put("mainPro", mainPro);
        modelMap.put("e", dbObject);
        return "ljj/sortPro/update";
    }


    /**
     * 更新
     */
    @ResponseBody
    @RequestMapping("update.json")
    public JsonVo<DBObject> updateEntity(String id,String name,String mainProId,int status,int tip) throws IllegalStateException,
            IOException {
        //获取文件 存储位置
        JsonVo<DBObject> json = new JsonVo<DBObject>();
        if (StringUtils.isBlank(id)) {
            json.setMsg("id不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(name)) {
            json.setMsg("名字不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(mainProId)) {
            json.setMsg("所属主题不能为空");
            json.setResult(false);
            return json;
        }
        DBObject dbObject=new BasicDBObject();
        dbObject.put("_id",new ObjectId(id));
        dbObject.put("name", name);
        dbObject.put("mainProId", mainProId);
        dbObject.put("status", status);
        dbObject.put("tip", tip);
        json.setResult(sortProService.update(dbObject));
        return json;
    }


}