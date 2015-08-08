package com.mcp.myself.service;


import com.mcp.myself.util.MongoConst;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import javax.servlet.http.HttpServletRequest;
/**
 * Created by bjjg11 on 2014/8/5.
 */


@Service
public class UserService extends BaseService{

    public ModelMap getAllListPageUser(ModelMap modelMap,HttpServletRequest request) {
        return this.getAllListPage(MongoConst.MONGO_MEMBER,modelMap,request);
    }

}

