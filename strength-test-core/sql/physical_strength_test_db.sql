# 数据库 
#创建数据库
DROP DATABASE IF EXISTS physical_strength_test_db;
CREATE DATABASE physical_strength_test_db;

#使用数据库
use physical_strength_test_db;


#创建角色表
CREATE TABLE role_tb(
role_id bigint(20) NOT NULL  COMMENT '角色id',
name varchar(255) COMMENT '角色名',
duty varchar(255) COMMENT '角色职责',
update_date datetime COMMENT '更新时间',
PRIMARY KEY (role_id)
)ENGINE = InnoDB  DEFAULT CHARSET=utf8 COMMENT='角色表';

#创建权限表
CREATE TABLE permission_tb(
permission_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '权限id',
type tinyint(4) COMMENT '权限类型，默认1开放，2鉴权',
manager_name varchar(255) COMMENT '权限管理名',
name varchar(255) COMMENT '权限名',
route varchar(255) unique COMMENT '权限路由',
update_date datetime COMMENT '更新时间',
PRIMARY KEY (permission_id),
INDEX INDEX_TYPE (type) USING BTREE,
INDEX INDEX_MANAGERNAME (manager_name) USING BTREE,
INDEX INDEX_NAME (name) USING BTREE,
INDEX INDEX_ROUTE (route) USING BTREE
)ENGINE = InnoDB  DEFAULT CHARSET=utf8 COMMENT='权限表';

#创建角色权限表
CREATE TABLE role_permission_tb(
role_permission_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色权限id',
region tinyint(4) COMMENT '范围，1公共，2自身',
role_id int(11) COMMENT '角色id,外键',
update_date datetime COMMENT '更新时间',
permission_id bigint(20) COMMENT '权限id,外键',
PRIMARY KEY (role_permission_id),
UNIQUE KEY UNIQUE_ROLEID_PERMISSIONID (role_id,permission_id),
INDEX INDEX_REGION (region) USING BTREE,
INDEX INDEX_ROLEID (role_id) USING BTREE,
INDEX INDEX_PERMISSIONID (permission_id) USING BTREE
)ENGINE = InnoDB  DEFAULT CHARSET=utf8 COMMENT='角色权限表';

#创建账户表 
CREATE TABLE account_tb(
account_id bigint(20) NOT NULL  COMMENT '账户id',
phone varchar(255) COMMENT '注册手机号',
password varchar(255) COMMENT '密码',
nickname varchar(255) COMMENT '昵称',
icon varchar(255) COMMENT '图像',
sex tinyint(4) DEFAULT 3 COMMENT '性别，为1男性，为2女性,默认为3未知',
country varchar(255) COMMENT '国家,默认中国',
realname varchar(255) COMMENT '真实姓名',
email varchar(255) COMMENT 'email',
birthday datetime COMMENT '生日',
invite_code varchar(255) COMMENT '邀请码',
auth tinyint(4) DEFAULT 1 COMMENT '认证，1没认证，2审核中，3已认证',
identity_cards varchar(255) COMMENT '身份证',
identity_cards_front_img varchar(255) COMMENT '身份证正面',
identity_cards_back_img varchar(255) COMMENT '身份证反面',
create_date datetime COMMENT '创建时间',
login_date datetime COMMENT '登陆时间',
status tinyint DEFAULT 1 COMMENT '状态，默认1正常，2封禁，3异常',
role_id bigint(20) COMMENT '角色id外键',
master_id bigint(20) COMMENT '上级id外键',
PRIMARY KEY (account_id),
INDEX INDEX_AUTH (auth) USING BTREE,
INDEX INDEX_PHONE (phone) USING BTREE,
INDEX INDEX_REALNAME (realname) USING BTREE,
INDEX INDEX_CREATEDATE (create_date) USING BTREE,
INDEX INDEX_LOGINDATE (login_date) USING BTREE,
INDEX INDEX_ROLEID (role_id) USING BTREE,
INDEX INDEX_INVITECODE (invite_code) USING BTREE,
INDEX INDEX_MASTERID (master_id) USING BTREE,
INDEX INDEX_STATUS (status) USING BTREE
)ENGINE = InnoDB  DEFAULT CHARSET=utf8 COMMENT='账户表';

