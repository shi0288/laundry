package com.mcp.myself.controller.ljj;

import com.mcp.myself.constant.SystemConstant;
import com.mcp.myself.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
@RequestMapping("ljj/user")
public class UserController extends  BaseAction{




    @Autowired
    private UserService userService;

    @RequestMapping(value = "list.htm", method = RequestMethod.GET)
    public String list(
            HttpServletRequest request, ModelMap modelMap) {
        modelMap=userService.getAllListPageUser(modelMap,request);
        return "ljj/user/list";
    }



    @RequestMapping(value = "logout.htm", method = RequestMethod.GET)
    public String logout(
            HttpServletRequest request, ModelMap modelMap) {

        HttpSession session = request.getSession();
        session.removeAttribute(SystemConstant.SESSION_ADMIN);
        return "redirect:/haohao/login.html";
    }








}
