package com.nieyue.controller;

import com.nieyue.bean.Project;
import com.nieyue.service.ProjectService;
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
 * 项目控制类
 * @author yy
 *
 */
@Api(tags={"project"},value="项目",description="项目管理")
@RestController
@RequestMapping("/project")
public class ProjectController extends BaseController<Project,Long> {
	@Resource
	private ProjectService projectService;
	
	/**
	 * 项目分页浏览
	 * @param orderName 商品排序数据库字段
	 * @param orderWay 商品排序方法 asc升序 desc降序
	 * @return
	 */
	@ApiOperation(value = "项目列表", notes = "项目分页浏览")
	@ApiImplicitParams({
	  @ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
	  @ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
	  @ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="updateDate"),
	  @ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	  })
	@RequestMapping(value = "/list", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Project>> list(
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="updateDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {
			StateResultList<List<Project>> rl = super.list(pageNum, pageSize, orderName, orderWay,null);
			return rl;
	}
	/**
	 * 项目修改
	 * @return
	 */
	@ApiOperation(value = "项目修改", notes = "项目修改")
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Project>> update(@ModelAttribute Project project,HttpSession session)  {
		project.setUpdateDate(new Date());
		StateResultList<List<Project>> u = super.update(project);
		return u;
	}
	/**
	 * 项目增加
	 * @return 
	 */
	@ApiOperation(value = "项目增加", notes = "项目增加")
	@RequestMapping(value = "/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Project>> add(@ModelAttribute Project project, HttpSession session) {
		project.setCreateDate(new Date());
		project.setUpdateDate(new Date());
		StateResultList<List<Project>> a = super.add(project);
		return a;
	}
	/**
	 * 项目删除
	 * @return
	 */
	@ApiOperation(value = "项目删除", notes = "项目删除")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="projectId",value="项目ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Project>> delete(@RequestParam("projectId") Long projectId,HttpSession session)  {
		StateResultList<List<Project>> d = super.delete(projectId);
		return d;
	}
	/**
	 * 项目浏览数量
	 * @return
	 */
	@ApiOperation(value = "项目数量", notes = "项目数量查询")
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(HttpSession session)  {
		StateResultList<List<Integer>> c = super.count(null);
		return c;
	}
	/**
	 * 项目单个加载
	 * @return
	 */
	@ApiOperation(value = "项目单个加载", notes = "项目单个加载")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="projectId",value="项目ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/load", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<Project>> loadProject(@RequestParam("projectId") Long projectId,HttpSession session)  {
		 StateResultList<List<Project>> l = super.load(projectId);
		 return l;
	}
	
}
