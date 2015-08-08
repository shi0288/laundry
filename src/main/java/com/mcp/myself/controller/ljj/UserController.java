package com.mcp.myself.controller.ljj;

import com.mcp.myself.bean.JsonVo;
import com.mcp.myself.service.UserService;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;


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


    @ResponseBody
    @RequestMapping(value = "add.json", method = RequestMethod.POST)
    public JsonVo<DBObject> add(
            @RequestParam(value = "userName") String userName,
            @RequestParam(value = "reUserName") String reUserName,
            HttpServletRequest request) {
        JsonVo<DBObject> json = new JsonVo<DBObject>();
        try {
            //校验
            if (StringUtils.isBlank(userName)) {
                json.setMsg("手机号不能为空");
                json.setResult(false);
                return json;
            }
            if (StringUtils.isBlank(reUserName)) {
                json.setMsg("请再次输入手机号");
                json.setResult(false);
                return json;
            }
            if (!userName.equals(reUserName)) {
                json.setMsg("两次输入不一致");
                json.setResult(false);
                return json;
            }
            DBObject user = new BasicDBObject();
            user.put("userName", userName);
            user.put("passWord", "123321");
            MongoUtil.getDb().getCollection(MongoConst.MONGO_MEMBER).save(user);
            json.setResult(true);
            return json;
        } catch (Exception e) {
            e.printStackTrace();
            json.setResult(false);
            return json;
        }
    }






}
