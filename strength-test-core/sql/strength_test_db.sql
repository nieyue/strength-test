# 数据库 
#创建数据库
DROP DATABASE IF EXISTS strength_test_db;
CREATE DATABASE strength_test_db;

#使用数据库
use strength_test_db;


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
age int(11) COMMENT '年龄',
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

#创建财务表
CREATE TABLE finance_tb(
finance_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '财务id',
password varchar(255)  COMMENT '交易密码',
money decimal(11,2) DEFAULT 0 COMMENT '余额',
recharge decimal(11,2) DEFAULT 0 COMMENT '充值金额',
consume decimal(11,2) DEFAULT 0 COMMENT '消费金额',
withdrawals decimal(11,2) DEFAULT 0 COMMENT '提现金额',
self_profit decimal(11,2) DEFAULT 0 COMMENT '自身总收益',
partner_profit decimal(11,2) DEFAULT 0 COMMENT '合伙人总收益',
base_profit decimal(11,2) DEFAULT 0 COMMENT '赠送金钱',
update_date datetime COMMENT '更新时间',
account_id bigint(20) COMMENT '账户id外键',
PRIMARY KEY (finance_id),
INDEX INDEX_ACCOUNTID (account_id) USING BTREE
)ENGINE = InnoDB  DEFAULT CHARSET=utf8 COMMENT='财务表';

#创建项目表
CREATE TABLE project_tb(
project_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '项目id',
name varchar(255) COMMENT '名称',
icon varchar(255) COMMENT '图标',
unit varchar(10) COMMENT '单位',
summary varchar(1000) COMMENT '简介',
create_date datetime   COMMENT '创建时间',
update_date datetime COMMENT '更新时间',
PRIMARY KEY (project_id)
)ENGINE = InnoDB  DEFAULT CHARSET=utf8 COMMENT='项目表';

#创建标准表
CREATE TABLE standard_tb(
standard_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '标准id',
age int(11) COMMENT '年龄',
sex tinyint(4) DEFAULT 3 COMMENT '性别，为1男性，为2女性,默认为3未知',
rank tinyint(4) COMMENT '等级,1不良,2未达,3合格,4良好,5优秀',
low double(11,2) COMMENT '低位',
high double(11,2) COMMENT '高位',
item varchar(255) COMMENT '项',
create_date datetime COMMENT '创建时间',
update_date datetime COMMENT '更新时间',
project_id bigint(20) COMMENT '项目id外键',
PRIMARY KEY (standard_id),
INDEX INDEX_AGE (age) USING BTREE,
INDEX INDEX_SEX (sex) USING BTREE,
INDEX INDEX_RANK (rank) USING BTREE,
INDEX INDEX_PROJECTID (project_id) USING BTREE
)ENGINE = InnoDB  DEFAULT CHARSET=utf8 COMMENT='标准表';

#创建测评表
CREATE TABLE assess_tb(
assess_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '测评id',
age int(11) COMMENT '年龄',
sex tinyint(4) DEFAULT 3 COMMENT '性别，为1男性，为2女性,默认为3未知',
rank tinyint(4) COMMENT '等级,1不良,2未达,3合格,4良好,5优秀',
score double(11,2) COMMENT '总分',
create_date datetime   COMMENT '创建时间',
update_date datetime COMMENT '更新时间',
account_id bigint(20) COMMENT '账户id外键',
PRIMARY KEY (assess_id),
INDEX INDEX_AGE (age) USING BTREE,
INDEX INDEX_SEX (sex) USING BTREE,
INDEX INDEX_RANK (rank) USING BTREE,
INDEX INDEX_ACCOUNTID (account_id) USING BTREE
)ENGINE = InnoDB  DEFAULT CHARSET=utf8 COMMENT='测评表';

#创建单项测评表
CREATE TABLE assess_project_tb(
assess_project_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '单项测评id',
rank tinyint(4) COMMENT '等级,1不良,2未达,3合格,4良好,5优秀',
score double(11,2) COMMENT '结果值',
item varchar(255) COMMENT '项',
create_date datetime   COMMENT '创建时间',
update_date datetime COMMENT '更新时间',
project_id bigint(20) COMMENT '项目id外键',
assess_id bigint(20) COMMENT '测评id外键',
PRIMARY KEY (assess_project_id),
INDEX INDEX_RANK (rank) USING BTREE,
INDEX INDEX_PROJECTID (project_id) USING BTREE,
INDEX INDEX_ASSESSID (assess_id) USING BTREE
)ENGINE = InnoDB  DEFAULT CHARSET=utf8 COMMENT='单项测评表';


#创建配置表
CREATE TABLE config_tb(
  config_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '配置id',
  platform_name varchar(255)  COMMENT '平台名称',
  service_phone varchar(255)  COMMENT '平台联系电话',
  service_qq varchar(255)  COMMENT '平台联系qq',
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
create_date,
update_date)
VALUES (
1000,
'LTX-GIVEMEFIVE少儿体能运动测评',
'15111336587',
'278076304',
now(),
now());

#设置初始管理员密码MD5加密123456
INSERT IGNORE INTO account_tb (account_id,nickname,phone,email,password,create_date,login_date,role_id) 
VALUES (1000,'聂跃','1000','1000@qq.com','11874bb6149dd45428da628c9766b252',now(),now(),1000);

#财务
INSERT IGNORE INTO finance_tb (money,recharge,consume,withdrawals,update_date,account_id)
VALUES (0,0,0,0,now(),1000);