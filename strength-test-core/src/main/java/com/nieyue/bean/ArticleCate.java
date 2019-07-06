package com.nieyue.bean;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 文章类型
 * @author yy
 *
 */
@Data
@ApiModel(value="文章类型",description="文章类型")
@TableName("article_cate_tb")
public class ArticleCate implements Serializable{
    /**
     *
     */
    private static final long serialVersionUID = 1L;
    /**
     * 文章类型id
     */
    @ApiModelProperty(value="文章类型id")
    @TableId("article_cate_id")
    private Long articleCateId;

    /**
     * 文章类型名称
     */
    @ApiModelProperty(value="文章类型名称")
    private String name;
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



