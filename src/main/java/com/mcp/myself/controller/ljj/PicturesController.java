package com.mcp.myself.controller.ljj;

import com.mcp.myself.bean.JsonVo;
import com.mcp.myself.constant.SystemConstant;
import com.mcp.myself.service.PicturesService;
import com.mcp.myself.util.MongoConst;
import com.mcp.myself.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import org.apache.commons.lang3.StringUtils;
import org.bson.types.ObjectId;
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
@RequestMapping("ljj/pictures")
public class PicturesController extends BaseAction {


    @Autowired
    private PicturesService picturesService;

    @RequestMapping(value = "list.htm", method = RequestMethod.GET)
    public String list(
            HttpServletRequest request, ModelMap modelMap) {
        modelMap = picturesService.getAllListPage(modelMap, request);
        return "ljj/pictures/list";
    }

    @ResponseBody
    @RequestMapping("add.json")
    public JsonVo<DBObject> add(String name,String urlName,int status,int sort,MultipartFile file,HttpServletRequest request) throws
            IOException{
        JsonVo<DBObject> json = new JsonVo<DBObject>();

        if (file==null) {
            json.setMsg("必须上传图片");
            json.setResult(false);
            return json;
        }
        //获取文件 存储位置
        String realPath = SystemConstant.UPLOAD_FOLDER+"/img";
        File pathFile = new File(realPath);
        if (!pathFile.exists()) {
            //文件夹不存 创建文件
            pathFile.mkdirs();
        }
        long fileSize= file.getSize();
        if(fileSize>SystemConstant.UPLOAD_FILE_SIZE){
            json.setMsg("文件太大了，弄小点");
            json.setResult(false);
            return json;
        }
        //将文件copy上传到服务器
        String[] jpgArr=file.getOriginalFilename().split("\\.");
        String jpg=jpgArr[jpgArr.length-1];
        if(!"jpg".equals(jpg)){
            json.setMsg("文件格式不支持上传");
            json.setResult(false);
            return json;
        }
        String fileName = System.currentTimeMillis()+"."+jpg;
        file.transferTo(new File(realPath + "/" + fileName));
        //校验
        if (StringUtils.isBlank(name)) {
            json.setMsg("名字不能为空");
            json.setResult(false);
            return json;
        }
        //校验
        if (StringUtils.isBlank(urlName)) {
            json.setMsg("链接不能为空");
            json.setResult(false);
            return json;
        }
        DBObject dbObject = new BasicDBObject();
        dbObject.put("name", name);
        dbObject.put("urlName", urlName);
        dbObject.put("status", status);
        dbObject.put("sort", sort);
        dbObject.put("fileName", fileName);
        dbObject.put("createTime",System.currentTimeMillis());
        MongoUtil.getDb().getCollection(MongoConst.MONGO_PICTURES).insert(dbObject);
        json.setResult(true);
        return json;
    }



    /**
     * 进入更新
     */
    @RequestMapping(value = "update.htm", method = RequestMethod.GET)
    public String update(@RequestParam(value = "id") String id,
                         ModelMap modelMap) {
        DBObject dbObject = picturesService.getById(id);
        modelMap.put("e", dbObject);
        return "ljj/pictures/update";
    }


    /**
     * 更新
     */
    @ResponseBody
    @RequestMapping("update.json")
    public JsonVo<DBObject> updateEntity(String id,String name,String urlName,int sort,int status,MultipartFile file,HttpServletRequest request) throws
            IOException {
        //获取文件 存储位置
        JsonVo<DBObject> json = new JsonVo<DBObject>();
        String fileName=null;
        if (file!=null) {
            //获取文件 存储位置
            String realPath = SystemConstant.UPLOAD_FOLDER+"/img";
            File pathFile = new File(realPath);
            if (!pathFile.exists()) {
                //文件夹不存 创建文件
                pathFile.mkdirs();
            }
            long fileSize= file.getSize();
            if(fileSize>SystemConstant.UPLOAD_FILE_SIZE){
                json.setMsg("文件太大了，弄小点");
                json.setResult(false);
                return json;
            }
            //将文件copy上传到服务器
            String[] jpgArr=file.getOriginalFilename().split("\\.");
            String jpg=jpgArr[jpgArr.length-1];
            if(!"jpg".equals(jpg)){
                json.setMsg("文件格式不支持上传");
                json.setResult(false);
                return json;
            }
            fileName = System.currentTimeMillis()+"."+jpg;
            file.transferTo(new File(realPath + "/" + fileName));
        }
        //校验
        if (StringUtils.isBlank(name)) {
            json.setMsg("名字不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(id)) {
            json.setMsg("id不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(urlName)) {
            json.setMsg("链接不能为空");
            json.setResult(false);
            return json;
        }
        DBObject dbObject = new BasicDBObject();
        dbObject.put("_id",new ObjectId(id));
        dbObject.put("name", name);
        dbObject.put("urlName", urlName);
        dbObject.put("status", status);
        dbObject.put("sort", sort);
        if(fileName!=null){
            dbObject.put("fileName", fileName);
        }
        json.setResult(picturesService.update(dbObject));
        return json;
    }


}