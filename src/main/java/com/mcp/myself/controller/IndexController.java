package com.mcp.myself.controller;

import com.mcp.myself.service.IndexService;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class IndexController {

    @Autowired
    private IndexService indexService;


    @RequestMapping("index.html")
    public String index(ModelMap modelMap) {
        modelMap=indexService.getIndexMainPro(modelMap);
        return "index";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String init(ModelMap modelMap) {
        modelMap=indexService.getIndexMainPro(modelMap);
        return "index";
    }


    @RequestMapping("sort.html")
    public String sort(ModelMap modelMap) {
        modelMap=indexService.getIndexMainPro(modelMap);
        return "sort";
    }


    @RequestMapping("haohao/login.html")
    public String ljjAdmin(ModelMap modelMap) {
        return "ljj/login";
    }



}
