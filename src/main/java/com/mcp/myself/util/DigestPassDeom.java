package com.mcp.myself.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;

/**
 * Created by bjjg11 on 2014/8/11.
 */

public class DigestPassDeom {

    public static void main(String[] args) {

        String messageInfo = "测试用消息摘要";

        /*
        * MessageDigest  创建消息摘要字符串功能类
        * */
        MessageDigest messageDigest = null;

        try {
              /*
              * 常用的加密方式有MD5与SHA算法，这里以MD5为例
              * */
            messageDigest = MessageDigest.getInstance("MD5");
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            /*
            * 传入消息摘要内容
            * */
            messageDigest.update(messageInfo.getBytes("UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        /*
        * 计算并加密消息摘要内容
        * */
        byte[] resultMessageDigestByteArray = messageDigest.digest();
        String resultMessageDigestString = "";
        for (int loopIndex = 0; loopIndex < resultMessageDigestByteArray.length; loopIndex++) {

            /*
            * 将计算结果字节数组转换为字符串
            * */
            resultMessageDigestString =
                    resultMessageDigestString +
                            Integer.toHexString((0x000000ff & resultMessageDigestByteArray[loopIndex]) | 0xffffff00).substring(6);
        }

        System.out.println("加密结果  ：    "+resultMessageDigestString);  //b675b0474293e7a3d2a16493ea5129fb


    }


}
