package com.mcp.myself.controller.ljj;

import com.mcp.myself.bean.JsonVo;
import com.mcp.myself.constant.SystemConstant;
import com.mcp.myself.service.BrandService;
import com.mcp.myself.util.ChinaInitial;
import com.mcp.myself.util.MD5;
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

@Controller
@RequestMapping("ljj/brand")
public class BrandController extends BaseAction {


    @Autowired
    private BrandService brandService;

    @RequestMapping(value = "list.htm", method = RequestMethod.GET)
    public String list(
            HttpServletRequest request, ModelMap modelMap) {
        modelMap = brandService.getAllListPage(modelMap, request);
        return "ljj/brand/list";
    }

    @ResponseBody
    @RequestMapping("add.json")
    public JsonVo<DBObject> add(String name,int status,String userName,String passWord,HttpServletRequest request) throws
            IOException{
        JsonVo<DBObject> json = new JsonVo<DBObject>();

        //校验
        if (StringUtils.isBlank(name)) {
            json.setMsg("名字不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(userName)) {
            json.setMsg("用户名不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(passWord)) {
            json.setMsg("密码不能为空");
            json.setResult(false);
            return json;
        }
        DBObject dbObject = new BasicDBObject();
        dbObject.put("name", name);
        dbObject.put("status", status);
        dbObject.put("userName", userName);
        dbObject.put("passWord", MD5.MD5Encode(passWord));
        String mark = ChinaInitial.getPYIndexStr(name.split("")[1],true);
        if(mark!=null&&!"".equals(mark)){
            try {
                int _rst=Integer.parseInt(mark);
                mark="ZZ";
            }catch (NumberFormatException e){
            }
            dbObject.put("mark", mark);
        }
        dbObject.put("createTime",System.currentTimeMillis());
        MongoUtil.getDb().getCollection(MongoConst.MONGO_SCHOOLS).insert(dbObject);
        json.setResult(true);
        return json;
    }


    /**
     * 进入更新
     */
    @RequestMapping(value = "update.htm", method = RequestMethod.GET)
    public String update(@RequestParam(value = "id") String id,
                         ModelMap modelMap) {
        DBObject dbObject = brandService.getById(id);
        modelMap.put("e", dbObject);
        return "ljj/brand/update";
    }


    /**
     * 更新
     */
    @ResponseBody
    @RequestMapping("update.json")
    public JsonVo<DBObject> updateEntity(String id,String name,String userName,String passWord,String mark,int status,HttpServletRequest request) throws
            IOException {
        //获取文件 存储位置
        JsonVo<DBObject> json = new JsonVo<DBObject>();
        //校验
        if (StringUtils.isBlank(name)) {
            json.setMsg("名字不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(id)) {
            json.setMsg("id不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(userName)) {
            json.setMsg("用户名不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(passWord)) {
            json.setMsg("密码不能为空");
            json.setResult(false);
            return json;
        }
        DBObject dbObject = new BasicDBObject();
        dbObject.put("_id",new ObjectId(id));
        dbObject.put("name", name);
        dbObject.put("userName", userName);
        dbObject.put("passWord", MD5.MD5Encode(passWord));
        dbObject.put("status", status);
        dbObject.put("mark", mark);
        json.setResult(brandService.update(dbObject));
        return json;
    }


}