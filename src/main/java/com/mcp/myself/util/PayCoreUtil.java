package com.mcp.myself.util;

import com.mcp.myself.constant.WeiXinConstant;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import org.bson.types.ObjectId;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import javax.servlet.http.HttpServletRequest;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.*;


public class PayCoreUtil {

    /** 
     * 除去数组中的空值和签名参数
     * @param sArray 签名参数组
     * @return 去掉空值与签名参数后的新签名参数组
     */
    public static Map<String, String> paraFilter(Map<String, String> sArray) {

        Map<String, String> result = new HashMap<String, String>();

        if (sArray == null || sArray.size() <= 0) {
            return result;
        }

        for (String key : sArray.keySet()) {
            String value = sArray.get(key);
            if (value == null || value.equals("") || key.equalsIgnoreCase("sign")
                || key.equalsIgnoreCase("sign_type")) {
                continue;
            }
            result.put(key, value);
        }

        return result;
    }

    /** 
     * 把数组所有元素排序，并按照“参数=参数值”的模式用“&”字符拼接成字符串
     * @param params 需要排序并参与字符拼接的参数组
     * @return 拼接后字符串
     */
    public static String createLinkString(Map<String, String> params) {

        List<String> keys = new ArrayList<String>(params.keySet());
        Collections.sort(keys);

        String prestr = "";

        for (int i = 0; i < keys.size(); i++) {
            String key = keys.get(i);
            String value = params.get(key);

            if (i == keys.size() - 1) {//拼接时，不包括最后一个&字符
                prestr = prestr + key + "=" + value;
            } else {
                prestr = prestr + key + "=" + value + "&";
            }
        }

        return prestr;
    }

    public static String map2Xml(Map<String,String> map){
        StringBuffer boot=new StringBuffer("<xml>");
        for(String key:map.keySet()){
            boot.append("<").append(key).append(">");
            boot.append(map.get(key));
            boot.append("</").append(key).append(">");
        }
        boot.append("</xml>");
        return boot.toString();
    }

    public static void main(String[] args) {
        String dd="0001";
        System.out.println(Integer.parseInt(dd));

    }


