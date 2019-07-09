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
 * 项目
 * @author yy
 *
 */
@Data
@ApiModel(value="项目",description="项目")
@TableName("project_tb")
public class Project implements Serializable{
    /**
     *
     */
    private static final long serialVersionUID = 1L;
    /**
     * 项目id
     */
    @ApiModelProperty(value="项目id")
    @TableId("project_id")
    private Long projectId;

    /**
     * 名称
     */
    @ApiModelProperty(value="名称")
    private String name;
    /**
     * 图标
     */
    @ApiModelProperty(value="图标")
    private String icon;
    /**
     * 单位
     */
    @ApiModelProperty(value="单位")
    private String unit;
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
    /**
     * 标准列表
     */
   /* @ApiModelProperty(value="标准列表")
    @TableField(exist = false)
    private List<Standard> standardList;*/
}



