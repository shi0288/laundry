package com.mcp.myself.util;

import org.apache.http.Consts;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.config.ConnectionConfig;
import org.apache.http.config.MessageConstraints;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
import java.io.IOException;
import java.nio.charset.CodingErrorAction;
import java.util.*;

public class HttpClientWrapper {


    private static CloseableHttpClient httpClient;

    protected synchronized static CloseableHttpClient getHttpClient() {
        if (httpClient == null) {
            PoolingHttpClientConnectionManager conManager = new PoolingHttpClientConnectionManager();
            MessageConstraints messageConstraints = MessageConstraints.custom().setMaxHeaderCount(200).setMaxLineLength(2000).build();
            //ConnectionConfig
            ConnectionConfig connectionConfig = ConnectionConfig.custom()
                    .setMalformedInputAction(CodingErrorAction.IGNORE)
                    .setUnmappableInputAction(CodingErrorAction.IGNORE).setCharset(Consts.UTF_8)
                    .setMessageConstraints(messageConstraints).build();

            conManager.setDefaultConnectionConfig(connectionConfig);
            RequestConfig defaultRequestConfig = RequestConfig.custom()
                    .setSocketTimeout(90000)
                    .setConnectTimeout(90000)
                    .setCookieSpec(CookieSpecs.IGNORE_COOKIES)
                    .setConnectionRequestTimeout(90000)
                    .setStaleConnectionCheckEnabled(true)
                    .build();
            httpClient = HttpClients.custom().setConnectionManager(conManager).setDefaultRequestConfig(defaultRequestConfig).build();
        }
        return httpClient;
    }

    public static String postMany(String url, Map<String, String> keys) {
        HttpPost request = new HttpPost(url);
        List<NameValuePair> reqParams = new ArrayList<NameValuePair>();
        for (String key : keys.keySet()) {
            reqParams.add(new BasicNameValuePair(key, keys.get(key)));
        }
        request.setEntity(new UrlEncodedFormEntity(reqParams, Consts.UTF_8));
        HttpContext context = HttpClientContext.create();
        String res = "";
        try {
            CloseableHttpResponse response = getHttpClient().execute(request, context);
            res = EntityUtils.toString(response.getEntity());
            res = new String(res.getBytes("ISO-8859-1"), "utf-8");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return res;
    }


    public static String postXml(String url, String xml) {
        HttpPost request = new HttpPost(url);
        request.setEntity(new StringEntity(xml, Consts.UTF_8));
        HttpContext context = HttpClientContext.create();
        String res = "";
        try {
            CloseableHttpResponse response = getHttpClient().execute(request, context);
            res = EntityUtils.toString(response.getEntity());
            res = new String(res.getBytes("ISO-8859-1"), "utf-8");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return res;
    }




    public static String getUrl(String url){
        HttpGet request = new HttpGet(url);
        //添加timeout属性
        RequestConfig.Builder rcBuilder = RequestConfig.copy(RequestConfig.DEFAULT);
        rcBuilder.setConnectTimeout(90000);
        rcBuilder.setSocketTimeout(90000);
        request.setConfig(rcBuilder.build());
        String res = "";
        try {
            CloseableHttpResponse response = getHttpClient().execute(request);
            res = EntityUtils.toString(response.getEntity());
            res = new String(res.getBytes("ISO-8859-1"), "utf-8");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return res;
    }

    /**
     * 提交json类型
     * @param url
     * @param jsonContent
     * @return
     */
    public static String postJson(String url, String jsonContent){
        HttpClient httpClient = getHttpClient();
        HttpPost method = new HttpPost(url);
        StringEntity entity = null;//解决中文乱码问题
        String res = "";
        try {
            entity = new StringEntity(jsonContent, "UTF-8");
            entity.setContentType("application/json");
            method.setEntity(entity);
            HttpResponse result = httpClient.execute(method);
            res = EntityUtils.toString(result.getEntity());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }

    public static String cmbcPost(String url, String key, String param) {
        HttpPost request = new HttpPost(url);
        List<NameValuePair> reqParams = new ArrayList<NameValuePair>();
        reqParams.add(new BasicNameValuePair(key, param));
        request.setEntity(new UrlEncodedFormEntity(reqParams, Consts.UTF_8));
        HttpContext context = HttpClientContext.create();
        String res = "";
        try {
            CloseableHttpResponse response = getHttpClient().execute(request, context);
            res = EntityUtils.toString(response.getEntity());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return res;
    }



    public static String getGbkUrl(String url){
        HttpGet request = new HttpGet(url);
        //添加timeout属性
        RequestConfig.Builder rcBuilder = RequestConfig.copy(RequestConfig.DEFAULT);
        rcBuilder.setConnectTimeout(90000);
        rcBuilder.setSocketTimeout(90000);
        request.setConfig(rcBuilder.build());
        String res = "";
        try {
            CloseableHttpResponse response = getHttpClient().execute(request);
            res = EntityUtils.toString(response.getEntity());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return res;
    }

}
