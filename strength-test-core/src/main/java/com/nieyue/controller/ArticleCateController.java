package com.nieyue.controller;

import com.nieyue.bean.ArticleCate;
import com.nieyue.service.ArticleCateService;
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
 * 文章类型控制类
 * @author yy
 *
 */
@Api(tags={"articleCate"},value="文章类型",description="文章类型管理")
@RestController
@RequestMapping("/articleCate")
public class ArticleCateController extends BaseController<ArticleCate,Long> {
	@Resource
	private ArticleCateService articleCateService;
	
	/**
	 * 文章类型分页浏览
	 * @param orderName 商品排序数据库字段
	 * @param orderWay 商品排序方法 asc升序 desc降序
	 * @return
	 */
	@ApiOperation(value = "文章类型列表", notes = "文章类型分页浏览")
	@ApiImplicitParams({
	  @ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
	  @ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
	  @ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="updateDate"),
	  @ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	  })
	@RequestMapping(value = "/list", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<ArticleCate>> list(
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="updateDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {
			StateResultList<List<ArticleCate>> rl = super.list(pageNum, pageSize, orderName, orderWay,null);
			return rl;
	}
	/**
	 * 文章类型修改
	 * @return
	 */
	@ApiOperation(value = "文章类型修改", notes = "文章类型修改")
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<ArticleCate>> update(@ModelAttribute ArticleCate articleCate,HttpSession session)  {
		articleCate.setUpdateDate(new Date());
		StateResultList<List<ArticleCate>> u = super.update(articleCate);
		return u;
	}
	/**
	 * 文章类型增加
	 * @return 
	 */
	@ApiOperation(value = "文章类型增加", notes = "文章类型增加")
	@RequestMapping(value = "/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<ArticleCate>> add(@ModelAttribute ArticleCate articleCate, HttpSession session) {
		articleCate.setCreateDate(new Date());
		articleCate.setUpdateDate(new Date());
		StateResultList<List<ArticleCate>> a = super.add(articleCate);
		return a;
	}
	/**
	 * 文章类型删除
	 * @return
	 */
	@ApiOperation(value = "文章类型删除", notes = "文章类型删除")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="articleCateId",value="文章类型ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<ArticleCate>> delete(@RequestParam("articleCateId") Long articleCateId,HttpSession session)  {
		StateResultList<List<ArticleCate>> d = super.delete(articleCateId);
		return d;
	}
	/**
	 * 文章类型浏览数量
	 * @return
	 */
	@ApiOperation(value = "文章类型数量", notes = "文章类型数量查询")
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(HttpSession session)  {
		StateResultList<List<Integer>> c = super.count(null);
		return c;
	}
	/**
	 * 文章类型单个加载
	 * @return
	 */
	@ApiOperation(value = "文章类型单个加载", notes = "文章类型单个加载")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="articleCateId",value="文章类型ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/load", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<ArticleCate>> loadArticleCate(@RequestParam("articleCateId") Long articleCateId,HttpSession session)  {
		 StateResultList<List<ArticleCate>> l = super.load(articleCateId);
		 return l;
	}
	
}
