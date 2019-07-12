/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : strength_test_db

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2019-07-12 18:37:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `account_tb`
-- ----------------------------
DROP TABLE IF EXISTS `account_tb`;
CREATE TABLE `account_tb` (
  `account_id` bigint(20) NOT NULL COMMENT '账户id',
  `phone` varchar(255) DEFAULT NULL COMMENT '注册手机号',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `nickname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `icon` varchar(255) DEFAULT NULL COMMENT '图像',
  `sex` tinyint(4) DEFAULT '3' COMMENT '性别，为1男性，为2女性,默认为3未知',
  `country` varchar(255) DEFAULT NULL COMMENT '国家,默认中国',
  `realname` varchar(255) DEFAULT NULL COMMENT '真实姓名',
  `email` varchar(255) DEFAULT NULL COMMENT 'email',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `invite_code` varchar(255) DEFAULT NULL COMMENT '邀请码',
  `auth` tinyint(4) DEFAULT '1' COMMENT '认证，1没认证，2审核中，3已认证',
  `identity_cards` varchar(255) DEFAULT NULL COMMENT '身份证',
  `identity_cards_front_img` varchar(255) DEFAULT NULL COMMENT '身份证正面',
  `identity_cards_back_img` varchar(255) DEFAULT NULL COMMENT '身份证反面',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `login_date` datetime DEFAULT NULL COMMENT '登陆时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态，默认1正常，2封禁，3异常',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id外键',
  `master_id` bigint(20) DEFAULT NULL COMMENT '上级id外键',
  PRIMARY KEY (`account_id`),
  KEY `INDEX_AUTH` (`auth`) USING BTREE,
  KEY `INDEX_PHONE` (`phone`) USING BTREE,
  KEY `INDEX_REALNAME` (`realname`) USING BTREE,
  KEY `INDEX_CREATEDATE` (`create_date`) USING BTREE,
  KEY `INDEX_LOGINDATE` (`login_date`) USING BTREE,
  KEY `INDEX_ROLEID` (`role_id`) USING BTREE,
  KEY `INDEX_INVITECODE` (`invite_code`) USING BTREE,
  KEY `INDEX_MASTERID` (`master_id`) USING BTREE,
  KEY `INDEX_STATUS` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账户表';

-- ----------------------------
-- Records of account_tb
-- ----------------------------
INSERT INTO `account_tb` VALUES ('1000', '1000', '11874bb6149dd45428da628c9766b252', '聂跃', null, '3', null, null, '1000@qq.com', null, '0', null, '1', null, null, null, '2019-07-08 18:04:05', '2019-07-12 17:09:21', '1', '1000', null);
INSERT INTO `account_tb` VALUES ('1148187514889449473', '15444334343', 'f44f3dd2f74ea4667947fed6b979200d', null, null, '1', null, 'gfh', null, '2017-07-07 00:00:00', '3', '1yM6XGz7', '1', null, null, null, '2019-07-08 19:10:10', '2019-07-08 19:10:10', '1', '1002', null);
INSERT INTO `account_tb` VALUES ('1148880505069305858', '15111336558', 'f44f3dd2f74ea4667947fed6b979200d', null, null, '1', null, '测试2', null, '2015-07-15 00:00:00', '4', 'ezuvZuaI', '1', null, null, null, '2019-07-10 17:03:52', '2019-07-10 17:03:52', '1', '1002', null);

-- ----------------------------
-- Table structure for `assess_project_tb`
-- ----------------------------
DROP TABLE IF EXISTS `assess_project_tb`;
CREATE TABLE `assess_project_tb` (
  `assess_project_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '单项测评id',
  `item` varchar(255) DEFAULT NULL COMMENT '项',
  `rank` tinyint(4) DEFAULT NULL COMMENT '等级,1不良,2未达,3合格,4良好,5优秀',
  `score` double(11,2) DEFAULT NULL COMMENT '分值',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目id外键',
  `assess_id` bigint(20) DEFAULT NULL COMMENT '测评id外键',
  PRIMARY KEY (`assess_project_id`),
  KEY `INDEX_RANK` (`rank`) USING BTREE,
  KEY `INDEX_PROJECTID` (`project_id`) USING BTREE,
  KEY `INDEX_ASSESSID` (`assess_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='单项测评表';

-- ----------------------------
-- Records of assess_project_tb
-- ----------------------------

-- ----------------------------
-- Table structure for `assess_tb`
-- ----------------------------
DROP TABLE IF EXISTS `assess_tb`;
CREATE TABLE `assess_tb` (
  `assess_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '测评id',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `sex` tinyint(4) DEFAULT '3' COMMENT '性别，为1男性，为2女性,默认为3未知',
  `rank` tinyint(4) DEFAULT NULL COMMENT '等级,1不良,2未达,3合格,4良好,5优秀',
  `score` double(11,2) DEFAULT NULL COMMENT '总分',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `account_id` bigint(20) DEFAULT NULL COMMENT '账户id外键',
  PRIMARY KEY (`assess_id`),
  KEY `INDEX_AGE` (`age`) USING BTREE,
  KEY `INDEX_SEX` (`sex`) USING BTREE,
  KEY `INDEX_RANK` (`rank`) USING BTREE,
  KEY `INDEX_ACCOUNTID` (`account_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='测评表';

-- ----------------------------
-- Records of assess_tb
-- ----------------------------

-- ----------------------------
-- Table structure for `config_tb`
-- ----------------------------
DROP TABLE IF EXISTS `config_tb`;
CREATE TABLE `config_tb` (
  `config_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '配置id',
  `platform_name` varchar(255) DEFAULT NULL COMMENT '平台名称',
  `service_phone` varchar(255) DEFAULT NULL COMMENT '平台联系电话',
  `service_qq` varchar(255) DEFAULT NULL COMMENT '平台联系qq',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8 COMMENT='配置表';

-- ----------------------------
-- Records of config_tb
-- ----------------------------
INSERT INTO `config_tb` VALUES ('1000', 'LTX-GIVEMEFIVE', '15111336587', '278076304', '2019-07-08 18:04:05', '2019-07-08 18:26:32');

-- ----------------------------
-- Table structure for `finance_tb`
-- ----------------------------
DROP TABLE IF EXISTS `finance_tb`;
CREATE TABLE `finance_tb` (
  `finance_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '财务id',
  `password` varchar(255) DEFAULT NULL COMMENT '交易密码',
  `money` decimal(11,2) DEFAULT '0.00' COMMENT '余额',
  `recharge` decimal(11,2) DEFAULT '0.00' COMMENT '充值金额',
  `consume` decimal(11,2) DEFAULT '0.00' COMMENT '消费金额',
  `withdrawals` decimal(11,2) DEFAULT '0.00' COMMENT '提现金额',
  `self_profit` decimal(11,2) DEFAULT '0.00' COMMENT '自身总收益',
  `partner_profit` decimal(11,2) DEFAULT '0.00' COMMENT '合伙人总收益',
  `base_profit` decimal(11,2) DEFAULT '0.00' COMMENT '赠送金钱',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `account_id` bigint(20) DEFAULT NULL COMMENT '账户id外键',
  PRIMARY KEY (`finance_id`),
  KEY `INDEX_ACCOUNTID` (`account_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1148880505115443203 DEFAULT CHARSET=utf8 COMMENT='财务表';

-- ----------------------------
-- Records of finance_tb
-- ----------------------------
INSERT INTO `finance_tb` VALUES ('1', null, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2019-07-08 18:04:05', '1000');
INSERT INTO `finance_tb` VALUES ('1148187530546786305', null, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2019-07-08 19:10:10', '1148187514889449473');
INSERT INTO `finance_tb` VALUES ('1148880505115443202', null, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2019-07-10 17:03:52', '1148880505069305858');

-- ----------------------------
-- Table structure for `permission_tb`
-- ----------------------------
DROP TABLE IF EXISTS `permission_tb`;
CREATE TABLE `permission_tb` (
  `permission_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `type` tinyint(4) DEFAULT NULL COMMENT '权限类型，默认1开放，2鉴权',
  `manager_name` varchar(255) DEFAULT NULL COMMENT '权限管理名',
  `name` varchar(255) DEFAULT NULL COMMENT '权限名',
  `route` varchar(255) DEFAULT NULL COMMENT '权限路由',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`permission_id`),
  UNIQUE KEY `route` (`route`),
  KEY `INDEX_TYPE` (`type`) USING BTREE,
  KEY `INDEX_MANAGERNAME` (`manager_name`) USING BTREE,
  KEY `INDEX_NAME` (`name`) USING BTREE,
  KEY `INDEX_ROUTE` (`route`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1148549290223079426 DEFAULT CHARSET=utf8 COMMENT='权限表';

-- ----------------------------
-- Records of permission_tb
-- ----------------------------
INSERT INTO `permission_tb` VALUES ('1148173932395110401', '2', '账户管理', '账户增加', '/account/add', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932487385089', '2', '账户管理', '账户实名认证', '/account/auth', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932516745218', '2', '账户管理', '认证审核', '/account/authExamine', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932550299649', '1', '账户管理', '账户数量', '/account/count', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932579659778', '2', '账户管理', '账户删除', '/account/delete', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932609019906', '2', '账户管理', '忘记密码', '/account/forgetPassword', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932650962946', '1', '账户管理', '是否登录', '/account/islogin', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932684517377', '1', '账户管理', '账户列表', '/account/list', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932713877506', '1', '账户管理', '账户单个加载', '/account/load', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932743237633', '1', '账户管理', '管理员登录', '/account/login', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932755820545', '1', '账户管理', '登出', '/account/loginout', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932797763585', '2', '账户管理', '手机号账户是否存在', '/account/phoneIsExist', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932831318018', '2', '账户管理', '账户修改', '/account/update', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932860678146', '2', '账户管理', '账户修改用户信息', '/account/updateInfo', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932881649665', '2', '账户管理', '更新邀请码', '/account/updateInviteCode', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932911009793', '2', '账户管理', '账户修改密码', '/account/updatePassword', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932940369922', '1', '账户管理', '手机验证码发送/邮箱验证链接', '/account/validCode', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932965535745', '1', '账户管理', 'web用户登录', '/account/weblogin', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173932994895874', '1', '账户管理', 'web用户注册', '/account/webregister', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933028450305', '2', '配置管理', '配置增加', '/config/add', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933049421826', '1', '配置管理', '配置数量', '/config/count', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933074587650', '2', '配置管理', '配置删除', '/config/delete', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933103947778', '1', '配置管理', '配置列表', '/config/list', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933124919297', '1', '配置管理', '配置单个加载', '/config/load', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933145890818', '2', '配置管理', '配置修改', '/config/update', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933179445250', '2', '财务管理', '财务增加', '/finance/add', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933196222465', '1', '财务管理', '财务数量', '/finance/count', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933221388290', '2', '财务管理', '财务删除', '/finance/delete', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933254942721', '1', '财务管理', '财务列表', '/finance/list', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933280108545', '1', '财务管理', '财务单个加载', '/finance/load', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933301080065', '2', '财务管理', '管理员充值', '/finance/recharge', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933322051586', '2', '财务管理', '财务修改', '/finance/update', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933347217410', '2', '财务管理', '管理员修改或增加交易密码', '/finance/updatePasswordByFinanceId', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933368188929', '2', '财务管理', '提现', '/finance/withdrawals', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933393354754', '2', '权限管理', '权限增加', '/permission/add', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933414326274', '1', '权限管理', '权限数量', '/permission/count', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933435297793', '2', '权限管理', '权限删除', '/permission/delete', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933456269313', '2', '权限管理', '初始化权限', '/permission/init', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933473046530', '1', '权限管理', '权限列表', '/permission/list', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933494018049', '1', '权限管理', '权限单个加载', '/permission/load', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933514989570', '2', '权限管理', '权限修改', '/permission/update', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933531766785', '2', '角色管理', '角色增加', '/role/add', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933556932609', '1', '角色管理', '角色数量', '/role/count', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933569515522', '2', '角色管理', '角色删除', '/role/delete', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933594681346', '1', '角色管理', '角色列表', '/role/list', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933615652866', '1', '角色管理', '角色单个加载', '/role/load', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933632430082', '2', '角色管理', '角色修改', '/role/update', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933649207298', '2', '角色权限管理', '角色权限增加', '/rolePermission/add', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933674373122', '1', '角色权限管理', '角色权限数量', '/rolePermission/count', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933695344641', '2', '角色权限管理', '角色权限删除', '/rolePermission/delete', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933716316162', '1', '角色权限管理', '角色权限列表', '/rolePermission/list', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933720510466', '1', '角色权限管理', '角色权限单个加载', '/rolePermission/load', '2019-07-08 18:16:12');
INSERT INTO `permission_tb` VALUES ('1148173933758259202', '2', '角色权限管理', '角色权限修改', '/rolePermission/update', '2019-07-08 18:16:13');
INSERT INTO `permission_tb` VALUES ('1148173933779230721', '1', '工具接口管理', 'cors', '/tool/cors', '2019-07-08 18:16:13');
INSERT INTO `permission_tb` VALUES ('1148173933800202241', '1', '工具接口管理', '上传文件', '/tool/file/add', '2019-07-08 18:16:13');
INSERT INTO `permission_tb` VALUES ('1148173933816979457', '1', '工具接口管理', '生成二维码', '/tool/getQrCode', '2019-07-08 18:16:13');
INSERT INTO `permission_tb` VALUES ('1148173933833756674', '1', '工具接口管理', '获取sessionId', '/tool/getSession', '2019-07-08 18:16:13');
INSERT INTO `permission_tb` VALUES ('1148173933846339585', '1', '工具接口管理', '验证码', '/tool/getVerificationCode', '2019-07-08 18:16:13');
INSERT INTO `permission_tb` VALUES ('1148173933871505410', '1', '工具接口管理', '上传图片', '/tool/img/add', '2019-07-08 18:16:13');
INSERT INTO `permission_tb` VALUES ('1148173933896671234', '1', '工具接口管理', 'test', '/tool/test', '2019-07-08 18:16:13');
INSERT INTO `permission_tb` VALUES ('1148549289191280642', '2', '测评管理', '测评增加', '/assess/add', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549289359052801', '1', '测评管理', '测评数量', '/assess/count', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549289392607233', '2', '测评管理', '测评删除', '/assess/delete', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549289421967362', '1', '测评管理', '测评列表', '/assess/list', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549289480687618', '1', '测评管理', '测评单个加载', '/assess/load', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549289518436354', '2', '测评管理', '测评修改', '/assess/update', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549289807843329', '2', '项目管理', '项目增加', '/project/add', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549289837203458', '1', '项目管理', '项目数量', '/project/count', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549289874952194', '2', '项目管理', '项目删除', '/project/delete', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549289912700929', '1', '项目管理', '项目列表', '/project/list', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549289933672449', '1', '项目管理', '项目单个加载', '/project/load', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549289958838273', '2', '项目管理', '项目修改', '/project/update', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549290097250305', '2', '标准管理', '标准增加', '/standard/add', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549290122416130', '1', '标准管理', '标准数量', '/standard/count', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549290143387650', '2', '标准管理', '标准删除', '/standard/delete', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549290172747778', '1', '标准管理', '标准列表', '/standard/list', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549290193719298', '1', '标准管理', '标准单个加载', '/standard/load', '2019-07-09 19:07:44');
INSERT INTO `permission_tb` VALUES ('1148549290223079425', '2', '标准管理', '标准修改', '/standard/update', '2019-07-09 19:07:44');

-- ----------------------------
-- Table structure for `project_tb`
-- ----------------------------
DROP TABLE IF EXISTS `project_tb`;
CREATE TABLE `project_tb` (
  `project_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '项目id',
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `unit` varchar(10) DEFAULT NULL COMMENT '单位',
  `summary` varchar(1000) DEFAULT NULL COMMENT '简介',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1148558816162746370 DEFAULT CHARSET=utf8 COMMENT='项目表';

-- ----------------------------
-- Records of project_tb
-- ----------------------------
INSERT INTO `project_tb` VALUES ('1148552217624973314', '上肢力量', 'http://localhost:8080/uploaderPath/img/20190709/1562671098885.png', '米', '上肢力量', '2019-07-09 19:19:22', '2019-07-09 19:21:51');
INSERT INTO `project_tb` VALUES ('1148552526602571777', '下肢力量', 'http://localhost:8080/uploaderPath/img/20190709/15626712197.png', '厘米', '下肢力量', '2019-07-09 19:20:36', '2019-07-09 19:20:36');
INSERT INTO `project_tb` VALUES ('1148552981919436802', '综合肺活', 'http://localhost:8080/uploaderPath/img/20190709/1562671328381.png', '毫升', '综合肺活', '2019-07-09 19:22:25', '2019-07-09 19:22:25');
INSERT INTO `project_tb` VALUES ('1148553108096684034', '柔韧性', 'http://localhost:8080/uploaderPath/img/20190709/1562671360208.png', '厘米', '柔韧性', '2019-07-09 19:22:55', '2019-07-09 19:22:55');
INSERT INTO `project_tb` VALUES ('1148553287864553473', '灵敏性', 'http://localhost:8080/uploaderPath/img/20190709/1562671404184.png', '秒', '灵敏性', '2019-07-09 19:23:38', '2019-07-09 19:23:38');
INSERT INTO `project_tb` VALUES ('1148553378281164801', '平衡力', 'http://localhost:8080/uploaderPath/img/20190709/1562671430154.png', '秒', '平衡力', '2019-07-09 19:23:59', '2019-07-09 19:23:59');
INSERT INTO `project_tb` VALUES ('1148558693387079682', '身高', 'http://localhost:8080/uploaderPath/img/20190709/1562672687811.png', 'cm', '身高', '2019-07-09 19:45:06', '2019-07-09 19:45:06');
INSERT INTO `project_tb` VALUES ('1148558816162746369', '体重', 'http://localhost:8080/uploaderPath/img/20190709/1562672715989.png', 'kg', '体重', '2019-07-09 19:45:36', '2019-07-09 19:45:36');

-- ----------------------------
-- Table structure for `role_permission_tb`
-- ----------------------------
DROP TABLE IF EXISTS `role_permission_tb`;
CREATE TABLE `role_permission_tb` (
  `role_permission_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色权限id',
  `region` tinyint(4) DEFAULT NULL COMMENT '范围，1公共，2自身',
  `role_id` int(11) DEFAULT NULL COMMENT '角色id,外键',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `permission_id` bigint(20) DEFAULT NULL COMMENT '权限id,外键',
  PRIMARY KEY (`role_permission_id`),
  UNIQUE KEY `UNIQUE_ROLEID_PERMISSIONID` (`role_id`,`permission_id`),
  KEY `INDEX_REGION` (`region`) USING BTREE,
  KEY `INDEX_ROLEID` (`role_id`) USING BTREE,
  KEY `INDEX_PERMISSIONID` (`permission_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

-- ----------------------------
-- Records of role_permission_tb
-- ----------------------------

-- ----------------------------
-- Table structure for `role_tb`
-- ----------------------------
DROP TABLE IF EXISTS `role_tb`;
CREATE TABLE `role_tb` (
  `role_id` bigint(20) NOT NULL COMMENT '角色id',
  `name` varchar(255) DEFAULT NULL COMMENT '角色名',
  `duty` varchar(255) DEFAULT NULL COMMENT '角色职责',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of role_tb
-- ----------------------------
INSERT INTO `role_tb` VALUES ('1000', '超级管理员', '超级管理员', '2019-07-08 18:04:05');
INSERT INTO `role_tb` VALUES ('1001', '普通管理员', '普通管理员', '2019-07-08 18:04:05');
INSERT INTO `role_tb` VALUES ('1002', '用户', '用户', '2019-07-08 18:04:05');

-- ----------------------------
-- Table structure for `standard_tb`
-- ----------------------------
DROP TABLE IF EXISTS `standard_tb`;
CREATE TABLE `standard_tb` (
  `standard_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '标准id',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `sex` tinyint(4) DEFAULT '3' COMMENT '性别，为1男性，为2女性,默认为3未知',
  `rank` tinyint(4) DEFAULT NULL COMMENT '等级,1不良,2未达,3合格,4良好,5优秀',
  `low` double(11,2) DEFAULT NULL COMMENT '低位',
  `high` double(11,2) DEFAULT NULL COMMENT '高位',
  `item` varchar(255) DEFAULT NULL COMMENT '项',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目id外键',
  PRIMARY KEY (`standard_id`),
  KEY `INDEX_AGE` (`age`) USING BTREE,
  KEY `INDEX_RANK` (`rank`) USING BTREE,
  KEY `INDEX_PROJECTID` (`project_id`) USING BTREE,
  KEY `INDEX_SEX` (`sex`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1148854629178998786 DEFAULT CHARSET=utf8 COMMENT='标准表';

-- ----------------------------
-- Records of standard_tb
-- ----------------------------
INSERT INTO `standard_tb` VALUES ('1148559471036207105', '3', '1', '1', '1.50', '1.90', '网球掷远', '2019-07-09 19:48:12', '2019-07-10 10:20:05', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148559746329350146', '3', '1', '2', '2.00', '2.90', '网球掷远', '2019-07-09 19:49:17', '2019-07-10 10:20:15', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148772357062995970', '3', '1', '3', '3.00', '3.90', '网球掷远', '2019-07-10 09:54:08', '2019-07-10 10:20:23', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148772473173913602', '3', '1', '4', '4.00', '5.40', '网球掷远', '2019-07-10 09:54:35', '2019-07-10 10:20:27', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148773412786089986', '3', '1', '5', '5.50', '999999.00', '网球掷远', '2019-07-10 09:58:19', '2019-07-10 10:20:34', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148779217325326338', '3', '2', '1', '1.00', '1.40', '网球掷远', '2019-07-10 10:21:23', '2019-07-10 10:21:23', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148779340012912642', '3', '2', '2', '1.50', '2.40', '网球掷远', '2019-07-10 10:21:53', '2019-07-10 10:21:53', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148786013674864641', '3', '2', '3', '2.50', '3.40', '网球掷远', '2019-07-10 10:48:24', '2019-07-10 10:48:24', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148786154909663233', '3', '2', '4', '3.50', '4.90', '网球掷远', '2019-07-10 10:48:57', '2019-07-10 10:48:57', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148786236098805761', '3', '2', '5', '5.00', '999999.00', '网球掷远', '2019-07-10 10:49:17', '2019-07-10 10:49:17', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148786567885029377', '4', '1', '1', '1.50', '2.90', '网球掷远', '2019-07-10 10:50:36', '2019-07-10 10:50:36', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148786645081194498', '4', '1', '2', '3.00', '3.90', '网球掷远', '2019-07-10 10:50:54', '2019-07-10 10:50:54', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148786743508926466', '4', '1', '3', '4.00', '4.90', '网球掷远', '2019-07-10 10:51:18', '2019-07-10 10:51:18', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148786817458700289', '4', '1', '4', '5.00', '5.90', '网球掷远', '2019-07-10 10:51:35', '2019-07-10 10:51:35', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148786902598877186', '4', '1', '5', '6.00', '999999.00', '网球掷远', '2019-07-10 10:51:56', '2019-07-10 10:51:56', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148787013571772417', '4', '2', '1', '2.00', '2.40', '网球掷远', '2019-07-10 10:52:22', '2019-07-10 10:52:22', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148787158384312322', '4', '2', '2', '2.50', '3.40', '网球掷远', '2019-07-10 10:52:57', '2019-07-10 10:52:57', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148787278429487106', '4', '2', '3', '3.50', '4.40', '网球掷远', '2019-07-10 10:53:25', '2019-07-10 10:53:25', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148787384608292866', '4', '2', '4', '4.50', '4.90', '网球掷远', '2019-07-10 10:53:51', '2019-07-10 10:53:51', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148827503524511745', '4', '2', '5', '5.00', '999999.00', '网球掷远', '2019-07-10 13:33:16', '2019-07-10 13:36:22', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148843386091274242', '5', '1', '1', '3.00', '3.90', '网球掷远', '2019-07-10 14:36:22', '2019-07-10 14:36:22', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148843480433754114', '5', '1', '2', '4.00', '5.40', '网球掷远', '2019-07-10 14:36:45', '2019-07-10 14:36:45', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148843629004390402', '5', '1', '3', '5.50', '7.40', '网球掷远', '2019-07-10 14:37:20', '2019-07-10 14:37:20', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148843876942282753', '5', '1', '4', '7.50', '8.90', '网球掷远', '2019-07-10 14:38:19', '2019-07-10 14:38:19', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148843955426099202', '5', '1', '5', '9.00', '999999.00', '网球掷远', '2019-07-10 14:38:38', '2019-07-10 14:38:38', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148844035516334081', '5', '2', '1', '3.00', '3.40', '网球掷远', '2019-07-10 14:38:57', '2019-07-10 14:38:57', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148844131733667842', '5', '2', '2', '3.50', '4.40', '网球掷远', '2019-07-10 14:39:20', '2019-07-10 14:39:20', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148845036843499522', '5', '2', '3', '4.50', '5.90', '网球掷远', '2019-07-10 14:42:56', '2019-07-10 14:42:56', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148845161594683394', '5', '2', '4', '6.00', '8.40', '网球掷远', '2019-07-10 14:43:26', '2019-07-10 14:43:26', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148845262136344577', '5', '2', '5', '8.50', '999999.00', '网球掷远', '2019-07-10 14:43:50', '2019-07-10 14:43:50', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148845443858759681', '6', '1', '1', '3.50', '4.40', '网球掷远', '2019-07-10 14:44:33', '2019-07-10 14:44:33', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148845565996892161', '6', '1', '2', '4.50', '6.90', '网球掷远', '2019-07-10 14:45:02', '2019-07-10 14:45:02', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148845648893116418', '6', '1', '3', '7.00', '9.40', '网球掷远', '2019-07-10 14:45:22', '2019-07-10 14:45:22', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148845844850999297', '6', '1', '4', '9.50', '11.90', '网球掷远', '2019-07-10 14:46:09', '2019-07-10 14:46:09', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148848270807072769', '6', '1', '5', '12.00', '999999.00', '网球掷远', '2019-07-10 14:55:47', '2019-07-10 14:55:47', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148848339648184321', '6', '2', '1', '3.00', '3.40', '网球掷远', '2019-07-10 14:56:03', '2019-07-10 14:56:03', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148848434171019266', '6', '2', '2', '3.50', '4.90', '网球掷远', '2019-07-10 14:56:26', '2019-07-10 14:56:26', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148848517658640386', '6', '2', '3', '5.00', '6.40', '网球掷远', '2019-07-10 14:56:46', '2019-07-10 14:56:46', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148848658545311746', '6', '2', '4', '6.50', '8.40', '网球掷远', '2019-07-10 14:57:19', '2019-07-10 14:57:19', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148848744008450050', '6', '2', '5', '8.50', '999999.00', '网球掷远', '2019-07-10 14:57:40', '2019-07-10 14:57:40', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148848961990623233', '7', '1', '1', '3.20', '4.40', '网球掷远', '2019-07-10 14:58:32', '2019-07-10 17:58:27', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148849057281015809', '7', '1', '2', '4.50', '5.80', '网球掷远', '2019-07-10 14:58:54', '2019-07-10 17:58:24', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148849164181241857', '7', '1', '3', '5.90', '8.30', '网球掷远', '2019-07-10 14:59:20', '2019-07-10 17:58:20', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148851108278894594', '7', '1', '4', '8.40', '13.40', '网球掷远', '2019-07-10 15:07:03', '2019-07-10 17:58:15', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148851236830117890', '7', '1', '5', '13.50', '999999.00', '网球掷远', '2019-07-10 15:07:34', '2019-07-10 17:58:11', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148851427972939777', '7', '2', '1', '2.40', '2.80', '网球掷远', '2019-07-10 15:08:20', '2019-07-10 17:58:07', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148851536123068418', '7', '2', '2', '2.90', '3.40', '网球掷远', '2019-07-10 15:08:45', '2019-07-10 17:58:03', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148851639789486082', '7', '2', '3', '3.50', '6.70', '网球掷远', '2019-07-10 15:09:10', '2019-07-10 17:57:59', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148851722777985025', '7', '2', '4', '6.80', '9.80', '网球掷远', '2019-07-10 15:09:30', '2019-07-10 17:57:56', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148851807662309377', '7', '2', '5', '9.90', '999999.00', '网球掷远', '2019-07-10 15:09:50', '2019-07-10 17:57:51', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148852327722450946', '8', '1', '1', '3.20', '4.40', '网球掷远', '2019-07-10 15:11:54', '2019-07-10 17:59:09', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148852423117701121', '8', '1', '2', '4.50', '5.80', '网球掷远', '2019-07-10 15:12:17', '2019-07-10 17:59:06', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148852536200331266', '8', '1', '3', '5.90', '8.30', '网球掷远', '2019-07-10 15:12:44', '2019-07-10 17:59:03', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148852896717537282', '8', '1', '4', '8.40', '13.40', '网球掷远', '2019-07-10 15:14:10', '2019-07-10 17:58:59', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148853028972331009', '8', '1', '5', '13.50', '999999.00', '网球掷远', '2019-07-10 15:14:41', '2019-07-10 17:58:56', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148853131258822657', '8', '2', '1', '2.40', '2.80', '网球掷远', '2019-07-10 15:15:06', '2019-07-10 17:58:53', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148853190167822338', '8', '2', '2', '2.90', '3.40', '网球掷远', '2019-07-10 15:15:20', '2019-07-10 17:58:49', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148853271373742081', '8', '2', '3', '3.50', '6.70', '网球掷远', '2019-07-10 15:15:39', '2019-07-10 17:58:46', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148853506258960386', '8', '2', '4', '6.80', '9.80', '网球掷远', '2019-07-10 15:16:35', '2019-07-10 17:58:43', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148853736018739202', '8', '2', '5', '9.90', '999999.00', '网球掷远', '2019-07-10 15:17:30', '2019-07-10 17:58:40', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148854282679156737', '9', '1', '1', '2.00', '3.40', '实心球掷远', '2019-07-10 15:19:40', '2019-07-10 15:19:40', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148854362664534018', '9', '1', '2', '3.50', '4.90', '实心球掷远', '2019-07-10 15:19:59', '2019-07-10 15:19:59', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148854446252818434', '9', '1', '3', '5.00', '6.60', '实心球掷远', '2019-07-10 15:20:19', '2019-07-10 15:20:19', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1148854629178998785', '9', '1', '4', '6.70', '9.40', '实心球掷远', '2019-07-10 15:21:03', '2019-07-10 15:21:03', '1148552217624973314');
