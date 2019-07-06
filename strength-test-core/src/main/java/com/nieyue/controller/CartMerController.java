package com.nieyue.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.CartMer;
import com.nieyue.exception.CommonRollbackException;
import com.nieyue.exception.NotAnymoreException;
import com.nieyue.exception.NotIsNotExistException;
import com.nieyue.service.CartMerService;
import com.nieyue.util.MyDom4jUtil;
import com.nieyue.util.ResultUtil;
import com.nieyue.util.StateResult;
import com.nieyue.util.StateResultList;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.*;


/**
 * 购物车商品控制类
 * @author yy
 *
 */
@Api(tags={"cartMer"},value="购物车商品",description="购物车商品管理")
@RestController
@RequestMapping("/cartMer")
public class CartMerController extends BaseController<CartMer,Long> {
	@Resource
	private CartMerService cartMerService;


	/**
	 * 购物车商品分页浏览
	 * @param orderName 购物车商品排序数据库字段
	 * @param orderWay 购物车商品排序方法 asc升序 desc降序
	 * @return
	 */
	@ApiOperation(value = "购物车商品列表", notes = "购物车商品分页浏览")
	@ApiImplicitParams({
			@ApiImplicitParam(name="spreadAccountId",value="推广账户id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="merId",value="商品id外键",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="accountId",value="账户id外键",dataType="long", paramType = "query"),
	  		@ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
			@ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
	  		@ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="updateDate"),
	  		@ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	  })
	@RequestMapping(value = "/list", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<CartMer>> list(
			@RequestParam(value="spreadAccountId",required=false)Long spreadAccountId,
			@RequestParam(value="merId",required=false)Long merId,
			@RequestParam(value="accountId",required=false)Long accountId,
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="updateDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {

			Wrapper<CartMer> wrapper=new EntityWrapper<>();
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("spread_account_id", spreadAccountId);
			map.put("mer_id", merId);
			map.put("account_id", accountId);
			wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
			List<CartMer> list = cartMerService.list(pageNum,pageSize,orderName,orderWay,wrapper);
			if(list!=null&&list.size()>0){
				return ResultUtil.getSlefSRSuccessList(list);
			}else{
				throw new NotAnymoreException();//没有更多
			}
	}
	/**
	 * 购物车商品修改
	 * @return
	 */
	@ApiOperation(value = "购物车商品修改", notes = "购物车商品修改")
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<CartMer>> update(@ModelAttribute CartMer cartMer,HttpSession session)  {
		cartMer.setUpdateDate(new Date());
		StateResultList<List<CartMer>> u = super.update(cartMer);
		return u;
	}
	/**
	 * 购物车商品增加
	 * @return 
	 */
	@ApiOperation(value = "购物车商品增加", notes = "购物车商品增加")
	@RequestMapping(value = "/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<CartMer>> add(@ModelAttribute CartMer cartMer, HttpSession session) {
		cartMer.setCreateDate(new Date());
		cartMer.setUpdateDate(new Date());

		StateResultList<List<CartMer>> a = super.add(cartMer);
		return a;
	}
	/**
	 * 购物车商品删除
	 * @return
	 */
	@ApiOperation(value = "购物车商品删除", notes = "购物车商品删除")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="cartMerId",value="购物车商品ID",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="cartMerList",value="购物车商品集合数组，\"[{'cartMerId':22,'number':1},{'cartMerId':22,'number':1}]\"",dataType="string", paramType = "query")
		  })
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<CartMer>> delete(
			@RequestParam(value="cartMerId",required=false) Long cartMerId,
			@RequestParam(value="cartMerList",required=false) String cartMerList,
			HttpSession session)  {
		if(cartMerId==null){
			JSONArray jsonarray = JSONArray.fromObject(cartMerList);
			List<CartMer> list=new ArrayList<>();
			for (Iterator iterator = jsonarray.iterator(); iterator.hasNext();) {
				JSONObject json = (JSONObject) iterator.next();
				list.add((CartMer)json.toBean(json, CartMer.class));
			}
			for (int i = 0; i < list.size(); i++) {
				boolean b = cartMerService.delete(list.get(i).getCartMerId());
			}
			return  ResultUtil.getSlefSRSuccessList(list);
		}else{
			StateResultList<List<CartMer>> c = super.delete(cartMerId);
			return c;
		}

	}
	/**
	 * 购物车商品批量转未支付订单商品
	 * @return
	 */
	@ApiOperation(value = "购物车商品批量转未支付订单商品", notes = "购物车商品批量转未支付订单商品")
	@ApiImplicitParams({
			@ApiImplicitParam(name="cartMerList",value="购物车商品列表",dataType="string", paramType = "query",required=true),
			@ApiImplicitParam(name="couponId",value="优惠券Id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="receiptInfoId",value="收货地址Id",dataType="long", paramType = "query",required=true),
			@ApiImplicitParam(name="accountId",value="账户Id",dataType="long", paramType = "query",required=true)
	})
	@RequestMapping(value = "/turnOrderBatch", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody
	StateResultList<List<CartMer>> batchCartMerTurnOrder(
			@RequestParam("cartMerList") String cartMerList,
			@RequestParam(value="couponId",required = false) Long couponId,
			@RequestParam("receiptInfoId") Long receiptInfoId,
			@RequestParam("accountId") Long accountId,
			HttpSession session)  {
		boolean dm=cartMerService.batchCartMerTurnOrder(cartMerList,couponId,receiptInfoId,accountId);
		if(dm){
			return ResultUtil.getSlefSRSuccessList(null);
		}else{
			return ResultUtil.getSlefSRFailList(null);

		}
	}
	/**
	 * 购物车商品浏览数量
	 * @return
	 */
	@ApiOperation(value = "购物车商品数量", notes = "购物车商品数量查询")
	@ApiImplicitParams({
			@ApiImplicitParam(name="spreadAccountId",value="推广账户id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="merId",value="商品id外键",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="accountId",value="账户id外键",dataType="long", paramType = "query"),
	})
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(
			@RequestParam(value="spreadAccountId",required=false)Long spreadAccountId,
			@RequestParam(value="merId",required=false)Long merId,
			@RequestParam(value="accountId",required=false)Long accountId,
			HttpSession session)  {
		Wrapper<CartMer> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("spread_account_id", spreadAccountId);
		map.put("mer_id", merId);
		map.put("account_id", accountId);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		StateResultList<List<Integer>> c = super.count(wrapper);
		return c;
	}
	/**
	 * 购物车商品单个加载
	 * @return
	 */
	@ApiOperation(value = "购物车商品单个加载", notes = "购物车商品单个加载")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="cartMerId",value="购物车商品ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/load", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<CartMer>> loadCartMer(@RequestParam("cartMerId") Long cartMerId,HttpSession session)  {
		List<CartMer> list = new ArrayList<>();
		CartMer cartMer = cartMerService.load(cartMerId);
		if(cartMer!=null &&!cartMer.equals("")){
			list.add(cartMer);
			return ResultUtil.getSlefSRSuccessList(list);
		}else{
			throw new NotIsNotExistException("");//不存在
		}
	}


}
