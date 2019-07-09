package com.nieyue.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.Project;
import com.nieyue.bean.Standard;
import com.nieyue.service.ProjectService;
import com.nieyue.service.StandardService;
import com.nieyue.util.MyDom4jUtil;
import com.nieyue.util.StateResultList;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 标准控制类
 * @author yy
 *
 */
@Api(tags={"standard"},value="标准",description="标准管理")
@RestController
@RequestMapping("/standard")
public class StandardController extends BaseController<Standard,Long> {
	@Autowired
	private StandardService standardService;
	@Autowired
	private ProjectService projectService;

	/**
	 * 标准分页浏览
	 * @param orderName 商品排序数据库字段
	 * @param orderWay 商品排序方法 asc升序 desc降序
	 * @return
	 */
	@ApiOperation(value = "标准列表", notes = "标准分页浏览")
	@ApiImplicitParams({
	  @ApiImplicitParam(name="age",value="年龄",dataType="int", paramType = "query"),
	  @ApiImplicitParam(name="rank",value="等级,1不良,2未达,3合格,4良好,5优秀",dataType="int", paramType = "query"),
	  @ApiImplicitParam(name="projectId",value="项目id外键",dataType="long", paramType = "query"),
	  @ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
	  @ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
	  @ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="updateDate"),
	  @ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	  })
	@RequestMapping(value = "/list", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Standard>> list(
			@RequestParam(value="age",required=false)Integer age,
			@RequestParam(value="rank",required=false)Integer rank,
			@RequestParam(value="projectId",required=false)Long projectId,
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="updateDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {
			Wrapper<Standard> wrapper=new EntityWrapper<>();
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("age", age);
			map.put("rank", rank);
			map.put("project_id", projectId);
			wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
			StateResultList<List<Standard>> rl = super.list(pageNum, pageSize, orderName, orderWay,wrapper);
			rl.getData().forEach(e->{
				Project project = projectService.load(e.getProjectId());
				e.setProject(project);
			});
			return rl;
	}
	/**
	 * 标准修改
	 * @return
	 */
	@ApiOperation(value = "标准修改", notes = "标准修改")
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Standard>> update(@ModelAttribute Standard standard,HttpSession session)  {
		standard.setUpdateDate(new Date());
		StateResultList<List<Standard>> u = super.update(standard);
		return u;
	}
	/**
	 * 标准增加
	 * @return 
	 */
	@ApiOperation(value = "标准增加", notes = "标准增加")
	@RequestMapping(value = "/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Standard>> add(@ModelAttribute Standard standard, HttpSession session) {
		standard.setCreateDate(new Date());
		standard.setUpdateDate(new Date());
		StateResultList<List<Standard>> a = super.add(standard);
		return a;
	}
	/**
	 * 标准删除
	 * @return
	 */
	@ApiOperation(value = "标准删除", notes = "标准删除")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="standardId",value="标准ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Standard>> delete(@RequestParam("standardId") Long standardId,HttpSession session)  {
		StateResultList<List<Standard>> d = super.delete(standardId);
		return d;
	}
	/**
	 * 标准浏览数量
	 * @return
	 */
	@ApiOperation(value = "标准数量", notes = "标准数量查询")
	@ApiImplicitParams({
			@ApiImplicitParam(name="age",value="年龄",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="rank",value="等级,1不良,2未达,3合格,4良好,5优秀",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="projectId",value="项目id外键",dataType="long", paramType = "query"),
	})
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(
			@RequestParam(value="age",required=false)Integer age,
			@RequestParam(value="rank",required=false)Integer rank,
			@RequestParam(value="projectId",required=false)Long projectId,
			HttpSession session)  {
		Wrapper<Standard> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("age", age);
		map.put("rank", rank);
		map.put("project_id", projectId);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		StateResultList<List<Integer>> c = super.count(wrapper);
		return c;
	}
	/**
	 * 标准单个加载
	 * @return
	 */
	@ApiOperation(value = "标准单个加载", notes = "标准单个加载")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="standardId",value="标准ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/load", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<Standard>> loadStandard(@RequestParam("standardId") Long standardId,HttpSession session)  {
		 StateResultList<List<Standard>> l = super.load(standardId);
			l.getData().forEach(e->{
				Project project = projectService.load(e.getProjectId());
				e.setProject(project);
			});
		 return l;
	}
	
}
