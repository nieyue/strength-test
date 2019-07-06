package com.nieyue.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.Order;
import com.nieyue.bean.OrderDetail;
import com.nieyue.bean.OrderReceiptInfo;
import com.nieyue.exception.CommonRollbackException;
import com.nieyue.exception.NotAnymoreException;
import com.nieyue.exception.NotIsNotExistException;
import com.nieyue.service.OrderDetailService;
import com.nieyue.service.OrderReceiptInfoService;
import com.nieyue.service.OrderService;
import com.nieyue.util.MyDom4jUtil;
import com.nieyue.util.ResultUtil;
import com.nieyue.util.StateResultList;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.*;


/**
 * 订单控制类
 * @author yy
 *
 */
@Api(tags={"order"},value="订单",description="订单管理")
@RestController
@RequestMapping("/order")
public class OrderController extends BaseController<Order,Long> {
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderDetailService orderDetailService;
	@Autowired
	private OrderReceiptInfoService orderReceiptInfoService;

	/**
	 * 订单分页浏览
	 * @param orderName 订单排序数据库字段
	 * @param orderWay 订单排序方法 asc升序 desc降序
	 * @return
	 */
	@ApiOperation(value = "订单列表", notes = "订单分页浏览")
	@ApiImplicitParams({
			@ApiImplicitParam(name="orderNumber",value="订单号",dataType="string", paramType = "query"),
			@ApiImplicitParam(name="type",value="类型，1购买商品，2账户提现，3退款，4诚信押金",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="payType",value="方式，1支付宝，2微信,3百度钱包,4Paypal,5网银",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="merType",value="商品类型，1普通商品，2降价商品，3预购商品",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="merchantAccountId",value="商户id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="spreadAccountId",value="推广账户id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="accountId",value="下单人",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="status",value="订单状态，2待支付，3待发货,4待收货，5待评价，6已取消，7已删除",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
			@ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
	  		@ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="updateDate"),
	  		@ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	  })
	@RequestMapping(value = "/list", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Order>> list(
			@RequestParam(value="orderNumber",required=false)String orderNumber,
			@RequestParam(value="type",required=false)Integer type,
			@RequestParam(value="payType",required=false)Integer payType,
			@RequestParam(value="merType",required=false)Integer merType,
			@RequestParam(value="merchantAccountId",required=false)Long merchantAccountId,
			@RequestParam(value="spreadAccountId",required=false)Long spreadAccountId,
			@RequestParam(value="accountId",required=false)Long accountId,
			@RequestParam(value="status",required=false)Integer status,
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="updateDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {

			Wrapper<Order> wrapper=new EntityWrapper<>();
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("order_number", orderNumber);
			map.put("type", type);
			map.put("pay_type", payType);
			map.put("mer_type", merType);
			map.put("merchant_account_id", merchantAccountId);
			map.put("spread_account_id", spreadAccountId);
			map.put("account_id", accountId);
			map.put("status", status);
			wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		List<Order> orderList = orderService.list(pageNum, pageSize, orderName, orderWay,wrapper);
		if(orderList.size()>0){
			for (int i = 0; i < orderList.size(); i++) {
				Order order = orderList.get(i);
				Wrapper<OrderDetail> wrapper2=new EntityWrapper<>();
				Map<String,Object> map2=new HashMap<String,Object>();
				map2.put("order_id", order.getOrderId());
				wrapper2.allEq(MyDom4jUtil.getNoNullMap(map2));
				List<OrderDetail> orderDetailList = orderDetailService.simplelist(wrapper2);
				if(orderDetailList.size()>0){
					order.setOrderDetailList(orderDetailList);
				}
			}
			return ResultUtil.getSlefSRSuccessList(orderList);
		}else{
			throw new NotAnymoreException();
		}
	}
	/**
	 * 订单修改
	 * @return
	 */
	@ApiOperation(value = "订单修改", notes = "订单修改")
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Order>> update(@ModelAttribute Order order,HttpSession session)  {
		order.setUpdateDate(new Date());
		StateResultList<List<Order>> u = super.update(order);
		return u;
	}
	/**
	 * 订单增加
	 * @return 
	 */
	@ApiOperation(value = "订单增加", notes = "订单增加")
	@RequestMapping(value = "/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Order>> add(@ModelAttribute Order order, HttpSession session) {
		order.setCreateDate(new Date());
		order.setUpdateDate(new Date());
		StateResultList<List<Order>> a = super.add(order);
		return a;
	}
	/**
	 * 订单删除
	 * @return
	 */
	@ApiOperation(value = "订单删除", notes = "订单删除")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="orderId",value="订单ID",dataType="long", paramType = "query",required=true),
		  @ApiImplicitParam(name="orderList",value="订单集合数组，\"[{'orderId':22},{'orderId':22}]\"",dataType="string", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Order>> delete(
			@RequestParam(value="orderId",required=false) Long orderId,
			@RequestParam(value="orderList",required=false) String orderList,
			HttpSession session)  {
		if(orderId==null){
			JSONArray jsonarray = JSONArray.fromObject(orderList);
			List<Order> list=new ArrayList<>();
			for (Iterator iterator = jsonarray.iterator(); iterator.hasNext();) {
				JSONObject json = (JSONObject) iterator.next();
				list.add((Order)json.toBean(json, Order.class));
			}
			for (int i = 0; i < list.size(); i++) {
				boolean b = orderService.delete(list.get(i).getOrderId());
				Wrapper<OrderDetail> wrapper=new EntityWrapper<>();
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("order_id", list.get(i).getOrderId());
				wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
				List<OrderDetail> odl = orderDetailService.simplelist(wrapper);
				for (int j = 0; j < odl.size(); j++) {
					orderDetailService.delete(odl.get(j).getOrderDetailId());
				}
				Wrapper<OrderReceiptInfo> wrapper2=new EntityWrapper<>();
				Map<String,Object> map2=new HashMap<String,Object>();
				map2.put("order_id", list.get(i).getOrderId());
				wrapper2.allEq(MyDom4jUtil.getNoNullMap(map2));
				List<OrderReceiptInfo> oril = orderReceiptInfoService.simplelist(wrapper2);
				for (int j = 0; j < oril.size(); j++) {
					orderReceiptInfoService.delete(oril.get(j).getOrderReceiptInfoId());
				}
			}
			return  ResultUtil.getSlefSRSuccessList(list);
		}else{
			StateResultList<List<Order>> c = super.delete(orderId);
			return c;
		}
	}
	/**
	 * 订单浏览数量
	 * @return
	 */
	@ApiOperation(value = "订单数量", notes = "订单数量查询")
	@ApiImplicitParams({
			@ApiImplicitParam(name="orderNumber",value="订单号",dataType="string", paramType = "query"),
			@ApiImplicitParam(name="type",value="类型，1购买商品，2账户提现，3退款，4诚信押金",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="payType",value="方式，1支付宝，2微信,3百度钱包,4Paypal,5网银",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="merType",value="商品类型，1普通商品，2降价商品，3预购商品",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="merchantAccountId",value="商户id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="spreadAccountId",value="推广账户id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="accountId",value="下单人",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="status",value="订单状态，2待支付，3待发货,4待收货，5待评价，6已取消，7已删除",dataType="int", paramType = "query"),
	})
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(
			@RequestParam(value="orderNumber",required=false)String orderNumber,
			@RequestParam(value="type",required=false)Integer type,
			@RequestParam(value="payType",required=false)Integer payType,
			@RequestParam(value="merType",required=false)Integer merType,
			@RequestParam(value="merchantAccountId",required=false)Long merchantAccountId,
			@RequestParam(value="spreadAccountId",required=false)Long spreadAccountId,
			@RequestParam(value="accountId",required=false)Long accountId,
			@RequestParam(value="status",required=false)Integer status,
			HttpSession session)  {
		Wrapper<Order> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("order_number", orderNumber);
		map.put("type", type);
		map.put("pay_type", payType);
		map.put("mer_type", merType);
		map.put("merchant_account_id", merchantAccountId);
		map.put("spread_account_id", spreadAccountId);
		map.put("account_id", accountId);
		map.put("status", status);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		StateResultList<List<Integer>> c = super.count(wrapper);
		return c;
	}
	/**
	 * 订单单个加载
	 * @return
	 */
	@ApiOperation(value = "订单单个加载", notes = "订单单个加载")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="orderId",value="订单ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/load", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<Order>> loadOrder(@RequestParam("orderId") Long orderId,HttpSession session)  {
		Order order = orderService.load(orderId);
		if(!ObjectUtils.isEmpty(order)){
			List<Order> list = new ArrayList<>();
			Wrapper<OrderDetail> wrapper=new EntityWrapper<>();
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("order_id", order.getOrderId());
			wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
			List<OrderDetail> orderDetailList = orderDetailService.simplelist(wrapper);
			if(orderDetailList.size()>0){
				order.setOrderDetailList(orderDetailList);
			}
			list.add(order);
			return ResultUtil.getSlefSRSuccessList(list);
		}else{
			throw new NotAnymoreException();
		}
	}
	/**
	 * 确认收货
	 * @return
	 */
	@ApiOperation(value = "确认收货", notes = "确认收货")
	@RequestMapping(value = "/sureReceivedOrder", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Order>> sureReceivedOrder(@ModelAttribute Order order,HttpSession session)  {
		//4待收货
		if(order.getStatus().equals(4)){
			//5待评价
			order.setStatus(5);
		}else{
			throw new CommonRollbackException("订单没完成");
		}
		order.setUpdateDate(new Date());
		StateResultList<List<Order>> u = super.update(order);
		return u;
	}
	
}
