package com.mcp.myself.service;


import com.mcp.myself.util.MongoConst;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by bjjg11 on 2014/8/5.
 */


@Service
public class OrderService extends BaseService{

    private String MONGO_NAME=MongoConst.MONGO_ORDERS;


    public ModelMap getAllListPage(ModelMap modelMap,HttpServletRequest request) {
        return this.getAllListPage(MONGO_NAME,modelMap,request);
    }

}

