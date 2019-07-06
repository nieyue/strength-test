package com.nieyue.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.MerImg;
import com.nieyue.service.MerImgService;
import com.nieyue.util.MyDom4jUtil;
import com.nieyue.util.StateResultList;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 商品图片控制类
 * @author yy
 *
 */
@Api(tags={"merImg"},value="商品图片",description="商品图片管理")
@RestController
@RequestMapping("/merImg")
public class MerImgController extends BaseController<MerImg,Long> {
	@Resource
	private MerImgService merImgService;


	/**
	 * 商品图片分页浏览
	 * @param orderName 商品图片排序数据库字段
	 * @param orderWay 商品图片排序方法 asc升序 desc降序
	 * @return
	 */
	@ApiOperation(value = "商品图片列表", notes = "商品图片分页浏览")
	@ApiImplicitParams({
			@ApiImplicitParam(name="merId",value="商品id外键",dataType="long", paramType = "query"),
	  		@ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
			@ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
	  		@ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="updateDate"),
	  		@ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	  })
	@RequestMapping(value = "/list", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<MerImg>> list(
			@RequestParam(value="merId",required=false)Long merId,
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="updateDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {

			Wrapper<MerImg> wrapper=new EntityWrapper<>();
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("mer_id", merId);
			wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
			StateResultList<List<MerImg>> rl = super.list(pageNum, pageSize, orderName, orderWay,wrapper);
			return rl;
	}
	/**
	 * 商品图片修改
	 * @return
	 */
	@ApiOperation(value = "商品图片修改", notes = "商品图片修改")
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<MerImg>> update(@ModelAttribute MerImg merImg,HttpSession session)  {
		merImg.setUpdateDate(new Date());
		StateResultList<List<MerImg>> u = super.update(merImg);
		return u;
	}
	/**
	 * 商品图片增加
	 * @return 
	 */
	@ApiOperation(value = "商品图片增加", notes = "商品图片增加")
	@RequestMapping(value = "/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<MerImg>> add(@ModelAttribute MerImg merImg, HttpSession session) {
		merImg.setCreateDate(new Date());
		merImg.setUpdateDate(new Date());
		StateResultList<List<MerImg>> a = super.add(merImg);
		return a;
	}
	/**
	 * 商品图片删除
	 * @return
	 */
	@ApiOperation(value = "商品图片删除", notes = "商品图片删除")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="merImgId",value="商品图片ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<MerImg>> delete(@RequestParam("merImgId") Long merImgId,HttpSession session)  {
		StateResultList<List<MerImg>> d = super.delete(merImgId);
		return d;
	}
	/**
	 * 商品图片浏览数量
	 * @return
	 */
	@ApiOperation(value = "商品图片数量", notes = "商品图片数量查询")
	@ApiImplicitParams({
			@ApiImplicitParam(name="merId",value="商品id外键",dataType="long", paramType = "query"),
	})
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(
			@RequestParam(value="merId",required=false)Long merId,
			HttpSession session)  {
		Wrapper<MerImg> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("mer_id", merId);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		StateResultList<List<Integer>> c = super.count(wrapper);
		return c;
	}
	/**
	 * 商品图片单个加载
	 * @return
	 */
	@ApiOperation(value = "商品图片单个加载", notes = "商品图片单个加载")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="merImgId",value="商品图片ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/load", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<MerImg>> loadMerImg(@RequestParam("merImgId") Long merImgId,HttpSession session)  {
		 StateResultList<List<MerImg>> l = super.load(merImgId);
		 return l;
	}


}
