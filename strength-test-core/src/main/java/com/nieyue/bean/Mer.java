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
 * 商品
 * @author 聂跃
 * @date 2017年4月12日
 */
@Data
@ApiModel(value="商品",description="商品")
@TableName("mer_tb")
public class Mer implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 商品id
	 */
	@ApiModelProperty(value="商品id")
	@TableId("mer_id")
	private Long merId;
	/**
	 * 名称
	 */
	@ApiModelProperty(value="名称")
	private String name;
	/**
	 * 类型，1普通商品，2降价商品，3预购商品
	 */
	@ApiModelProperty(value="类型，1普通商品，2降价商品，3预购商品")
	private Integer type;
	/**
	 * 简介
	 */
	@ApiModelProperty(value="简介")
	private String summary;
	/**
	 * 封面
	 */
	@ApiModelProperty(value="封面")
	private String imgAddress;
	/**
	 * 推荐，默认1不推，2封推，3推荐
	 */
	@ApiModelProperty(value="推荐，默认1不推，2封推，3推荐")
	private Integer recommend;
	/**
	 * 原始单价
	 */
	@ApiModelProperty(value="原始单价")
	private Double oldUnitPrice;
	/**
	 * 单价
	 */
	@ApiModelProperty(value="单价")
	private Double unitPrice;
	/**
	 * 折扣
	 */
	@ApiModelProperty(value="折扣")
	private Double discount;
	/**
	 * 销量
	 */
	@ApiModelProperty(value="销量")
	private Integer saleNumber;
	/**
	 * 库存数
	 */
	@ApiModelProperty(value="库存数")
	private Integer stockNumber;
	/**
	 * 商品评分
	 */
	@ApiModelProperty(value="商品评分")
	private Double merScore;
	/**
	 * 商品评论数
	 */
	@ApiModelProperty(value="商品评论数")
	private Integer merCommentNumber;
	/**
	 * 商品详情
	 */
	@ApiModelProperty(value="商品详情")
	private String details;

	/**
	 * 状态,默认1上架,2下架
	 */
	@ApiModelProperty(value="状态,默认1上架,2下架")
	private Integer status;
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
	 * 商品类型id,外键
	 */
	@ApiModelProperty(value="商品类型id,外键")
	private Long merCateId;
	/**
	 * 商户账户id,外键
	 */
	@ApiModelProperty(value="商户账户id,外键")
	private Long merchantAccountId;
	/**
	 * 商品类型
	 */
	@ApiModelProperty(value="商品类型")
	@TableField(exist = false)
	private MerCate merCate;
	/**
	 * 商品图片列表
	 */
	@ApiModelProperty(value="商品图片列表")
	@TableField(exist = false)
	private List<MerImg> merImgList;

}
