package com.mcp.myself.controller;

import com.mcp.myself.constant.WeiXinConstant;
import com.mcp.myself.service.AdminService;
import com.mcp.myself.service.CoreService;
import com.mcp.myself.service.WeiXinService;
import com.mcp.myself.util.*;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import org.apache.log4j.Logger;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.xml.sax.InputSource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("weixin")
public class WeiXinController {

    @Autowired
    private WeiXinService weiXinService;

    private static Logger logger = Logger.getLogger(WeiXinController.class);


    @RequestMapping(value = "api", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public String getWeiXinMessage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 将请求、响应的编码均设置为UTF-8（防止中文乱码）
        request.setCharacterEncoding("UTF-8");  //微信服务器POST消息时用的是UTF-8编码，在接收时也要用同样的编码，否则中文会乱码；
        response.setCharacterEncoding("UTF-8"); //在响应消息（回复消息给用户）时，也将编码方式设置为UTF-8，原理同上；
        logger.info("微信消息推送");
        //判断token的缓存情况 ， 更新缓存
        try {
            Map token = weiXinService.findToken();
            if (token.containsKey("updateTime")) {
                long updateTime = (Long) token.get("updateTime");
                if (new Date().getTime() - updateTime > 1000 * 60 * 100) {//大于1小时40分钟 更新token
                    String result = HttpClientWrapper.getUrl(WeiXinConstant.QUERY_TOKEN_URL);
                    logger.info("查询到的token，并更新" + result);
                    JSONObject jsonObject = new JSONObject(result);
                    String access_token = jsonObject.get("access_token").toString();
                    weiXinService.updateToken(access_token);
                }
            } else {
                String result = HttpClientWrapper.getUrl(WeiXinConstant.QUERY_TOKEN_URL);
                logger.info("查询到的token，并更新" + result);
                JSONObject jsonObject = new JSONObject(result);
                String access_token = jsonObject.get("access_token").toString();
                weiXinService.saveToken(access_token);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        //初始化配置文件
        String respMessage = CoreService.processRequest(request);//调用CoreService类的processRequest方法接收、处理消息，并得到处理结果；
        // 响应消息
        //调用response.getWriter().write()方法将消息的处理结果返回给用户
        return new String(respMessage.getBytes("utf-8"), "ISO8859_1");
    }


    @RequestMapping(value = "callback", method = {RequestMethod.POST, RequestMethod.GET})
    public String getWeiXinCallback(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //第一步微信 登陆认证回掉地址
        String webcode = request.getParameter("code");
        String state = request.getParameter("state");
        logger.info("webCode:" + webcode);
        logger.info("state:" + state);
        //根据 webCode 获webtoken  并获取用户的 openId
        String webTokenUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + WeiXinConstant.APPID + "&secret=" + WeiXinConstant.APPSECRET + "&code=" + webcode + "&grant_type=authorization_code";
        String result = HttpClientWrapper.getUrl(webTokenUrl);
        JSONObject jsonObject = new JSONObject(result);
        String openId = jsonObject.getString("openid");
        logger.info("openId:" + openId);
        request.getSession().setAttribute("openId", openId);
        DBCollection collection = MongoUtil.getDb().getCollection(MongoConst.MONGO_MEMBER);
        BasicDBObject query = new BasicDBObject();
        query.put("name", openId);
        List list = collection.find(query).toArray();
        String nickName = "";
        String headImgUrl = "";
        if (list.size() == 1) {
            DBObject userJson = (DBObject) list.get(0);
            nickName = (String) userJson.get("nickName");
            logger.info("nickName: " + nickName +"--用户登陆");
            headImgUrl = (String) userJson.get("headImgUrl");
            if (nickName == null || headImgUrl == null) {
                logger.info("用户无nickName，本次获取并保存" + openId);
                String nickNameStr = "";
                nickNameStr = this.getUserNickName(openId);
                nickName = nickNameStr.split("@")[0];
                headImgUrl = nickNameStr.split("@")[1];
                logger.info("nickName: " + nickNameStr);
                BasicDBObject set = new BasicDBObject("$set", new BasicDBObject("nickName", nickName).append("headImgUrl", headImgUrl));
                collection.update(query, set, false, false);
            }
        } else {
            AdminService adminService = new AdminService();
            adminService.register(openId, "12345609", openId);
            String nickNameStr = this.getUserNickName(openId);
            nickName = nickNameStr.split("@")[0];
            headImgUrl = nickNameStr.split("@")[1];
            logger.info("nickName: " + nickNameStr +"--用户登陆");
            BasicDBObject set = new BasicDBObject("$set", new BasicDBObject("nickName", nickName).append("headImgUrl", headImgUrl));
            collection.update(query, set, false, false);
        }
        request.getSession().setAttribute("nickName", nickName);
        request.getSession().setAttribute("headImgUrl", headImgUrl);

        //根据参数 state 可以跳转到不同菜单的页面
        return "redirect:/" + state + ".html";
    }

    public String getUserNickName(String openId) {
        Map token = weiXinService.findToken();
        String tempToken = "";
        try {
            if (token.containsKey("updateTime")) {
                long updateTime = (Long) token.get("updateTime");
                if (new Date().getTime() - updateTime > 1000 * 60 * 100) {//大于1小时40分钟 更新token
                    String result = HttpClientWrapper.getUrl(WeiXinConstant.QUERY_TOKEN_URL);
                    logger.info("查询到的token，并更新" + result);
                    JSONObject jsonObject = new JSONObject(result);
                    tempToken = jsonObject.get("access_token").toString();
                    weiXinService.updateToken(tempToken);
                }
            } else {
                String result = HttpClientWrapper.getUrl(WeiXinConstant.QUERY_TOKEN_URL);
                logger.info("查询到的token，并更新" + result);
                JSONObject jsonObject = new JSONObject(result);
                tempToken = jsonObject.get("access_token").toString();
                weiXinService.saveToken(tempToken);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if ("".equals(tempToken)) {
            tempToken = (String) token.get("value");
        }
        String webForUserUrl = WeiXinConstant.QUERY_USEINFO_URL.replace("%ACCESS_TOKEN%", tempToken).replace("%OPENID%", openId);
        String result = HttpClientWrapper.getUrl(webForUserUrl);
        JSONObject jsonObject = null;
        try {
            jsonObject = new JSONObject(result);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        String nickname = null;
        String headimgurl = null;
        try {
            nickname = jsonObject.get("nickname").toString();
            headimgurl = jsonObject.get("headimgurl").toString();
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return nickname + '@' + headimgurl;
    }

    @RequestMapping(value = "dealWeiPay", method = {RequestMethod.POST, RequestMethod.GET})
    public void dealWeiPay(HttpServletRequest request, HttpServletResponse response) throws Exception {
        logger.info("微信支付回调数据开始");
        String inputLine;
        String notityXml = "";
        String resXml = "";
        try {
            while ((inputLine = request.getReader().readLine()) != null) {
                notityXml += inputLine;
            }
            request.getReader().close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        logger.info("接收到的报文：" + notityXml);

        Map m = parseXmlToList2(notityXml);
//        WxPayResult wpr = new WxPayResult();
//        wpr.setAppid(m.get("appid").toString());
//        wpr.setBankType(m.get("bank_type").toString());
//        wpr.setCashFee(m.get("cash_fee").toString());
//        wpr.setFeeType(m.get("fee_type").toString());
//        wpr.setIsSubscribe(m.get("is_subscribe").toString());
//        wpr.setMchId(m.get("mch_id").toString());
//        wpr.setNonceStr(m.get("nonce_str").toString());
//        wpr.setOpenid(m.get("openid").toString());
//        wpr.setOutTradeNo(m.get("out_trade_no").toString());
//        wpr.setResultCode(m.get("result_code").toString());
//        wpr.setReturnCode(m.get("return_code").toString());
//        wpr.setSign(m.get("sign").toString());
//        wpr.setTimeEnd(m.get("time_end").toString());
//        wpr.setTotalFee(m.get("total_fee").toString());
//        wpr.setTradeType(m.get("trade_type").toString());
//        wpr.setTransactionId(m.get("transaction_id").toString());

        if ("SUCCESS".equals(m.get("result_code").toString())) {
            //支付成功
            String outerId = m.get("out_trade_no").toString();
            DBObject queryForPrePay = new BasicDBObject();
            queryForPrePay.put("orderId", outerId);
            MongoUtil.getDb().getCollection(MongoConst.MONGO_PREPAY).remove(queryForPrePay);
            DBObject dbObject = MongoUtil.findOne(MongoConst.MONGO_ORDERS, outerId);
            if (dbObject != null) {
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                String openId=m.get("openid").toString();
                //直接1101  不再打印
                int statusTemp= (int) dbObject.get("status");
                if(statusTemp==1000){
                    WeixinMessage.sendOrderPaySuccess(openId, sdf.format(new Date()));
                    BasicDBObject set = new BasicDBObject("$set", new BasicDBObject("status", 1101));
                    MongoUtil.getDb().getCollection(MongoConst.MONGO_ORDERS).update(dbObject, set, false, false);
                    int a = (int) (Math.random() * (9999 - 1000 + 1)) + 1000;
                    String msgCode = String.valueOf(a);
                    DigestPassDeom.SendMsg("18311436873", msgCode);
                }
//                //增加活动
//                DBObject dbActyvity = new BasicDBObject();
//                dbActyvity.put("activeId","1001");
//                dbActyvity.put("userName",openId);
//                dbActyvity.put("createTime", System.currentTimeMillis());
//                dbActyvity.put("activeState",0);
//                MongoUtil.insert(MongoConst.MONGO_ACTIVITY, dbActyvity);//为了活动增加
            }
            resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"
                    + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
        } else {
            resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>"
                    + "<return_msg><![CDATA[报文为空]]></return_msg>" + "</xml> ";
        }

        logger.info("微信支付回调数据结束");

        BufferedOutputStream out = new BufferedOutputStream(
                response.getOutputStream());
        out.write(resXml.getBytes());
        out.flush();
        out.close();
    }

    /**
     * description: 解析微信通知xml
     *
     * @param xml
     * @return
     * @author ex_yangxiaoyi
     * @see
     */
    @SuppressWarnings({"unused", "rawtypes", "unchecked"})
    private static Map parseXmlToList2(String xml) {
        Map retMap = new HashMap();
        try {
            StringReader read = new StringReader(xml);
            // 创建新的输入源SAX 解析器将使用 InputSource 对象来确定如何读取 XML 输入
            InputSource source = new InputSource(read);
            // 创建一个新的SAXBuilder
            SAXBuilder sb = new SAXBuilder();
            // 通过输入源构造一个Document
            Document doc = (Document) sb.build(source);
            Element root = doc.getRootElement();// 指向根节点
            List<Element> es = root.getChildren();
            if (es != null && es.size() != 0) {
                for (Element element : es) {
                    retMap.put(element.getName(), element.getValue());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return retMap;
    }

    public static void main(String[] args) {
        JSONObject jsonObject=new JSONObject();
        try {
            jsonObject.put("touser","o2KYuwf97lKTOg3Dg5gBPh0ZTAig");
            jsonObject.put("template_id","p1Gd4ypZ1ajFrEl6NTAsb94hBoPAH-ihirUS7J719pI");
            jsonObject.put("url","https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + WeiXinConstant.APPID + "&redirect_uri=http://www.mcp8.net/laundry/weixin/callback&response_type=code&scope=snsapi_base&state=toAccount#wechat_redirect");
            jsonObject.put( "topcolor","#ea2727");
            JSONObject data=new JSONObject();

            JSONObject productType=new JSONObject();
            productType.put("value","下单时间");
            productType.put("color","#000000");
            data.put("productType",productType);

            JSONObject name=new JSONObject();
            name.put("value","2015-09-09 23:33:33");
            name.put("color","#173177");
            data.put("name",name);


            JSONObject number=new JSONObject();
            number.put("value","1份");
            number.put("color","#173177");
            data.put("number", number);

            JSONObject expDate=new JSONObject();
            expDate.put("value","forever");
            expDate.put("color","#173177");
            data.put("expDate", expDate);


            JSONObject remark=new JSONObject();
            remark.put("value","\n感谢您对乐小购的惠顾");
            remark.put("color","#000000");
            data.put("remark", remark);
            jsonObject.put("data",data);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        HttpClientWrapper.postJson("https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=LzO7dOiD0p6CFG3qRIMod3ojbl2pBXjgASqEMtXiB4I25WtKLmTXN0tcRPzWKAp_ODoair_2W_oUOTSGTZJEeRWkNtx8RB2TPUjANYPMwGk",jsonObject.toString());

    }


}
