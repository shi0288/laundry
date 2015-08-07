package com.mcp.myself.controller;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.Resource;


@Controller
public class IndexController {

    @RequestMapping("index.html")
    public String index(ModelMap modelMap) {
        System.out.println("----------   start");
        System.out.println("----------   end");
        modelMap.put("username", "asdasdasd");
        modelMap.put("password", "asdasdasdas");
        return "index";
    }

    @RequestMapping("/")
    public String init(ModelMap modelMap) {
        System.out.println("----------   start");
        System.out.println("----------   end");
        modelMap.put("username", "asdasdasd");
        modelMap.put("password", "asdasdasdas");
        return "index";
    }

    @RequestMapping("bid.html")
    public String bid(ModelMap modelMap) {
        System.out.println("----------   start");
        System.out.println("----------   end");
        modelMap.put("username", "asdasdasd");
        modelMap.put("password", "asdasdasdas");
        return "bid";
    }



}
