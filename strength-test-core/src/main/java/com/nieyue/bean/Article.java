package com.nieyue.bean;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 文章
 * @author 聂跃
 * @date 2017年4月12日
 */
@Data
@ApiModel(value="文章",description="文章")
@TableName("article_tb")
public class Article implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 商品文章id
	 */
	@ApiModelProperty(value="文章id")
	@TableId("article_id")
	private Long articleId;
	/**
	 * 标题
	 */
	@ApiModelProperty(value="标题")
	private String title;
	/**
	 * 子标题
	 */
	@ApiModelProperty(value="子标题")
	private String subtitle;
	/**
	 * 来源
	 */
	@ApiModelProperty(value="来源")
	private String resource;
	/**
	 * 封面
	 */
	@ApiModelProperty(value="封面")
	private String imgAddress;
	/**
	 * 跳转url
	 */
	@ApiModelProperty(value="跳转url")
	private String redirectUrl;
	/**
	 * 内容
	 */
	@ApiModelProperty(value="内容")
	private String content;
	/**
	 * 阅读数
	 */
	@ApiModelProperty(value="阅读数")
	private Long readingNumber;
	/**
	 * 状态,1上架,2下架
	 */
	@ApiModelProperty(value="状态,1上架,2下架")
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
	 * 文章类型id外键
	 */
	@ApiModelProperty(value="文章类型id外键")
	private Long articleCateId;

}
