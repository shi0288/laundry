package com.mcp.myself.controller;

import com.mcp.myself.bean.JsonVo;
import com.mcp.myself.bean.PageVo;
import com.mcp.myself.service.IndexService;
import com.mcp.myself.util.DigestPassDeom;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import org.bson.types.ObjectId;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class IndexController {

    @Autowired
    private IndexService indexService;


    @RequestMapping("main.html")
    public String index(ModelMap modelMap) {
        modelMap = indexService.getIndexMainPro(modelMap);
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
        modelMap = indexService.getIndexMainPro(modelMap);
        return "sort";
    }

    @RequestMapping("brand.html")
    public String brand(ModelMap modelMap) {
        modelMap = indexService.getIndexBrand(modelMap);
        return "brand";
    }

    @RequestMapping("product.html")
    public String product(ModelMap modelMap, HttpServletRequest request) {
        modelMap = indexService.getIndexMainPro(modelMap);
        request.setAttribute("toWhat", 0);
        modelMap = indexService.getIndexProduct(modelMap, request);
        return "product";
    }

    @RequestMapping("cart.html")
    public String cart(ModelMap modelMap, HttpServletRequest request) {
        return "cart";
    }


    @RequestMapping("conform.html")
    public String conform(ModelMap modelMap, HttpServletRequest request) {
        return "conform";
    }

    @RequestMapping("tuan.html")
    public String tuan(ModelMap modelMap, HttpServletRequest request) {
        request.setAttribute("toWhat", 1);
        modelMap = indexService.getIndexProduct(modelMap, request);
        return "tuan";
    }

    @ResponseBody
    @RequestMapping(value = "tuanP.json", method = RequestMethod.POST)
    public JsonVo tuanP(ModelMap modelMap, HttpServletRequest request) {
        JsonVo<String> json = new JsonVo<String>();
        request.setAttribute("toWhat", 1);
        modelMap = indexService.getIndexProduct(modelMap, request);
        List list = ((PageVo) modelMap.get("pageVo")).getList();
        for (int oo = 0; oo < list.size(); oo++) {
            DBObject dbObject = (DBObject) list.get(oo);
            list.set(oo, dbObject.toString());
        }
        json.setObject(list);
        json.setResult(true);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "pP.json", method = RequestMethod.POST)
    public JsonVo pP(ModelMap modelMap, HttpServletRequest request) {
        JsonVo<String> json = new JsonVo<String>();
        request.setAttribute("toWhat", 0);
        modelMap = indexService.getIndexProduct(modelMap, request);
        List list = ((PageVo) modelMap.get("pageVo")).getList();
        for (int oo = 0; oo < list.size(); oo++) {
            DBObject dbObject = (DBObject) list.get(oo);
            list.set(oo, dbObject.toString());
        }
        json.setObject(list);
        json.setResult(true);
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "sendMsg.json", method = RequestMethod.POST)
    public JsonVo sendMsg(ModelMap modelMap, String r_captcha, String r_mobile, HttpServletRequest request) {
        JsonVo<String> json = new JsonVo<String>();
        if (r_captcha == null || "".equals(r_captcha)) {
            json.setResult(false);
            json.setMsg("验证码不能为空");
            return json;
        }
        if (r_mobile == null || "".equals(r_mobile)) {
            json.setResult(false);
            json.setMsg("手机号不能为空");
            return json;
        }
        HttpSession session = request.getSession();
        String captcha = (String) session.getAttribute("CODE");
        if (captcha == null) {
            json.setResult(false);
            json.setMsg("验证码已失效，请重新获取");
            return json;
        }

        if (captcha.equals(r_captcha.toUpperCase())) {
            int a = (int) (Math.random() * (9999 - 1000 + 1)) + 1000;
            String msgCode = String.valueOf(a);
            session.setAttribute("MSGCODE", msgCode);
            if (DigestPassDeom.SendMsg(r_mobile, msgCode)) {
                json.setResult(true);
                return json;
            }else{
                json.setResult(false);
                json.setMsg("信息发送失败，请重试");
                return json;
            }
        } else {
            json.setResult(false);
            json.setMsg("验证码输入有误");
            return json;
        }
    }


    @ResponseBody
    @RequestMapping(value = "testProduct.json", method = RequestMethod.POST)
    public JsonVo testProduct(@RequestParam(value = "id") String id,@RequestParam(value = "numbers") int numbers) {
        JsonVo<String> json = new JsonVo<String>();
        DBObject dbObject = MongoUtil.findOne(MongoConst.MONGO_PRODUCT, id);
        int status = (int) dbObject.get("status");
        int num = (int) dbObject.get("num");
        if (status != 0) {
            json.setResult(false);
            return json;
        }
        if (num < 1) {
            json.setResult(false);
            return json;
        }
        if(num<numbers){
            json.setResult(false);
            return json;
        }
        json.setResult(true);
        return json;
    }


    @RequestMapping("acount.html")
    public String acount(@RequestParam(value = "name") String name, ModelMap modelMap, HttpServletRequest request) {
        DBObject dbObject = new BasicDBObject();
        dbObject.put("name", name);
        dbObject.put("status", 1000);
        int payNum = MongoUtil.queryCount(MongoConst.MONGO_ORDERS, dbObject);
        dbObject.put("status", 1100);
        int waitNum = MongoUtil.queryCount(MongoConst.MONGO_ORDERS, dbObject);
        modelMap.put("payNum", payNum);
        modelMap.put("waitNum", waitNum);
        return "acount";
    }

    @RequestMapping("address.html")
    public String address(ModelMap modelMap, HttpServletRequest request) {
        return "address";
    }

    @RequestMapping("editAddress.html")
    public String editAddress(ModelMap modelMap, HttpServletRequest request) {
        return "editAddress";
    }

    @RequestMapping("updateAddress.html")
    public String updateAddress(@RequestParam(value = "id") String id, ModelMap modelMap) {
        DBObject dbObject = MongoUtil.findOne(MongoConst.MONGO_ADDRESS, id);
        modelMap.put("e", dbObject);
        return "updateAddress";
    }

    @RequestMapping("login.html")
    public String login(ModelMap modelMap, HttpServletRequest request) {
        return "login";
    }

    @RequestMapping("regest.html")
    public String regest(ModelMap modelMap, HttpServletRequest request) {
        return "regest";
    }

    @RequestMapping("getPassWord.html")
    public String getPassWord(ModelMap modelMap, HttpServletRequest request) {
        return "getPassWord";
    }


    @RequestMapping("orders.html")
    public String orders(@RequestParam(value = "name") String name, @RequestParam(value = "status") int status, ModelMap modelMap, HttpServletRequest request) throws JSONException {
        Map map = new HashMap();
        map.put("name", name);
        if (status != 9999) {
            map.put("status", status);
        }
        List list = MongoUtil.queryForPage(MongoConst.MONGO_ORDERS, map, 1, 10, "createTime", -1);
        modelMap.put("e", list);
        return "orders";
    }

    @RequestMapping("proDetail.html")
    public String proDetail(String proId, ModelMap modelMap, HttpServletRequest request) {
        DBObject dbObject = MongoUtil.findOne(MongoConst.MONGO_PRODUCT, proId);
        modelMap.put("e", dbObject);
        return "proDetail";
    }


    @RequestMapping("haohao/login.html")
    public String ljjAdmin(ModelMap modelMap) {
        return "ljj/login";
    }

    @RequestMapping("zhuanpan.html")
    public String activiteZhuan(ModelMap modelMap) {
        return "zhuanpan";
    }

    public static void main(String[] args) {

    }
}
