package com.nieyue.bean;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 订单详情
 * @author 聂跃
 * @date 2017年4月12日
 */
@Data
@ApiModel(value="订单详情",description="订单详情")
@TableName("order_detail_tb")
public class OrderDetail implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 商品订单详情id
	 */
	@ApiModelProperty(value="订单详情id")
	@TableId("order_detail_id")
	private Long orderDetailId;
	/**
	 * 名称
	 */
	@ApiModelProperty(value="名称")
	private String name;
	/**
	 * 封面
	 */
	@ApiModelProperty(value="商品图片")
	private String imgAddress;
	/**
	 * 类型名名称
	 */
	@ApiModelProperty(value="类型名名称")
	private String merCateName;
	/**
	 * 单价
	 */
	@ApiModelProperty(value="单价")
	private Double unitPrice;
	/**
	 * 数量
	 */
	@ApiModelProperty(value="数量")
	private Integer number;
	/**
	 * 总价
	 */
	@ApiModelProperty(value="总价")
	private Double totalPrice;
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
	 * 优惠劵id
	 */
	@ApiModelProperty(value="优惠劵id")
	private Long couponId;
	/**
	 * 商品id
	 */
	@ApiModelProperty(value="商品id")
	private Long merId;
	/**
	 * 订单ID
	 */
	@ApiModelProperty(value="订单ID")
	private Long orderId;

}
