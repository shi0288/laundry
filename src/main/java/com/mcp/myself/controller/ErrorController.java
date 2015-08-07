package com.mcp.myself.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/error")
public class ErrorController {


    @RequestMapping("404.htm")
    public String e404(ModelMap modelMap) {
        return "error/404";
    }

    @RequestMapping("503.htm")
    public String e503(ModelMap modelMap) {
        return "error/503";
    }




}
