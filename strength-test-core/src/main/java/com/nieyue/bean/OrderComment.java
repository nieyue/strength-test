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
 * 订单评价
 * @author 聂跃
 * @date 2017年4月12日
 */
@Data
@ApiModel(value="订单评价",description="订单评价")
@TableName("order_comment_tb")
public class OrderComment implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 商品订单评价id
	 */
	@ApiModelProperty(value="订单评价id")
	@TableId("order_comment_id")
	private Long orderCommentId;
	/**
	 * 评分
	 */
	@ApiModelProperty(value="评分")
	private Double score;
	/**
	 * 内容
	 */
	@ApiModelProperty(value="内容")
	private String content;
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
	 * 商品id
	 */
	@ApiModelProperty(value="商品id")
	private Long merId;
	/**
	 * 订单ID
	 */
	@ApiModelProperty(value="订单ID")
	private Long orderId;
	/**
	 * 评论人id外键
	 */
	@ApiModelProperty(value="评论人id外键")
	private Long accountId;
	/**
	 * 评论人
	 */
	@ApiModelProperty(value="评论人")
	@TableField(exist = false)
	private Account account;

}
