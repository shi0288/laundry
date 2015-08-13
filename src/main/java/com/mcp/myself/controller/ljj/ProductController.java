package com.mcp.myself.controller.ljj;

import com.mcp.myself.bean.JsonVo;
import com.mcp.myself.constant.SystemConstant;
import com.mcp.myself.service.ProductService;
import com.mcp.myself.util.MD5;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("ljj/product")
public class ProductController extends BaseAction {


    @Autowired
    private ProductService productService;

    @RequestMapping(value = "list.htm", method = RequestMethod.GET)
    public String list(
            HttpServletRequest request, ModelMap modelMap) {
        modelMap = productService.getAllListPage(modelMap, request);
        List mainPro = MongoUtil.queryAll(MongoConst.MONGO_MAINPRO, null, "createTime", 1);
        modelMap.put("mainPro", mainPro);
        List sortPro = MongoUtil.queryAll(MongoConst.MONGO_SORTPRO, null, "createTime", 1);
        modelMap.put("sortPro", sortPro);
        List brand = MongoUtil.queryAll(MongoConst.MONGO_BRAND, null, "createTime", 1);
        modelMap.put("brand", brand);
        return "ljj/product/list";
    }

    @ResponseBody
    @RequestMapping("add.json")
    public JsonVo<DBObject> add(String name, int status, String mainProId, String sortProId, String brandId, int oldPrice, int price,String desc,
                                MultipartHttpServletRequest request) throws
            IOException {
        List<MultipartFile> files = request.getFiles("files");
        JsonVo<DBObject> json = new JsonVo<DBObject>();
        String fileName = null;
        List fileNames = new ArrayList();
        if (files.size() == 0) {
            json.setMsg("文件不能为空");
            json.setResult(false);
            return json;
        }
        for (int i = 0; i < files.size(); i++) {
            MultipartFile file = files.get(i);
            //获取文件 存储位置
            String realPath = request.getSession().getServletContext()
                    .getRealPath(SystemConstant.UPLOAD_FOLDER + "/img");
            File pathFile = new File(realPath);
            if (!pathFile.exists()) {
                //文件夹不存 创建文件
                pathFile.mkdirs();
            }
            long fileSize = file.getSize();
            if (fileSize > SystemConstant.UPLOAD_FILE_SIZE) {
                json.setMsg("文件太大了，弄小点");
                json.setResult(false);
                return json;
            }
            //将文件copy上传到服务器
            String[] jpgArr = file.getOriginalFilename().split("\\.");
            String jpg = jpgArr[jpgArr.length - 1];
            if (!"jpg".equals(jpg)) {
                json.setMsg("文件格式不支持上传");
                json.setResult(false);
                return json;
            }
            fileName = System.currentTimeMillis() + MD5.MondomStr(8).toUpperCase() + "." + jpg;
            file.transferTo(new File(realPath + "/" + fileName));
            fileNames.add(fileName);
        }

        //校验
        if (StringUtils.isBlank(name)) {
            json.setMsg("名字不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(mainProId)) {
            json.setMsg("主题不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(sortProId)) {
            json.setMsg("分类不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(brandId)) {
            json.setMsg("品牌不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(desc)) {
            json.setMsg("描述不能为空");
            json.setResult(false);
            return json;
        }
        DBObject dbObject = new BasicDBObject();
        dbObject.put("name", name);
        dbObject.put("status", status);
        dbObject.put("mainProId", mainProId);
        dbObject.put("sortProId", sortProId);
        dbObject.put("brandId", brandId);
        dbObject.put("oldPrice", oldPrice);
        dbObject.put("price", price);
        dbObject.put("saleNum", 0);
        dbObject.put("clickNum", 0);
        dbObject.put("desc", desc);
        dbObject.put("fileNames", fileNames);
        dbObject.put("createTime", System.currentTimeMillis());
        MongoUtil.getDb().getCollection(MongoConst.MONGO_PRODUCT).insert(dbObject);
        json.setResult(true);
        return json;
    }


    /**
     * 进入更新
     */
    @RequestMapping(value = "update.htm", method = RequestMethod.GET)
    public String update(@RequestParam(value = "id") String id,
                         ModelMap modelMap) {
        DBObject dbObject = productService.getById(id);
        modelMap.put("e", dbObject);
        return "ljj/product/update";
    }

    /**
     * 更新
     */

    @ResponseBody
    @RequestMapping("update.json")
    public JsonVo<DBObject> updateEntity(String id, String name, int status, String colorTip,
                                         MultipartFile[] files, HttpServletRequest request) throws IllegalStateException,
            IOException {
        //获取文件 存储位置
        JsonVo<DBObject> json = new JsonVo<DBObject>();
        String fileName = null;
        List fileNames = new ArrayList();
        if (files != null) {
            for (int i = 0; i < files.length; i++) {
                MultipartFile file = files[i];
                //获取文件 存储位置
                String realPath = request.getSession().getServletContext()
                        .getRealPath(SystemConstant.UPLOAD_FOLDER + "/img");
                File pathFile = new File(realPath);
                if (!pathFile.exists()) {
                    //文件夹不存 创建文件
                    pathFile.mkdirs();
                }
                long fileSize = file.getSize();
                if (fileSize > SystemConstant.UPLOAD_FILE_SIZE) {
                    json.setMsg("文件太大了，弄小点");
                    json.setResult(false);
                    return json;
                }
                //将文件copy上传到服务器
                String[] jpgArr = file.getOriginalFilename().split("\\.");
                String jpg = jpgArr[jpgArr.length - 1];
                if (!"jpg".equals(jpg)) {
                    json.setMsg("文件格式不支持上传");
                    json.setResult(false);
                    return json;
                }
                fileName = System.currentTimeMillis() + "." + jpg;
                file.transferTo(new File(realPath + "/" + fileName));
                fileNames.add(fileName);
            }
        }


        if (StringUtils.isBlank(id)) {
            json.setMsg("id不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(name)) {
            json.setMsg("名字不能为空");
            json.setResult(false);
            return json;
        }
        if (StringUtils.isBlank(colorTip)) {
            json.setMsg("颜色不能为空");
            json.setResult(false);
            return json;
        }
        DBObject dbObject = new BasicDBObject();
        dbObject.put("_id", new ObjectId(id));
        dbObject.put("status", status);
        dbObject.put("colorTip", colorTip);
        dbObject.put("name", name);
        dbObject.put("fileNames", fileNames);
        json.setResult(productService.update(dbObject));
        return json;
    }


}