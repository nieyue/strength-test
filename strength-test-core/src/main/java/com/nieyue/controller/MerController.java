package com.nieyue.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.Mer;
import com.nieyue.exception.CommonRollbackException;
import com.nieyue.exception.NotAnymoreException;
import com.nieyue.exception.NotIsNotExistException;
import com.nieyue.service.MerService;
import com.nieyue.util.MyDom4jUtil;
import com.nieyue.util.ResultUtil;
import com.nieyue.util.StateResultList;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.*;


/**
 * 商品控制类
 * @author yy
 *
 */
@Api(tags={"mer"},value="商品",description="商品管理")
@RestController
@RequestMapping("/mer")
public class MerController extends BaseController<Mer,Long> {
	@Resource
	private MerService merService;


	/**
	 * 商品分页浏览
	 * @param orderName 商品排序数据库字段
	 * @param orderWay 商品排序方法 asc升序 desc降序
	 * @return
	 */
	@ApiOperation(value = "商品列表", notes = "商品分页浏览")
	@ApiImplicitParams({
			@ApiImplicitParam(name="type",value="类型，1普通商品，2降价商品，3预购商品",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="name",value="名称,模糊查询",dataType="string", paramType = "query"),
			@ApiImplicitParam(name="recommend",value="推荐，默认1不推，2封推，3推荐",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="unitPrice",value="单价",dataType="double", paramType = "query"),
			@ApiImplicitParam(name="saleNumber",value="销量",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="merScore",value="商品评分",dataType="double", paramType = "query"),
			@ApiImplicitParam(name="status",value="状态,默认1上架,2下架",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="merCateId",value="商品类型id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="merchantAccountId",value="商户账户id",dataType="long", paramType = "query"),
	  		@ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
			@ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
	  		@ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="updateDate"),
	  		@ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	  })
	@RequestMapping(value = "/list", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Mer>> list(
			@RequestParam(value="type",required=false)Integer type,
			@RequestParam(value="name",required=false)String name,
			@RequestParam(value="recommend",required=false)Integer recommend,
			@RequestParam(value="unitPrice",required=false)Double unitPrice,
			@RequestParam(value="saleNumber",required=false)Integer saleNumber,
			@RequestParam(value="merScore",required=false)Double merScore,
			@RequestParam(value="status",required=false)Integer status,
			@RequestParam(value="merCateId",required=false)Long merCateId,
			@RequestParam(value="merchantAccountId",required=false)Long merchantAccountId,
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="updateDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {

			Wrapper<Mer> wrapper=new EntityWrapper<>();
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("type", type);
			map.put("name", name);
			map.put("recommend", recommend);
			map.put("unit_price", unitPrice);
			map.put("sale_number", saleNumber);
			map.put("mer_score", merScore);
			map.put("status", status);
			map.put("mer_cate_id", merCateId);
			map.put("merchant_account_id", merchantAccountId);
			wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		List<Mer> list = merService.list(pageNum,pageSize,orderName,orderWay,wrapper);
		if(list!=null&&list.size()>0){
			return ResultUtil.getSlefSRSuccessList(list);
		}else{
			throw new NotAnymoreException();//没有更多
		}
	}
	/**
	 * 商品修改
	 * @return
	 */
	@ApiOperation(value = "商品修改", notes = "商品修改")
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Mer>> update(@ModelAttribute Mer mer,HttpSession session)  {
		mer.setUpdateDate(new Date());
		StateResultList<List<Mer>> u = super.update(mer);
		return u;
	}
	/**
	 * 商品增加
	 * @return 
	 */
	@ApiOperation(value = "商品增加", notes = "商品增加")
	@RequestMapping(value = "/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Mer>> add(@ModelAttribute Mer mer, HttpSession session) {
		mer.setCreateDate(new Date());
		mer.setUpdateDate(new Date());
		List<Mer> list = new ArrayList<>();
		boolean am = merService.add(mer);
		if(am){
			list.add(mer);
			return ResultUtil.getSlefSRSuccessList(list);
		}
		throw new CommonRollbackException("增加失败");
	}
	/**
	 * 商品删除
	 * @return
	 */
	@ApiOperation(value = "商品删除", notes = "商品删除")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="merId",value="商品ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Mer>> delete(@RequestParam("merId") Long merId,HttpSession session)  {
		StateResultList<List<Mer>> d = super.delete(merId);
		return d;
	}
	/**
	 * 商品浏览数量
	 * @return
	 */
	@ApiOperation(value = "商品数量", notes = "商品数量查询")
	@ApiImplicitParams({
			@ApiImplicitParam(name="type",value="类型，1普通商品，2降价商品，3预购商品",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="name",value="名称,模糊查询",dataType="string", paramType = "query"),
			@ApiImplicitParam(name="recommend",value="推荐，默认1不推，2封推，3推荐",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="unitPrice",value="单价",dataType="double", paramType = "query"),
			@ApiImplicitParam(name="saleNumber",value="销量",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="merScore",value="商品评分",dataType="double", paramType = "query"),
			@ApiImplicitParam(name="status",value="状态,默认1上架,2下架",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="merCateId",value="商品类型id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="merchantAccountId",value="商户账户id",dataType="long", paramType = "query"),
	})
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(
			@RequestParam(value="type",required=false)Integer type,
			@RequestParam(value="name",required=false)String name,
			@RequestParam(value="recommend",required=false)Integer recommend,
			@RequestParam(value="unitPrice",required=false)Double unitPrice,
			@RequestParam(value="saleNumber",required=false)Integer saleNumber,
			@RequestParam(value="merScore",required=false)Double merScore,
			@RequestParam(value="status",required=false)Integer status,
			@RequestParam(value="merCateId",required=false)Long merCateId,
			@RequestParam(value="merchantAccountId",required=false)Long merchantAccountId,
			HttpSession session)  {
		Wrapper<Mer> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("type", type);
		map.put("name", name);
		map.put("recommend", recommend);
		map.put("unit_price", unitPrice);
		map.put("sale_number", saleNumber);
		map.put("mer_score", merScore);
		map.put("status", status);
		map.put("mer_cate_id", merCateId);
		map.put("merchant_account_id", merchantAccountId);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		StateResultList<List<Integer>> c = super.count(wrapper);
		return c;
	}
	/**
	 * 商品单个加载
	 * @return
	 */
	@ApiOperation(value = "商品单个加载", notes = "商品单个加载")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="merId",value="商品ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/load", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<Mer>> loadMer(@RequestParam("merId") Long merId,HttpSession session)  {
		List<Mer> list = new ArrayList<>();
		Mer mer = merService.load(merId);
		if(mer!=null &&!mer.equals("")){
			list.add(mer);
			return ResultUtil.getSlefSRSuccessList(list);
		}else{
			throw new NotIsNotExistException("");//不存在
		}
	}


}
