package com.mcp.myself.service;

import com.mcp.myself.bean.Activity;
import com.mcp.myself.util.MD5;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Random;

/**
 * Created by forest on 2015/8/25.
 */
@Service
public class ActivityService extends BaseService{

    private static Logger logger = Logger.getLogger(ActivityService.class);


    private String MONGO_NAME=MongoConst.MONGO_ACTIVITY;

    public boolean getUser(String userName, String passWord) {
        boolean check = false;
        DBObject param = new BasicDBObject();
        param.put("userName",userName);
        param.put("passWord", MD5.MD5Encode(passWord));
        int count = MongoUtil.queryCount(MongoConst.MONGO_MEMBER, param);
        if (count == 0) {
            check = true;
        }
        return check;
    }
    public boolean update(DBObject dbObject) {
        return this.update(MONGO_NAME, dbObject);
    }

    public Activity waBao(String userName, String activeId) {
        Activity activity = new Activity();
        //1.验证是否抽过奖
        boolean chou = getCheck(userName, activeId, 3);
        if(chou){
            activity.setCheck(false);
        }else{
            DBObject dbObject = new BasicDBObject();
            int n = randomNo();
            if(n>=0&&n<=39){
                activity.setActiveId(activeId);
                activity.setActiveType("A");
                activity.setActiveName("香皂");
                activity.setActiveDes("迎新生挖宝活动");
            }else if(n>=40&&n<=69){
                activity.setActiveId(activeId);
                activity.setActiveType("B");
                activity.setActiveName("洗衣液");
                activity.setActiveDes("迎新生挖宝活动");
            }else if(n>=70&&n<=89){
                activity.setActiveId(activeId);
                activity.setActiveType("C");
                activity.setActiveName("刮刮乐");
                activity.setActiveDes("迎新生挖宝活动");
            }else if(n>=90&&n<=99){
                activity.setActiveId(activeId);
                activity.setActiveType("D");
                activity.setActiveName("现金券50元");
                activity.setActiveDes("迎新生挖宝活动");
            }
            dbObject.put("activeId",activeId);
            dbObject.put("userName",userName);
            dbObject.put("currentDate",getDate());
            dbObject.put("createTime",System.currentTimeMillis());
            dbObject.put("activeType",activity.getActiveType());
            dbObject.put("activeName",activity.getActiveName());
            dbObject.put("activeDes",activity.getActiveDes());
            dbObject.put("activeState","0");
            int res = MongoUtil.save(MongoConst.MONGO_ACTIVITY, dbObject);
            System.out.println("res:" + res);
            if(res==0){
                activity.setCheck(true);
            }else{
                activity.setCheck(false);
            }
        }
        return activity;
    }



