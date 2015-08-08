package com.mcp.myself.controller.ljj;

import com.mcp.myself.bean.JsonVo;
import com.mcp.myself.constant.SystemConstant;
import com.mcp.myself.service.MainProService;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
@Controller
@RequestMapping("ljj/mainPro")
public class MainProController extends BaseAction {


    @Autowired
    private MainProService mainProService;

    @RequestMapping(value = "list.htm", method = RequestMethod.GET)
    public String list(
            HttpServletRequest request, ModelMap modelMap) {
        modelMap = mainProService.getAllListPageMainPro(modelMap, request);
        return "ljj/mainPro/list";
    }

    @ResponseBody
    @RequestMapping("add.json")
    public JsonVo<DBObject> upload(@RequestParam("name") String name, @RequestParam("status") int status,
                                   @RequestParam("file") MultipartFile f,
                                   HttpServletRequest request) throws IllegalStateException,
            IOException {
        JsonVo<DBObject> json = new JsonVo<DBObject>();
        System.out.println("name:  " + name);
        System.out.println("status  " + status);
        //获取文件 存储位置
        String realPath = request.getSession().getServletContext()
                .getRealPath(SystemConstant.UPLOAD_FOLDER+"/img");
        File pathFile = new File(realPath);
        if (!pathFile.exists()) {
            //文件夹不存 创建文件
            pathFile.mkdirs();
        }
        long fileSize= f.getSize();
        if(fileSize>SystemConstant.UPLOAD_FILE_SIZE){
            json.setMsg("文件太大了，弄小点");
            json.setResult(false);
            return json;
        }
        //将文件copy上传到服务器
        String[] jpgArr=f.getOriginalFilename().split("\\.");
        String jpg=jpgArr[jpgArr.length-1];
        if(!"jpg".equals(jpg)){
            json.setMsg("文件格式不支持上传");
            json.setResult(false);
            return json;
        }
        String fileName = System.currentTimeMillis()+"."+jpg;
        f.transferTo(new File(realPath + "/" + fileName));
        //校验
        if (StringUtils.isBlank(name)) {
            json.setMsg("名字不能为空");
            json.setResult(false);
            return json;
        }
        DBObject dbObject = new BasicDBObject();
        dbObject.put("name", name);
        dbObject.put("status", status);
        dbObject.put("fileName", fileName);
        dbObject.put("createTime",System.currentTimeMillis());
        MongoUtil.getDb().getCollection(MongoConst.MONGO_MAINPRO).insert(dbObject);
        json.setResult(true);
        return json;
    }


    /**
     * 更新
     */
    @RequestMapping(value = "update.htm", method = RequestMethod.GET)
    public String update(@RequestParam(value = "id") String id,
                         ModelMap modelMap) {
        DBObject dbObject = mainProService.getByIdMainPro(id);
        modelMap.put("e", dbObject);
        return "ljj/mainPro/update";
    }

}