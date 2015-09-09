package com.mcp.myself.controller;

import com.mcp.myself.constant.SystemConstant;
import com.mcp.myself.constant.WeiXinConstant;
import com.mcp.myself.service.CoreService;
import com.mcp.myself.service.IndexService;
import com.mcp.myself.service.WeiXinService;
import com.mcp.myself.util.HttpClientWrapper;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("weixin")
public class WeiXinController {

    @Autowired
    private WeiXinService weiXinService;


    @RequestMapping(value = "api", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public String getWeiXinMessage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 将请求、响应的编码均设置为UTF-8（防止中文乱码）
        request.setCharacterEncoding("UTF-8");  //微信服务器POST消息时用的是UTF-8编码，在接收时也要用同样的编码，否则中文会乱码；
        response.setCharacterEncoding("UTF-8"); //在响应消息（回复消息给用户）时，也将编码方式设置为UTF-8，原理同上；
        System.out.println("微信消息推送");
        //判断token的缓存情况 ， 更新缓存
        try {
            Map token = weiXinService.findToken();
            if (token.containsKey("updateTime")) {
                long updateTime = (Long) token.get("updateTime");
                if (new Date().getTime() - updateTime > 1000 * 60 * 100) {//大于1小时40分钟 更新token
                    String result = HttpClientWrapper.getUrl(WeiXinConstant.QUERY_TOKEN_URL);
                    System.out.println("查询到的token，并更新" + result);
                    JSONObject jsonObject = new JSONObject(result);
                    String access_token = jsonObject.get("access_token").toString();
                    weiXinService.updateToken(access_token);
                }
            } else {
                String result = HttpClientWrapper.getUrl(WeiXinConstant.QUERY_TOKEN_URL);
                System.out.println("查询到的token，并更新" + result);
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
        System.out.println("webCode:" + webcode);
        System.out.println("state:" + state);
        //根据 webCode 获webtoken  并获取用户的 openId
        String webTokenUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + WeiXinConstant.APPID + "&secret=" + WeiXinConstant.APPSECRET + "&code=" + webcode + "&grant_type=authorization_code";
        String result = HttpClientWrapper.getUrl(webTokenUrl);
        JSONObject jsonObject = new JSONObject(result);
        String openId = jsonObject.getString("openid");
        System.out.println("openId:" + openId);
        request.getSession().setAttribute("openId", openId);
        //根据参数 state 可以跳转到不同菜单的页面
        return "redirect:/index.html";
    }

    @RequestMapping(value = "dealWeiPay", method = {RequestMethod.POST, RequestMethod.GET})
    public void dealWeiPay(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.print("微信支付回调数据开始");
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

        System.out.println("接收到的报文：" + notityXml);

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

        if("SUCCESS".equals(m.get("result_code").toString())){
            //支付成功
            String outerId=m.get("out_trade_no").toString();
            DBObject queryForPrePay=new BasicDBObject();
            queryForPrePay.put("orderId",outerId);
            MongoUtil.getDb().getCollection(MongoConst.MONGO_PREPAY).remove(queryForPrePay);
            DBObject dbObject= MongoUtil.findOne(MongoConst.MONGO_ORDERS, outerId);
            if (dbObject != null) {
                BasicDBObject set = new BasicDBObject("$set", new BasicDBObject("status", 1100));
                MongoUtil.getDb().getCollection(MongoConst.MONGO_ORDERS).update(dbObject, set, false, false);
            }
            resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"
                    + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
        }else{
            resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>"
                    + "<return_msg><![CDATA[报文为空]]></return_msg>" + "</xml> ";
        }

        System.out.println("微信支付回调数据结束");

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
    @SuppressWarnings({ "unused", "rawtypes", "unchecked" })
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




}