    private int randomNo() {
        Random random = new Random();
        int n = random.nextInt(100);
        return n;
    }
    private boolean getCheck(String userName, String activeId) {
        boolean chou = true;
        DBObject param = new BasicDBObject();
        param.put("activeId", activeId);
        param.put("userName",userName);
        int count = MongoUtil.queryCount(MongoConst.MONGO_ACTIVITY, param);
        if (count == 0) {
            chou = false;
        }
        return chou;
    }
    private boolean getCheck(String userName, String activeId,int num) {
        boolean chou = true;
        DBObject param = new BasicDBObject();
        param.put("activeId",activeId);
        param.put("userName",userName);
        int count = MongoUtil.queryCount(MongoConst.MONGO_ACTIVITY, param);
        if(count<num){
            chou = false;
        }
        return chou;
    }
    private boolean getCheckStatus(String userName, String activeId,int state) {
        boolean chou = true;
        DBObject param = new BasicDBObject();
        param.put("activeId",activeId);
        param.put("userName",userName);
        param.put("activeState",state);
        int count = MongoUtil.queryCount(MongoConst.MONGO_ACTIVITY, param);
        if(count<1){
            chou = false;
        }
        return chou;
    }
    public Activity guagLe(String userName, String activeId) {
        Activity activity = new Activity();
        //1.验证是否抽过奖
        boolean chou = getCheck(userName, activeId);
        if(chou){
            activity.setCheck(false);
        }else{
            DBObject dbObject = new BasicDBObject();
            int n = randomNo();
            if(n>=0&&n<=39){
                activity.setActiveId(activeId);
                activity.setActiveType("A");
                activity.setActiveName("香皂");
                activity.setActiveDes("迎新生挖宝活动");
            }else if(n>=40&&n<=69){
                activity.setActiveId(activeId);
                activity.setActiveType("B");
                activity.setActiveName("洗衣液");
                activity.setActiveDes("迎新生挖宝活动");
            }else if(n>=70&&n<=89){
                activity.setActiveId(activeId);
                activity.setActiveType("C");
                activity.setActiveName("刮刮乐");
                activity.setActiveDes("迎新生挖宝活动");
            }else if(n>=90&&n<=99){
                activity.setActiveId(activeId);
                activity.setActiveType("D");
                activity.setActiveName("现金券50元");
                activity.setActiveDes("迎新生挖宝活动");
            }
            dbObject.put("activeId",activeId);
            dbObject.put("userName",userName);
            dbObject.put("currentDate",getDate());
            dbObject.put("createTime",System.currentTimeMillis());
            dbObject.put("activeType",activity.getActiveType());
            dbObject.put("activeName",activity.getActiveName());
            dbObject.put("activeDes",activity.getActiveDes());
            dbObject.put("activeState","0");
            int res = MongoUtil.save(MongoConst.MONGO_ACTIVITY, dbObject);
            System.out.println("res:"+res);
            if(res==0){
                activity.setCheck(true);
            }else{
                activity.setCheck(false);
            }
    }
        return activity;
    }

