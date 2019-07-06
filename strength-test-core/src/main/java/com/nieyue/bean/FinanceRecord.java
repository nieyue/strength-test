package com.nieyue.bean;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 财务记录
 * @author 聂跃
 * @date 2017年4月12日
 */
@Data
@TableName("finance_record_tb")
@ApiModel(value="财务记录",description="财务记录")
public class FinanceRecord implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 财务记录id
	 */
	@TableId("finance_record_id")
	@ApiModelProperty(value="财务记录id")
	private Long financeRecordId;
	/**
	 * 方式，1支付宝，2微信,3百度钱包,4Paypal,5网银,6ios内购,7余额
	 */
	@ApiModelProperty(value="方式，1支付宝，2微信,3百度钱包,4Paypal,5网银,6ios内购,7余额")
	private Integer method;
	/**
	 * 类型，1购买商品，2提现记录，3退款记录，4诚信押金，5商品售出，6推广分成，7上级推广分成
	 */
	@ApiModelProperty(value="类型，1购买商品，2提现记录，3退款记录，4诚信押金，5商品售出，6推广分成，7上级推广分成")
	private Integer type;
	/**
	 * 交易单号
	 */
	@ApiModelProperty(value="交易单号")
	private String transactionNumber;
	/**
	 * 真实姓名
	 */
	@ApiModelProperty(value="真实姓名",example="真实姓名")
	private String realname;
	/**
	 * 实际金额
	 */
	@ApiModelProperty(value="实际金额",example="实际金额")
	private Double realMoney;
	/**
	 * 备注
	 */
	@ApiModelProperty(value="备注",example="备注")
	private String mark;
	/**
	 * 状态，默认1待处理，2成功，3已拒绝
	 */
	@ApiModelProperty(value="状态，默认1待处理，2成功，3已拒绝",example="状态，默认1待处理，2成功，3已拒绝")
	private Integer status;
	/**
	 * 创建时间
	 */
	@ApiModelProperty(value="创建时间",example="创建时间")
	private Date createDate;
	/**
	 * 更新时间
	 */
	@ApiModelProperty(value="更新时间",example="更新时间")
	private Date updateDate;
	/**
	 * 账户id外键
	 */
	@ApiModelProperty(value="账户id外键",example="账户id外键")
	private Long accountId;


}
