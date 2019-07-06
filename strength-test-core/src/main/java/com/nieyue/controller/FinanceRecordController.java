package com.nieyue.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.FinanceRecord;
import com.nieyue.exception.NotAnymoreException;
import com.nieyue.service.FinanceRecordService;
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
 * 财务记录控制类
 * @author yy
 *
 */
@Api(tags={"financeRecord"},value="财务记录",description="财务记录管理")
@RestController
@RequestMapping("/financeRecord")
public class FinanceRecordController extends BaseController<FinanceRecord,Long> {
	@Resource
	private FinanceRecordService financeRecordService;
	
	/**
	 * 财务记录分页浏览
	 * @param orderName 商品排序数据库字段
	 * @param orderWay 商品排序方法 asc升序 desc降序
	 * @return
	 */
	@ApiOperation(value = "财务记录列表", notes = "财务记录分页浏览")
	@ApiImplicitParams({
			@ApiImplicitParam(name="accountId",value="账户Id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="status",value="状态，默认1待处理，2成功，3已拒绝",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="method",value="方式，1支付宝，2微信,3百度钱包,4Paypal,5网银,6ios内购,7余额",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="type",value="类型，1购买商品，2提现记录，3退款记录，4诚信押金，5商品售出，6推广分成，7上级推广分成",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="transactionNumber",value="交易单号",dataType="string", paramType = "query"),
			@ApiImplicitParam(name="pageNum",value="页头数位",dataType="int", paramType = "query",defaultValue="1"),
	  		@ApiImplicitParam(name="pageSize",value="每页数目",dataType="int", paramType = "query",defaultValue="10"),
	  		@ApiImplicitParam(name="orderName",value="排序字段",dataType="string", paramType = "query",defaultValue="updateDate"),
	  		@ApiImplicitParam(name="orderWay",value="排序方式",dataType="string", paramType = "query",defaultValue="desc")
	  })
	@RequestMapping(value = "/list", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<FinanceRecord>> list(
			@RequestParam(value="accountId",required=false)Long accountId,
			@RequestParam(value="status",required=false)Integer status,
			@RequestParam(value="method",required=false)Integer method,
			@RequestParam(value="type",required=false)Integer type,
			@RequestParam(value="transactionNumber",required=false)String transactionNumber,
			@RequestParam(value="pageNum",defaultValue="1",required=false)int pageNum,
			@RequestParam(value="pageSize",defaultValue="10",required=false) int pageSize,
			@RequestParam(value="orderName",required=false,defaultValue="updateDate") String orderName,
			@RequestParam(value="orderWay",required=false,defaultValue="desc") String orderWay)  {
		Wrapper<FinanceRecord> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("account_id", accountId);
		map.put("status", status);
		map.put("method", method);
		map.put("type", type);
		map.put("transaction_number", transactionNumber);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		List<FinanceRecord> rl = financeRecordService.list(pageNum, pageSize, orderName, orderWay,wrapper);
		if(rl!=null&&rl.size()>0){
			return ResultUtil.getSlefSRSuccessList(rl);
		}else{
			throw new NotAnymoreException();//没有更多
		}
	}
	/**
	 * 财务记录修改
	 * @return
	 */
	@ApiOperation(value = "财务记录修改", notes = "财务记录修改")
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<FinanceRecord>> update(@ModelAttribute FinanceRecord financeRecord,HttpSession session)  {
		financeRecord.setUpdateDate(new Date());
		StateResultList<List<FinanceRecord>> u = super.update(financeRecord);
		return u;
	}
	/**
	 * 财务记录增加
	 * @return 
	 */
	@ApiOperation(value = "财务记录增加", notes = "财务记录增加")
	@RequestMapping(value = "/add", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<FinanceRecord>> add(@ModelAttribute FinanceRecord financeRecord, HttpSession session) {
		financeRecord.setCreateDate(new Date());
		financeRecord.setUpdateDate(new Date());
		StateResultList<List<FinanceRecord>> a = super.add(financeRecord);
		return a;
	}
	/**
	 * 财务记录删除
	 * @return
	 */
	@ApiOperation(value = "财务记录删除", notes = "财务记录删除")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="financeRecordId",value="财务记录ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<FinanceRecord>> delete(@RequestParam("financeRecordId") Long financeRecordId,HttpSession session)  {
		StateResultList<List<FinanceRecord>> d = super.delete(financeRecordId);
		return d;
	}
	/**
	 * 财务记录浏览数量
	 * @return
	 */
	@ApiOperation(value = "财务记录数量", notes = "财务记录数量查询")
	@ApiImplicitParams({
			@ApiImplicitParam(name="accountId",value="账户Id",dataType="long", paramType = "query"),
			@ApiImplicitParam(name="status",value="状态，默认1待处理，2成功，3已拒绝",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="method",value="方式，1支付宝，2微信,3百度钱包,4Paypal,5网银,6ios内购,7余额",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="type",value="类型，1购买商品，2提现记录，3退款记录，4诚信押金，5商品售出，6推广分成，7上级推广分成",dataType="int", paramType = "query"),
			@ApiImplicitParam(name="transactionNumber",value="交易单号",dataType="string", paramType = "query"),
	})
	@RequestMapping(value = "/count", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody StateResultList<List<Integer>> count(
			@RequestParam(value="accountId",required=false)Long accountId,
			@RequestParam(value="status",required=false)Integer status,
			@RequestParam(value="method",required=false)Integer method,
			@RequestParam(value="type",required=false)Integer type,
			@RequestParam(value="transactionNumber",required=false)String transactionNumber,
			HttpSession session)  {
		Wrapper<FinanceRecord> wrapper=new EntityWrapper<>();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("account_id", accountId);
		map.put("status", status);
		map.put("method", method);
		map.put("type", type);
		map.put("transaction_number", transactionNumber);
		wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
		StateResultList<List<Integer>> c = super.count(wrapper);
		return c;
	}
	/**
	 * 财务记录单个加载
	 * @return
	 */
	@ApiOperation(value = "财务记录单个加载", notes = "财务记录单个加载")
	@ApiImplicitParams({
		  @ApiImplicitParam(name="financeRecordId",value="财务记录ID",dataType="long", paramType = "query",required=true)
		  })
	@RequestMapping(value = "/load", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<FinanceRecord>> loadFinanceRecord(@RequestParam("financeRecordId") Long financeRecordId,HttpSession session)  {
		 StateResultList<List<FinanceRecord>> l = super.load(financeRecordId);
		 return l;
	}

	/**
	 *提现到账
	 * @return
	 */
	@ApiOperation(value = "提现到账", notes = "提现到账")
	@ApiImplicitParams({
			@ApiImplicitParam(name="financeRecordId",value="财务记录ID",dataType="long", paramType = "query",required=true)
	})
	@RequestMapping(value = "/withdrawals", method = {RequestMethod.GET,RequestMethod.POST})
	public  StateResultList<List<FinanceRecord>> withdrawalsFinanceRecord(
			@RequestParam("financeRecordId") Long financeRecordId,
			HttpSession session)  {
		List<FinanceRecord> list = new ArrayList<FinanceRecord>();
		FinanceRecord financeRecord = financeRecordService.load(financeRecordId);
		if(financeRecord.getStatus()==1){
			financeRecord.setStatus(2);//成功
		}
		boolean b = financeRecordService.update(financeRecord);
		if(b && financeRecord!=null &&!financeRecord.equals("")){
			//到账通知
			//Notice notice =new Notice();// noticeBusiness.getNoticeByDaozhang(financeRecord.getAccountId(), financeRecord.getMethod(), financeRecord.getMoney());
			//b=noticeService.addNotice(notice);
			if(b){
				list.add(financeRecord);
				return ResultUtil.getSlefSRSuccessList(list);
			}
			return ResultUtil.getSlefSRFailList(list);
		}else{
			return ResultUtil.getSlefSRFailList(list);
		}
	}

}