    public static String jsApi(HttpServletRequest request,String orderPrice,DBObject dbObject){

        String prepay_id="";

        String appid= WeiXinConstant.APPID;
        String mch_id= WeiXinConstant.MCH_ID;
        String device_info= WeiXinConstant.DEVICE_INFO;
        String nonce_str= UUID.randomUUID().toString().replace("-", "");
        String spbill_create_ip=request.getRemoteAddr();
        String total_fee=orderPrice.replace(".", "");
        total_fee=String.valueOf(Integer.parseInt(total_fee));
        String notify_url=WeiXinConstant.NOTIFY_URL;
        String trade_type = WeiXinConstant.TRADE_TYPE;
        String openid= (String) request.getSession().getAttribute("openId");
        String body="乐小购支付订单";
        // String detail="";
        String out_trade_no="";
        try {
            dbObject.put("orderPrice", orderPrice);
            dbObject.put("status", 1000);
            dbObject.put("createTime", System.currentTimeMillis());
            MongoUtil.insert(MongoConst.MONGO_ORDERS, dbObject);
            List tempList=MongoUtil.getDb().getCollection(MongoConst.MONGO_ORDERS).find(dbObject).toArray();
            if(tempList.size()==1){
                DBObject objOrder= (DBObject) tempList.get(0);
                out_trade_no=((ObjectId)objOrder.get("_id")).toString();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return  prepay_id;
        }

        Map<String, String> sParaTemp = new HashMap<String, String>();
        sParaTemp.put("appid",appid);
        sParaTemp.put("mch_id",mch_id);
        sParaTemp.put("device_info",device_info);
        sParaTemp.put("nonce_str",nonce_str);
        sParaTemp.put("openid",openid);
        sParaTemp.put("body",body);
        sParaTemp.put("out_trade_no",out_trade_no);
        sParaTemp.put("total_fee",total_fee);
        sParaTemp.put("spbill_create_ip",spbill_create_ip);
        sParaTemp.put("notify_url",notify_url);
        sParaTemp.put("trade_type",trade_type);

        //除去数组中的空值和签名参数
        Map<String, String> sPara = PayCoreUtil.paraFilter(sParaTemp);
        //生成签名结果
        String mysign = PayCoreUtil.createLinkString(sPara);

        String stringSignTemp=mysign+WeiXinConstant.API_SECRET;
        String sign= MD5.MD5Encode(stringSignTemp).toUpperCase();
        sPara.put("sign",sign);
        String toStr=PayCoreUtil.map2Xml(sPara);
        String result = HttpClientWrapper.postXml(WeiXinConstant.XIA_DAN, toStr);

        if(result.indexOf("FAIL")!=-1){
            return prepay_id;
        }
        Map map = null;
        try {
            map = doXMLParse(result);
        } catch (Exception e) {
            e.printStackTrace();
            return prepay_id;
        }
        prepay_id  = (String) map.get("prepay_id");
        System.out.println("获取交易ID:  "+prepay_id);

        SortedMap<String, String> finalpackage = new TreeMap<String, String>();
        String timestamp = String.valueOf(System.currentTimeMillis() / 1000);
        String packages = "prepay_id="+prepay_id;
        finalpackage.put("appId", appid);
        finalpackage.put("timeStamp", timestamp);
        finalpackage.put("nonceStr", nonce_str);
        finalpackage.put("package", packages);
        finalpackage.put("signType", "MD5");
        //除去数组中的空值和签名参数
        Map<String, String> finalpackageTemp = PayCoreUtil.paraFilter(finalpackage);
        //生成签名结果
        String packSignStr = PayCoreUtil.createLinkString(finalpackageTemp);

        packSignStr=packSignStr+WeiXinConstant.API_SECRET;
        String finalsign= MD5.MD5Encode(packSignStr).toUpperCase();

        JSONObject resultJSON=new JSONObject();
        try {
            resultJSON.put("appId",appid);
            resultJSON.put("timeStamp",timestamp);
            resultJSON.put("nonceStr",nonce_str);
            resultJSON.put("package",packages);
            resultJSON.put("signType","MD5");
            resultJSON.put("paySign",finalsign);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        //
        prepay_id = resultJSON.toString();
        DBCollection prePayCollection=MongoUtil.getDb().getCollection(MongoConst.MONGO_PREPAY);
        DBObject prePayObj=new BasicDBObject();
        prePayObj.put("orderId",out_trade_no);
        prePayObj.put("createTime",System.currentTimeMillis());
        prePayObj.put("prepay_id",prepay_id);
        prePayCollection.insert(prePayObj);
        System.out.println("V3 jsApi package:"+resultJSON.toString());
        return prepay_id;

    }


    /**
     * 解析xml,返回第一级元素键值对。如果第一级元素有子节点，则此节点的值是子节点的xml数据。
     * @param strxml
     * @return
     */
    public static Map doXMLParse(String strxml) throws Exception {
        if(null == strxml || "".equals(strxml)) {
            return null;
        }

        Map m = new HashMap();
        InputStream in = String2Inputstream(strxml);
        SAXBuilder builder = new SAXBuilder();
        Document doc = builder.build(in);
        Element root = doc.getRootElement();
        List list = root.getChildren();
        Iterator it = list.iterator();
        while(it.hasNext()) {
            Element e = (Element) it.next();
            String k = e.getName();
            String v = "";
            List children = e.getChildren();
            if(children.isEmpty()) {
                v = e.getTextNormalize();
            } else {
                v = getChildrenText(children);
            }

            m.put(k, v);
        }

        //关闭流
        in.close();

        return m;
    }
    /**
     * 获取子结点的xml
     * @param children
     * @return String
     */
    public static String getChildrenText(List children) {
        StringBuffer sb = new StringBuffer();
        if(!children.isEmpty()) {
            Iterator it = children.iterator();
            while(it.hasNext()) {
                Element e = (Element) it.next();
                String name = e.getName();
                String value = e.getTextNormalize();
                List list = e.getChildren();
                sb.append("<" + name + ">");
                if(!list.isEmpty()) {
                    sb.append(getChildrenText(list));
                }
                sb.append(value);
                sb.append("</" + name + ">");
            }
        }

        return sb.toString();
    }
    public static InputStream String2Inputstream(String str) {
        return new ByteArrayInputStream(str.getBytes());
    }


}