    public Activity zhuanP(String userName, String activeId) {
        Activity activity = new Activity();
        //1.验证是否抽过奖
        boolean chou = getCheckStatus(userName, activeId,0);
        //chou = false;
        if(!chou){
            activity.setCheck(false);
        }else{
            DBObject dbObject = new BasicDBObject();
            int n = randomNo();
            if(n>=0&&n<=11){
                activity.setActiveId(activeId);
                activity.setNum(0);
                activity.setActiveType("A");
                activity.setActiveName("注册送礼");
                activity.setActiveDes("这个“牛肉”可以撕着吃");
                activity.setProductName("手撕牛肉");
                activity.setProductNum(1);
                activity.setProductPrice(0.9);
            }else if(n>=12&&n<=19){
                activity.setActiveId(activeId);
                activity.setActiveType("B");
                activity.setNum(1);
                activity.setActiveName("注册送礼");
                activity.setActiveDes("喵星人送我今喜客猫耳仔芝麻味一袋");
                activity.setProductName("今喜客猫耳仔");
                activity.setProductNum(1);
                activity.setProductPrice(1);
            }else if(n>=20&&n<=27){
                activity.setActiveId(activeId);
                activity.setActiveType("C");
                activity.setNum(2);
                activity.setActiveName("注册送礼");
                activity.setActiveDes("黑加白不等于灰，而是春夏潮流趋势的绝配，黑白配到手啦");
                activity.setProductName("黑白配");
                activity.setProductNum(1);
                activity.setProductPrice(0.9);
            }else if(n>=28&&n<=35){
                activity.setActiveId(activeId);
                activity.setActiveType("D");
                activity.setNum(3);
                activity.setActiveName("注册送礼");
                activity.setActiveDes("大大，还是小时候的味道");
                activity.setProductName("大大泡泡糖");
                activity.setProductNum(2);
                activity.setProductPrice(0.2);
            }else if(n>=36&&n<=43){
                activity.setActiveId(activeId);
                activity.setActiveType("E");
                activity.setNum(4);
                activity.setActiveName("注册送礼");
                activity.setActiveDes("吃在嘴里甜在心里，真知棒真的很棒");
                activity.setProductName("真知棒");
                activity.setProductNum(1);
                activity.setProductPrice(0.5);
            }else if(n>=44&&n<=48){
                activity.setActiveId(activeId);
                activity.setActiveType("G");
                activity.setNum(6);
                activity.setActiveName("注册送礼");
                activity.setActiveDes("对，我就是央视总是洗脑的那个舒肤佳香皂");
                activity.setProductName("舒肤佳香皂");
                activity.setProductNum(1);
                activity.setProductPrice(4.2);
            }else if(n>=49&&n<=53){//丞相
                activity.setActiveId(activeId);
                activity.setActiveType("H");
                activity.setNum(7);
                activity.setActiveName("注册送礼");
                activity.setActiveDes("爱，就是心心相印，一包纸巾，一份大爱");
                activity.setProductName("心心相印纸巾");
                activity.setProductNum(1);
                activity.setProductPrice(0.6);
            }else if(n>=54&&n<=61){//土匪
                activity.setActiveId(activeId);
                activity.setActiveType("J");
                activity.setNum(8);
                activity.setActiveName("注册送礼");
                activity.setActiveDes("你嘴巴怎么那么大，哦，原来被堵嘴薯片堵住了");
                activity.setProductName("堵嘴薯片");
                activity.setProductNum(1);
                activity.setProductPrice(1);
            }else if(n>=62&&n<=66){//土匪
                activity.setActiveId(activeId);
                activity.setActiveType("K");
                activity.setNum(9);
                activity.setActiveName("注册送礼");
                activity.setActiveDes("这个肥皂是用来洗衣服很不错");
                activity.setProductName("洗衣皂");
                activity.setProductNum(1);
                activity.setProductPrice(4.3);
            }else if(n>=67&&n<=76){//土匪
                activity.setActiveId(activeId);
                activity.setActiveType("L");
                activity.setNum(10);
                activity.setActiveName("注册送礼");
                activity.setActiveDes("这个卫龙面筋有点辣的");
                activity.setProductName("卫龙面筋");
                activity.setProductNum(1);
                activity.setProductPrice(0.4);
            }else if(n>=77&&n<=91){//土匪
                activity.setActiveId(activeId);
                activity.setActiveType("M");
                activity.setNum(11);
                activity.setActiveName("注册送礼");
                activity.setActiveDes("我不是嘴馋，只是有点饿，馋大嘴巴来一袋");
                activity.setProductName("馋大嘴巴");
                activity.setProductNum(1);
                activity.setProductPrice(0.5);
            }else if(n>=92&&n<=99){//土匪
                activity.setActiveId(activeId);
                activity.setActiveType("N");
                activity.setNum(5);
                activity.setActiveName("注册送礼");
                activity.setActiveDes("阿尔卑斯棒棒糖，爱你一辈子");
                activity.setProductName("阿尔卑斯棒棒糖");
                activity.setProductNum(1);
                activity.setProductPrice(0.5);
            }
            dbObject.put("activeId",activeId);
            dbObject.put("userName",userName);
            dbObject.put("currentDate", getDate());
            dbObject.put("createTime",System.currentTimeMillis());
            dbObject.put("activeType",activity.getActiveType());
            dbObject.put("activeName",activity.getActiveName());
            dbObject.put("productName",activity.getProductName());
            dbObject.put("productNum",activity.getProductNum());
            dbObject.put("productPrice", activity.getProductPrice());

            //dbObject.put("activeDes","每人参加一次");
            dbObject.put("activeState",1);
           // int res = MongoUtil.save(MongoConst.MONGO_ACTIVITY, dbObject);
            DBObject upObject = new BasicDBObject();
            upObject.put("activeId",activeId);
            upObject.put("activeState", 0);
            upObject.put("userName", userName);
            int update = MongoUtil.update(MongoConst.MONGO_ACTIVITY, upObject, dbObject);
            if(update==1){
                activity.setCheck(true);
            }else{
                activity.setCheck(false);
            }
        }
        return activity;
    }

    public static String getDate() {
        String DATE_FORMAT = "yyyy-MM-dd";
        SimpleDateFormat format = new SimpleDateFormat(DATE_FORMAT, Locale.getDefault());
        return format.format(new Date());
    }
    public static String getTime() {
        String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
        SimpleDateFormat format = new SimpleDateFormat(DATE_FORMAT, Locale.getDefault());
        return format.format(new Date());
    }
    public static void main(String[] args) {
        ActivityService a = new ActivityService();
        System.out.println(System.currentTimeMillis());

    }


}

