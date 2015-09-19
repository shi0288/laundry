package com.mcp.myself.util;


import com.mcp.myself.constant.WeiXinConstant;
import com.mcp.myself.service.WeiXinService;
import org.apache.log4j.Logger;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import java.util.Date;
import java.util.Map;

public class WeixinMessage {


    private static Logger logger = Logger.getLogger(WeixinMessage.class);


    public static String getToken() {
        String tempToken = "";
        WeiXinService weiXinService = new WeiXinService();
        Map token = weiXinService.findToken();
        try {
            if (token.containsKey("updateTime")) {
                long updateTime = (Long) token.get("updateTime");
                if (new Date().getTime() - updateTime > 1000 * 60 * 100) {//大于1小时40分钟 更新token
                    String result = HttpClientWrapper.getUrl(WeiXinConstant.QUERY_TOKEN_URL);
                    logger.info("查询到的token，并更新" + result);
                    JSONObject tokenObj = new JSONObject(result);
                    tempToken = tokenObj.get("access_token").toString();
                    weiXinService.updateToken(tempToken);
                }
            } else {
                String result = HttpClientWrapper.getUrl(WeiXinConstant.QUERY_TOKEN_URL);
                logger.info("查询到的token，并更新" + result);
                JSONObject tokenObj = new JSONObject(result);
                tempToken = tokenObj.get("access_token").toString();
                weiXinService.saveToken(tempToken);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if ("".equals(tempToken)) {
            tempToken = (String) token.get("value");
        }
        return tempToken;
    }


    public static void sendOrderPaySuccess(String openId, String payTime) {
        logger.info("发送下单成功消息："+openId);
        String tempToken=getToken();
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("touser", openId);
            jsonObject.put("template_id", WeiXinConstant.MESSAGE_PAY_ID);
            jsonObject.put("url", "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + WeiXinConstant.APPID + "&redirect_uri=http://www.mcp8.net/laundry/weixin/callback&response_type=code&scope=snsapi_base&state=toAccount#wechat_redirect");
            jsonObject.put("topcolor", "#ea2727");
            JSONObject data = new JSONObject();
            JSONObject productType = dealMessageJSON("购买时间","#000000");
            data.put("productType", productType);
            JSONObject name = dealMessageJSON(payTime,"#173177");
            data.put("name", name);
            JSONObject number = dealMessageJSON("一份","#173177");
            data.put("number", number);
            JSONObject expDate = dealMessageJSON("forever","#173177");
            data.put("expDate", expDate);
            JSONObject remark = dealMessageJSON("\n" + "感谢您对乐小购的惠顾","#000000");
            data.put("remark", remark);
            jsonObject.put("data", data);
            HttpClientWrapper.postJson("https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" + tempToken, jsonObject.toString());
        } catch (
                JSONException e
                )
        {
            e.printStackTrace();
        }

    }

    public static void sendOrderFinish(String openId, String orderId) {
        logger.info("发送订单完成消息："+openId);

        String tempToken=getToken();
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("touser", openId);
            jsonObject.put("template_id", WeiXinConstant.MESSAGE_FINISH_ID);
            jsonObject.put("url", "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + WeiXinConstant.APPID + "&redirect_uri=http://www.mcp8.net/laundry/weixin/callback&response_type=code&scope=snsapi_base&state=toAccount#wechat_redirect");
            jsonObject.put("topcolor", "#ea2727");
            JSONObject data = new JSONObject();

            JSONObject first = dealMessageJSON("您的订单已经确认收货，交易完成","#000000");
            data.put("first", first);

            JSONObject keyword1 = dealMessageJSON(orderId,"#173177");
            data.put("keyword1", keyword1);

            JSONObject keyword2 = dealMessageJSON("商品服务","#173177");
            data.put("keyword2", keyword2);

            JSONObject remark = dealMessageJSON("\n" + "感谢您对乐小购的支持","#000000");
            data.put("remark", remark);

            jsonObject.put("data", data);
            HttpClientWrapper.postJson("https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" + tempToken, jsonObject.toString());
        } catch (
                JSONException e
                )
        {
            e.printStackTrace();
        }

    }

    public static JSONObject dealMessageJSON(String value, String color) {
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("value", value);
            jsonObject.put("color", color);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return jsonObject;
    }

}

