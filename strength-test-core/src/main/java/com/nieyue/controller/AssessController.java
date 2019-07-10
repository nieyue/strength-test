package com.nieyue.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.Account;
import com.nieyue.bean.Project;
import com.nieyue.bean.Assess;
import com.nieyue.service.AccountService;
import com.nieyue.service.ProjectService;
import com.nieyue.service.AssessService;
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
 * 测评控制类
 * @author yy
 *
 */
@Api(tags={"assess"},value="测评",description="测评管理")
@RestController
@RequestMapping("/assess")
public class AssessController extends BaseController<Assess,Long> {
	@Autowired
	private AssessService assessService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private AccountService accountService;

	/**
	 * 测评分页浏览
	 * @param orderName 商品排序数据库字段
	 * @param orderWay 商品排序方法 asc升序 desc降序
	 * @return
	 */
	@ApiOperation(value = "测评列表", notes = "测评分页浏览")
	@ApiImplicitParams({
	  @ApiImplicitParam(name="age",value="年龄",dataType="int", paramType = "query"),
	  @ApiImplicitParam(name="sex",value="性别，为1男性，为2女性,默认为3未知",dataType="int", paramType = "query"),
	  @ApiImplicitParam(name="rank",value="等级,1不良,2未达,3合格,4良好,5优秀",dataType="int", paramType = "query"),
	  @ApiImplicitParam(name="projectId",value="项目id外键",dataType="long", paramType = "query"),
	  @ApiImplicitParam(name="accountId",value="账户id外键",dataType="long", paramType = "query"),
	  @ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
	  @ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
	  @ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="createDate"),
	  @ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	  })
	@RequestMapping(value = "/list", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Assess>> list(
			@RequestParam(value="age",required=false)Integer age,
			@RequestParam(value="sex",required=false)Integer sex,
			@RequestParam(value="rank",required=false)Integer rank,
			@RequestParam(value="projectId",required=false)Long projectId,
			@RequestParam(value="accountId",required=false)Long accountId,
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="createDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {
			Wrapper<Assess> wrapper=new EntityWrapper<>();
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("age", age);
			map.put("sex", sex);
			map.put("rank", rank);
			map.put("project_id", projectId);
			map.put("account_id", accountId);
			wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
			StateResultList<List<Assess>> rl = super.list(pageNum, pageSize, orderName, orderWay,wrapper);
			rl.getData().forEach(e->{
				Project project = projectService.load(e.getProjectId());
				e.setProject(project);
				Account account = accountService.load(e.getAccountId());
				e.setAccount(account);
			});
			return rl;
	}
	/**
	 * 测评修改
	 * @return
	 */
	@ApiOperation(value = "测评修改", notes = "测评修改")
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Assess>> update(@ModelAttribute Assess assess,HttpSession session)  {
		assess.setUpdateDate(new Date());
		StateResultList<List<Assess>> u = super.update(assess);
		return u;
	}
	/**
	 * 测评增加
	 * @return 
	 */
	@ApiOperation(value = "测评增加", notes = "测评增加")
	@RequestMapping(value = "/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Assess>> add(@ModelAttribute Assess assess, HttpSession session) {
		assess.setCreateDate(new Date());
		assess.setUpdateDate(new Date());
		Account account = accountService.load(assess.getAccountId());
		assess.setAge(account.getAge());
		StateResultList<List<Assess>> a = super.add(assess);
		return a;
	}
	/**
	 * 测评删除
	 * @return
	 */
	@ApiOperation(value = "测评删除", notes = "测评删除")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="assessId",value="测评ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Assess>> delete(@RequestParam("assessId") Long assessId,HttpSession session)  {
		StateResultList<List<Assess>> d = super.delete(assessId);
		return d;
	}
	/**
	 * 测评浏览数量
	 * @return
	 */
	@ApiOperation(value = "测评数量", notes = "测评数量查询")
	@ApiImplicitParams({
			@ApiImplicitParam(name="age",value="年龄",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="sex",value="性别，为1男性，为2女性,默认为3未知",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="rank",value="等级,1不良,2未达,3合格,4良好,5优秀",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="projectId",value="项目id外键",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="accountId",value="项目id外键",dataType="long", paramType = "query"),
	})
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(
			@RequestParam(value="age",required=false)Integer age,
			@RequestParam(value="sex",required=false)Integer sex,
			@RequestParam(value="rank",required=false)Integer rank,
			@RequestParam(value="projectId",required=false)Long projectId,
			@RequestParam(value="accountId",required=false)Long accountId,
			HttpSession session)  {
		Wrapper<Assess> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("age", age);
		map.put("sex", sex);
		map.put("rank", rank);
		map.put("project_id", projectId);
		map.put("account_id", accountId);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		StateResultList<List<Integer>> c = super.count(wrapper);
		return c;
	}
	/**
	 * 测评单个加载
	 * @return
	 */
	@ApiOperation(value = "测评单个加载", notes = "测评单个加载")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="assessId",value="测评ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/load", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<Assess>> loadAssess(@RequestParam("assessId") Long assessId,HttpSession session)  {
		 StateResultList<List<Assess>> l = super.load(assessId);
			l.getData().forEach(e->{
				Project project = projectService.load(e.getProjectId());
				e.setProject(project);
				Account account = accountService.load(e.getAccountId());
				e.setAccount(account);
			});
		 return l;
	}
	
}
