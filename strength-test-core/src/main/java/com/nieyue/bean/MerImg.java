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
 * 商品图片
 * @author 聂跃
 * @date 2017年4月12日
 */
@Data
@ApiModel(value="商品图片",description="商品图片")
@TableName("mer_img_tb")
public class MerImg implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 商品图片id
	 */
	@ApiModelProperty(value="商品图片id")
	@TableId("mer_img_id")
	private Long merImgId;
	/**
	 * 图片地址
	 */
	@ApiModelProperty(value="图片地址")
	private String imgAddress;
	/**
	 * 图片顺序
	 */
	@ApiModelProperty(value="图片顺序")
	private Integer number;
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
	 * 商品id外键
	 */
	@ApiModelProperty(value="商品id外键")
	private Long merId;

}
