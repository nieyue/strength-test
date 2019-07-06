package com.nieyue.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.OrderDetail;
import com.nieyue.service.OrderDetailService;
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
 * 订单详情控制类
 * @author yy
 *
 */
@Api(tags={"orderDetail"},value="订单详情",description="订单详情管理")
@RestController
@RequestMapping("/orderDetail")
public class OrderDetailController extends BaseController<OrderDetail,Long> {
	@Resource
	private OrderDetailService orderDetailService;

	/**
	 * 订单详情分页浏览
	 * @param orderName 订单详情排序数据库字段
	 * @param orderWay 订单详情排序方法 asc升序 desc降序
	 * @return
	 */
	@ApiOperation(value = "订单详情列表", notes = "订单详情分页浏览")
	@ApiImplicitParams({
			@ApiImplicitParam(name="couponId",value="优惠劵id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="merId",value="商品id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="orderId",value="订单ID",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
			@ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
			@ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="updateDate"),
			@ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	})
	@RequestMapping(value = "/list", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<OrderDetail>> list(
			@RequestParam(value="couponId",required=false)Long couponId,
			@RequestParam(value="merId",required=false)Long merId,
			@RequestParam(value="orderId",required=false)Long orderId,
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="updateDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {

		Wrapper<OrderDetail> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("coupon_id", couponId);
		map.put("mer_id", merId);
		map.put("order_id", orderId);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		StateResultList<List<OrderDetail>> rl = super.list(pageNum, pageSize, orderName, orderWay,wrapper);
		return rl;
	}
	/**
	 * 订单详情修改
	 * @return
	 */
	@ApiOperation(value = "订单详情修改", notes = "订单详情修改")
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<OrderDetail>> update(@ModelAttribute OrderDetail orderDetail,HttpSession session)  {
		orderDetail.setUpdateDate(new Date());
		StateResultList<List<OrderDetail>> u = super.update(orderDetail);
		return u;
	}
	/**
	 * 订单详情增加
	 * @return 
	 */
	@ApiOperation(value = "订单详情增加", notes = "订单详情增加")
	@RequestMapping(value = "/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<OrderDetail>> add(@ModelAttribute OrderDetail orderDetail, HttpSession session) {
		orderDetail.setCreateDate(new Date());
		orderDetail.setUpdateDate(new Date());
		StateResultList<List<OrderDetail>> a = super.add(orderDetail);
		return a;
	}
	/**
	 * 订单详情删除
	 * @return
	 */
	@ApiOperation(value = "订单详情删除", notes = "订单详情删除")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="orderDetailId",value="订单详情ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<OrderDetail>> delete(@RequestParam("orderDetailId") Long orderDetailId,HttpSession session)  {
		StateResultList<List<OrderDetail>> d = super.delete(orderDetailId);
		return d;
	}
	/**
	 * 订单详情浏览数量
	 * @return
	 */
	@ApiOperation(value = "订单详情数量", notes = "订单详情数量查询")
	@ApiImplicitParams({
			@ApiImplicitParam(name="couponId",value="优惠劵id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="merId",value="商品id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="orderId",value="订单ID",dataType="long", paramType = "query"),
	})
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(
			@RequestParam(value="couponId",required=false)Long couponId,
			@RequestParam(value="merId",required=false)Long merId,
			@RequestParam(value="orderId",required=false)Long orderId,
			HttpSession session)  {
		Wrapper<OrderDetail> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("coupon_id", couponId);
		map.put("mer_id", merId);
		map.put("order_id", orderId);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		StateResultList<List<Integer>> c = super.count(wrapper);
		return c;
	}
	/**
	 * 订单详情单个加载
	 * @return
	 */
	@ApiOperation(value = "订单详情单个加载", notes = "订单详情单个加载")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="orderDetailId",value="订单详情ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/load", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<OrderDetail>> loadOrderDetail(@RequestParam("orderDetailId") Long orderDetailId,HttpSession session)  {
		 StateResultList<List<OrderDetail>> l = super.load(orderDetailId);
		 return l;
	}
	
}
