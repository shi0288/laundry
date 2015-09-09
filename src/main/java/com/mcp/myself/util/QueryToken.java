package com.mcp.myself.util;

import com.mcp.myself.constant.WeiXinConstant;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

/**
 * Created by ChubChen on 2015/6/3.
 */
public class QueryToken {

    private static final String URL = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&";
    //https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN
    public static void main(String[] args){
        String url = URL+"appid=" + WeiXinConstant.APPID +"&secret=" + WeiXinConstant.APPSECRET;
        String result = HttpClientWrapper.getUrl(url);
        System.out.println(result);
        JSONObject jsonObject = null;
        try {
            jsonObject = new JSONObject(result);
            String access_token =  jsonObject.get("access_token").toString();
            String expires_in =   jsonObject.get("expires_in").toString();
            if(access_token!=null){
                System.out.println(access_token);

                //   WeiXinDao.updateToken(access_token);
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

//        String token = "MPN6SWAH3F-lbYlTA30g3pyV7xbNcjNk0GF8L0fEzfJQZOl3lnFz9Fb0R9QQvv-_icsDU-RVXdNId6UUFeZY1cnlHsMc9tjCQCfiD7plZmE";
//        String url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token="+token+"&openid=o0LrFuAlDa3g0QG-SPTsIyJDUrc4&lang=zh_CN";
//        String result = HttpClientWrapper.getUrl(url);
//        System.out.println(result);

    }
}
