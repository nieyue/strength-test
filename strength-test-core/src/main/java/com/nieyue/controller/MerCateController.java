package com.nieyue.controller;

import com.nieyue.bean.MerCate;
import com.nieyue.service.MerCateService;
import com.nieyue.util.StateResultList;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;


/**
 * 商品类型控制类
 * @author yy
 *
 */
@Api(tags={"merCate"},value="商品类型",description="商品类型管理")
@RestController
@RequestMapping("/merCate")
public class MerCateController extends BaseController<MerCate,Long> {
	@Resource
	private MerCateService merCateService;
	
	/**
	 * 商品类型分页浏览
	 * @param orderName 商品排序数据库字段
	 * @param orderWay 商品排序方法 asc升序 desc降序
	 * @return
	 */
	@ApiOperation(value = "商品类型列表", notes = "商品类型分页浏览")
	@ApiImplicitParams({
	  		@ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
			@ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
	  		@ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="updateDate"),
	  		@ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	  })
	@RequestMapping(value = "/list", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<MerCate>> list(
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="updateDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {
			StateResultList<List<MerCate>> rl = super.list(pageNum, pageSize, orderName, orderWay,null);
			return rl;
	}
	/**
	 * 商品类型修改
	 * @return
	 */
	@ApiOperation(value = "商品类型修改", notes = "商品类型修改")
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<MerCate>> update(@ModelAttribute MerCate merCate,HttpSession session)  {
		merCate.setUpdateDate(new Date());
		StateResultList<List<MerCate>> u = super.update(merCate);
		return u;
	}
	/**
	 * 商品类型增加
	 * @return 
	 */
	@ApiOperation(value = "商品类型增加", notes = "商品类型增加")
	@RequestMapping(value = "/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<MerCate>> add(@ModelAttribute MerCate merCate, HttpSession session) {
		merCate.setCreateDate(new Date());
		merCate.setUpdateDate(new Date());
		StateResultList<List<MerCate>> a = super.add(merCate);
		return a;
	}
	/**
	 * 商品类型删除
	 * @return
	 */
	@ApiOperation(value = "商品类型删除", notes = "商品类型删除")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="merCateId",value="商品类型ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<MerCate>> delete(@RequestParam("merCateId") Long merCateId,HttpSession session)  {
		StateResultList<List<MerCate>> d = super.delete(merCateId);
		return d;
	}
	/**
	 * 商品类型浏览数量
	 * @return
	 */
	@ApiOperation(value = "商品类型数量", notes = "商品类型数量查询")
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(
			HttpSession session)  {
		StateResultList<List<Integer>> c = super.count(null);
		return c;
	}
	/**
	 * 商品类型单个加载
	 * @return
	 */
	@ApiOperation(value = "商品类型单个加载", notes = "商品类型单个加载")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="merCateId",value="商品类型ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/load", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<MerCate>> loadMerCate(@RequestParam("merCateId") Long merCateId,HttpSession session)  {
		 StateResultList<List<MerCate>> l = super.load(merCateId);
		 return l;
	}
	
}
