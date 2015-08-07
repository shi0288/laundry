package com.mcp.myself.controller;

import com.mcp.myself.bean.JsonVo;
import com.mcp.myself.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;


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
        System.out.println(json.isResult());
        return json;
    }




}