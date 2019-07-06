package com.nieyue.bean;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 订单
 * @author 聂跃
 * @date 2017年4月12日
 */
@Data
@ApiModel(value="订单",description="订单")
@TableName("order_tb")
public class Order implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 订单id
	 */
	@ApiModelProperty(value="订单id")
	@TableId("order_id")
	private Long orderId;
	/**
	 * 订单号
	 */
	@ApiModelProperty(value="订单号")
	private String orderNumber;
	/**
	 * 类型，1购买商品，2账户提现，3退款，4诚信押金
	 */
	@ApiModelProperty(value="类型，1购买商品，2账户提现，3退款，4诚信押金")
	private Integer type;
	/**
	 * 方式，1支付宝，2微信,3百度钱包,4Paypal,5网银
	 */
	@ApiModelProperty(value="方式，1支付宝，2微信,3百度钱包,4Paypal,5网银")
	private Integer payType;
	/**
	 * 商品类型，1普通商品，2降价商品，3预购商品
	 */
	@ApiModelProperty(value="商品类型，1普通商品，2降价商品，3预购商品")
	private Integer merType;
	/**
	 * 创建时间
	 */
	@ApiModelProperty(value="创建时间")
	private Date createDate;
	/**
	 * 更新时间
	 */
	@ApiModelProperty(value="更新时间")
	private Date updateDate;
	/**
	 * 支付日期
	 */
	@ApiModelProperty(value="支付日期")
	private Date paymentDate;
	/**
	 * 商户id
	 */
	@ApiModelProperty(value="商户id")
	private Long merchantAccountId;
	/**
	 * 推广账户id
	 */
	@ApiModelProperty(value="推广账户id")
	private Long spreadAccountId;
	/**
	 * 下单人
	 */
	@ApiModelProperty(value="下单人")
	private Long accountId;
	/**
	 * 订单状态，2待支付，3待发货,4待收货，5待评价，6已取消，7已删除
	 */
	@ApiModelProperty(value="订单状态，2待支付，3待发货,4待收货，5待评价，6已取消，7已删除")
	private Integer status;
	/**
	 * 订单详情
	 */
	@ApiModelProperty(value="订单详情")
	@TableField(exist = false)
	private List<OrderDetail> orderDetailList;

}
