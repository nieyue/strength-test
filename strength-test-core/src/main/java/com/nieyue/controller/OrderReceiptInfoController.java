package com.nieyue.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.OrderReceiptInfo;
import com.nieyue.exception.CommonRollbackException;
import com.nieyue.service.OrderReceiptInfoService;
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
 * 订单收货信息控制类
 * @author yy
 *
 */
@Api(tags={"orderReceiptInfo"},value="订单收货信息",description="订单收货信息管理")
@RestController
@RequestMapping("/orderReceiptInfo")
public class OrderReceiptInfoController extends BaseController<OrderReceiptInfo,Long> {
	@Resource
	private OrderReceiptInfoService orderReceiptInfoService;
	
	/**
	 * 订单收货信息分页浏览
	 * @param orderName 订单收货信息排序数据库字段
	 * @param orderWay 订单收货信息排序方法 asc升序 desc降序
	 * @return
	 */
	@ApiOperation(value = "订单收货信息列表", notes = "订单收货信息分页浏览")
	@ApiImplicitParams({
			@ApiImplicitParam(name="accountId",value="账户id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="orderId",value="订单id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="isDefault",value="默认为2,1是,2不是",dataType="int", paramType = "query"),
	  		@ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
			@ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
	  		@ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="updateDate"),
	  		@ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	  })
	@RequestMapping(value = "/list", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<OrderReceiptInfo>> list(
			@RequestParam(value="accountId",required=false)Long accountId,
			@RequestParam(value="orderId",required=false)Long orderId,
			@RequestParam(value="isDefault",required=false)Integer isDefault,
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="updateDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {

			Wrapper<OrderReceiptInfo> wrapper=new EntityWrapper<>();
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("account_id", accountId);
			map.put("order_id", orderId);
			map.put("is_default", isDefault);
			wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
			StateResultList<List<OrderReceiptInfo>> rl = super.list(pageNum, pageSize, orderName, orderWay,wrapper);
			return rl;
	}
	/**
	 * 订单收货信息修改
	 * @return
	 */
	@ApiOperation(value = "订单收货信息修改", notes = "订单收货信息修改")
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<OrderReceiptInfo>> update(@ModelAttribute OrderReceiptInfo orderReceiptInfo,HttpSession session)  {
		orderReceiptInfo.setUpdateDate(new Date());
		boolean b = orderReceiptInfoService.update(orderReceiptInfo);
		if(b){
			List<OrderReceiptInfo> list = new ArrayList<>();
				list.add(orderReceiptInfo);
				return ResultUtil.getSlefSRSuccessList(list);
		}
		throw new CommonRollbackException("修改失败");
	}
	/**
	 * 订单收货信息增加
	 * @return 
	 */
	@ApiOperation(value = "订单收货信息增加", notes = "订单收货信息增加")
	@RequestMapping(value = "/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<OrderReceiptInfo>> add(@ModelAttribute OrderReceiptInfo orderReceiptInfo, HttpSession session) {
		orderReceiptInfo.setCreateDate(new Date());
		orderReceiptInfo.setUpdateDate(new Date());
		boolean b = orderReceiptInfoService.add(orderReceiptInfo);
		if(b){
			List<OrderReceiptInfo> list = new ArrayList<>();
			list.add(orderReceiptInfo);
			return ResultUtil.getSlefSRSuccessList(list);
		}
		throw new CommonRollbackException("增加失败");
	}
	/**
	 * 订单收货信息删除
	 * @return
	 */
	@ApiOperation(value = "订单收货信息删除", notes = "订单收货信息删除")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="orderReceiptInfoId",value="订单收货信息ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<OrderReceiptInfo>> delete(@RequestParam("orderReceiptInfoId") Long orderReceiptInfoId,HttpSession session)  {
		StateResultList<List<OrderReceiptInfo>> d = super.delete(orderReceiptInfoId);
		return d;
	}
	/**
	 * 订单收货信息浏览数量
	 * @return
	 */
	@ApiOperation(value = "订单收货信息数量", notes = "订单收货信息数量查询")
	@ApiImplicitParams({
			@ApiImplicitParam(name="accountId",value="账户id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="orderId",value="订单id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="isDefault",value="默认为2,1是,2不是",dataType="int", paramType = "query"),
	})
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(
			@RequestParam(value="accountId",required=false)Long accountId,
			@RequestParam(value="orderId",required=false)Long orderId,
			@RequestParam(value="isDefault",required=false)Integer isDefault,
			HttpSession session)  {
		Wrapper<OrderReceiptInfo> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("account_id", accountId);
		map.put("order_id", orderId);
		map.put("is_default", isDefault);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		StateResultList<List<Integer>> c = super.count(wrapper);
		return c;
	}
	/**
	 * 订单收货信息单个加载
	 * @return
	 */
	@ApiOperation(value = "订单收货信息单个加载", notes = "订单收货信息单个加载")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="orderReceiptInfoId",value="订单收货信息ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/load", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<OrderReceiptInfo>> loadOrderReceiptInfo(@RequestParam("orderReceiptInfoId") Long orderReceiptInfoId,HttpSession session)  {
		 StateResultList<List<OrderReceiptInfo>> l = super.load(orderReceiptInfoId);
		 return l;
	}
	
}
