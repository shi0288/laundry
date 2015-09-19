
package com.mcp.myself.constant;


/**
 * 系统常量
 *
 * @author w44
 */
public class WeiXinConstant {


    public static final String APPID = "wx53239078f0df4887";
    public static final String APPSECRET = "d41c5a19618ec40cad4334fa0054a513";


    public static final String MCH_ID = "1268917201";
    public static final String DEVICE_INFO = "WEB";
    public static final String NOTIFY_URL = "http://www.mcp8.net/laundry/weixin/dealWeiPay";
    public static final String TRADE_TYPE = "JSAPI";

    public static final String API_SECRET = "&key=b1eea7f5a3c44e528554b530d9ff96be";
    public static final String XIA_DAN = "https://api.mch.weixin.qq.com/pay/unifiedorder";


    public static final String MESSAGE_PAY_ID = "p1Gd4ypZ1ajFrEl6NTAsb94hBoPAH-ihirUS7J719pI";
    public static final String MESSAGE_FINISH_ID = "VAcs84W1katcGOu9GgjN5beOyCZDYK6ffQZG3GNFYjA";
    public static final String MESSAGE_CANCEL_ID = "-6-kYKAg_uVWE4UE7AO-7Sb70NSP54TSHx4uOwoSSZ4";


    public static final String QUERY_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + APPID + "&secret=" + APPSECRET;
    public static final String QUERY_USEINFO_URL = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=%ACCESS_TOKEN%&openid=%OPENID%&lang=zh_CN";

}
