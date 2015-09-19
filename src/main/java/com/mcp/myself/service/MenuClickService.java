package com.mcp.myself.service;

import com.mcp.myself.constant.WeiXinConstant;
import com.mcp.myself.message.resp.Article;
import com.mcp.myself.message.resp.MessageResponse;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import org.apache.log4j.Logger;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * 创建人：herosky
 * 创建时间：2015-3-30 下午5:13:57
 * 描述：菜单点击事件，处理
 */
public class MenuClickService {

    private static Logger logger = Logger.getLogger(MenuClickService.class);

    /**
     * 描述：@param eventKey
     * 描述：@param fromUserName
     * 描述：@param toUserName
     * 描述：@return 接受用户点击事件，通过微信推送给用户消息，跳转页面，发送消息等
     * 作者：herosky
     */
    public static String getClickResponse(String eventKey, String fromUserName,
                                          String toUserName) {
        // TODO 判断evetKey事件处理
        if (eventKey.equals("recharge")) {
            logger.info("查询积分信息");
            try {
                DBObject query = new BasicDBObject();
                query.put("openId", fromUserName);
                List list = MongoUtil.getDb().getCollection(MongoConst.MONGO_MEMBER).find(query).toArray();
                if (list.size() == 1) {
                    DBObject dbUser = (DBObject) list.get(0);
                    int recharge = Integer.parseInt(dbUser.get("recharge").toString());
                    List<Article> messageList = new ArrayList<Article>();
                    Article article = new Article();
                    article.setTitle("现有积分：" + recharge);
                    article.setDescription("查看账户信息");
                    article.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + WeiXinConstant.APPID + "&redirect_uri=http://www.mcp8.net/laundry/weixin/callback&response_type=code&scope=snsapi_base&state=toAccount#wechat_redirect");
                    messageList.add(article);
                    return MessageResponse.getNewsMessage(fromUserName, toUserName, messageList);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (eventKey.equals("youhui")) {

        } else if (eventKey.equals("orders")) {

            logger.info("查询订单");

            DBObject query = new BasicDBObject();
            BasicDBList values = new BasicDBList();
            values.add(new BasicDBObject("status", 1100));
            values.add(new BasicDBObject("status", 1101));
            query.put("$or", values);
            query.put("name", fromUserName);
            List list = MongoUtil.getDb().getCollection(MongoConst.MONGO_ORDERS).find(query).skip(0).limit(5).sort(new BasicDBObject("createTime", -1)).toArray();
            logger.info("数量:" + list.size());
            if (list.size() < 1) {
                List<Article> messageList = new ArrayList<Article>();
                Article article = new Article();
                article.setTitle("抱歉，您目前没有可派送的订单");
                article.setDescription("查看账户信息");
                article.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + WeiXinConstant.APPID + "&redirect_uri=http://www.mcp8.net/laundry/weixin/callback&response_type=code&scope=snsapi_base&state=toAccount#wechat_redirect");
                messageList.add(article);
                return MessageResponse.getNewsMessage(fromUserName, toUserName, messageList);
            } else {
                List<Article> messageList = new ArrayList<Article>();
                for (int i = 0; i < list.size(); i++) {
                    DBObject dbObject = (DBObject) list.get(i);
                    String conName = (String) dbObject.get("conName");
                    String conMobile = (String) dbObject.get("conMobile");
                    long createTime = (long) dbObject.get("createTime");
                    String orderPrice = (String) dbObject.get("orderPrice");
                    int status = (int) dbObject.get("status");
                    Date date = new Date(createTime);
                    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
                    String conTime = sdf.format(date);
                    StringBuffer title = new StringBuffer();
                    title.append("收件人:" + conName).append("\n");
                    title.append("联系方式:" + conMobile).append("\n");
                    title.append("订单金额:" + orderPrice).append("\n");
                    String statusStr = "派送中";
                    if (status == 1100) {
                        statusStr = "等待派送";
                    } else if (status == 1101) {
                    } else {
                        statusStr = "订单处理";
                    }
                    title.append("订单状态: " + statusStr).append("\n");
                    title.append("创建时间:" + conTime).append("\n");
                    title.append("客官莫慌，送货员正在加速...");
                    Article article = new Article();
                    article.setTitle(title.toString());
                    logger.info(title.toString());
                    article.setDescription("查看账户信息");
                    article.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + WeiXinConstant.APPID + "&redirect_uri=http://www.mcp8.net/laundry/weixin/callback&response_type=code&scope=snsapi_base&state=toAccount#wechat_redirect");
                    messageList.add(article);
                }
                return MessageResponse.getNewsMessage(fromUserName, toUserName, messageList);
            }


        }
        return null;
    }

    public static void main(String[] args) {
//        DBObject query = new BasicDBObject();
//        BasicDBList values = new BasicDBList();
//        values.add(new BasicDBObject("status", 1100));
//        values.add(new BasicDBObject("status", 1101));
//        query.put("$or", values);
//        query.put("name", "o2KYuwf97lKTOg3Dg5gBPh0ZTAig");
//        List list = MongoUtil.getDb().getCollection(MongoConst.MONGO_ORDERS).find(query).skip(0).limit(5).sort(new BasicDBObject("createTime", -1)).toArray();
//        DBObject dbObject = (DBObject) list.get(0);
//        String conName = (String) dbObject.get("conName");
//        String conMobile = (String) dbObject.get("conMobile");
//        long createTime = (long) dbObject.get("createTime");
//        String orderPrice = (String) dbObject.get("orderPrice");
//        int status = (int) dbObject.get("status");
//        Date date = new Date(createTime);
//        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
//        String conTime = sdf.format(date);
//        StringBuffer title = new StringBuffer();
//        title.append("收件人:" + conName).append("\n");
//        title.append("联系方式:" + conMobile).append("\n");
//        title.append("订单金额:" + orderPrice).append("\n");
//        String statusStr = "派送中";
//        if (status == 1100) {
//            statusStr = "等待派送";
//        } else if(status == 1101) {
//        }else{
//            statusStr = "订单处理";
//        }
//        title.append("订单状态: " + statusStr).append("\n");
//        title.append("创建时间:" + conTime).append("\n");
//        title.append("客观莫慌，送货员正在加速...");
//        System.out.println(title.toString());
    }

}
