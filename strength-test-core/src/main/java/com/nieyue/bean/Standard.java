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
 * 标准
 * @author yy
 *
 */
@Data
@ApiModel(value="标准",description="标准")
@TableName("standard_tb")
public class Standard implements Serializable{
    /**
     *
     */
    private static final long serialVersionUID = 1L;
    /**
     * 标准id
     */
    @ApiModelProperty(value="标准id")
    @TableId("standard_id")
    private Long standardId;

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
     * 低位
     */
    @ApiModelProperty(value="低位")
    private Double low;
    /**
     * 高位
     */
    @ApiModelProperty(value="高位")
    private Double high;
    /**
     * 项
     */
    @ApiModelProperty(value="项")
    private String item;
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
     * 项目id外键
     */
    @ApiModelProperty(value="项目id外键")
    private Long projectId;
    /**
     * 项目
     */
    @ApiModelProperty(value="项目")
    @TableField(exist = false)
    private Project project;


}



