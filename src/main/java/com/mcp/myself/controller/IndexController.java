package com.mcp.myself.controller;

import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class IndexController {


    @RequestMapping("index.html")
    public String index(ModelMap modelMap) {
        modelMap=this.commonIndex(modelMap);
        return "index";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String init(ModelMap modelMap) {
        modelMap=this.commonIndex(modelMap);
        return "index";
    }

    public ModelMap commonIndex(ModelMap modelMap){
        //模块
        List mainPro= MongoUtil.queryAll(MongoConst.MONGO_MAINPRO,null,"createTime",1);
        modelMap.put("mainPro", mainPro);
        return modelMap;
    }

    @RequestMapping("sort.html")
    public String sort(ModelMap modelMap) {
        return "sort";
    }


    @RequestMapping("haohao/login.html")
    public String ljjAdmin(ModelMap modelMap) {
        return "ljj/login";
    }



}
