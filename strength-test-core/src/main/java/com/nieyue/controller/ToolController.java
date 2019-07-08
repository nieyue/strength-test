package com.nieyue.controller;

import com.nieyue.util.DateUtil;
import com.nieyue.util.FileUploadUtil;
import com.nieyue.util.MyQRcode;
import com.nieyue.util.ThumbnailatorUtils;
import com.nieyue.verification.VerificationCode;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;



/**
 * 工具控制类
 * @author yy
 *
 */
@Api(tags={"tool"},value="工具",description="工具接口管理")
@RestController
@RequestMapping("/tool")
public class ToolController extends BaseController<Object,Long>{
	@Resource
	VerificationCode verificationCode;
	@Value("${myPugin.uploaderPath.rootPath}")
	String rootPath;
	@Value("${myPugin.uploaderPath.locationPath}")
	String locationPath;

	/**
	 * cors
	 * @return
	 */
	@ApiOperation(value = "cors", notes = "cors")
	@RequestMapping(value = "/cors", method = {RequestMethod.GET,RequestMethod.POST})
	public RedirectView cors(
			@RequestParam("callbackurl") String callbackurl,
			HttpSession	 session
	){
		return new RedirectView(callbackurl);

	}
	/**
	 * 验证码
	 * @return
	 * @throws Exception 
	 */
	@ApiOperation(value = "验证码", notes = "验证码")
	@RequestMapping(value = "/getVerificationCode", method = {RequestMethod.GET,RequestMethod.POST})
	public void getVerificationCode(
			HttpSession session,HttpServletRequest request,HttpServletResponse response) throws Exception{
			ByteArrayOutputStream vc = verificationCode.execute(session);
			response.getOutputStream().write(vc.toByteArray());
		return ;
	}
	/**
	 * 生成二维码
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "生成二维码", notes = "生成二维码")
	@RequestMapping(value = "/getQrCode", method = {RequestMethod.GET,RequestMethod.POST})
	@ApiImplicitParams({
			@ApiImplicitParam(name="url",value="url链接",dataType="string", paramType = "query"),
	})
	public void getQrCode(
			@RequestParam("url") String url,
			HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		MyQRcode.createQrcode(url, response.getOutputStream());
		return ;
	}
	/**
	 * 文件增加、修改
	 * @return
	 * @throws IOException 
	 */
	@ApiOperation(value = "上传文件", notes = "上传文件")
	@RequestMapping(value = "/file/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody String addFile(
			@RequestParam("editorUpload") MultipartFile file,
			HttpServletRequest request,HttpSession session ) throws IOException  {
		String fileUrl = null;
		String filedir=DateUtil.getImgDir();
		try{
			fileUrl = FileUploadUtil.FormDataMerImgFileUpload(file, session,rootPath,locationPath,filedir);
		}catch (IOException e) {
			throw new IOException();
		}
		StringBuffer url=request.getRequestURL();
		String redirect_url = url.delete(url.length() - request.getRequestURI().length(), url.length()).toString(); 
		return redirect_url+fileUrl;
	}
	/**
	 * 图片增加、修改
	 * @param file 上传图片
	 * @param width （可选）固定图片宽度
	 * @param height （可选）固定图片高度
	 * @param compression 默认0，原图不压缩，1压缩最优
	 * @return
	 * @throws IOException 
	 */
	@ApiOperation(value = "上传图片", notes = "上传图片")
	@RequestMapping(value = "/img/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody String addAdvertiseImg(
			@RequestParam("editorUpload") MultipartFile file,
			@RequestParam(value="width",required=false) Integer width,
			@RequestParam(value="height",required=false) Integer height,
			@RequestParam(value="compression",required=false,defaultValue="0")Integer compression,
			HttpServletRequest request,HttpSession session ) throws IOException  {
		String imgUrl = null;
		String imgdir=DateUtil.getImgDir();
		Map<String ,Integer> kgmap=new HashMap<String,Integer>();
		kgmap.put("width", width);
		kgmap.put("height", height);
		kgmap.put("compression", compression);
		try{
			imgUrl = ThumbnailatorUtils.fileUpload(file, session,rootPath,locationPath,imgdir,kgmap);
		}catch (IOException e) {
			throw new IOException();
		}
		StringBuffer url=request.getRequestURL();
		String redirect_url = url.delete(url.length() - request.getRequestURI().length(), url.length()).toString(); 
		//String redirect_url="http://118.123.15.27";
		return redirect_url+imgUrl;
	}
	/**
	 * 获取Session
	 * @return
	 */
	@ApiOperation(value = "获取sessionId", notes = "获取sessionId")
	@RequestMapping(value = "/getSession", method = {RequestMethod.GET,RequestMethod.POST})
	public String getSession(
			HttpSession	 session
			){
		System.err.println(session.getAttribute("account"));
		System.err.println(session.getAttribute("role"));
		System.err.println(session.getAttribute("finance"));
		System.err.println(session.getAttribute("rolePermission"));
		this.logger.debug("\naccount：\n{} ",session.getAttribute("account"));
		this.logger.info("\nrole：\n{} ",session.getAttribute("role"));
		this.logger.warn("\nfinance：\n{} ",session.getAttribute("finance"));
		this.logger.warn("\nrolePermission：\n{} ",session.getAttribute("rolePermission"));
		//this.logger.error("\ngetId：\n{} ",session.getId());
		return session.getId();
		
	}
	@Autowired
	StringRedisTemplate stringRedisTemplate;
	/**
	 * test
	 * @return
	 * @throws InterruptedException 
	 */
	@ApiOperation(value = "test", notes = "test")
	@RequestMapping(value = "/test", method = {RequestMethod.GET,RequestMethod.POST})
	public  String test(
			HttpServletRequest request,
			HttpSession	 session
			) throws Exception{
		BufferedReader br = request.getReader();
		String str, wholeStr = "";
		while((str = br.readLine()) != null){
			wholeStr += str;
		}
		JSONObject json = JSONObject.fromObject(wholeStr);

		return (String)json.get("orderId");
	}

}
