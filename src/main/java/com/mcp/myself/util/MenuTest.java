package com.mcp.myself.util;


import com.mcp.myself.constant.WeiXinConstant;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;

/**
 * Created by ChubChen on 2015/6/3.
*/
public class MenuTest {

    private static final String URL = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=";

    public static void main(String[] args) throws Exception{

        String token = "zy7sM9tVIeYKGeNB-3zOaxBVYx7uBHA-knvHCfV304Nv4z0v5-DRpPVhAYXEHyZ39EFE19yB0K8t_9yfdN7PySyOZItjMM0KkJMY-rrHtGA";


        String url = URL+token;
        String pageUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + WeiXinConstant.APPID+ "&redirect_uri=http://www.mcp8.net/laundry/weixin/callback&response_type=code&scope=snsapi_base&state=";

        JSONArray button = new JSONArray();

        JSONObject buttonObj = new JSONObject();
        buttonObj.put("name", "首页" );
        buttonObj.put("type", "view" );
        buttonObj.put("url", pageUrl + "index#wechat_redirect" );
        button.put(buttonObj);


        JSONObject subObj7 = new JSONObject();
        subObj7.put("name", "订单查询");
        subObj7.put("type", "click");
        subObj7.put("key", "orders");
        button.put(subObj7);

        JSONObject buttonObj2 = new JSONObject();
        buttonObj2.put("name", "更多服务" );
        JSONObject subObj4 = new JSONObject();
        subObj4.put("type", "click");
        subObj4.put("name", "账户积分");
        subObj4.put("key", "recharge");

        JSONObject subObj5 = new JSONObject();
        subObj5.put("type", "view");
        subObj5.put("name", "登陆入口");
        subObj5.put("url", "http://www.mcp8.net/laundry/student/login.html");
        JSONArray subArray2 = new JSONArray();
        subArray2.put(subObj4);
        subArray2.put(subObj5);
        buttonObj2.put("sub_button", subArray2);
        button.put(buttonObj2);

        JSONObject object = new JSONObject();
        object.put("button", button);

        String jsonString = object.toString();
        System.out.println(jsonString);
        String result = HttpClientWrapper.postJson(url, jsonString);
        System.out.println(result);


    }
}
