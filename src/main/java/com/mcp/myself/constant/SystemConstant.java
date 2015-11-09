
package com.mcp.myself.constant;


/**
 * 系统常量
 * 
 * @author w44
 * 
 */
public class SystemConstant {


	/**
	 * 上传文件夹
	 */
	public static String UPLOAD_FOLDER = "/data/www/upload";

	/**
	 * 上传文件夹
	 */
	public static long UPLOAD_FILE_SIZE = 200000;

	/**
	 * 备份文件夹
	 */
	public static String BACKUP_FOLDER = "/WEB-INF/backup";

	/**
	 * Session中的管理员Key
	 */
	public static final String SESSION_ADMIN = "SESSION_ADMIN";

	/**
	 * Session中的管理员Key
	 */
	public static final String SESSION_SALE = "SESSION_SALE";

	/**
	 * Session中的会有Key
	 */
	public static final String SESSION_MUMBER = "SESSION_MUMBER";


	/**
	 *  分页数量
	 */
	public static final int ROW = 18;

	/**
	 *  短信模板ID
	 */
	public static final String MSG_ID = "35000";
	public static final String MSG_ID_ORDER = "40884";

	/**
	 *  有效时间 分钟
	 */
	public static final String MSG_TIME = "2";

	/**
	 *  短信地址及端口
	 */
	//*沙盒环境（用于应用开发调试）：restAPI.init("sandboxapp.cloopen.com", "8883");*
	//*生产环境（用户应用上线使用）：restAPI.init("app.cloopen.com", "8883");       *
	public static final String MSG_URL = "app.cloopen.com";
	public static final String MSG_PORT = "8883";

	/**
	 *  短信平台账户ACOUNT SID，AUTH TOKEN
	 */
	public static final String MSG_ACOUNT_SID = "8a48b5514f73ea32014f8896e1722ab5";
	public static final String MSG_AUTH_TOKEN = "b04b21a1dc6a4cda825982b7e57a995c";

	/**
	 *  短信平台账户APP ID
	 */
	public static final String MSG_APP_ID = "8a48b5514f73ea32014f8898c93d2abe";

}
