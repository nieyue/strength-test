package com.nieyue.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.OrderComment;
import com.nieyue.service.AccountService;
import com.nieyue.service.OrderCommentService;
import com.nieyue.util.MyDom4jUtil;
import com.nieyue.util.StateResultList;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 订单评价控制类
 * @author yy
 *
 */
@Api(tags={"orderComment"},value="订单评价",description="订单评价管理")
@RestController
@RequestMapping("/orderComment")
public class OrderCommentController extends BaseController<OrderComment,Long> {
	@Autowired
	private OrderCommentService orderCommentService;
	@Autowired
	private AccountService accountService;

	/**
	 * 订单评价分页浏览
	 * @param orderName 订单评价排序数据库字段
	 * @param orderWay 订单评价排序方法 asc升序 desc降序
	 * @return
	 */
	@ApiOperation(value = "订单评价列表", notes = "订单评价分页浏览")
	@ApiImplicitParams({
			@ApiImplicitParam(name="merId",value="商品id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="orderId",value="订单ID",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="accountId",value="账户ID",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
			@ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
			@ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="updateDate"),
			@ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	})
	@RequestMapping(value = "/list", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<OrderComment>> list(
			@RequestParam(value="merId",required=false)Long merId,
			@RequestParam(value="orderId",required=false)Long orderId,
			@RequestParam(value="accountId",required=false)Long accountId,
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="updateDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {

		Wrapper<OrderComment> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("mer_id", merId);
		map.put("order_id", orderId);
		map.put("account_id", accountId);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		StateResultList<List<OrderComment>> rl = super.list(pageNum, pageSize, orderName, orderWay,wrapper);
		rl.getData().forEach(e->{
			e.setAccount(accountService.load(e.getAccountId()));
		});
		return rl;
	}
	/**
	 * 订单评价修改
	 * @return
	 */
	@ApiOperation(value = "订单评价修改", notes = "订单评价修改")
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<OrderComment>> update(@ModelAttribute OrderComment orderComment,HttpSession session)  {
		orderComment.setUpdateDate(new Date());
		StateResultList<List<OrderComment>> u = super.update(orderComment);
		return u;
	}
	/**
	 * 订单评价增加
	 * @return 
	 */
	@ApiOperation(value = "订单评价增加", notes = "订单评价增加")
	@RequestMapping(value = "/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<OrderComment>> add(@ModelAttribute OrderComment orderComment, HttpSession session) {
		orderComment.setCreateDate(new Date());
		orderComment.setUpdateDate(new Date());
		StateResultList<List<OrderComment>> a = super.add(orderComment);
		return a;
	}
	/**
	 * 订单评价删除
	 * @return
	 */
	@ApiOperation(value = "订单评价删除", notes = "订单评价删除")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="orderCommentId",value="订单评价ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<OrderComment>> delete(@RequestParam("orderCommentId") Long orderCommentId,HttpSession session)  {
		StateResultList<List<OrderComment>> d = super.delete(orderCommentId);
		return d;
	}
	/**
	 * 订单评价浏览数量
	 * @return
	 */
	@ApiOperation(value = "订单评价数量", notes = "订单评价数量查询")
	@ApiImplicitParams({
			@ApiImplicitParam(name="merId",value="商品id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="orderId",value="订单ID",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="accountId",value="账户ID",dataType="long", paramType = "query"),
	})
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(
			@RequestParam(value="merId",required=false)Long merId,
			@RequestParam(value="orderId",required=false)Long orderId,
			@RequestParam(value="accountId",required=false)Long accountId,
			HttpSession session)  {
		Wrapper<OrderComment> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("mer_id", merId);
		map.put("order_id", orderId);
		map.put("account_id", accountId);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		StateResultList<List<Integer>> c = super.count(wrapper);
		return c;
	}
	/**
	 * 订单评价单个加载
	 * @return
	 */
	@ApiOperation(value = "订单评价单个加载", notes = "订单评价单个加载")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="orderCommentId",value="订单评价ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/load", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<OrderComment>> loadOrderComment(@RequestParam("orderCommentId") Long orderCommentId,HttpSession session)  {
		 StateResultList<List<OrderComment>> l = super.load(orderCommentId);
		l.getData().forEach(e->{
			e.setAccount(accountService.load(e.getAccountId()));
		});
		 return l;
	}
	
}
