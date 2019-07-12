package com.nieyue.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.Assess;
import com.nieyue.bean.AssessProject;
import com.nieyue.bean.Project;
import com.nieyue.service.AssessProjectService;
import com.nieyue.service.AssessService;
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
 * 单项测评控制类
 * @author yy
 *
 */
@Api(tags={"assessProject"},value="单项测评",description="单项测评管理")
@RestController
@RequestMapping("/assessProject")
public class AssessProjectController extends BaseController<AssessProject,Long> {
	@Autowired
	private AssessProjectService assessProjectService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private AssessService assessService;
	@Autowired
	private StandardService standardService;

	/**
	 * 单项测评分页浏览
	 * @param orderName 商品排序数据库字段
	 * @param orderWay 商品排序方法 asc升序 desc降序
	 * @return
	 */
	@ApiOperation(value = "单项测评列表", notes = "单项测评分页浏览")
	@ApiImplicitParams({
	  @ApiImplicitParam(name="rank",value="等级,1不良,2未达,3合格,4良好,5优秀",dataType="int", paramType = "query"),
	  @ApiImplicitParam(name="projectId",value="项目id外键",dataType="long", paramType = "query"),
	  @ApiImplicitParam(name="assessId",value="测评id外键",dataType="long", paramType = "query"),
	  @ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
	  @ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
	  @ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="createDate"),
	  @ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	  })
	@RequestMapping(value = "/list", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<AssessProject>> list(
			@RequestParam(value="rank",required=false)Integer rank,
			@RequestParam(value="projectId",required=false)Long projectId,
			@RequestParam(value="assessId",required=false)Long assessId,
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="createDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {
			Wrapper<AssessProject> wrapper=new EntityWrapper<>();
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("rank", rank);
			map.put("project_id", projectId);
			map.put("assess_id", assessId);
			wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
			StateResultList<List<AssessProject>> rl = super.list(pageNum, pageSize, orderName, orderWay,wrapper);
			rl.getData().forEach(e->{
				Project project = projectService.load(e.getProjectId());
				e.setProject(project);
				Assess assess = assessService.load(e.getAssessId());
				e.setAssess(assess);
			});
			return rl;
	}
	/**
	 * 单项测评修改
	 * @return
	 */
	@ApiOperation(value = "单项测评修改", notes = "单项测评修改")
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<AssessProject>> update(@ModelAttribute AssessProject assessProject,HttpSession session)  {
		assessProject.setUpdateDate(new Date());
		StateResultList<List<AssessProject>> u = super.update(assessProject);
		return u;
	}
	/**
	 * 单项测评增加
	 * @return 
	 */
	@ApiOperation(value = "单项测评增加", notes = "单项测评增加")
	@RequestMapping(value = "/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<AssessProject>> add(@ModelAttribute AssessProject assessProject, HttpSession session) {
		assessProject.setCreateDate(new Date());
		assessProject.setUpdateDate(new Date());
		StateResultList<List<AssessProject>> a = super.add(assessProject);
		return a;
	}
	/**
	 * 单项测评删除
	 * @return
	 */
	@ApiOperation(value = "单项测评删除", notes = "单项测评删除")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="assessProjectId",value="单项测评ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<AssessProject>> delete(@RequestParam("assessProjectId") Long assessProjectId,HttpSession session)  {
		StateResultList<List<AssessProject>> d = super.delete(assessProjectId);
		return d;
	}
	/**
	 * 单项测评浏览数量
	 * @return
	 */
	@ApiOperation(value = "单项测评数量", notes = "单项测评数量查询")
	@ApiImplicitParams({
			@ApiImplicitParam(name="rank",value="等级,1不良,2未达,3合格,4良好,5优秀",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="projectId",value="项目id外键",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="assessId",value="测评id外键",dataType="long", paramType = "query"),
	})
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(
			@RequestParam(value="rank",required=false)Integer rank,
			@RequestParam(value="projectId",required=false)Long projectId,
			@RequestParam(value="assessId",required=false)Long assessId,
			HttpSession session)  {
		Wrapper<AssessProject> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("rank", rank);
		map.put("project_id", projectId);
		map.put("assess_id", assessId);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		StateResultList<List<Integer>> c = super.count(wrapper);
		return c;
	}
	/**
	 * 单项测评单个加载
	 * @return
	 */
	@ApiOperation(value = "单项测评单个加载", notes = "单项测评单个加载")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="assessProjectId",value="单项测评ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/load", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<AssessProject>> loadAssessProject(@RequestParam("assessProjectId") Long assessProjectId,HttpSession session)  {
		 StateResultList<List<AssessProject>> l = super.load(assessProjectId);
			l.getData().forEach(e->{
				Project project = projectService.load(e.getProjectId());
				e.setProject(project);
				Assess assess = assessService.load(e.getAssessId());
				e.setAssess(assess);
			});
		 return l;
	}
	
}
