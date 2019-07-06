package com.nieyue.bean;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 商品类型
 * @author 聂跃
 * @date 2017年4月12日
 */
@Data
@ApiModel(value="商品类型",description="商品类型")
@TableName("mer_cate_tb")
public class MerCate implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 商品类型id
	 */
	@ApiModelProperty(value="商品类型id")
	@TableId("mer_cate_id")
	private Long merCateId;
	/**
	 * 商品类型名称
	 */
	@ApiModelProperty(value="商品类型名称")
	private String name;
	/**
	 * 简介
	 */
	@ApiModelProperty(value="简介")
	private String summary;
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

}
