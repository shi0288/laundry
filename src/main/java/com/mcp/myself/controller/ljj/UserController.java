package com.mcp.myself.controller.ljj;

import com.mcp.myself.bean.PageVo;
import com.mcp.myself.service.UserService;
import com.mongodb.DBObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.Map;


@Controller
@RequestMapping("ljj/user")
public class UserController extends  BaseAction{


    @Autowired
    private UserService userService;


    /**
     * 进入用户列表
     */
    @RequestMapping(value = "list.htm", method = RequestMethod.GET)
    public String list(
            HttpServletRequest request, ModelMap modelMap) {
        Enumeration<String> valueNames = request.getParameterNames();
        Map datas = this.packageDatas(valueNames, request);
        int p=0;
        if (datas !=null && datas.get("p")!=null) {
            p=Integer.parseInt(datas.get("p").toString());
            datas.remove("p");
        }
        PageVo<DBObject> pageVo = userService.getAllListPage(p, this.checkMap(datas));
        modelMap.put("pageVo", pageVo);
        modelMap.put("cond",datas);
        modelMap.put("p", p);
        return "ljj/user/list";
    }



}
