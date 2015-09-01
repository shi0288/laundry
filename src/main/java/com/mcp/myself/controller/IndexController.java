package com.mcp.myself.controller;

import com.mcp.myself.service.IndexService;
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

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class IndexController {

    @Autowired
    private IndexService indexService;


    @RequestMapping("main.html")
    public String index(ModelMap modelMap) {
        modelMap = indexService.getIndexMainPro(modelMap);
        return "index";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String init(ModelMap modelMap) {
        return "test";
    }

    @RequestMapping(value = "index.html", method = RequestMethod.GET)
    public String test(ModelMap modelMap) {
        return "test";
    }


    @RequestMapping("sort.html")
    public String sort(ModelMap modelMap) {
        modelMap = indexService.getIndexMainPro(modelMap);
        return "sort";
    }

    @RequestMapping("brand.html")
    public String brand(ModelMap modelMap) {
        modelMap = indexService.getIndexBrand(modelMap);
        return "brand";
    }

    @RequestMapping("product.html")
    public String product(ModelMap modelMap, HttpServletRequest request) {
        modelMap = indexService.getIndexMainPro(modelMap);
        modelMap = indexService.getIndexProduct(modelMap, request);
        return "product";
    }

    @RequestMapping("cart.html")
    public String cart(ModelMap modelMap, HttpServletRequest request) {
        return "cart";
    }


    @RequestMapping("conform.html")
    public String conform(ModelMap modelMap, HttpServletRequest request) {
        return "conform";
    }

    @RequestMapping("acount.html")
    public String acount(@RequestParam(value = "name") String name,ModelMap modelMap, HttpServletRequest request) {
        DBObject dbObject=new BasicDBObject();
        dbObject.put("name",name);
        dbObject.put("status", 1000);
        int payNum = MongoUtil.queryCount(MongoConst.MONGO_ORDERS,dbObject);
        dbObject.put("status",1100);
        int waitNum = MongoUtil.queryCount(MongoConst.MONGO_ORDERS,dbObject);
        modelMap.put("payNum", payNum);
        modelMap.put("waitNum", waitNum);
        return "acount";
    }

    @RequestMapping("address.html")
    public String address(ModelMap modelMap, HttpServletRequest request) {
        return "address";
    }

    @RequestMapping("editAddress.html")
    public String editAddress(ModelMap modelMap, HttpServletRequest request) {
        return "editAddress";
    }

    @RequestMapping("updateAddress.html")
    public String updateAddress(@RequestParam(value = "id") String id, ModelMap modelMap) {
        DBObject dbObject = MongoUtil.findOne(MongoConst.MONGO_ADDRESS, id);
        modelMap.put("e", dbObject);
        return "updateAddress";
    }

    @RequestMapping("login.html")
    public String login(ModelMap modelMap, HttpServletRequest request) {
        return "login";
    }

    @RequestMapping("regest.html")
    public String regest(ModelMap modelMap, HttpServletRequest request) {
        return "regest";
    }

    @RequestMapping("orders.html")
    public String orders(@RequestParam(value = "name") String name,@RequestParam(value = "status") int status,ModelMap modelMap, HttpServletRequest request) throws JSONException {
        Map map = new HashMap();
        map.put("name",name);
        if(status!=9999){
            map.put("status",status);
        }
        List list = MongoUtil.queryForPage(MongoConst.MONGO_ORDERS, map, 1, 10, "createTime", -1);
        modelMap.put("e", list);
        return "orders";
    }

    @RequestMapping("proDetail.html")
    public String proDetail(String proId, ModelMap modelMap, HttpServletRequest request) {
        DBObject dbObject = MongoUtil.findOne(MongoConst.MONGO_PRODUCT, proId);
        modelMap.put("e", dbObject);
        return "proDetail";
    }


    @RequestMapping("haohao/login.html")
    public String ljjAdmin(ModelMap modelMap) {
        return "ljj/login";
    }

    public static void main(String[] args) {
    }
}
