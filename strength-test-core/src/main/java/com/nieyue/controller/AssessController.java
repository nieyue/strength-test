package com.nieyue.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.Account;
import com.nieyue.bean.Assess;
import com.nieyue.bean.AssessProject;
import com.nieyue.bean.Standard;
import com.nieyue.service.*;
import com.nieyue.util.DateUtil;
import com.nieyue.util.MyDom4jUtil;
import com.nieyue.util.StateResultList;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.*;


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
	private AssessProjectService assessProjectService;
	@Autowired
	private AccountService accountService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private StandardService standardService;

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
			map.put("account_id", accountId);
			wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
			StateResultList<List<Assess>> rl = super.list(pageNum, pageSize, orderName, orderWay,wrapper);
			rl.getData().forEach(e->{
				Account account = accountService.load(e.getAccountId());
				e.setAccount(account);
				Wrapper<AssessProject> wrapper2=new EntityWrapper<>();
				Map<String,Object> map2=new HashMap<String,Object>();
				map2.put("assess_id", e.getAssessId());
				wrapper2.allEq(MyDom4jUtil.getNoNullMap(map2));
				List<AssessProject> apl = assessProjectService.simplelist(wrapper2);
				e.setAssessProjectList((ArrayList<AssessProject>)apl);
			});
			return rl;
	}

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
			@ApiImplicitParam(name="accountId",value="账户id外键",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="createDate",value="创建时间",dataType="date-time", paramType = "query"),
			@ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
			@ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
			@ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="createDate"),
			@ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	})
	@RequestMapping(value = "/data", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Assess>> data(
			@RequestParam(value="age",required=false)Integer age,
			@RequestParam(value="sex",required=false)Integer sex,
			@RequestParam(value="rank",required=false)Integer rank,
			@RequestParam(value="accountId",required=false)Long accountId,
			@RequestParam(value="createDate",required=false)Date createDate,
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="createDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {
		Wrapper<Assess> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("age", age);
		map.put("sex", sex);
		map.put("rank", rank);
		map.put("account_id", accountId);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		if(createDate!=null){
			wrapper.andNew().le("DATE(create_date)", DateUtil.dateFormatSimpleDate(createDate,"yyyy-MM-dd"));
		}
		StateResultList<List<Assess>> rl = super.list(pageNum, pageSize, orderName, orderWay,wrapper);
		rl.getData().forEach(e->{
			Account account = accountService.load(e.getAccountId());
			e.setAccount(account);
			Wrapper<AssessProject> wrapper2=new EntityWrapper<>();
			Map<String,Object> map2=new HashMap<String,Object>();
			map2.put("assess_id", e.getAssessId());
			wrapper2.allEq(MyDom4jUtil.getNoNullMap(map2));
			List<AssessProject> apl = assessProjectService.list(1,Integer.MAX_VALUE,"assess_project_id","desc",wrapper2);
			e.setAssessProjectList((ArrayList<AssessProject>)apl);
			apl.forEach(ee->{
				//放入项目
				ee.setProject(projectService.load(ee.getProjectId()));
				//根据年龄、性别、项目id获取对应的合格标准线
				Wrapper<Standard> wrapper3=new EntityWrapper<>();
				Map<String,Object> map3=new HashMap<String,Object>();
				map3.put("age", e.getAge());
				map3.put("sex", e.getSex());
				map3.put("project_id", ee.getProjectId());
				map3.put("rank", 3);//合格
				wrapper3.allEq(MyDom4jUtil.getNoNullMap(map3));
				List<Standard> standardList = standardService.list(1,Integer.MAX_VALUE,"standard_id","desc",wrapper3);
				if(standardList.size()>0){
					ee.setStandard(standardList.get(0));
				}
			});
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
			@ApiImplicitParam(name="accountId",value="项目id外键",dataType="long", paramType = "query"),
	})
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(
			@RequestParam(value="age",required=false)Integer age,
			@RequestParam(value="sex",required=false)Integer sex,
			@RequestParam(value="rank",required=false)Integer rank,
			@RequestParam(value="accountId",required=false)Long accountId,
			HttpSession session)  {
		Wrapper<Assess> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("age", age);
		map.put("sex", sex);
		map.put("rank", rank);
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
				Account account = accountService.load(e.getAccountId());
				e.setAccount(account);
				Wrapper<AssessProject> wrapper2=new EntityWrapper<>();
				Map<String,Object> map2=new HashMap<String,Object>();
				map2.put("assess_id", e.getAssessId());
				wrapper2.allEq(MyDom4jUtil.getNoNullMap(map2));
				List<AssessProject> apl = assessProjectService.simplelist(wrapper2);
				e.setAssessProjectList((ArrayList<AssessProject>) apl);
			});
		 return l;
	}

}
