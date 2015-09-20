package com.mcp.myself.controller;

import com.mcp.myself.bean.JsonVo;
import com.mcp.myself.service.AdminService;
import com.mcp.myself.util.*;
import com.mongodb.*;
import org.apache.log4j.Logger;
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

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;


@Controller
@RequestMapping("manage")
public class MangageLoginController {

    @Autowired
    private AdminService adminService;

    private static Logger logger = Logger.getLogger(MangageLoginController.class);


    @ResponseBody
    @RequestMapping(value = "admin.json", method = RequestMethod.POST)
    public JsonVo adminLogin(@RequestParam(value = "name") String name,
                             @RequestParam(value = "password") String password,
                             HttpServletRequest request, ModelMap modelMap) {
        JsonVo<String> json = new JsonVo<String>();
        json.setResult(adminService.adminLogin(name, password, request));
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "register.json", method = RequestMethod.POST)
    public JsonVo register(@RequestParam(value = "name") String name,
                           @RequestParam(value = "password") String password,
                           @RequestParam(value = "captcha") String captcha,
                           @RequestParam(value = "msgCode") String msgCode, HttpServletRequest request) {
        JsonVo<String> json = new JsonVo<String>();
        HttpSession session = request.getSession();
        String code = (String) session.getAttribute("CODE");
        if (!code.equals(captcha.toUpperCase())) {
            json.setResult(false);
            json.setMsg("验证码不对呀亲");
            return json;
        }
        String _msgCodeSession = (String) session.getAttribute("MSGCODE");
        if (!_msgCodeSession.equals(msgCode)) {
            json.setResult(false);
            json.setMsg("短信验证码不对呀亲");
            return json;
        }
        String openId = (String) session.getAttribute("openId");
        json.setResult(adminService.register(name, password, openId));
        if (!json.isResult()) {
            json.setMsg("注册失败请重试");
        }
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "bangding.json", method = RequestMethod.POST)
    public JsonVo bangding(@RequestParam(value = "name") String name,
                           @RequestParam(value = "captcha") String captcha,
                           @RequestParam(value = "msgCode") String msgCode, HttpServletRequest request) {
        JsonVo<String> json = new JsonVo<String>();
        HttpSession session = request.getSession();
        String code = (String) session.getAttribute("CODE");
        if (!code.equals(captcha.toUpperCase())) {
            json.setResult(false);
            json.setMsg("对不起亲，验证码不对");
            return json;
        }
        String _msgCodeSession = (String) session.getAttribute("MSGCODE");
        if (!_msgCodeSession.equals(msgCode)) {
            json.setResult(false);
            json.setMsg("对不起亲，短信验证码不对");
            return json;
        }
        String openId = (String) session.getAttribute("openId");
        DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_MEMBER);
        BasicDBObject query = new BasicDBObject();
        query.put("name", openId);
        BasicDBObject set = new BasicDBObject("$set", new BasicDBObject("mobile", name));
        collection.update(query, set, false, false);
        json.setResult(true);
        if (!json.isResult()) {
            json.setMsg("绑定失败，请重试");
        }
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "updatePassWord.json", method = RequestMethod.POST)
    public JsonVo updatePassWord(@RequestParam(value = "name") String name,
                                 @RequestParam(value = "password") String password,
                                 @RequestParam(value = "captcha") String captcha,
                                 @RequestParam(value = "msgCode") String msgCode, HttpServletRequest request) {
        JsonVo<String> json = new JsonVo<String>();
        HttpSession session = request.getSession();
        String code = (String) session.getAttribute("CODE");
        if (!code.equals(captcha.toUpperCase())) {
            json.setResult(false);
            json.setMsg("验证码不对呀亲");
            return json;
        }
        String _msgCodeSession = (String) session.getAttribute("MSGCODE");
        if (!_msgCodeSession.equals(msgCode)) {
            json.setResult(false);
            json.setMsg("短信验证码不对呀亲");
            return json;
        }

        json.setResult(adminService.updatePassWord(name, password));
        if (!json.isResult()) {
            json.setMsg("修改密码失败请重试");
        }
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "login.json", method = RequestMethod.POST)
    public JsonVo login(@RequestParam(value = "name") String name,
                        @RequestParam(value = "password") String password,
                        @RequestParam(value = "captcha") String captcha, HttpServletRequest request) {
        JsonVo<String> json = new JsonVo<String>();
        HttpSession session = request.getSession();
        String code = (String) session.getAttribute("CODE");
        if (!code.equals(captcha.toUpperCase())) {
            json.setResult(false);
            json.setMsg("验证码不对呀亲");
            return json;
        }
        json.setResult(adminService.login(name, password));
        if (!json.isResult()) {
            json.setMsg("用户名或密码错误");
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "address.json", method = RequestMethod.POST)
    public JsonVo address(@RequestParam(value = "name") String name,
                          @RequestParam(value = "userName") String userName,
                          @RequestParam(value = "mobile") String mobile,
                          @RequestParam(value = "provice") String provice,
                          @RequestParam(value = "where") String where,
                          @RequestParam(value = "first") int first) {
        JsonVo<String> json = new JsonVo<String>();
        json.setResult(adminService.address(name, userName, mobile, provice, where, first));
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "updateAddress.json", method = RequestMethod.POST)
    public JsonVo updateAddress(@RequestParam(value = "name") String name,
                                @RequestParam(value = "id") String id,
                                @RequestParam(value = "userName") String userName,
                                @RequestParam(value = "mobile") String mobile,
                                @RequestParam(value = "provice") String provice,
                                @RequestParam(value = "where") String where,
                                @RequestParam(value = "first") int first) {
        JsonVo<String> json = new JsonVo<String>();
        json.setResult(adminService.updateAddress(name, id, userName, mobile, provice, where, first));
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "delAddress.json", method = RequestMethod.POST)
    public JsonVo delAddress(@RequestParam(value = "id") String id) {
        JsonVo<String> json = new JsonVo<String>();
        DBObject dbObject = new BasicDBObject();
        dbObject.put("_id", new ObjectId(id));
        WriteResult writeResult = MongoUtil.getDb().getCollection(MongoConst.MONGO_ADDRESS).remove(dbObject);
        int i = writeResult.getN();
        if (i == 1) {
            json.setResult(true);
        } else {
            json.setResult(false);
        }
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "addressList.json", method = RequestMethod.POST)
    public String addressList(@RequestParam(value = "name") String name) {
        DBObject query = new BasicDBObject();
        query.put("name", name);
        List rstList = MongoUtil.queryAll(MongoConst.MONGO_ADDRESS, query, "createTime", -1);
        JSONArray results = new JSONArray();
        for (int i = 0; i < rstList.size(); i++) {
            DBObject obj = (DBObject) rstList.get(i);
            results.put(obj);
        }
        JSONObject json = new JSONObject();
        try {
            json.put("result", true);
            json.put("datas", results);
            return json.toString();
        } catch (JSONException e) {
            e.printStackTrace();
        }
        try {
            json.put("result", false);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return json.toString();
    }

    @ResponseBody
    @RequestMapping(value = "addressPro.json", method = RequestMethod.POST)
    public String addressPro(@RequestParam(value = "name") String name) {
        DBObject query = new BasicDBObject();
        query.put("name", name);
        query.put("status", 0);
        DBObject dbObject = MongoUtil.getDb().getCollection(MongoConst.MONGO_ADDRESS).findOne(query);
        JSONObject json = new JSONObject();
        try {
            json.put("result", true);
            json.put("datas", dbObject);
            return json.toString();
        } catch (JSONException e) {
            e.printStackTrace();
        }
        try {
            json.put("result", false);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return json.toString();
    }

    @ResponseBody
    @RequestMapping(value = "selectAddress.json", method = RequestMethod.POST)
    public JsonVo selectAddress(@RequestParam(value = "name") String name, @RequestParam(value = "id") String id) {
        JsonVo<String> json = new JsonVo<String>();
        json.setResult(adminService.selectAddress(name, id));
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "goToPay.json", method = RequestMethod.POST)
    public JsonVo goToPay(@RequestParam(value = "id") String id) {
        JsonVo<String> json = new JsonVo<String>();
        DBObject query = new BasicDBObject();
        query.put("orderId", id);
        List list = MongoUtil.getDb().getCollection(MongoConst.MONGO_PREPAY).find(query).toArray();
        if (list.size() == 1) {
            DBObject dbObject = (DBObject) list.get(0);
            String prepay_id = (String) dbObject.get("prepay_id");
            long createTime = (long) dbObject.get("createTime");
            if (System.currentTimeMillis() - createTime > 600000) {
                json.setResult(false);
                json.setMsg("该订单支付时间超时，请重新下单");
                return json;
            }
            json.setResult(true);
            json.setObject(prepay_id);
            return json;
        }
        json.setResult(false);
        json.setMsg("该订单已经过期，请重新下单");
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "commitOrder.json", method = RequestMethod.POST)
    public JsonVo commitOrder(@RequestParam(value = "name") String name,
                              @RequestParam(value = "conName") String conName,
                              @RequestParam(value = "conMobile") String conMobile,
                              @RequestParam(value = "conAddress") String conAddress,
                              @RequestParam(value = "orderStr") String orderStr,
                              @RequestParam(value = "orderPrice") String orderPrice,
                              @RequestParam(value = "payType") int payType, HttpServletRequest request) {
        logger.info("#################有订单进入，用户:" + name + "  金额:" + orderPrice);
        logger.info("#################支付类型payType:" + payType);
        JsonVo<String> json = new JsonVo<String>();
        DBObject dbObject = new BasicDBObject();
        dbObject.put("name", name);
        dbObject.put("conName", conName);
        dbObject.put("conMobile", conMobile);
        dbObject.put("conAddress", conAddress);
        dbObject.put("orderStr", orderStr);
        dbObject.put("payType", payType);
        //处理订单
        String[] orders = orderStr.split(";");
        double yuanOrderPrice = 0;
        boolean is = true;
        String tempStr = "";
        Map<String, Integer> map = new HashMap<String, Integer>();

        String ordersNumber = String.valueOf(orders.length);
        for (int i = 0; i < orders.length; i++) {
            JSONObject jsonObject = null;
            try {
                jsonObject = new JSONObject(orders[i]);
                String proId = (String) jsonObject.get("proId");
                int num = Integer.parseInt((String) jsonObject.get("numbers"));
                //缓存商品和数量
                map.put(proId, num);
                double price = Double.parseDouble((String) jsonObject.get("price"));
                DBObject productObj = MongoUtil.findOne(MongoConst.MONGO_PRODUCT, proId);
                int yuanNum = (int) productObj.get("num");
                int status = (int) productObj.get("status");
                double yuanPrice = Double.parseDouble((String) productObj.get("price"));
                tempStr = (String) productObj.get("name");
                //商品状态不出售
                if (status != 0) {
                    json.setResult(false);
                    json.setMsg("对不起," + tempStr + "：库存不足,建议您下次购买此商品，抱歉！");
                    is = false;
                    break;
                }
                //数量不足
                if (num < 1) {
                    json.setResult(false);
                    json.setMsg("对不起," + tempStr + "：库存不足,建议您下次购买此商品，抱歉！");
                    is = false;
                    break;
                }
                //购买数量大于库存
                if (num > yuanNum) {
                    json.setResult(false);
                    json.setMsg("对不起," + tempStr + "：库存不足,建议您下次购买此商品，抱歉！");
                    is = false;
                    break;
                }
                //商品价格不一致
                if (price != yuanPrice) {
                    json.setResult(false);
                    json.setMsg("对不起," + tempStr + "：商品数据有问题，请重试！");
                    is = false;
                    break;
                }
                yuanOrderPrice = (yuanOrderPrice * 100 + (yuanPrice * 100 * num)) / 100;
            } catch (JSONException e) {
                e.printStackTrace();
                json.setResult(false);
                json.setMsg("对不起," + tempStr + "：商品数据有问题，请重试！");
                is = false;
                break;
            }
        }

        if (!is) {
            return json;
        }

        //-------------------活动减费逻辑

        //外送费校验
        DBCursor dbCursor = MongoUtil.getDb().getCollection(MongoConst.MONGO_INITPRICE).find();
        List list = dbCursor.toArray();
        if (list.size() == 1) {
            DBObject initPriceObj = (DBObject) list.get(0);
            double initPrice = Double.parseDouble(initPriceObj.get("price").toString());
            if (yuanOrderPrice < initPrice) {
                double sendPrice = Double.parseDouble(initPriceObj.get("sendPrice").toString());
                yuanOrderPrice = (yuanOrderPrice * 100 + (sendPrice * 100)) / 100;
            }
        }

        //.....

        double tempOrderPrice = Double.parseDouble(orderPrice);

        logger.info("============传的钱");
        logger.info(tempOrderPrice);
        logger.info("============算的钱");
        logger.info(yuanOrderPrice);

        if (tempOrderPrice != yuanOrderPrice) {
            json.setResult(false);
            json.setMsg("对不起,订单金额数据有问题，请重试！");
            return json;
        }

        //0 货到付款  1微信  2支付宝
        if (payType == 1) {
            String result = PayCoreUtil.jsApi(request, orderPrice, dbObject);
            if ("".equals(result)) {
                json.setMsg("订单处理失败,请重试");
                json.setResult(false);
            } else {
                json.setResult(true);
                json.setObject(result);
            }
            return json;
        }

        for (String id : map.keySet()) {
            int num = map.get(id);
            adminService.updateNum(id, num, false);
        }

        dbObject.put("orderPrice", orderPrice);
        dbObject.put("status", 1100);
        dbObject.put("createTime", System.currentTimeMillis());
        try {
            MongoUtil.insert(MongoConst.MONGO_ORDERS, dbObject);
            json.setResult(true);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            WeixinMessage.sendOrderPaySuccess(name, sdf.format(new Date()));
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("订单提交失败,请重试");
            json.setResult(false);
        }
        return json;
    }

    /**
     * 获取包邮额
     */
    @ResponseBody
    @RequestMapping("initPrice.json")
    public JsonVo initPrice() {
        JsonVo<String> json = new JsonVo<String>();
        DBCursor dbCursor = MongoUtil.getDb().getCollection(MongoConst.MONGO_INITPRICE).find();
        List list = dbCursor.toArray();
        if (list.size() == 1) {
            DBObject dbObject = (DBObject) list.get(0);
            json.setObject(dbObject.toString());
        }
        json.setResult(true);
        return json;
    }


    @RequestMapping("code.img")
    public void getCode(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        int width = 90;
        int height = 20;
        int codeCount = 4;
        int xx = 15;
        int fontHeight = 18;
        int codeY = 16;
        char[] codeSequence = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J',
                'K', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
                'X', 'Y', 'Z', '2', '3', '4', '5', '6', '7', '8', '9'};
        BufferedImage buffImg = new BufferedImage(width, height,
                BufferedImage.TYPE_INT_RGB);
        Graphics gd = buffImg.getGraphics();
        Random random = new Random();
        gd.setColor(Color.WHITE);
        gd.fillRect(0, 0, width, height);
        Font font = new Font("Fixedsys", Font.BOLD, fontHeight);
        gd.setFont(font);
        gd.setColor(Color.BLACK);
        gd.drawRect(0, 0, width - 1, height - 1);
        gd.setColor(Color.BLACK);
        for (int i = 0; i < 3; i++) {
            int x = random.nextInt(width);
            int y = random.nextInt(height);
            int xl = random.nextInt(12);
            int yl = random.nextInt(12);
            gd.drawLine(x, y, x + xl, y + yl);
        }
        StringBuffer randomCode = new StringBuffer();
        int red = 0, green = 0, blue = 0;
        for (int i = 0; i < codeCount; i++) {
            String code = String.valueOf(codeSequence[random.nextInt(codeSequence.length - 1)]);
            red = random.nextInt(255);
            green = random.nextInt(255);
            blue = random.nextInt(255);
            gd.setColor(new Color(red, green, blue));
            gd.drawString(code, (i + 1) * xx, codeY);
            randomCode.append(code);
        }
        HttpSession session = req.getSession();
        session.setAttribute("CODE", randomCode.toString());
        resp.setHeader("Pragma", "no-cache");
        resp.setHeader("Cache-Control", "no-cache");
        resp.setDateHeader("Expires", 0);
        resp.setContentType("image/jpeg");
        ServletOutputStream sos = resp.getOutputStream();
        ImageIO.write(buffImg, "jpeg", sos);
        sos.close();
    }

    public static void main(String[] args) {
        int tempRecharge = (int) (Double.parseDouble("2.9") * 100);
        System.out.println(tempRecharge);
    }

}
