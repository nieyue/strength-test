package com.nieyue.bean;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;
/**
 * 账户
 * @author 聂跃
 * @date 2017年4月12日
 */
@Data
@ApiModel(value="账户",description="账户")
@TableName("account_tb")
public class Account implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 账户id
	 */
	@ApiModelProperty(value="账户id")
	@TableId("account_id")
	private Long accountId;
	/**
	 * 注册手机号
	 */
	@ApiModelProperty(value="注册手机号")
	private String phone;
	/**
	 * 密码
	 */
	@ApiModelProperty(value="密码")
	private String password;
	/**
	 * 昵称
	 */
	@ApiModelProperty(value="昵称")
	private String nickname;
	/**
	 * 图像
	 */
	@ApiModelProperty(value="图像")
	private String icon;
	/**
	 * 性别，为1男性，为2女性,默认为3未知
	 */
	@ApiModelProperty(value="性别，为1男性，为2女性,默认为3未知")
	private Integer sex;
	/**
	 * 真实姓名
	 */
	@ApiModelProperty(value="真实姓名")
	private String realname;
	/**
	 * 生日
	 */
	@ApiModelProperty(value="生日")
	private Date birthday;
	//private LocalDateTime birthday;
	/**
	 * 年龄
	 */
	@ApiModelProperty(value="年龄")
	private Integer age;
	/**
	 * email
	 */
	@ApiModelProperty(value="email")
	private String email;
	/**
	 * 国家
	 */
	@ApiModelProperty(value="国家")
	private String country;
	/**
	 * 邀请码
	 */
	@ApiModelProperty(value="邀请码")
	private String inviteCode;
	/**
	 * 身份证
	 */
	@ApiModelProperty(value="身份证")
	private String identityCards;
	/**
	 * 身份证正面
	 */
	@ApiModelProperty(value="身份证正面")
	private String identityCardsFrontImg;
	/**
	 * 身份证反面
	 */
	@ApiModelProperty(value="身份证反面")
	private String identityCardsBackImg;

	/**
	 * 认证，1没认证，2审核中，3已认证
	 */
	@ApiModelProperty(value="认证，1没认证，2审核中，3已认证")
	private Integer auth;
	/**
	 * 创建时间
	 */
	@ApiModelProperty(value="创建时间")
	private Date createDate;
	/**
	 * 登陆时间
	 */
	@ApiModelProperty(value="登陆时间")
	private Date loginDate;
	/**
	 * 状态 1正常，2封禁，3异常
	 */
	@ApiModelProperty(value="状态 1正常，2封禁，3异常")
	private Integer status;
	/**
	 * 上级id外键
	 */
	@ApiModelProperty(value="上级id外键")
	private Long masterId;
	/**
	 * 角色id外键
	 */
	@ApiModelProperty(value="角色id外键")
	private Long roleId;
	/**
	 * 角色
	 */
	@ApiModelProperty(value="角色")
	@TableField(exist=false)
	private  Role role;

}
