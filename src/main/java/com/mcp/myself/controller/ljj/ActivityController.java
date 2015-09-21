package com.mcp.myself.controller.ljj;

import com.mcp.myself.bean.Activity;
import com.mcp.myself.bean.JsonVo;
import com.mcp.myself.service.ActivityService;
import com.mongodb.DBObject;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;

@Controller
@RequestMapping("activity")
public class ActivityController extends BaseAction {


    private static Logger logger = Logger.getLogger(ActivityController.class);


    @Autowired
    private ActivityService activityService;

    @ResponseBody
    @RequestMapping("choujiang.json")
    public JsonVo<DBObject> waBao(String body) throws IOException {
        Activity activity = new Activity();
        JsonVo json = new JsonVo();
        System.out.println("body:"+body);
        JSONObject jsonObject = JSONObject.fromObject(body);
        String userName = jsonObject.getString("userName");
        String activeId = jsonObject.getString("activeId");
        String passWord = jsonObject.getString("passWord");
        String actitityType = jsonObject.getString("actitityType");
        //1.判断是否登录
        if("".equals(userName)||"".equals(passWord)){
            json.setResult(false);
            json.setMsg("还未登录");
            return json;
        }
        boolean userInfo = activityService.getUser(userName, passWord);
//        if(!userInfo){
//            json.setResult(false);
//            json.setMsg("查无此用户");
//            return json;
//        }
        //2.判断今天是否领取，领取返回提示已经领取
        activity = activityService.waBao(userName, activeId);
        if(!activity.isCheck()){
            json.setResult(true);
            json.setMsg("亲，今日已经挖过宝达到三次，明日再来！");
            json.setObject(activity);
            return json;
        }
        //3.没有领取调用抽奖算法
        json.setResult(true);
        json.setMsg("恭喜你挖宝成功");
        json.setObject(activity);
        return json;
    }

    @ResponseBody
    @RequestMapping("guaguale.json")
    public JsonVo<DBObject> ggLe(String body) throws IOException {
        Activity activity = new Activity();
        JsonVo json = new JsonVo();
        JSONObject jsonObject = JSONObject.fromObject(body);
        String userName = jsonObject.getString("userName");
        String activeId = jsonObject.getString("activeId");
        String passWord = jsonObject.getString("passWord");
        String actitityType = jsonObject.getString("actitityType");
        //1.判断是否登录
        if("".equals(userName)||"".equals(passWord)){
            json.setResult(false);
            json.setMsg("还未登录");
            return json;
        }
        boolean userInfo = activityService.getUser(userName, passWord);
//        if(!userInfo){
//            json.setResult(false);
//            json.setMsg("查无此用户");
//            return json;
//        }
        //2.判断今天是否领取，领取返回提示已经领取
        activity = activityService.guagLe(userName, activeId);
        if(!activity.isCheck()){
            json.setResult(true);
            json.setMsg("亲，今日已经过了");
            json.setObject(activity);
            return json;
        }
        //3.没有领取调用抽奖算法
        json.setResult(true);
        json.setMsg("恭喜你刮奖成功成功");
        json.setObject(activity);
        return json;
    }

    @ResponseBody
    @RequestMapping("zhuanpan.json")
    public JsonVo<DBObject> zhuanPan(String body) throws IOException {
        Activity activity = new Activity();
        JsonVo json = new JsonVo();
        JSONObject jsonObject = JSONObject.fromObject(body);
        String userName = jsonObject.getString("userName");
        String activeId = jsonObject.getString("activeId");
        //1.判断是否登录
        if(userName==null||"".equals(userName)){
            json.setResult(false);
            json.setMsg("您尚未登陆");
            return json;
        }
//        boolean userInfo = activityService.getUser(userName, passWord);
//        if(!userInfo){
//            json.setResult(false);
//            json.setMsg("查无此用户");
//            return json;
//        }
        //2.判断是否符合抽奖条件
        activity = activityService.zhuanP(userName, activeId);
        if(!activity.isCheck()){
            json.setResult(true);
            json.setMsg("亲，下单购买之后就有机会哦！");
            json.setObject(activity);
            return json;
        }
        //3.没有领取调用抽奖算法
        json.setResult(true);
        json.setMsg("恭喜你抽奖成功成功");
        json.setObject(activity);
        return json;
    }
}