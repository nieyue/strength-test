package com.nieyue.bean;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 购物车商品
 * @author 聂跃
 * @date 2017年4月12日
 */
@Data
@ApiModel(value="购物车商品",description="购物车商品")
@TableName("cart_mer_tb")
public class CartMer implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 购物车商品id
	 */
	@ApiModelProperty(value="购物车商品id")
	@TableId("cart_mer_id")
	private Long cartMerId;
	/**
	 *数量
	 */
	@ApiModelProperty(value="数量",example="数量")
	private Integer number;
	/**
	 *总价
	 */
	@ApiModelProperty(value="总价",example="总价")
	private Double totalPrice;
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
	 * 推广账户id
	 */
	@ApiModelProperty(value="推广账户id",example="推广账户id")
	private Long spreadAccountId;
	/**
	 * 商品id外键
	 */
	@ApiModelProperty(value="商品id外键",example="商品id外键")
	private Long merId;
	/**
	 * 账户id外键
	 */
	@ApiModelProperty(value="账户id外键",example="账户id外键")
	private Long accountId;
	/**
	 * 商品
	 */
	@ApiModelProperty(value="商品",example="商品")
	@TableField(exist = false)
	private Mer mer;

}
