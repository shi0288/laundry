package com.mcp.myself.controller;

import com.mcp.myself.service.IndexService;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.DBObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class IndexController {

    @Autowired
    private IndexService indexService;


    @RequestMapping("main.html")
    public String index(ModelMap modelMap) {
        modelMap=indexService.getIndexMainPro(modelMap);
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
        modelMap=indexService.getIndexMainPro(modelMap);
        return "sort";
    }

    @RequestMapping("brand.html")
    public String brand(ModelMap modelMap) {
        modelMap=indexService.getIndexBrand(modelMap);
        return "brand";
    }

    @RequestMapping("product.html")
    public String product(ModelMap modelMap,HttpServletRequest request) {
        modelMap=indexService.getIndexProduct(modelMap, request);
        return "product";
    }

    @RequestMapping("cart.html")
    public String cart(ModelMap modelMap,HttpServletRequest request) {
        return "cart";
    }


    @RequestMapping("conform.html")
    public String conform(ModelMap modelMap,HttpServletRequest request) {
        return "conform";
    }

    @RequestMapping("acount.html")
    public String acount(ModelMap modelMap,HttpServletRequest request) {
        return "acount";
    }

    @RequestMapping("login.html")
    public String login(ModelMap modelMap,HttpServletRequest request) {
        return "login";
    }
    @RequestMapping("regest.html")
    public String regest(ModelMap modelMap,HttpServletRequest request) {
        return "regest";
    }

    @RequestMapping("proDetail.html")
    public String proDetail(String proId,ModelMap modelMap,HttpServletRequest request) {
        DBObject dbObject= MongoUtil.findOne(MongoConst.MONGO_PRODUCT,proId);
        modelMap.put("e",dbObject);
        return "proDetail";
    }


    @RequestMapping("haohao/login.html")
    public String ljjAdmin(ModelMap modelMap) {
        return "ljj/login";
    }
    public static void main(String[] args) {
    }
}
