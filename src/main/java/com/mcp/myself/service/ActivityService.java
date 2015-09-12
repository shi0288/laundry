package com.mcp.myself.service;

import com.mcp.myself.bean.Activity;
import com.mcp.myself.util.MD5;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Random;

/**
 * Created by forest on 2015/8/25.
 */
@Service
public class ActivityService {
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
        System.out.println("n:" + n);
        return n;
    }
    private boolean getCheck(String userName, String activeId) {
        boolean chou = true;
        DBObject param = new BasicDBObject();
        param.put("activeId", activeId);
        param.put("userName",userName);
        param.put("currentDate", getDate());
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
        param.put("currentDate", getDate());
        int count = MongoUtil.queryCount(MongoConst.MONGO_ACTIVITY, param);
        if(count<num){
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
        boolean chou = getCheck(userName, activeId,3);
        if(chou){
            activity.setCheck(false);
        }else{
            DBObject dbObject = new BasicDBObject();
            int n = randomNo();
            if(n>=0&&n<=9){
                //var result_arr = ['你的前世是和尚','你的前世是财主','你的前世是嫔妃','你的前世是将军','你的前世是书生','你的前世是皇帝','你的前世是名妓','你的前世是老鸨','你的前世是丞相','你的前世是诗人','你的前世是佳人','你的前世是土匪'];
                activity.setActiveId(activeId);
                activity.setNum(0);
                activity.setActiveType("A");
                activity.setActiveName("辣条");
                activity.setActiveDes("获得一袋辣条");
            }else if(n>=10&&n<=19){
                activity.setActiveId(activeId);
                activity.setActiveType("B");
                activity.setNum(1);
                activity.setActiveName("辣条");
                activity.setActiveDes("当然有钱，任性，两袋辣条");
            }else if(n>=20&&n<=29){
                activity.setActiveId(activeId);
                activity.setActiveType("C");
                activity.setNum(2);
                activity.setActiveName("太阳伞");
                activity.setActiveDes("大夏天出门那么热，当然得有太阳伞");
            }else if(n>=30&&n<=44){
                activity.setActiveId(activeId);
                activity.setActiveType("D");
                activity.setNum(3);
                activity.setActiveName("鸡腿");
                activity.setActiveDes("霸气外露，来根大鸡腿");
            }else if(n>=45&&n<=69){
                activity.setActiveId(activeId);
                activity.setActiveType("E");
                activity.setNum(4);
                activity.setActiveName("碳素笔");
                activity.setActiveDes("文质彬彬，当然多写字");
            }else if(n>=90&&n<=99){
                activity.setActiveId(activeId);
                activity.setActiveType("G");
                activity.setNum(5);
                activity.setActiveName("帝王套餐");
                activity.setActiveDes("众卿家平身，一起用膳");
            }else if(n>=80&&n<=89){//丞相
                activity.setActiveId(activeId);
                activity.setActiveType("H");
                activity.setNum(9);
                activity.setActiveName("无敌大汉堡");
                activity.setActiveDes("俗话说宰相肚里能撑船，我能撑汉堡");
            }else if(n>=70&&n<=79){//土匪
                activity.setActiveId(activeId);
                activity.setActiveType("J");
                activity.setNum(11);
                activity.setActiveName("饮料");
                activity.setActiveDes("出来就是混的，讲究的就是大口吃肉大口喝饮料");
            }
            dbObject.put("activeId",activeId);
            dbObject.put("userName",userName);
            dbObject.put("currentDate",getDate());
            dbObject.put("createTime",System.currentTimeMillis());
            dbObject.put("activeType",activity.getActiveType());
            dbObject.put("activeName",activity.getActiveName());
            dbObject.put("activeDes","算命抽奖活动");
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

