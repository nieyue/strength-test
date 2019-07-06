package com.nieyue.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.Article;
import com.nieyue.service.ArticleService;
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
 * 文章控制类
 * @author yy
 *
 */
@Api(tags={"article"},value="文章",description="文章管理")
@RestController
@RequestMapping("/article")
public class ArticleController extends BaseController<Article,Long> {
	@Resource
	private ArticleService articleService;


	/**
	 * 文章分页浏览
	 * @param orderName 文章排序数据库字段
	 * @param orderWay 文章排序方法 asc升序 desc降序
	 * @return
	 */
	@ApiOperation(value = "文章列表", notes = "文章分页浏览")
	@ApiImplicitParams({
			@ApiImplicitParam(name="articleCateId",value="文章类型id外键",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="status",value="状态,1上架,2下架",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
			@ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
			@ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="updateDate"),
			@ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	})
	@RequestMapping(value = "/list", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Article>> list(
			@RequestParam(value="articleCateId",required=false)Long articleCateId,
			@RequestParam(value="status",required=false)Integer status,
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="updateDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {

		Wrapper<Article> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("article_cate_id", articleCateId);
		map.put("status", status);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		StateResultList<List<Article>> rl = super.list(pageNum, pageSize, orderName, orderWay,wrapper);
		return rl;
	}
	/**
	 * 文章修改
	 * @return
	 */
	@ApiOperation(value = "文章修改", notes = "文章修改")
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Article>> update(@ModelAttribute Article article,HttpSession session)  {
		article.setUpdateDate(new Date());
		StateResultList<List<Article>> u = super.update(article);
		return u;
	}
	/**
	 * 文章增加
	 * @return
	 */
	@ApiOperation(value = "文章增加", notes = "文章增加")
	@RequestMapping(value = "/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Article>> add(@ModelAttribute Article article, HttpSession session) {
		article.setCreateDate(new Date());
		article.setUpdateDate(new Date());
		StateResultList<List<Article>> a = super.add(article);
		return a;
	}
	/**
	 * 文章删除
	 * @return
	 */
	@ApiOperation(value = "文章删除", notes = "文章删除")
	@ApiImplicitParams({
			@ApiImplicitParam(name="articleId",value="文章ID",dataType="long", paramType = "query",required=true)
	})
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Article>> delete(@RequestParam("articleId") Long articleId,HttpSession session)  {
		StateResultList<List<Article>> d = super.delete(articleId);
		return d;
	}
	/**
	 * 文章浏览数量
	 * @return
	 */
	@ApiOperation(value = "文章数量", notes = "文章数量查询")
	@ApiImplicitParams({
			@ApiImplicitParam(name="articleCateId",value="文章类型id外键",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="status",value="状态,1上架,2下架",dataType="int", paramType = "query"),
	})
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(
			@RequestParam(value="articleCateId",required=false)Long articleCateId,
			@RequestParam(value="status",required=false)Integer status,
			HttpSession session)  {
		Wrapper<Article> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("article_cate_id", articleCateId);
		map.put("status", status);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		StateResultList<List<Integer>> c = super.count(wrapper);
		return c;
	}
	/**
	 * 文章单个加载
	 * @return
	 */
	@ApiOperation(value = "文章单个加载", notes = "文章单个加载")
	@ApiImplicitParams({
			@ApiImplicitParam(name="articleId",value="文章ID",dataType="long", paramType = "query",required=true)
	})
	@RequestMapping(value = "/load", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<Article>> loadArticle(@RequestParam("articleId") Long articleId,HttpSession session)  {
		StateResultList<List<Article>> l = super.load(articleId);
		return l;
	}


}
