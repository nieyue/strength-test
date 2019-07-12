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
 * 测评
 * @author yy
 *
 */
@Data
@ApiModel(value="测评",description="测评")
@TableName("assess_tb")
public class Assess implements Serializable{
    /**
     *
     */
    private static final long serialVersionUID = 1L;
    /**
     * 测评id
     */
    @ApiModelProperty(value="测评id")
    @TableId("assess_id")
    private Long assessId;

    /**
     * 年龄
     */
    @ApiModelProperty(value="年龄")
    private Integer age;
    /**
     * 性别，为1男性，为2女性,默认为3未知
     */
    @ApiModelProperty(value="性别，为1男性，为2女性,默认为3未知")
    private Integer sex;
    /**
     * 等级,1不良,2未达,3合格,4良好,5优秀
     */
    @ApiModelProperty(value="等级,1不良,2未达,3合格,4良好,5优秀")
    private Integer rank;
    /**
     * 总分
     */
    @ApiModelProperty(value="总分")
    private Double score;
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
     * 账户id外键
     */
    @ApiModelProperty(value="账户id外键")
    private Long accountId;
    /**
     * 账户
     */
    @ApiModelProperty(value="账户")
    @TableField(exist = false)
    private Account account;
    /**
     * 单项测评列表
     */
    @ApiModelProperty(value="单项测评列表")
    @TableField(exist = false)
    private List<AssessProject> assessProjectList;


}



