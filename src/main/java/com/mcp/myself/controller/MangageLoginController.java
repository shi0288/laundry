package com.mcp.myself.controller;

import com.mcp.myself.bean.JsonVo;
import com.mcp.myself.service.AdminService;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


@Controller
@RequestMapping("manage")
public class MangageLoginController {

    @Autowired
    private AdminService adminService;

    @ResponseBody
    @RequestMapping(value = "admin.json", method = RequestMethod.POST)
    public JsonVo adminLogin(@RequestParam(value = "name") String name,
                             @RequestParam(value = "password") String password,
                             HttpServletRequest request, ModelMap modelMap) {
        JsonVo<String> json = new JsonVo<String>();
        json.setResult(adminService.adminLogin(name,password,request));
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "register.json", method = RequestMethod.POST)
    public JsonVo register(@RequestParam(value = "name") String name,
                             @RequestParam(value = "password") String password) {
        JsonVo<String> json = new JsonVo<String>();
        json.setResult(adminService.register(name, password));
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "login.json", method = RequestMethod.POST)
    public JsonVo login(@RequestParam(value = "name") String name,
                           @RequestParam(value = "password") String password) {
        JsonVo<String> json = new JsonVo<String>();
        json.setResult(adminService.login(name, password));
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "address.json", method = RequestMethod.POST)
    public JsonVo address(@RequestParam(value = "name") String name,
                          @RequestParam(value = "userName") String userName,
                          @RequestParam(value = "mobile") String mobile,
                          @RequestParam(value = "provice") String provice,
                          @RequestParam(value = "where") String where,
                          @RequestParam(value = "first") int first) {
        JsonVo<String> json = new JsonVo<String>();
        json.setResult(adminService.address(name, userName, mobile, provice, where, first));
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "addressList.json", method = RequestMethod.POST)
    public String addressList(@RequestParam(value = "name") String name) {
        DBObject query=new BasicDBObject();
        query.put("name", name);
        List rstList= MongoUtil.queryAll(MongoConst.MONGO_ADDRESS, query, "createTime", -1);
        JSONArray results = new JSONArray();
        for (int i = 0; i < rstList.size(); i++) {
            DBObject obj = (DBObject) rstList.get(i);
            results.put(obj);
        }
        JSONObject json=new JSONObject();
        try {
            json.put("result",true);
            json.put("datas",results);
            return json.toString();
        } catch (JSONException e) {
            e.printStackTrace();
        }
        try {
            json.put("result",false);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return json.toString();
    }

    @ResponseBody
    @RequestMapping(value = "addressPro.json", method = RequestMethod.POST)
    public String addressPro(@RequestParam(value = "name") String name) {
        DBObject query=new BasicDBObject();
        query.put("name", name);
        query.put("status", 0);
        DBObject dbObject= MongoUtil.getDb().getCollection(MongoConst.MONGO_ADDRESS).findOne(query);
        JSONObject json=new JSONObject();
        try {
            json.put("result",true);
            json.put("datas",dbObject);
            return json.toString();
        } catch (JSONException e) {
            e.printStackTrace();
        }
        try {
            json.put("result",false);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return json.toString();
    }

    @ResponseBody
    @RequestMapping(value = "selectAddress.json", method = RequestMethod.POST)
    public JsonVo selectAddress(@RequestParam(value = "name") String name,@RequestParam(value = "id") String id) {
        JsonVo<String> json = new JsonVo<String>();
        json.setResult(adminService.selectAddress(name,id));
        return json;
    }






}