#创建标准表
CREATE TABLE standard_tb(
standard_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '标准id',
project varchar(50) COMMENT '项目',
project_introduction varchar(255) COMMENT '项目介绍',
summary varchar(255) COMMENT '简介',
create_date datetime   COMMENT '创建时间',
update_date datetime COMMENT '更新时间',
PRIMARY KEY (standard_id)
)ENGINE = InnoDB  DEFAULT CHARSET=utf8 COMMENT='商品类型表';

#创建商品图片表
CREATE TABLE mer_img_tb(
mer_img_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商品图片id',
img_address varchar(255) COMMENT '图片地址',
number int(11) COMMENT '图片顺序',
create_date datetime COMMENT '创建时间',
update_date datetime COMMENT '更新时间',
mer_id bigint(20) COMMENT '商品id外键',
PRIMARY KEY (mer_img_id),
INDEX INDEX_MERID (mer_id) USING BTREE
)ENGINE = InnoDB DEFAULT CHARSET=utf8 COMMENT='商品图片表';

#创建配置表
CREATE TABLE config_tb(
  config_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '配置id',
  platform_name varchar(255)  COMMENT '平台名称',
  service_phone varchar(255)  COMMENT '平台联系电话',
  service_qq varchar(255)  COMMENT '平台联系qq',
  order_mer_max_number int(11) DEFAULT 5 COMMENT '最大订单商品数量',
  spread_proportion decimal(11,2) DEFAULT 5  COMMENT '推广分成比例，单位%',
  master_spread_proportion decimal(11,2) DEFAULT 2  COMMENT '上级享受推广分成比例，单位%',
  min_withdrawals decimal(11,2) DEFAULT 500  COMMENT '提现最低额度',
  withdrawals_proportion decimal(11,2) DEFAULT 3  COMMENT '提现手续费比例，单位%',
  withdrawals_min_brokerage decimal(11,2) DEFAULT 2000  COMMENT '无提现手续费最低额度',
  create_date datetime COMMENT '创建时间',
  update_date datetime COMMENT '更新时间',
  PRIMARY KEY (config_id)
)ENGINE = InnoDB  DEFAULT CHARSET=utf8 COMMENT='配置表';

#设置初始角色
INSERT IGNORE INTO role_tb (role_id,name,duty,update_date) 
VALUES (1000,'超级管理员','超级管理员',now());
INSERT IGNORE INTO role_tb (role_id,name,duty,update_date) 
VALUES (1001,'普通管理员','普通管理员',now());
INSERT IGNORE INTO role_tb (role_id,name,duty,update_date)
VALUES (1002,'用户','用户',now());

#初始化配置
INSERT IGNORE INTO config_tb (
config_id,
platform_name,
service_phone,
service_qq,
order_mer_max_number,
spread_proportion,
master_spread_proportion,
min_withdrawals,
withdrawals_proportion,
withdrawals_min_brokerage,
create_date,
update_date)
VALUES (
1000,
'本真',
'15111336587',
'278076304',
5,
5,
2,
500,
3,
2000,
now(),
now());

#设置初始管理员密码MD5加密123456
INSERT IGNORE INTO account_tb (account_id,nickname,phone,email,password,create_date,login_date,role_id) 
VALUES (1000,'聂跃','1000','1000@qq.com','11874bb6149dd45428da628c9766b252',now(),now(),1000);

#财务
INSERT IGNORE INTO finance_tb (money,recharge,consume,withdrawals,update_date,account_id)
VALUES (0,0,0,0,now(),1000);