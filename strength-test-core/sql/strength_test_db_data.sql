/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : strength_test_db

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2019-07-19 19:05:55
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
INSERT INTO `account_tb` VALUES ('1000', '1000', '11874bb6149dd45428da628c9766b252', '聂跃', null, '3', null, null, '1000@qq.com', null, '0', null, '1', null, null, null, '2019-07-08 18:04:05', '2019-07-19 10:28:20', '1', '1000', null);
INSERT INTO `account_tb` VALUES ('1148187514889449473', '15444334343', 'f44f3dd2f74ea4667947fed6b979200d', null, null, '1', null, 'gfh', null, '2017-07-07 00:00:00', '3', '1yM6XGz7', '1', null, null, null, '2019-07-08 19:10:10', '2019-07-08 19:10:10', '1', '1002', null);
INSERT INTO `account_tb` VALUES ('1148880505069305858', '15111336558', 'f44f3dd2f74ea4667947fed6b979200d', null, null, '1', null, '王大锤', null, '2015-07-15 00:00:00', '5', 'ezuvZuaI', '1', null, null, null, '2019-07-10 17:03:52', '2019-07-10 17:03:52', '1', '1002', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=1152094376118636546 DEFAULT CHARSET=utf8 COMMENT='单项测评表';

-- ----------------------------
-- Records of assess_project_tb
-- ----------------------------
INSERT INTO `assess_project_tb` VALUES ('1152046533840392194', '称重', '1', '17.00', '2019-07-17 10:44:32', '2019-07-17 13:37:58', '1148558816162746369', '1151415760540037121');
INSERT INTO `assess_project_tb` VALUES ('1152090781566554114', '尺量', '1', '98.00', '2019-07-17 13:40:22', '2019-07-17 13:40:22', '1148558693387079682', '1151415760540037121');
INSERT INTO `assess_project_tb` VALUES ('1152091098345558018', '平衡木1段', '5', '10.20', '2019-07-17 13:41:37', '2019-07-17 13:41:37', '1148553378281164801', '1151415760540037121');
INSERT INTO `assess_project_tb` VALUES ('1152091181870927873', '10米折返跑', '5', '12.00', '2019-07-17 13:41:57', '2019-07-17 13:41:57', '1148553287864553473', '1151415760540037121');
INSERT INTO `assess_project_tb` VALUES ('1152091264129617921', '坐位体前屈', '2', '7.50', '2019-07-17 13:42:17', '2019-07-17 13:42:17', '1148553108096684034', '1151415760540037121');
INSERT INTO `assess_project_tb` VALUES ('1152091512948314114', null, '1', '0.00', '2019-07-17 13:43:16', '2019-07-17 13:43:16', '1148552981919436802', '1151415760540037121');
INSERT INTO `assess_project_tb` VALUES ('1152092179226087425', null, '1', '2.00', '2019-07-17 13:45:55', '2019-07-17 13:45:55', '1148552217624973314', '1151415760540037121');
INSERT INTO `assess_project_tb` VALUES ('1152092293839638529', '立定跳远', '1', '55.00', '2019-07-17 13:46:22', '2019-07-17 13:46:22', '1148552526602571777', '1151415760540037121');
INSERT INTO `assess_project_tb` VALUES ('1152093818536251394', '称重', '3', '19.00', '2019-07-19 13:52:26', '2019-07-19 13:52:52', '1148558816162746369', '1152093735191236609');
INSERT INTO `assess_project_tb` VALUES ('1152093974711160833', '尺量', '3', '112.00', '2019-07-19 13:53:03', '2019-07-19 13:53:12', '1148558693387079682', '1152093735191236609');
INSERT INTO `assess_project_tb` VALUES ('1152094069267550209', '平衡木1段', '5', '9.00', '2019-07-19 13:53:26', '2019-07-19 13:53:26', '1148553378281164801', '1152093735191236609');
INSERT INTO `assess_project_tb` VALUES ('1152094127081836546', '10米折返跑', '5', '11.00', '2019-07-19 13:53:39', '2019-07-19 13:53:39', '1148553287864553473', '1152093735191236609');
INSERT INTO `assess_project_tb` VALUES ('1152094187228155905', '坐位体前屈', '3', '9.00', '2019-07-19 13:53:54', '2019-07-19 13:53:54', '1148553108096684034', '1152093735191236609');
INSERT INTO `assess_project_tb` VALUES ('1152094222753910785', null, '1', '0.00', '2019-07-19 13:54:02', '2019-07-19 13:54:02', '1148552981919436802', '1152093735191236609');
INSERT INTO `assess_project_tb` VALUES ('1152094252319559681', '网球掷远', '4', '8.00', '2019-07-19 13:54:09', '2019-07-19 13:54:26', '1148552217624973314', '1152093735191236609');
INSERT INTO `assess_project_tb` VALUES ('1152094376118636545', '立定跳远', '2', '77.00', '2019-07-19 13:54:39', '2019-07-19 13:54:46', '1148552526602571777', '1152093735191236609');

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
) ENGINE=InnoDB AUTO_INCREMENT=1152093735191236610 DEFAULT CHARSET=utf8 COMMENT='测评表';

-- ----------------------------
-- Records of assess_tb
-- ----------------------------
INSERT INTO `assess_tb` VALUES ('1150576171147526145', '3', '1', '1', '0.00', '2019-07-15 09:21:51', '2019-07-15 09:21:51', '1148187514889449473');
INSERT INTO `assess_tb` VALUES ('1151415760540037121', '5', '1', '1', '0.00', '2019-07-17 16:58:04', '2019-07-17 16:58:04', '1148880505069305858');
INSERT INTO `assess_tb` VALUES ('1152093735191236609', '5', '1', '1', '0.00', '2019-07-19 13:52:06', '2019-07-19 13:52:06', '1148880505069305858');

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
) ENGINE=InnoDB AUTO_INCREMENT=1152110084403707907 DEFAULT CHARSET=utf8 COMMENT='权限表';

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
INSERT INTO `permission_tb` VALUES ('1150570249553641474', '2', '单项测评管理', '单项测评增加', '/assessProject/add', '2019-07-15 08:58:19');
INSERT INTO `permission_tb` VALUES ('1150570249662693378', '1', '单项测评管理', '单项测评数量', '/assessProject/count', '2019-07-15 08:58:19');
INSERT INTO `permission_tb` VALUES ('1150570249708830722', '2', '单项测评管理', '单项测评删除', '/assessProject/delete', '2019-07-15 08:58:19');
INSERT INTO `permission_tb` VALUES ('1150570249754968065', '1', '单项测评管理', '单项测评列表', '/assessProject/list', '2019-07-15 08:58:19');
INSERT INTO `permission_tb` VALUES ('1150570249792716802', '1', '单项测评管理', '单项测评单个加载', '/assessProject/load', '2019-07-15 08:58:19');
INSERT INTO `permission_tb` VALUES ('1150570249830465537', '2', '单项测评管理', '单项测评修改', '/assessProject/update', '2019-07-15 08:58:19');
INSERT INTO `permission_tb` VALUES ('1152110084403707906', '2', '测评管理', '测评列表', '/assess/data', '2019-07-19 14:57:04');

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
INSERT INTO `project_tb` VALUES ('1148552217624973314', '上肢力量', 'http://localhost:8080/uploaderPath/img/20190709/1562671098885.png', 'm', '上肢力量', '2019-07-09 19:19:22', '2019-07-19 15:35:03');
INSERT INTO `project_tb` VALUES ('1148552526602571777', '下肢力量', 'http://localhost:8080/uploaderPath/img/20190709/15626712197.png', 'cm', '下肢力量', '2019-07-09 19:20:36', '2019-07-19 15:35:27');
INSERT INTO `project_tb` VALUES ('1148552981919436802', '综合肺活', 'http://localhost:8080/uploaderPath/img/20190709/1562671328381.png', 'ml', '综合肺活', '2019-07-09 19:22:25', '2019-07-19 15:34:56');
INSERT INTO `project_tb` VALUES ('1148553108096684034', '柔韧性', 'http://localhost:8080/uploaderPath/img/20190709/1562671360208.png', 'cm', '柔韧性', '2019-07-09 19:22:55', '2019-07-19 15:34:32');
INSERT INTO `project_tb` VALUES ('1148553287864553473', '灵敏性', 'http://localhost:8080/uploaderPath/img/20190709/1562671404184.png', 's', '灵敏性', '2019-07-09 19:23:38', '2019-07-19 15:34:25');
INSERT INTO `project_tb` VALUES ('1148553378281164801', '平衡力', 'http://localhost:8080/uploaderPath/img/20190709/1562671430154.png', 's', '平衡力', '2019-07-09 19:23:59', '2019-07-19 15:34:14');
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
) ENGINE=InnoDB AUTO_INCREMENT=1152061811408162819 DEFAULT CHARSET=utf8 COMMENT='标准表';

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
INSERT INTO `standard_tb` VALUES ('1151418732909064193', '9', '1', '5', '9.50', '999999.00', '实心球掷远', '2019-07-17 17:09:53', '2019-07-17 17:09:53', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151418821488570369', '9', '2', '1', '1.50', '2.40', '实心球掷远', '2019-07-17 17:10:14', '2019-07-17 17:10:14', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151418902853873666', '9', '2', '2', '2.50', '4.10', '实心球掷远', '2019-07-17 17:10:33', '2019-07-17 17:10:33', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151419310338895873', '9', '2', '3', '4.20', '4.90', '实心球掷远', '2019-07-17 17:12:11', '2019-07-17 17:12:11', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151419487980253186', '9', '2', '4', '5.00', '8.10', '实心球掷远', '2019-07-17 17:12:53', '2019-07-17 17:12:53', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151420460928757762', '9', '2', '5', '8.20', '999999.00', '实心球掷远', '2019-07-17 17:16:45', '2019-07-17 17:16:45', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151420646728036354', '10', '1', '1', '2.00', '3.40', '实心球掷远', '2019-07-17 17:17:29', '2019-07-17 17:17:29', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151420760569835521', '10', '1', '2', '3.50', '4.90', '实心球掷远', '2019-07-17 17:17:56', '2019-07-17 17:17:56', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151420809588666370', '10', '1', '3', '5.00', '6.60', '实心球掷远', '2019-07-17 17:18:08', '2019-07-17 17:18:08', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151420879373496322', '10', '1', '4', '6.70', '9.40', '实心球掷远', '2019-07-17 17:18:25', '2019-07-17 17:18:25', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151420927964508162', '10', '1', '5', '9.50', '999999.00', '实心球掷远', '2019-07-17 17:18:36', '2019-07-17 17:18:36', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151421003461980162', '10', '2', '1', '1.50', '2.40', '实心球掷远', '2019-07-17 17:18:54', '2019-07-17 17:19:35', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151421321755127810', '10', '2', '2', '2.50', '4.10', '实心球掷远', '2019-07-17 17:20:10', '2019-07-17 17:20:10', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151421360137203714', '10', '2', '3', '4.20', '4.90', '实心球掷远', '2019-07-17 17:20:19', '2019-07-17 17:20:19', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151421412662472705', '10', '2', '4', '5.00', '8.10', '实心球掷远', '2019-07-17 17:20:32', '2019-07-17 17:20:32', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151421464860585986', '10', '2', '5', '8.20', '999999.00', '实心球掷远', '2019-07-17 17:20:44', '2019-07-17 17:20:44', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151421541142392833', '11', '1', '1', '5.70', '6.40', '实心球掷远', '2019-07-17 17:21:02', '2019-07-17 17:21:02', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151421602094018561', '11', '1', '2', '6.50', '8.20', '实心球掷远', '2019-07-17 17:21:17', '2019-07-17 17:21:17', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151421652350169089', '11', '1', '3', '8.30', '8.90', '实心球掷远', '2019-07-17 17:21:29', '2019-07-17 17:21:29', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151421731765121025', '11', '1', '4', '9.00', '11.90', '实心球掷远', '2019-07-17 17:21:48', '2019-07-17 17:21:48', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151421799897395202', '11', '1', '5', '12.00', '999999.00', '实心球掷远', '2019-07-17 17:22:04', '2019-07-17 17:22:04', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151421901550546945', '11', '2', '1', '4.00', '5.60', '实心球掷远', '2019-07-17 17:22:28', '2019-07-17 17:22:28', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151423110671921154', '11', '2', '2', '5.70', '6.40', '实心球掷远', '2019-07-17 17:27:17', '2019-07-17 17:27:17', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151423182079946754', '11', '2', '3', '6.50', '8.20', '实心球掷远', '2019-07-17 17:27:34', '2019-07-17 17:27:34', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151423365350060034', '11', '2', '4', '8.30', '10.10', '实心球掷远', '2019-07-17 17:28:17', '2019-07-17 17:28:17', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151423398556364801', '11', '2', '5', '10.20', '999999.00', '实心球掷远', '2019-07-17 17:28:25', '2019-07-17 17:29:01', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151423500205322242', '12', '1', '1', '5.70', '6.40', '实心球掷远', '2019-07-17 17:28:50', '2019-07-17 17:29:09', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151423684662423553', '12', '1', '2', '6.50', '8.20', '实心球掷远', '2019-07-17 17:29:33', '2019-07-17 17:29:33', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151423759044210690', '12', '1', '3', '8.30', '8.90', '实心球掷远', '2019-07-17 17:29:51', '2019-07-17 17:29:51', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151423841588113409', '12', '1', '4', '9.00', '11.90', '实心球掷远', '2019-07-17 17:30:11', '2019-07-17 17:30:11', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151423881249452034', '12', '1', '5', '12.00', '999999.00', '实心球掷远', '2019-07-17 17:30:20', '2019-07-17 17:30:20', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151423928699613185', '12', '2', '1', '4.00', '5.60', '实心球掷远', '2019-07-17 17:30:32', '2019-07-17 17:30:32', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151423971921915905', '12', '2', '2', '5.70', '6.40', '实心球掷远', '2019-07-17 17:30:42', '2019-07-17 17:30:42', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151424004868173825', '12', '2', '3', '6.50', '8.20', '实心球掷远', '2019-07-17 17:30:50', '2019-07-17 17:31:31', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151424056076431362', '12', '2', '4', '8.30', '10.10', '实心球掷远', '2019-07-17 17:31:02', '2019-07-17 17:31:36', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151424101609795585', '12', '2', '5', '10.20', '999999.00', '实心球掷远', '2019-07-17 17:31:13', '2019-07-17 17:31:42', '1148552217624973314');
INSERT INTO `standard_tb` VALUES ('1151426544808652802', '3', '1', '1', '21.00', '29.00', '立定跳远', '2019-07-17 17:40:55', '2019-07-17 17:40:55', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151426707442790401', '3', '1', '2', '30.00', '42.00', '立定跳远', '2019-07-17 17:41:34', '2019-07-17 17:41:34', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151426932127461377', '3', '1', '3', '43.00', '58.00', '立定跳远', '2019-07-17 17:42:28', '2019-07-17 17:42:28', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151426985491591170', '3', '1', '4', '59.00', '75.00', '立定跳远', '2019-07-17 17:42:40', '2019-07-17 17:42:40', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151427042244718594', '3', '1', '5', '76.00', '999999.00', '立定跳远', '2019-07-17 17:42:54', '2019-07-17 17:42:54', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151427088889573378', '3', '2', '1', '21.00', '28.00', '立定跳远', '2019-07-17 17:43:05', '2019-07-17 17:43:05', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151427175665528833', '3', '2', '2', '29.00', '39.00', '立定跳远', '2019-07-17 17:43:26', '2019-07-17 17:43:26', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151427214488006658', '3', '2', '3', '40.00', '54.00', '立定跳远', '2019-07-17 17:43:35', '2019-07-17 17:43:35', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151427250881982466', '3', '2', '4', '55.00', '70.00', '立定跳远', '2019-07-17 17:43:44', '2019-07-17 17:43:44', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151427307366674433', '3', '2', '5', '71.00', '999999.00', '立定跳远', '2019-07-17 17:43:57', '2019-07-17 17:43:57', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151427354430959618', '4', '1', '1', '35.00', '46.00', '立定跳远', '2019-07-17 17:44:08', '2019-07-17 17:44:08', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151427913363910657', '4', '1', '2', '47.00', '64.00', '立定跳远', '2019-07-17 17:46:22', '2019-07-17 17:46:22', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428010558517249', '4', '1', '3', '65.00', '79.00', '立定跳远', '2019-07-17 17:46:45', '2019-07-17 17:46:45', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428063620657153', '4', '1', '4', '80.00', '94.00', '立定跳远', '2019-07-17 17:46:58', '2019-07-17 17:46:58', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428105819549698', '4', '1', '5', '95.00', '999999.00', '立定跳远', '2019-07-17 17:47:08', '2019-07-17 17:47:08', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428155308142594', '4', '2', '1', '32.00', '43.00', '立定跳远', '2019-07-17 17:47:19', '2019-07-17 17:47:19', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428183766495233', '4', '2', '2', '44.00', '59.00', '立定跳远', '2019-07-17 17:47:26', '2019-07-17 17:47:26', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428212828827649', '4', '2', '3', '60.00', '73.00', '立定跳远', '2019-07-17 17:47:33', '2019-07-17 17:47:33', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428283259580417', '4', '2', '4', '74.00', '80.00', '立定跳远', '2019-07-17 17:47:50', '2019-07-17 17:47:50', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428312489684994', '4', '2', '5', '81.00', '999999.00', '立定跳远', '2019-07-17 17:47:57', '2019-07-17 17:47:57', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428357653950465', '5', '1', '1', '50.00', '64.00', '立定跳远', '2019-07-17 17:48:08', '2019-07-17 17:48:08', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428399462772738', '5', '1', '2', '65.00', '79.00', '立定跳远', '2019-07-17 17:48:18', '2019-07-17 17:48:18', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428431473700866', '5', '1', '3', '80.00', '95.00', '立定跳远', '2019-07-17 17:48:25', '2019-07-17 17:48:25', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428466408058882', '5', '1', '4', '96.00', '109.00', '立定跳远', '2019-07-17 17:48:34', '2019-07-17 17:48:34', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428502265163777', '5', '1', '5', '110.00', '999999.00', '立定跳远', '2019-07-17 17:48:42', '2019-07-17 17:48:42', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428540362027009', '5', '2', '1', '50.00', '59.00', '立定跳远', '2019-07-17 17:48:51', '2019-07-17 17:48:51', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428580476350466', '5', '2', '2', '60.00', '74.00', '立定跳远', '2019-07-17 17:49:01', '2019-07-17 17:49:01', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428617994399746', '5', '2', '3', '75.00', '88.00', '立定跳远', '2019-07-17 17:49:10', '2019-07-17 17:49:10', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428652832288770', '5', '2', '4', '89.00', '101.00', '立定跳远', '2019-07-17 17:49:18', '2019-07-17 17:49:18', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428737691447297', '5', '2', '5', '102.00', '999999.00', '立定跳远', '2019-07-17 17:49:38', '2019-07-17 17:49:38', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428796910825474', '6', '1', '1', '61.00', '78.00', '立定跳远', '2019-07-17 17:49:52', '2019-07-17 17:49:52', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428832411414530', '6', '1', '2', '79.00', '94.00', '立定跳远', '2019-07-17 17:50:01', '2019-07-17 17:50:01', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428903047688193', '6', '1', '3', '95.00', '110.00', '立定跳远', '2019-07-17 17:50:18', '2019-07-17 17:50:18', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428939848511490', '6', '1', '4', '111.00', '126.00', '立定跳远', '2019-07-17 17:50:26', '2019-07-17 17:50:26', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151428981720248321', '6', '1', '5', '127.00', '999999.00', '立定跳远', '2019-07-17 17:50:36', '2019-07-17 17:50:36', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151429411426693121', '6', '2', '1', '60.00', '70.00', '立定跳远', '2019-07-17 17:52:19', '2019-07-17 17:52:19', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151429448831496193', '6', '2', '2', '71.00', '86.00', '立定跳远', '2019-07-17 17:52:28', '2019-07-17 17:52:28', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151429508663242753', '6', '2', '3', '87.00', '100.00', '立定跳远', '2019-07-17 17:52:42', '2019-07-17 17:52:42', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151429536756690945', '6', '2', '4', '101.00', '115.00', '立定跳远', '2019-07-17 17:52:49', '2019-07-17 17:52:49', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151429565575753729', '6', '2', '5', '116.00', '999999.00', '立定跳远', '2019-07-17 17:52:56', '2019-07-17 17:52:56', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151429671880388609', '7', '1', '1', '93.00', '99.00', '立定跳远', '2019-07-17 17:53:21', '2019-07-17 17:53:21', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151429710765780993', '7', '1', '2', '100.00', '106.00', '立定跳远', '2019-07-17 17:53:30', '2019-07-17 17:53:30', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151429767032369154', '7', '1', '3', '107.00', '129.00', '立定跳远', '2019-07-17 17:53:44', '2019-07-17 17:53:44', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151429809751355394', '7', '1', '4', '130.00', '148.00', '立定跳远', '2019-07-17 17:53:54', '2019-07-17 17:53:54', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151429859281891330', '7', '1', '5', '149.00', '999999.00', '立定跳远', '2019-07-17 17:54:06', '2019-07-17 17:54:06', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151429944543703041', '7', '2', '1', '86.00', '91.00', '立定跳远', '2019-07-17 17:54:26', '2019-07-17 17:54:26', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151429974629445633', '7', '2', '2', '92.00', '98.00', '立定跳远', '2019-07-17 17:54:33', '2019-07-17 17:54:33', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151430007525371906', '7', '2', '3', '99.00', '119.00', '立定跳远', '2019-07-17 17:54:41', '2019-07-17 17:54:41', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151430037028106242', '7', '2', '4', '120.00', '137.00', '立定跳远', '2019-07-17 17:54:48', '2019-07-17 17:54:48', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151430087644966914', '7', '2', '5', '138.00', '999999.00', '立定跳远', '2019-07-17 17:55:00', '2019-07-17 17:55:00', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151430133450960898', '8', '1', '1', '93.00', '99.00', '立定跳远', '2019-07-17 17:55:11', '2019-07-17 17:55:11', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151430160298700802', '8', '1', '2', '100.00', '106.00', '立定跳远', '2019-07-17 17:55:17', '2019-07-17 17:55:17', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151430190829039617', '8', '1', '3', '107.00', '129.00', '立定跳远', '2019-07-17 17:55:25', '2019-07-17 17:55:25', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151430529091268609', '8', '1', '4', '130.00', '148.00', '立定跳远', '2019-07-17 17:56:45', '2019-07-17 17:56:45', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151430568882630657', '8', '1', '5', '149.00', '999999.00', '立定跳远', '2019-07-17 17:56:55', '2019-07-17 17:56:55', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151431027479441410', '8', '2', '1', '86.00', '91.00', '立定跳远', '2019-07-17 17:58:44', '2019-07-17 17:58:44', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151431300436357121', '8', '2', '2', '92.00', '98.00', '立定跳远', '2019-07-17 17:59:49', '2019-07-17 17:59:49', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151431343587356673', '8', '2', '3', '99.00', '119.00', '立定跳远', '2019-07-17 18:00:00', '2019-07-17 18:00:00', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151431372251230209', '8', '2', '4', '120.00', '137.00', '立定跳远', '2019-07-17 18:00:06', '2019-07-17 18:00:06', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151431402286641154', '8', '2', '5', '138.00', '999999.00', '立定跳远', '2019-07-17 18:00:14', '2019-07-17 18:00:14', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151432605070422018', '9', '1', '1', '117.00', '122.00', '立定跳远', '2019-07-17 18:05:00', '2019-07-17 18:05:00', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151432645440598017', '9', '1', '2', '123.00', '128.00', '立定跳远', '2019-07-17 18:05:10', '2019-07-17 18:05:10', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151432688461574145', '9', '1', '3', '129.00', '152.00', '立定跳远', '2019-07-17 18:05:20', '2019-07-17 18:05:20', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151432727510544385', '9', '1', '4', '153.00', '169.00', '立定跳远', '2019-07-17 18:05:29', '2019-07-17 18:05:29', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151432770330193921', '9', '1', '5', '170.00', '999999.00', '立定跳远', '2019-07-17 18:05:40', '2019-07-17 18:05:40', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151432956213358594', '9', '2', '1', '107.00', '112.00', '立定跳远', '2019-07-17 18:06:24', '2019-07-17 18:06:24', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151433026224680962', '9', '2', '2', '113.00', '118.00', '立定跳远', '2019-07-17 18:06:41', '2019-07-17 18:06:41', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151433066859098114', '9', '2', '3', '119.00', '140.00', '立定跳远', '2019-07-17 18:06:50', '2019-07-17 18:06:50', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151433306358050818', '9', '2', '4', '141.00', '159.00', '立定跳远', '2019-07-17 18:07:47', '2019-07-17 18:07:47', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151433339379806209', '9', '2', '5', '160.00', '999999.00', '立定跳远', '2019-07-17 18:07:55', '2019-07-17 18:07:55', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151433411618304002', '10', '1', '1', '117.00', '122.00', '立定跳远', '2019-07-17 18:08:13', '2019-07-17 18:08:13', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151433443822170114', '10', '1', '2', '123.00', '128.00', '立定跳远', '2019-07-17 18:08:20', '2019-07-17 18:08:20', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151433500080369665', '10', '1', '3', '129.00', '152.00', '立定跳远', '2019-07-17 18:08:34', '2019-07-17 18:08:34', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151433538890264578', '10', '1', '4', '153.00', '169.00', '立定跳远', '2019-07-17 18:08:43', '2019-07-17 18:08:43', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151433668204851201', '10', '1', '5', '170.00', '999999.00', '立定跳远', '2019-07-17 18:09:14', '2019-07-17 18:09:14', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151433961978097665', '10', '2', '1', '107.00', '112.00', '立定跳远', '2019-07-17 18:10:24', '2019-07-17 18:10:24', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151434053741080577', '10', '2', '2', '113.00', '118.00', '立定跳远', '2019-07-17 18:10:46', '2019-07-17 18:10:46', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151434094044147713', '10', '2', '3', '119.00', '140.00', '立定跳远', '2019-07-17 18:10:55', '2019-07-17 18:10:55', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151434123030982658', '10', '2', '4', '141.00', '159.00', '立定跳远', '2019-07-17 18:11:02', '2019-07-17 18:11:02', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151434202039087105', '10', '2', '5', '160.00', '999999.00', '立定跳远', '2019-07-17 18:11:21', '2019-07-17 18:11:21', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151434255617126402', '11', '1', '1', '132.00', '138.00', '立定跳远', '2019-07-17 18:11:34', '2019-07-17 18:11:34', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151434527173144577', '11', '1', '2', '139.00', '145.00', '立定跳远', '2019-07-17 18:12:39', '2019-07-17 18:12:39', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151434580453388290', '11', '1', '3', '146.00', '169.00', '立定跳远', '2019-07-17 18:12:51', '2019-07-17 18:12:51', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151434615370969090', '11', '1', '4', '170.00', '188.00', '立定跳远', '2019-07-17 18:13:00', '2019-07-17 18:13:00', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151434699907166210', '11', '1', '5', '189.00', '999999.00', '立定跳远', '2019-07-17 18:13:20', '2019-07-17 18:13:20', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151434793121378306', '11', '2', '1', '122.00', '127.00', '立定跳远', '2019-07-17 18:13:42', '2019-07-17 18:13:42', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151434845285937153', '11', '2', '2', '128.00', '133.00', '立定跳远', '2019-07-17 18:13:54', '2019-07-17 18:13:54', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151434879893139458', '11', '2', '3', '134.00', '156.00', '立定跳远', '2019-07-17 18:14:03', '2019-07-17 18:14:03', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151434913783115777', '11', '2', '4', '157.00', '176.00', '立定跳远', '2019-07-17 18:14:11', '2019-07-17 18:14:11', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151434952639148034', '11', '2', '5', '177.00', '999999.00', '立定跳远', '2019-07-17 18:14:20', '2019-07-17 18:14:20', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151435004371693569', '12', '1', '1', '132.00', '138.00', '立定跳远', '2019-07-17 18:14:32', '2019-07-17 18:14:32', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151435034377744386', '12', '1', '2', '139.00', '145.00', '立定跳远', '2019-07-17 18:14:39', '2019-07-17 18:14:39', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151435076186566658', '12', '1', '3', '146.00', '169.00', '立定跳远', '2019-07-17 18:14:49', '2019-07-17 18:14:49', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151435118360293378', '12', '1', '4', '170.00', '188.00', '立定跳远', '2019-07-17 18:15:00', '2019-07-17 18:15:00', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151435151784701953', '12', '1', '5', '189.00', '999999.00', '立定跳远', '2019-07-17 18:15:07', '2019-07-17 18:15:07', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151435232080457730', '12', '2', '1', '122.00', '127.00', '立定跳远', '2019-07-17 18:15:27', '2019-07-17 18:15:27', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151435270860992514', '12', '2', '2', '128.00', '133.00', '立定跳远', '2019-07-17 18:15:36', '2019-07-17 18:15:36', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151435310643965954', '12', '2', '3', '134.00', '156.00', '立定跳远', '2019-07-17 18:15:45', '2019-07-17 18:15:45', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151435341971222529', '12', '2', '4', '157.00', '176.00', '立定跳远', '2019-07-17 18:15:53', '2019-07-17 18:15:53', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151435384266584066', '12', '2', '5', '177.00', '999999.00', '立定跳远', '2019-07-17 18:16:03', '2019-07-17 18:16:03', '1148552526602571777');
INSERT INTO `standard_tb` VALUES ('1151661197960351746', '7', '1', '1', '500.00', '579.00', '肺活机', '2019-07-18 09:13:21', '2019-07-18 09:13:21', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661239521710082', '7', '1', '2', '580.00', '699.00', '肺活机', '2019-07-18 09:13:31', '2019-07-18 09:13:31', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661285541613570', '7', '1', '3', '700.00', '1299.00', '肺活机', '2019-07-18 09:13:42', '2019-07-18 09:13:42', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661317930029058', '7', '1', '4', '1300.00', '1499.00', '肺活机', '2019-07-18 09:13:50', '2019-07-18 09:13:50', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661358946127874', '7', '1', '5', '1500.00', '999999.00', '肺活机', '2019-07-18 09:13:59', '2019-07-18 09:13:59', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661402436866049', '7', '2', '1', '500.00', '539.00', '肺活机', '2019-07-18 09:14:10', '2019-07-18 09:14:10', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661433852203009', '7', '2', '2', '540.00', '599.00', '肺活机', '2019-07-18 09:14:17', '2019-07-18 09:14:17', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661492811534337', '7', '2', '3', '600.00', '999.00', '肺活机', '2019-07-18 09:14:31', '2019-07-18 09:14:31', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661534867820545', '7', '2', '4', '1000.00', '1199.00', '肺活机', '2019-07-18 09:14:41', '2019-07-18 09:14:41', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661576638894082', '7', '2', '5', '1200.00', '999999.00', '肺活机', '2019-07-18 09:14:51', '2019-07-18 09:14:51', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661628367245314', '8', '1', '1', '550.00', '649.00', '肺活机', '2019-07-18 09:15:04', '2019-07-18 09:15:04', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661668670312450', '8', '1', '2', '650.00', '799.00', '肺活机', '2019-07-18 09:15:13', '2019-07-18 09:15:13', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661705924120577', '8', '1', '3', '800.00', '1499.00', '肺活机', '2019-07-18 09:15:22', '2019-07-18 09:15:22', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661752636084225', '8', '1', '4', '1500.00', '1799.00', '肺活机', '2019-07-18 09:15:33', '2019-07-18 09:15:33', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661804175691778', '8', '1', '5', '1800.00', '999999.00', '肺活机', '2019-07-18 09:15:46', '2019-07-18 09:15:46', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661844747194370', '8', '2', '1', '600.00', '639.00', '肺活机', '2019-07-18 09:15:55', '2019-07-18 09:15:55', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661886539239426', '8', '2', '2', '640.00', '699.00', '肺活机', '2019-07-18 09:16:05', '2019-07-18 09:16:05', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661931552509953', '8', '2', '3', '700.00', '1199.00', '肺活机', '2019-07-18 09:16:16', '2019-07-18 09:16:16', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151661969037004801', '8', '2', '4', '1200.00', '1399.00', '肺活机', '2019-07-18 09:16:25', '2019-07-18 09:16:25', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151662008656400386', '8', '2', '5', '1400.00', '999999.00', '肺活机', '2019-07-18 09:16:34', '2019-07-18 09:16:34', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151662062058278914', '9', '1', '1', '600.00', '719.00', '肺活机', '2019-07-18 09:16:47', '2019-07-18 09:16:47', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151662091913334785', '9', '1', '2', '720.00', '899.00', '肺活机', '2019-07-18 09:16:54', '2019-07-18 09:16:54', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151662136951771137', '9', '1', '3', '900.00', '1699.00', '肺活机', '2019-07-18 09:17:05', '2019-07-18 09:17:05', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151662169491181569', '9', '1', '4', '1700.00', '2099.00', '肺活机', '2019-07-18 09:17:13', '2019-07-18 09:17:13', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151662211740405761', '9', '1', '5', '2100.00', '999999.00', '肺活机', '2019-07-18 09:17:23', '2019-07-18 09:17:23', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151662257621897217', '9', '2', '1', '700.00', '739.00', '肺活机', '2019-07-18 09:17:34', '2019-07-18 09:17:34', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151662296054304770', '9', '2', '2', '740.00', '799.00', '肺活机', '2019-07-18 09:17:43', '2019-07-18 09:17:43', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151662347367419906', '9', '2', '3', '800.00', '1399.00', '肺活机', '2019-07-18 09:17:55', '2019-07-18 09:17:55', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151662381425168386', '9', '2', '4', '1400.00', '1599.00', '肺活机', '2019-07-18 09:18:03', '2019-07-18 09:18:03', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151662415365476354', '9', '2', '5', '1600.00', '999999.00', '肺活机', '2019-07-18 09:18:11', '2019-07-18 09:18:11', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151662459636355074', '10', '1', '1', '750.00', '889.00', '肺活机', '2019-07-18 09:18:22', '2019-07-18 09:18:22', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151662497510920194', '10', '1', '2', '890.00', '1099.00', '肺活机', '2019-07-18 09:18:31', '2019-07-18 09:18:31', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151662555039993857', '10', '1', '3', '1100.00', '1899.00', '肺活机', '2019-07-18 09:18:45', '2019-07-18 09:18:45', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151662600787267586', '10', '1', '4', '1900.00', '2399.00', '肺活机', '2019-07-18 09:18:56', '2019-07-18 09:18:56', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151663269195747330', '10', '1', '5', '2400.00', '999999.00', '肺活机', '2019-07-18 09:21:35', '2019-07-18 09:21:35', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151663308727062530', '10', '2', '1', '800.00', '839.00', '肺活机', '2019-07-18 09:21:44', '2019-07-18 09:21:44', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151663360996478977', '10', '2', '2', '840.00', '899.00', '肺活机', '2019-07-18 09:21:57', '2019-07-18 09:21:57', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151663411701420034', '10', '2', '3', '900.00', '1599.00', '肺活机', '2019-07-18 09:22:09', '2019-07-18 09:22:09', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151663455246684162', '10', '2', '4', '1600.00', '1799.00', '肺活机', '2019-07-18 09:22:19', '2019-07-18 09:22:19', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151663497458159618', '10', '2', '5', '1800.00', '999999.00', '肺活机', '2019-07-18 09:22:29', '2019-07-18 09:22:29', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151663626240069634', '11', '1', '1', '900.00', '1059.00', '肺活机', '2019-07-18 09:23:00', '2019-07-18 09:23:00', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664011780493313', '11', '1', '2', '1060.00', '1299.00', '肺活机', '2019-07-18 09:24:32', '2019-07-18 09:24:32', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664046324781057', '11', '1', '3', '1300.00', '2199.00', '肺活机', '2019-07-18 09:24:40', '2019-07-18 09:24:40', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664109264506881', '11', '1', '4', '2200.00', '2699.00', '肺活机', '2019-07-18 09:24:55', '2019-07-18 09:24:55', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664149433356290', '11', '1', '5', '2700.00', '999999.00', '肺活机', '2019-07-18 09:25:05', '2019-07-18 09:25:05', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664206832406529', '11', '2', '1', '900.00', '959.00', '肺活机', '2019-07-18 09:25:18', '2019-07-18 09:25:18', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664247592652801', '11', '2', '2', '960.00', '1049.00', '肺活机', '2019-07-18 09:25:28', '2019-07-18 09:25:28', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664310389772289', '11', '2', '3', '1050.00', '1849.00', '肺活机', '2019-07-18 09:25:43', '2019-07-18 09:25:43', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664353372999682', '11', '2', '4', '1850.00', '2049.00', '肺活机', '2019-07-18 09:25:53', '2019-07-18 09:25:53', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664397018927105', '11', '2', '5', '2050.00', '999999.00', '肺活机', '2019-07-18 09:26:04', '2019-07-18 09:26:04', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664455114231810', '12', '1', '1', '1050.00', '1229.00', '肺活机', '2019-07-18 09:26:18', '2019-07-18 09:26:18', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664589948522497', '12', '1', '2', '1230.00', '1499.00', '肺活机', '2019-07-18 09:26:50', '2019-07-18 09:26:50', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664618994077697', '12', '1', '3', '1500.00', '2499.00', '肺活机', '2019-07-18 09:26:57', '2019-07-18 09:26:57', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664656528904193', '12', '1', '4', '2500.00', '2999.00', '肺活机', '2019-07-18 09:27:06', '2019-07-18 09:27:06', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664696412540929', '12', '1', '5', '3000.00', '999999.00', '肺活机', '2019-07-18 09:27:15', '2019-07-18 09:27:15', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664732139622402', '12', '2', '1', '1050.00', '1109.00', '肺活机', '2019-07-18 09:27:24', '2019-07-18 09:27:24', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664812217274369', '12', '2', '2', '1110.00', '1199.00', '肺活机', '2019-07-18 09:27:43', '2019-07-18 09:27:43', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664855464742913', '12', '2', '3', '1200.00', '2099.00', '肺活机', '2019-07-18 09:27:53', '2019-07-18 09:27:53', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664894643736578', '12', '2', '4', '2100.00', '2299.00', '肺活机', '2019-07-18 09:28:02', '2019-07-18 09:28:02', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151664948335022082', '12', '2', '5', '2300.00', '999999.00', '肺活机', '2019-07-18 09:28:15', '2019-07-18 09:28:15', '1148552981919436802');
INSERT INTO `standard_tb` VALUES ('1151665302632075265', '3', '1', '1', '2.90', '4.80', '坐位体前屈', '2019-07-18 09:29:40', '2019-07-18 09:29:40', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151665359381008385', '3', '1', '2', '4.90', '8.50', '坐位体前屈', '2019-07-18 09:29:53', '2019-07-18 09:29:53', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151665401097555969', '3', '1', '3', '8.60', '11.60', '坐位体前屈', '2019-07-18 09:30:03', '2019-07-18 09:30:03', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151665437269233666', '3', '1', '4', '11.70', '14.80', '坐位体前屈', '2019-07-18 09:30:12', '2019-07-18 09:30:12', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151665497944035329', '3', '1', '5', '14.90', '999999.00', '坐位体前屈', '2019-07-18 09:30:26', '2019-07-18 09:30:26', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151665538066747393', '3', '2', '1', '3.20', '6.20', '坐位体前屈', '2019-07-18 09:30:36', '2019-07-18 09:30:36', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151665572229353473', '3', '2', '2', '6.30', '9.90', '坐位体前屈', '2019-07-18 09:30:44', '2019-07-18 09:30:44', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151665622028324865', '3', '2', '3', '10.00', '12.90', '坐位体前屈', '2019-07-18 09:30:56', '2019-07-18 09:30:56', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151665657461805057', '3', '2', '4', '13.00', '15.80', '坐位体前屈', '2019-07-18 09:31:04', '2019-07-18 09:31:04', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151665731927478274', '3', '2', '5', '15.90', '999999.00', '坐位体前屈', '2019-07-18 09:31:22', '2019-07-18 09:31:22', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151665783068626945', '4', '1', '1', '2.40', '4.40', '坐位体前屈', '2019-07-18 09:31:34', '2019-07-18 09:31:34', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151665813414416386', '4', '1', '2', '4.50', '8.40', '坐位体前屈', '2019-07-18 09:31:41', '2019-07-18 09:31:41', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151665848982114306', '4', '1', '3', '8.50', '11.40', '坐位体前屈', '2019-07-18 09:31:50', '2019-07-18 09:31:50', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151665954389168129', '4', '1', '4', '11.50', '14.80', '坐位体前屈', '2019-07-18 09:32:15', '2019-07-18 09:32:15', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151665996709695490', '4', '1', '5', '14.90', '999999.00', '坐位体前屈', '2019-07-18 09:32:25', '2019-07-18 09:32:25', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666034399711233', '4', '2', '1', '3.00', '5.90', '坐位体前屈', '2019-07-18 09:32:34', '2019-07-18 09:32:34', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666076019789825', '4', '2', '2', '6.00', '7.90', '坐位体前屈', '2019-07-18 09:32:44', '2019-07-18 09:32:44', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666147796914178', '4', '2', '3', '8.00', '12.90', '坐位体前屈', '2019-07-18 09:33:01', '2019-07-18 09:33:01', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666177157042178', '4', '2', '4', '13.00', '15.80', '坐位体前屈', '2019-07-18 09:33:08', '2019-07-18 09:33:08', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666214469570562', '4', '2', '5', '15.90', '999999.00', '坐位体前屈', '2019-07-18 09:33:17', '2019-07-18 09:33:17', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666293855162370', '5', '1', '1', '1.10', '3.40', '坐位体前屈', '2019-07-18 09:33:36', '2019-07-18 09:33:36', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666379699982337', '5', '1', '2', '3.50', '7.50', '坐位体前屈', '2019-07-18 09:33:57', '2019-07-18 09:33:57', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666424742612993', '5', '1', '3', '7.60', '10.90', '坐位体前屈', '2019-07-18 09:34:07', '2019-07-18 09:34:07', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666459194626049', '5', '1', '4', '11.00', '14.30', '坐位体前屈', '2019-07-18 09:34:15', '2019-07-18 09:34:15', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666496687509506', '5', '1', '5', '14.40', '999999.00', '坐位体前屈', '2019-07-18 09:34:24', '2019-07-18 09:34:24', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666533022765057', '5', '2', '1', '3.00', '5.40', '坐位体前屈', '2019-07-18 09:34:33', '2019-07-18 09:34:33', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666579495653378', '5', '2', '2', '5.50', '9.60', '坐位体前屈', '2019-07-18 09:34:44', '2019-07-18 09:34:44', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666616749461505', '5', '2', '3', '9.70', '13.10', '坐位体前屈', '2019-07-18 09:34:53', '2019-07-18 09:34:53', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666652971470850', '5', '2', '4', '13.20', '16.50', '坐位体前屈', '2019-07-18 09:35:02', '2019-07-18 09:35:02', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666712526393346', '5', '2', '5', '16.60', '999999.00', '坐位体前屈', '2019-07-18 09:35:16', '2019-07-18 09:35:16', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666774044250114', '6', '1', '1', '1.00', '3.10', '坐位体前屈', '2019-07-18 09:35:31', '2019-07-18 09:35:31', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666820055764993', '6', '1', '2', '3.20', '7.00', '坐位体前屈', '2019-07-18 09:35:41', '2019-07-18 09:35:41', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666849176817666', '6', '1', '3', '7.10', '10.40', '坐位体前屈', '2019-07-18 09:35:48', '2019-07-18 09:35:48', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666887244320770', '6', '1', '4', '10.50', '14.30', '坐位体前屈', '2019-07-18 09:35:58', '2019-07-18 09:35:58', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666926851133441', '6', '1', '5', '14.40', '999999.00', '坐位体前屈', '2019-07-18 09:36:07', '2019-07-18 09:36:07', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151666975987404802', '6', '2', '1', '3.00', '5.30', '坐位体前屈', '2019-07-18 09:36:19', '2019-07-18 09:36:19', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151667018077245442', '6', '2', '2', '5.40', '9.50', '坐位体前屈', '2019-07-18 09:36:29', '2019-07-18 09:36:29', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151667068887044097', '6', '2', '3', '9.60', '12.90', '坐位体前屈', '2019-07-18 09:36:41', '2019-07-18 09:36:41', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151667099228639234', '6', '2', '4', '13.00', '16.60', '坐位体前屈', '2019-07-18 09:36:48', '2019-07-18 09:36:48', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151667139259076609', '6', '2', '5', '16.70', '999999.00', '坐位体前屈', '2019-07-18 09:36:58', '2019-07-18 09:36:58', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151667343630733313', '7', '1', '1', '-4.00', '-2.50', '坐位体前屈', '2019-07-18 09:37:46', '2019-07-18 09:37:46', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151667483691126786', '7', '1', '2', '-2.40', '-0.90', '坐位体前屈', '2019-07-18 09:38:20', '2019-07-18 09:38:20', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151668403304861697', '7', '1', '3', '-0.80', '10.90', '坐位体前屈', '2019-07-18 09:41:59', '2019-07-18 10:13:57', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151668439715614722', '7', '1', '4', '11.00', '12.90', '坐位体前屈', '2019-07-18 09:42:08', '2019-07-18 09:42:08', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151668484422701057', '7', '1', '5', '13.00', '999999.00', '坐位体前屈', '2019-07-18 09:42:18', '2019-07-18 09:42:18', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151668539850428418', '7', '2', '1', '-1.60', '-0.90', '坐位体前屈', '2019-07-18 09:42:32', '2019-07-18 09:42:32', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151668584985333762', '7', '2', '2', '-0.80', '2.30', '坐位体前屈', '2019-07-18 09:42:42', '2019-07-18 10:13:42', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151668654635945986', '7', '2', '3', '2.40', '13.30', '坐位体前屈', '2019-07-18 09:42:59', '2019-07-18 09:42:59', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151668717504368642', '7', '2', '4', '13.40', '15.90', '坐位体前屈', '2019-07-18 09:43:14', '2019-07-18 09:43:14', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151668766422536193', '7', '2', '5', '16.00', '999999.00', '坐位体前屈', '2019-07-18 09:43:26', '2019-07-18 09:43:26', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151668865148063746', '8', '1', '1', '-4.40', '-2.90', '坐位体前屈', '2019-07-18 09:43:49', '2019-07-18 09:43:49', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151668928641437698', '8', '1', '2', '-2.80', '-0.50', '坐位体前屈', '2019-07-18 09:44:04', '2019-07-18 09:44:04', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151668981116375041', '8', '1', '3', '-0.40', '10.50', '坐位体前屈', '2019-07-18 09:44:17', '2019-07-18 09:44:17', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669036330192898', '8', '1', '4', '10.60', '13.10', '坐位体前屈', '2019-07-18 09:44:30', '2019-07-18 09:44:30', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669078336147458', '8', '1', '5', '13.20', '999999.00', '坐位体前屈', '2019-07-18 09:44:40', '2019-07-18 09:44:40', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669139237441538', '8', '2', '1', '-1.70', '-0.20', '坐位体前屈', '2019-07-18 09:44:54', '2019-07-18 09:44:54', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669173219692546', '8', '2', '2', '-0.10', '2.20', '坐位体前屈', '2019-07-18 09:45:03', '2019-07-18 09:45:03', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669232783003649', '8', '2', '3', '2.30', '13.20', '坐位体前屈', '2019-07-18 09:45:17', '2019-07-18 09:45:17', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669270141669378', '8', '2', '4', '13.30', '16.20', '坐位体前屈', '2019-07-18 09:45:26', '2019-07-18 09:45:26', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669360910602241', '8', '2', '5', '16.30', '999999.00', '坐位体前屈', '2019-07-18 09:45:47', '2019-07-18 09:45:47', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669477101211649', '9', '1', '1', '-4.80', '-3.30', '坐位体前屈', '2019-07-18 09:46:15', '2019-07-18 09:46:15', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669540175155202', '9', '1', '2', '-3.20', '-0.90', '坐位体前屈', '2019-07-18 09:46:30', '2019-07-18 09:46:30', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669590435500033', '9', '1', '3', '-0.80', '10.10', '坐位体前屈', '2019-07-18 09:46:42', '2019-07-18 09:46:42', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669622559674369', '9', '1', '4', '10.20', '13.30', '坐位体前屈', '2019-07-18 09:46:50', '2019-07-18 09:46:50', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669794370949122', '9', '1', '5', '13.40', '999999.00', '坐位体前屈', '2019-07-18 09:47:31', '2019-07-18 09:47:31', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669854181724161', '9', '2', '1', '-1.80', '-0.30', '坐位体前屈', '2019-07-18 09:47:45', '2019-07-18 09:47:45', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669890047217666', '9', '2', '2', '-0.20', '2.10', '坐位体前屈', '2019-07-18 09:47:53', '2019-07-18 09:47:53', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669933508595714', '9', '2', '3', '2.20', '13.10', '坐位体前屈', '2019-07-18 09:48:04', '2019-07-18 09:48:04', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151669965595021313', '9', '2', '4', '13.20', '16.50', '坐位体前屈', '2019-07-18 09:48:11', '2019-07-18 09:48:11', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151670011975634946', '9', '2', '5', '16.60', '999999.00', '坐位体前屈', '2019-07-18 09:48:23', '2019-07-18 09:48:23', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151671682667581442', '10', '1', '1', '-7.20', '-5.30', '坐位体前屈', '2019-07-18 09:55:01', '2019-07-18 09:55:01', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151671757477187586', '10', '1', '2', '-5.20', '-2.30', '坐位体前屈', '2019-07-18 09:55:19', '2019-07-18 09:55:19', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151671798078050306', '10', '1', '3', '-2.20', '9.80', '坐位体前屈', '2019-07-18 09:55:28', '2019-07-18 09:55:28', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672003598946306', '10', '1', '4', '9.90', '13.50', '坐位体前屈', '2019-07-18 09:56:17', '2019-07-18 09:56:17', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672040898891778', '10', '1', '5', '13.60', '999999.00', '坐位体前屈', '2019-07-18 09:56:26', '2019-07-18 09:56:26', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672108464934913', '10', '2', '1', '-1.90', '-0.40', '坐位体前屈', '2019-07-18 09:56:42', '2019-07-18 09:56:42', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672144598863873', '10', '2', '2', '-0.30', '2.00', '坐位体前屈', '2019-07-18 09:56:51', '2019-07-18 09:56:51', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672181001228289', '10', '2', '3', '2.10', '13.00', '坐位体前屈', '2019-07-18 09:57:00', '2019-07-18 09:57:00', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672223187537922', '10', '2', '4', '13.10', '16.80', '坐位体前屈', '2019-07-18 09:57:10', '2019-07-18 09:57:10', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672265034108929', '10', '2', '5', '16.90', '999999.00', '坐位体前屈', '2019-07-18 09:57:20', '2019-07-18 09:57:20', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672321019678722', '11', '1', '1', '-7.60', '-5.70', '坐位体前屈', '2019-07-18 09:57:33', '2019-07-18 09:57:33', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672389248421890', '11', '1', '2', '-5.60', '2.50', '坐位体前屈', '2019-07-18 09:57:49', '2019-07-18 09:57:49', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672430184828929', '11', '1', '3', '2.60', '9.30', '坐位体前屈', '2019-07-18 09:57:59', '2019-07-18 09:57:59', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672472706682881', '11', '1', '4', '9.40', '13.70', '坐位体前屈', '2019-07-18 09:58:09', '2019-07-18 09:58:09', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672512531599362', '11', '1', '5', '13.80', '999999.00', '坐位体前屈', '2019-07-18 09:58:19', '2019-07-18 09:58:19', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672555334471681', '11', '2', '1', '-2.00', '-0.50', '坐位体前屈', '2019-07-18 09:58:29', '2019-07-18 09:58:29', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672592483422209', '11', '2', '2', '-0.40', '1.90', '坐位体前屈', '2019-07-18 09:58:38', '2019-07-18 09:58:38', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672631100379137', '11', '2', '3', '2.00', '12.90', '坐位体前屈', '2019-07-18 09:58:47', '2019-07-18 09:58:47', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672663723675650', '11', '2', '4', '13.00', '17.10', '坐位体前屈', '2019-07-18 09:58:55', '2019-07-18 09:58:55', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672695197732866', '11', '2', '5', '17.20', '999999.00', '坐位体前屈', '2019-07-18 09:59:02', '2019-07-18 09:59:02', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672760222027778', '12', '1', '1', '-9.00', '-7.10', '坐位体前屈', '2019-07-18 09:59:18', '2019-07-18 09:59:18', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672828673069057', '12', '1', '2', '-7.00', '-4.10', '坐位体前屈', '2019-07-18 09:59:34', '2019-07-18 09:59:34', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672920880648194', '12', '1', '3', '-4.00', '8.90', '坐位体前屈', '2019-07-18 09:59:56', '2019-07-18 09:59:56', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151672968473415681', '12', '1', '4', '9.00', '13.90', '坐位体前屈', '2019-07-18 10:00:07', '2019-07-18 10:00:07', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151673005660114945', '12', '1', '5', '14.00', '999999.00', '坐位体前屈', '2019-07-18 10:00:16', '2019-07-18 10:00:16', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151673065902903298', '12', '2', '1', '-2.10', '-0.60', '坐位体前屈', '2019-07-18 10:00:31', '2019-07-18 10:00:31', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151673100442996738', '12', '2', '2', '-0.50', '1.80', '坐位体前屈', '2019-07-18 10:00:39', '2019-07-18 10:00:39', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151673152204902402', '12', '2', '3', '1.90', '12.80', '坐位体前屈', '2019-07-18 10:00:51', '2019-07-18 10:00:51', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151673185469927425', '12', '2', '4', '12.90', '17.40', '坐位体前屈', '2019-07-18 10:00:59', '2019-07-18 10:00:59', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151673219414429698', '12', '2', '5', '17.50', '999999.00', '坐位体前屈', '2019-07-18 10:01:07', '2019-07-18 10:01:07', '1148553108096684034');
INSERT INTO `standard_tb` VALUES ('1151676840289964033', '3', '1', '1', '12.90', '15.80', '10米折返跑', '2019-07-18 10:15:31', '2019-07-18 10:15:31', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151676893968666626', '3', '1', '2', '10.30', '12.80', '10米折返跑', '2019-07-18 10:15:43', '2019-07-18 10:15:43', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151676932514320386', '3', '1', '3', '9.10', '10.20', '10米折返跑', '2019-07-18 10:15:52', '2019-07-18 10:15:52', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151676967134105602', '3', '1', '4', '8.10', '9.00', '10米折返跑', '2019-07-18 10:16:01', '2019-07-18 10:16:01', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151677095802769409', '3', '1', '5', '0.00', '8.00', '10米折返跑', '2019-07-18 10:16:31', '2019-07-18 10:16:31', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151677602705379330', '3', '2', '1', '13.50', '16.80', '10米折返跑', '2019-07-18 10:18:32', '2019-07-18 10:18:32', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151677635785854977', '3', '2', '2', '10.60', '13.40', '10米折返跑', '2019-07-18 10:18:40', '2019-07-18 10:19:49', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151677833882832898', '3', '2', '3', '9.40', '10.50', '10米折返跑', '2019-07-18 10:19:27', '2019-07-18 10:19:27', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151678546461528065', '3', '2', '4', '8.30', '9.30', '10米折返跑', '2019-07-18 10:22:17', '2019-07-18 10:28:14', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151680001184567297', '3', '2', '5', '0.00', '8.20', '10米折返跑', '2019-07-18 10:28:04', '2019-07-18 10:28:04', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151680189320073217', '4', '1', '1', '10.20', '12.40', '10米折返跑', '2019-07-18 10:28:49', '2019-07-18 10:28:49', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151680287441620994', '4', '1', '2', '8.30', '10.10', '10米折返跑', '2019-07-18 10:29:12', '2019-07-18 10:29:12', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151680330248687617', '4', '1', '3', '7.70', '8.20', '10米折返跑', '2019-07-18 10:29:23', '2019-07-18 10:29:23', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151680365711527938', '4', '1', '4', '7.00', '7.60', '10米折返跑', '2019-07-18 10:29:31', '2019-07-18 10:29:31', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151680412981334018', '4', '1', '5', '0.00', '6.90', '10米折返跑', '2019-07-18 10:29:42', '2019-07-18 10:29:42', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151680465665986562', '4', '2', '1', '10.90', '13.20', '10米折返跑', '2019-07-18 10:29:55', '2019-07-18 10:29:55', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151682785762021377', '4', '2', '2', '9.10', '10.80', '10米折返跑', '2019-07-18 10:39:08', '2019-07-18 10:39:08', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151682819576500225', '4', '2', '3', '8.10', '9.00', '10米折返跑', '2019-07-18 10:39:16', '2019-07-18 10:39:16', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151682864577187842', '4', '2', '4', '7.30', '8.00', '10米折返跑', '2019-07-18 10:39:27', '2019-07-18 10:39:27', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151682890913222658', '4', '2', '5', '0.00', '7.20', '10米折返跑', '2019-07-18 10:39:33', '2019-07-18 10:39:33', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683058781851649', '5', '1', '1', '9.00', '10.30', '10米折返跑', '2019-07-18 10:40:13', '2019-07-18 10:40:13', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683106882129921', '5', '1', '2', '7.70', '8.90', '10米折返跑', '2019-07-18 10:40:25', '2019-07-18 10:40:25', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683142365941761', '5', '1', '3', '7.00', '7.60', '10米折返跑', '2019-07-18 10:40:33', '2019-07-18 10:40:33', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683176843120642', '5', '1', '4', '6.50', '6.90', '10米折返跑', '2019-07-18 10:40:41', '2019-07-18 10:40:41', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683218060546050', '5', '1', '5', '0.00', '6.40', '10米折返跑', '2019-07-18 10:40:51', '2019-07-18 10:40:51', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683256484564994', '5', '2', '1', '9.70', '11.20', '10米折返跑', '2019-07-18 10:41:00', '2019-07-18 10:41:00', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683294338158593', '5', '2', '2', '8.10', '9.60', '10米折返跑', '2019-07-18 10:41:09', '2019-07-18 10:41:09', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683325510225921', '5', '2', '3', '7.30', '8.00', '10米折返跑', '2019-07-18 10:41:17', '2019-07-18 10:41:17', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683430015504385', '5', '2', '4', '6.80', '7.20', '10米折返跑', '2019-07-18 10:41:42', '2019-07-18 10:41:42', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683471576862722', '5', '2', '5', '0.00', '6.70', '10米折返跑', '2019-07-18 10:41:52', '2019-07-18 10:41:52', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683517659680769', '6', '1', '1', '8.00', '9.40', '10米折返跑', '2019-07-18 10:42:03', '2019-07-18 10:42:03', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683571803951105', '6', '1', '2', '6.90', '7.90', '10米折返跑', '2019-07-18 10:42:15', '2019-07-18 10:42:15', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683607166128130', '6', '1', '3', '6.30', '6.80', '10米折返跑', '2019-07-18 10:42:24', '2019-07-18 10:42:24', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683645015527426', '6', '1', '4', '5.90', '6.20', '10米折返跑', '2019-07-18 10:42:33', '2019-07-18 10:42:33', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683692465688578', '6', '1', '5', '0.00', '5.80', '10米折返跑', '2019-07-18 10:42:44', '2019-07-18 10:42:44', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683733330792450', '6', '2', '1', '8.60', '10.20', '10米折返跑', '2019-07-18 10:42:54', '2019-07-18 10:42:54', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683771020808194', '6', '2', '2', '7.30', '8.50', '10米折返跑', '2019-07-18 10:43:03', '2019-07-18 10:43:03', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683823730626561', '6', '2', '3', '6.60', '7.20', '10米折返跑', '2019-07-18 10:43:15', '2019-07-18 10:43:15', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683862951563266', '6', '2', '4', '6.20', '6.50', '10米折返跑', '2019-07-18 10:43:25', '2019-07-18 10:43:25', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151683892634652673', '6', '2', '5', '0.00', '6.10', '10米折返跑', '2019-07-18 10:43:32', '2019-07-18 10:43:32', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151684007063654401', '7', '1', '1', '17.50', '19.20', '10米X5折返跑', '2019-07-18 10:43:59', '2019-07-18 10:43:59', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151798438472912897', '7', '1', '2', '15.70', '17.40', '10米X5折返跑', '2019-07-18 18:18:42', '2019-07-18 18:18:42', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151798495930683393', '7', '1', '3', '13.60', '15.60', '10米X5折返跑', '2019-07-18 18:18:55', '2019-07-18 18:18:55', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151798581137969153', '7', '1', '4', '12.50', '13.50', '10米X5折返跑', '2019-07-18 18:19:16', '2019-07-18 18:19:16', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151798636762828802', '7', '1', '5', '0.00', '12.40', '10米X5折返跑', '2019-07-18 18:19:29', '2019-07-18 18:19:29', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151798690978402305', '7', '2', '1', '17.10', '18.00', '10米X5折返跑', '2019-07-18 18:19:42', '2019-07-18 18:19:42', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151798725308780546', '7', '2', '2', '15.20', '17.00', '10米X5折返跑', '2019-07-18 18:19:50', '2019-07-18 18:19:50', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151798771756503042', '7', '2', '3', '14.10', '15.10', '10米X5折返跑', '2019-07-18 18:20:01', '2019-07-18 18:20:01', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151798807353561090', '7', '2', '4', '13.00', '14.00', '10米X5折返跑', '2019-07-18 18:20:10', '2019-07-18 18:20:10', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151798837225394177', '7', '2', '5', '0.00', '12.90', '10米X5折返跑', '2019-07-18 18:20:17', '2019-07-18 18:20:17', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151798902107082754', '8', '1', '1', '17.50', '19.20', '10米X5折返跑', '2019-07-18 18:20:32', '2019-07-18 18:20:32', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151798941437071362', '8', '1', '2', '15.70', '17.40', '10米X5折返跑', '2019-07-18 18:20:42', '2019-07-18 18:20:42', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151798976899911681', '8', '1', '3', '13.60', '15.60', '10米X5折返跑', '2019-07-18 18:20:50', '2019-07-18 18:20:50', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799024912109570', '8', '1', '4', '12.50', '13.50', '10米X5折返跑', '2019-07-18 18:21:02', '2019-07-18 18:21:02', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799068096663554', '8', '1', '5', '0.00', '12.40', '10米X5折返跑', '2019-07-18 18:21:12', '2019-07-18 18:21:12', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799113902657537', '8', '2', '1', '17.10', '18.00', '10米X5折返跑', '2019-07-18 18:21:23', '2019-07-18 18:21:23', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799151814971394', '8', '2', '2', '15.20', '17.00', '10米X5折返跑', '2019-07-18 18:21:32', '2019-07-18 18:21:32', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799206496112641', '8', '2', '3', '14.10', '15.10', '10米X5折返跑', '2019-07-18 18:21:45', '2019-07-18 18:21:45', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799254525087745', '8', '2', '4', '13.00', '14.00', '10米X5折返跑', '2019-07-18 18:21:56', '2019-07-18 18:21:56', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799300595322881', '8', '2', '5', '0.00', '12.90', '10米X5折返跑', '2019-07-18 18:22:07', '2019-07-18 18:22:07', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799360137662465', '9', '1', '1', '14.90', '15.50', '10米X5折返跑', '2019-07-18 18:22:22', '2019-07-18 18:22:22', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799404916051970', '9', '1', '2', '14.10', '14.80', '10米X5折返跑', '2019-07-18 18:22:32', '2019-07-18 18:22:32', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799433013694465', '9', '1', '3', '13.30', '14.00', '10米X5折返跑', '2019-07-18 18:22:39', '2019-07-18 18:22:39', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799484402307074', '9', '1', '4', '11.40', '13.20', '10米X5折返跑', '2019-07-18 18:22:51', '2019-07-18 18:22:51', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799531290431490', '9', '1', '5', '0.00', '11.30', '10米X5折返跑', '2019-07-18 18:23:02', '2019-07-18 18:23:02', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799583387881473', '9', '2', '1', '14.80', '15.50', '10米X5折返跑', '2019-07-18 18:23:15', '2019-07-18 18:23:15', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799627147055106', '9', '2', '2', '14.10', '14.70', '10米X5折返跑', '2019-07-18 18:23:25', '2019-07-18 18:23:25', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799658491088897', '9', '2', '3', '13.30', '14.00', '10米X5折返跑', '2019-07-18 18:23:33', '2019-07-18 18:23:33', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799719090393090', '9', '2', '4', '11.40', '13.20', '10米X5折返跑', '2019-07-18 18:23:47', '2019-07-18 18:23:47', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799752137314306', '9', '2', '5', '0.00', '11.30', '10米X5折返跑', '2019-07-18 18:23:55', '2019-07-18 18:23:55', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799791735738369', '10', '1', '1', '14.90', '15.50', '10米X5折返跑', '2019-07-18 18:24:04', '2019-07-18 18:24:04', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799845456384002', '10', '1', '2', '14.10', '14.80', '10米X5折返跑', '2019-07-18 18:24:17', '2019-07-18 18:24:17', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799904289886210', '10', '1', '3', '13.30', '14.00', '10米X5折返跑', '2019-07-18 18:24:31', '2019-07-18 18:24:31', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799944072859649', '10', '1', '4', '11.40', '13.20', '10米X5折返跑', '2019-07-18 18:24:41', '2019-07-18 18:24:41', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151799981242781698', '10', '1', '5', '0.00', '11.30', '10米X5折返跑', '2019-07-18 18:24:50', '2019-07-18 18:24:50', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800033436700674', '10', '2', '1', '14.80', '15.50', '10米X5折返跑', '2019-07-18 18:25:02', '2019-07-18 18:25:02', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800071311265794', '10', '2', '2', '14.10', '14.70', '10米X5折返跑', '2019-07-18 18:25:11', '2019-07-18 18:25:11', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800115108188161', '10', '2', '3', '13.30', '14.00', '10米X5折返跑', '2019-07-18 18:25:22', '2019-07-18 18:25:22', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800150197735425', '10', '2', '4', '11.40', '13.20', '10米X5折返跑', '2019-07-18 18:25:30', '2019-07-18 18:25:30', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800194871267330', '10', '2', '5', '0.00', '11.30', '10米X5折返跑', '2019-07-18 18:25:41', '2019-07-18 18:25:41', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800281626251265', '11', '1', '1', '14.30', '15.00', '10米X5折返跑', '2019-07-18 18:26:01', '2019-07-18 18:26:01', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800324374597634', '11', '1', '2', '13.50', '14.20', '10米X5折返跑', '2019-07-18 18:26:11', '2019-07-18 18:26:11', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800400077590530', '11', '1', '3', '12.00', '13.40', '10米X5折返跑', '2019-07-18 18:26:29', '2019-07-18 18:26:29', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800438728101889', '11', '1', '4', '10.90', '11.90', '10米X5折返跑', '2019-07-18 18:26:39', '2019-07-18 18:26:39', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800484701868033', '11', '1', '5', '0.00', '10.80', '10米X5折返跑', '2019-07-18 18:26:50', '2019-07-18 18:26:50', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800525239816194', '11', '2', '1', '16.30', '18.50', '10米X5折返跑', '2019-07-18 18:26:59', '2019-07-18 18:26:59', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800584798932993', '11', '2', '2', '14.10', '16.20', '10米X5折返跑', '2019-07-18 18:27:13', '2019-07-18 18:27:13', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800632874045441', '11', '2', '3', '12.30', '14.00', '10米X5折返跑', '2019-07-18 18:27:25', '2019-07-18 18:27:25', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800667498024961', '11', '2', '4', '11.30', '12.20', '10米X5折返跑', '2019-07-18 18:27:33', '2019-07-18 18:27:33', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800703476764674', '11', '2', '5', '0.00', '11.20', '10米X5折返跑', '2019-07-18 18:27:42', '2019-07-18 18:27:42', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800757679755266', '12', '1', '1', '14.30', '15.00', '10米X5折返跑', '2019-07-18 18:27:55', '2019-07-18 18:27:55', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800801933856769', '12', '1', '2', '13.50', '14.20', '10米X5折返跑', '2019-07-18 18:28:05', '2019-07-18 18:28:05', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800838332026881', '12', '1', '3', '12.00', '13.40', '10米X5折返跑', '2019-07-18 18:28:14', '2019-07-18 18:28:14', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800876584079361', '12', '1', '4', '10.90', '11.90', '10米X5折返跑', '2019-07-18 18:28:23', '2019-07-18 18:28:23', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800907953278978', '12', '1', '5', '0.00', '10.80', '10米X5折返跑', '2019-07-18 18:28:31', '2019-07-18 18:28:31', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800947954356226', '12', '2', '1', '16.30', '18.50', '10米X5折返跑', '2019-07-18 18:28:40', '2019-07-18 18:28:40', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151800975758397442', '12', '2', '2', '14.10', '16.20', '10米X5折返跑', '2019-07-18 18:28:47', '2019-07-18 18:28:47', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151803745492209665', '12', '2', '3', '12.30', '14.00', '10米X5折返跑', '2019-07-18 18:39:47', '2019-07-18 18:39:47', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151803789784059905', '12', '2', '4', '11.30', '12.20', '10米X5折返跑', '2019-07-18 18:39:58', '2019-07-18 18:39:58', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151804168240304130', '12', '2', '5', '0.00', '11.20', '10米X5折返跑', '2019-07-18 18:41:28', '2019-07-18 18:41:28', '1148553287864553473');
INSERT INTO `standard_tb` VALUES ('1151804329968472066', '3', '1', '1', '32.50', '48.50', '平衡木1段', '2019-07-18 18:42:06', '2019-07-18 18:42:06', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151804371219451905', '3', '1', '2', '16.90', '32.40', '平衡木1段', '2019-07-18 18:42:16', '2019-07-18 18:42:16', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151804429893570562', '3', '1', '3', '10.60', '16.80', '平衡木1段', '2019-07-18 18:42:30', '2019-07-18 18:42:30', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151804804470083586', '3', '1', '4', '6.70', '10.50', '平衡木1段', '2019-07-18 18:44:00', '2019-07-18 18:44:00', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151804848648687618', '3', '1', '5', '0.00', '6.60', '平衡木1段', '2019-07-18 18:44:10', '2019-07-18 18:44:10', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151804886330314753', '3', '2', '1', '32.50', '49.80', '平衡木1段', '2019-07-18 18:44:19', '2019-07-18 18:44:19', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151804947101585410', '3', '2', '2', '17.40', '32.40', '平衡木1段', '2019-07-18 18:44:34', '2019-07-18 18:44:34', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151804990823010305', '3', '2', '3', '10.80', '17.30', '平衡木1段', '2019-07-18 18:44:44', '2019-07-18 18:44:44', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151805025384075265', '3', '2', '4', '7.00', '10.70', '平衡木1段', '2019-07-18 18:44:52', '2019-07-18 18:44:52', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151805052928069634', '3', '2', '5', '0.00', '6.90', '平衡木1段', '2019-07-18 18:44:59', '2019-07-18 18:44:59', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151805103070973954', '4', '1', '1', '21.60', '33.20', '平衡木1段', '2019-07-18 18:45:11', '2019-07-18 18:45:11', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151805135539081218', '4', '1', '2', '11.60', '21.50', '平衡木1段', '2019-07-18 18:45:18', '2019-07-18 18:45:18', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151805179734462465', '4', '1', '3', '7.40', '11.50', '平衡木1段', '2019-07-18 18:45:29', '2019-07-18 18:45:29', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151805460408897537', '4', '1', '4', '5.00', '7.30', '平衡木1段', '2019-07-18 18:46:36', '2019-07-18 18:46:36', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151805497977278466', '4', '1', '5', '0.00', '4.90', '平衡木1段', '2019-07-18 18:46:45', '2019-07-18 18:46:45', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151805534962651138', '4', '2', '1', '22.60', '32.20', '平衡木1段', '2019-07-18 18:46:54', '2019-07-18 18:46:54', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151805569653739522', '4', '2', '2', '12.30', '22.50', '平衡木1段', '2019-07-18 18:47:02', '2019-07-18 18:47:02', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151805617284255746', '4', '2', '3', '8.20', '12.20', '平衡木1段', '2019-07-18 18:47:13', '2019-07-18 18:47:13', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151805652688375810', '4', '2', '4', '5.40', '8.10', '平衡木1段', '2019-07-18 18:47:22', '2019-07-18 18:47:22', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151805682195304449', '4', '2', '5', '0.00', '5.30', '平衡木1段', '2019-07-18 18:47:29', '2019-07-18 18:47:29', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806154130001922', '5', '1', '1', '14.10', '22.20', '平衡木1段', '2019-07-18 18:49:21', '2019-07-18 18:49:21', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806196538609666', '5', '1', '2', '7.90', '14.00', '平衡木1段', '2019-07-18 18:49:31', '2019-07-18 18:49:31', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806230298562561', '5', '1', '3', '5.30', '7.80', '平衡木1段', '2019-07-18 18:49:39', '2019-07-18 18:49:39', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806270526132225', '5', '1', '4', '3.80', '5.20', '平衡木1段', '2019-07-18 18:49:49', '2019-07-18 18:49:49', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806299164839938', '5', '1', '5', '0.00', '3.70', '平衡木1段', '2019-07-18 18:49:56', '2019-07-18 18:49:56', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806343171477505', '5', '2', '1', '14.10', '23.70', '平衡木1段', '2019-07-18 18:50:06', '2019-07-18 18:50:06', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806377459912705', '5', '2', '2', '8.30', '14.00', '平衡木1段', '2019-07-18 18:50:15', '2019-07-18 18:50:15', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806416454356993', '5', '2', '3', '5.80', '8.20', '平衡木1段', '2019-07-18 18:50:24', '2019-07-18 18:50:24', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806451715870721', '5', '2', '4', '4.20', '5.70', '平衡木1段', '2019-07-18 18:50:32', '2019-07-18 18:50:32', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806479876427777', '5', '2', '5', '0.00', '4.10', '平衡木1段', '2019-07-18 18:50:39', '2019-07-18 18:50:39', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806518724071426', '6', '1', '1', '9.40', '16.00', '平衡木1段', '2019-07-18 18:50:48', '2019-07-18 18:50:48', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806628388343810', '6', '1', '2', '5.40', '9.30', '平衡木1段', '2019-07-18 18:51:14', '2019-07-18 18:51:14', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806668376838146', '6', '1', '3', '3.80', '5.30', '平衡木1段', '2019-07-18 18:51:24', '2019-07-18 18:51:24', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806702401032194', '6', '1', '4', '2.80', '3.70', '平衡木1段', '2019-07-18 18:51:32', '2019-07-18 18:51:32', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806733644402690', '6', '1', '5', '0.00', '2.70', '平衡木1段', '2019-07-18 18:51:39', '2019-07-18 18:51:39', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806815169089537', '6', '2', '1', '10.80', '17.00', '平衡木1段', '2019-07-18 18:51:59', '2019-07-18 18:51:59', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806861029609473', '6', '2', '2', '6.20', '10.70', '平衡木1段', '2019-07-18 18:52:10', '2019-07-18 18:52:10', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806906755911681', '6', '2', '3', '4.30', '6.10', '平衡木1段', '2019-07-18 18:52:21', '2019-07-18 18:52:21', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806945473531905', '6', '2', '4', '3.10', '4.20', '平衡木1段', '2019-07-18 18:52:30', '2019-07-18 18:52:30', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151806969485922306', '6', '2', '5', '0.00', '3.00', '平衡木1段', '2019-07-18 18:52:36', '2019-07-18 18:52:36', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151807132937949185', '7', '1', '1', '32.50', '48.50', '平衡木2段', '2019-07-18 18:53:15', '2019-07-18 18:53:15', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151807174281203714', '7', '1', '2', '16.90', '32.40', '平衡木2段', '2019-07-18 18:53:25', '2019-07-18 18:53:25', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151807256720248833', '7', '1', '3', '10.60', '16.80', '平衡木2段', '2019-07-18 18:53:44', '2019-07-18 18:53:44', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151807338488205313', '7', '1', '4', '6.70', '10.50', '平衡木2段', '2019-07-18 18:54:04', '2019-07-18 18:54:04', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151807365474357250', '7', '1', '5', '0.00', '6.60', '平衡木2段', '2019-07-18 18:54:10', '2019-07-18 18:54:10', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151807632966094850', '7', '2', '1', '32.50', '49.80', '平衡木2段', '2019-07-18 18:55:14', '2019-07-18 18:55:14', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151813428575670273', '7', '2', '2', '17.40', '32.40', '平衡木2段', '2019-07-18 19:18:16', '2019-07-18 19:18:16', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151813466064359425', '7', '2', '3', '10.80', '17.30', '平衡木2段', '2019-07-18 19:18:25', '2019-07-18 19:18:25', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151813502001156098', '7', '2', '4', '7.00', '10.70', '平衡木2段', '2019-07-18 19:18:33', '2019-07-18 19:18:33', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151813531344506882', '7', '2', '5', '0.00', '6.90', '平衡木2段', '2019-07-18 19:18:40', '2019-07-18 19:18:40', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151813577272135681', '8', '1', '1', '21.60', '33.20', '平衡木2段', '2019-07-18 19:18:51', '2019-07-18 19:18:51', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151813607903137793', '8', '1', '2', '11.60', '21.50', '平衡木2段', '2019-07-18 19:18:58', '2019-07-18 19:18:58', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151813656875831298', '8', '1', '3', '7.40', '11.50', '平衡木2段', '2019-07-18 19:19:10', '2019-07-18 19:19:10', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151813688630906882', '8', '1', '4', '5.00', '7.30', '平衡木2段', '2019-07-18 19:19:18', '2019-07-18 19:19:18', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151813724781613058', '8', '1', '5', '0.00', '4.90', '平衡木2段', '2019-07-18 19:19:26', '2019-07-18 19:19:26', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151813849574739969', '8', '2', '1', '22.60', '32.20', '平衡木2段', '2019-07-18 19:19:56', '2019-07-18 19:19:56', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151813884576206850', '8', '2', '2', '12.30', '22.50', '平衡木2段', '2019-07-18 19:20:04', '2019-07-18 19:20:04', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151813921146343425', '8', '2', '3', '8.20', '12.20', '平衡木2段', '2019-07-18 19:20:13', '2019-07-18 19:20:13', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151813956206530561', '8', '2', '4', '5.40', '8.10', '平衡木2段', '2019-07-18 19:20:21', '2019-07-18 19:20:21', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151813998074073089', '8', '2', '5', '0.00', '5.30', '平衡木2段', '2019-07-18 19:20:31', '2019-07-18 19:20:31', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151814080890605570', '9', '1', '1', '14.10', '22.20', '平衡木2段', '2019-07-18 19:20:51', '2019-07-18 19:21:16', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151814267688128514', '9', '1', '2', '7.90', '14.00', '平衡木2段', '2019-07-18 19:21:36', '2019-07-18 19:21:36', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151814311338250242', '9', '1', '3', '5.30', '7.80', '平衡木2段', '2019-07-18 19:21:46', '2019-07-18 19:21:46', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151814348256514049', '9', '1', '4', '3.80', '5.20', '平衡木2段', '2019-07-18 19:21:55', '2019-07-18 19:21:55', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151814386210770946', '9', '1', '5', '0.00', '3.70', '平衡木2段', '2019-07-18 19:22:04', '2019-07-18 19:22:04', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819012356116482', '9', '2', '1', '14.10', '23.70', '平衡木2段', '2019-07-18 19:40:27', '2019-07-18 19:40:27', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819412161368065', '9', '2', '2', '8.30', '14.00', '平衡木2段', '2019-07-18 19:42:02', '2019-07-18 19:42:02', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819465928151041', '9', '2', '3', '5.80', '8.20', '平衡木2段', '2019-07-18 19:42:15', '2019-07-18 19:42:15', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819501772673026', '9', '2', '4', '4.20', '5.70', '平衡木2段', '2019-07-18 19:42:24', '2019-07-18 19:42:24', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819540389629954', '9', '2', '5', '0.00', '4.10', '平衡木2段', '2019-07-18 19:42:33', '2019-07-18 19:42:33', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819581363785730', '10', '1', '1', '9.40', '16.00', '平衡木2段', '2019-07-18 19:42:43', '2019-07-18 19:42:43', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819615216013314', '10', '1', '2', '5.40', '9.30', '平衡木2段', '2019-07-18 19:42:51', '2019-07-18 19:42:51', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819649085018114', '10', '1', '3', '3.80', '5.30', '平衡木2段', '2019-07-18 19:42:59', '2019-07-18 19:42:59', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819678273179649', '10', '1', '4', '2.80', '3.70', '平衡木2段', '2019-07-18 19:43:06', '2019-07-18 19:43:06', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819707360677890', '10', '1', '5', '0.00', '2.70', '平衡木2段', '2019-07-18 19:43:13', '2019-07-18 19:43:13', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819748443885570', '10', '2', '1', '10.80', '17.00', '平衡木2段', '2019-07-18 19:43:22', '2019-07-18 19:43:22', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819797634682882', '10', '2', '2', '6.20', '10.70', '平衡木2段', '2019-07-18 19:43:34', '2019-07-18 19:43:34', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819844770271233', '10', '2', '3', '4.30', '6.10', '平衡木2段', '2019-07-18 19:43:45', '2019-07-18 19:43:45', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819882665807874', '10', '2', '4', '3.10', '4.20', '平衡木2段', '2019-07-18 19:43:54', '2019-07-18 19:43:54', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819924822757377', '10', '2', '5', '0.00', '3.00', '平衡木2段', '2019-07-18 19:44:05', '2019-07-18 19:44:05', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151819996100759554', '11', '1', '1', '32.50', '48.50', '平衡木3段', '2019-07-18 19:44:22', '2019-07-18 19:44:22', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820034201817090', '11', '1', '2', '16.90', '32.40', '平衡木3段', '2019-07-18 19:44:31', '2019-07-18 19:44:31', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820079475134466', '11', '1', '3', '10.60', '16.80', '平衡木3段', '2019-07-18 19:44:41', '2019-07-18 19:44:41', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820108998840321', '11', '1', '4', '6.70', '10.50', '平衡木3段', '2019-07-18 19:44:48', '2019-07-18 19:44:48', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820143383744513', '11', '1', '5', '0.00', '6.60', '平衡木3段', '2019-07-18 19:44:57', '2019-07-18 19:44:57', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820191932813314', '11', '2', '1', '32.50', '49.80', '平衡木3段', '2019-07-18 19:45:08', '2019-07-18 19:45:08', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820223557865473', '11', '2', '2', '17.40', '32.40', '平衡木3段', '2019-07-18 19:45:16', '2019-07-18 19:45:16', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820252515340289', '11', '2', '3', '10.80', '17.30', '平衡木3段', '2019-07-18 19:45:23', '2019-07-18 19:45:23', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820282169069569', '11', '2', '4', '7.00', '10.70', '平衡木3段', '2019-07-18 19:45:30', '2019-07-18 19:45:30', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820321574555649', '11', '2', '5', '0.00', '6.90', '平衡木3段', '2019-07-18 19:45:39', '2019-07-18 19:45:39', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820371709071361', '12', '1', '1', '21.60', '33.20', '平衡木3段', '2019-07-18 19:45:51', '2019-07-18 19:45:51', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820409227120642', '12', '1', '2', '11.60', '21.50', '平衡木3段', '2019-07-18 19:46:00', '2019-07-18 19:46:00', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820440801841153', '12', '1', '3', '7.40', '11.50', '平衡木3段', '2019-07-18 19:46:08', '2019-07-18 19:46:08', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820478105980930', '12', '1', '4', '5.00', '7.30', '平衡木3段', '2019-07-18 19:46:16', '2019-07-18 19:46:16', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820517771513858', '12', '1', '5', '0.00', '4.90', '平衡木3段', '2019-07-18 19:46:26', '2019-07-18 19:46:26', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820564814827522', '12', '2', '1', '22.60', '32.20', '平衡木3段', '2019-07-18 19:46:37', '2019-07-18 19:46:37', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820609849069569', '12', '2', '2', '12.30', '22.50', '平衡木3段', '2019-07-18 19:46:48', '2019-07-18 19:46:48', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820649099366401', '12', '2', '3', '8.20', '12.20', '平衡木3段', '2019-07-18 19:46:57', '2019-07-18 19:46:57', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820710302650370', '12', '2', '4', '5.40', '8.10', '平衡木3段', '2019-07-18 19:47:12', '2019-07-18 19:47:12', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1151820745203453954', '12', '2', '5', '0.00', '5.30', '平衡木3段', '2019-07-18 19:47:20', '2019-07-18 19:47:20', '1148553378281164801');
INSERT INTO `standard_tb` VALUES ('1152048239181484033', '3', '1', '1', '0.00', '14.64', '称量', '2019-07-19 10:51:19', '2019-07-19 10:56:56', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152048370945544193', '3', '1', '2', '16.39', '999999.00', '称量', '2019-07-19 10:51:50', '2019-07-19 10:57:50', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152048702983426050', '3', '1', '3', '14.65', '16.38', '称量', '2019-07-19 10:53:09', '2019-07-19 10:53:09', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152050032967864321', '4', '1', '1', '0.00', '16.63', '称重', '2019-07-19 10:58:27', '2019-07-19 10:58:27', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152050101817364482', '4', '1', '2', '18.67', '999999.00', '称重', '2019-07-19 10:58:43', '2019-07-19 10:58:43', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152050173292498946', '4', '1', '3', '16.64', '18.66', '称重', '2019-07-19 10:59:00', '2019-07-19 10:59:00', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152050324631375873', '5', '1', '1', '0.00', '18.97', '称重', '2019-07-19 10:59:36', '2019-07-19 10:59:36', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152050415630995458', '5', '1', '2', '21.46', '999999.00', '称重', '2019-07-19 10:59:58', '2019-07-19 10:59:58', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152050490780340226', '5', '1', '3', '18.98', '21.45', '称重', '2019-07-19 11:00:16', '2019-07-19 11:00:16', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152050824550469633', '6', '1', '1', '0.00', '21.25', '称重', '2019-07-19 11:01:35', '2019-07-19 11:01:35', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152050890128412673', '6', '1', '2', '24.32', '999999.00', '称重', '2019-07-19 11:01:51', '2019-07-19 11:01:51', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152051002003083265', '6', '1', '3', '21.26', '24.32', '称重', '2019-07-19 11:02:18', '2019-07-19 11:02:18', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152051122241196034', '7', '1', '1', '0.00', '24.05', '称重', '2019-07-19 11:02:46', '2019-07-19 11:02:46', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152051225567875074', '7', '1', '2', '28.05', '999999.00', '称重', '2019-07-19 11:03:11', '2019-07-19 11:03:11', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152051286490140673', '7', '1', '3', '24.06', '28.04', '称重', '2019-07-19 11:03:25', '2019-07-19 11:03:25', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152051410087890945', '8', '1', '1', '0.00', '27.32', '称重', '2019-07-19 11:03:55', '2019-07-19 11:03:55', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152051477121257474', '8', '1', '2', '32.57', '999999.00', '称重', '2019-07-19 11:04:11', '2019-07-19 11:04:11', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152051555382775810', '8', '1', '3', '27.33', '32.56', '称重', '2019-07-19 11:04:30', '2019-07-19 11:04:30', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152051628288167938', '9', '1', '1', '0.00', '30.45', '称重', '2019-07-19 11:04:47', '2019-07-19 11:04:47', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152051676120010753', '9', '1', '2', '36.92', '999999.00', '称重', '2019-07-19 11:04:58', '2019-07-19 11:04:58', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152051752443760641', '9', '1', '3', '30.46', '36.91', '称重', '2019-07-19 11:05:17', '2019-07-19 11:05:17', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152051818294333441', '10', '1', '1', '0.00', '33.73', '称重', '2019-07-19 11:05:32', '2019-07-19 11:05:32', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152051872023367681', '10', '1', '2', '41.31', '999999.00', '称重', '2019-07-19 11:05:45', '2019-07-19 11:05:45', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152051922694754305', '10', '1', '3', '33.74', '41.30', '称重', '2019-07-19 11:05:57', '2019-07-19 11:05:57', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152051976910327809', '11', '1', '1', '0.00', '37.68', '称重', '2019-07-19 11:06:10', '2019-07-19 11:06:10', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152052022129119233', '11', '1', '2', '46.33', '999999.00', '称重', '2019-07-19 11:06:21', '2019-07-19 11:06:21', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152052110121422849', '11', '1', '3', '37.69', '46.32', '称重', '2019-07-19 11:06:42', '2019-07-19 11:06:42', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152052162852212738', '12', '1', '1', '0.00', '42.48', '称重', '2019-07-19 11:06:54', '2019-07-19 11:06:54', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152052204757504002', '12', '1', '2', '52.31', '999999.00', '称重', '2019-07-19 11:07:04', '2019-07-19 11:07:04', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152052275087593474', '12', '1', '3', '42.49', '52.30', '称重', '2019-07-19 11:07:21', '2019-07-19 11:07:21', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152052444587806721', '3', '2', '1', '0.00', '14.12', '称重', '2019-07-19 11:08:02', '2019-07-19 11:08:02', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152052533561577473', '3', '2', '2', '15.83', '999999.00', '称重', '2019-07-19 11:08:23', '2019-07-19 11:08:23', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152052574623813633', '3', '2', '3', '14.13', '15.82', '称重', '2019-07-19 11:08:33', '2019-07-19 11:08:33', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152052626612211713', '4', '2', '1', '0.00', '16.16', '称重', '2019-07-19 11:08:45', '2019-07-19 11:08:45', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152052781876957186', '4', '2', '2', '18.19', '999999.00', '称重', '2019-07-19 11:09:22', '2019-07-19 11:09:22', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152053079219556354', '4', '2', '3', '16.17', '18.18', '称重', '2019-07-19 11:10:33', '2019-07-19 11:10:33', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152054831822065666', '5', '2', '1', '0.00', '18.25', '称重', '2019-07-19 11:17:31', '2019-07-19 11:17:31', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152054880257888258', '5', '2', '2', '20.66', '999999.00', '称重', '2019-07-19 11:17:42', '2019-07-19 11:17:42', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152054938818760705', '5', '2', '3', '18.26', '20.65', '称重', '2019-07-19 11:17:56', '2019-07-19 11:17:56', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152055016610516993', '6', '2', '1', '0.00', '20.36', '称重', '2019-07-19 11:18:15', '2019-07-19 11:18:15', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152055059669241858', '6', '2', '2', '23.27', '999999.00', '称重', '2019-07-19 11:18:25', '2019-07-19 11:18:25', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152055117315756034', '6', '2', '3', '20.37', '23.26', '称重', '2019-07-19 11:18:39', '2019-07-19 11:18:39', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152055529213186050', '7', '2', '1', '0.00', '22.63', '称重', '2019-07-19 11:20:17', '2019-07-19 11:20:17', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152055581302247425', '7', '2', '2', '26.16', '99999.00', '称重', '2019-07-19 11:20:29', '2019-07-19 11:20:29', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152055636599951361', '7', '2', '3', '22.64', '26.15', '称重', '2019-07-19 11:20:43', '2019-07-19 11:20:43', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152055914774581249', '8', '2', '1', '0.00', '25.24', '称重', '2019-07-19 11:21:49', '2019-07-19 11:21:49', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152056100238315522', '8', '2', '2', '29.56', '999999.00', '称重', '2019-07-19 11:22:33', '2019-07-19 11:22:33', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152056186322210817', '8', '2', '3', '25.25', '29.55', '称重', '2019-07-19 11:22:54', '2019-07-19 11:22:54', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152056322251214850', '9', '2', '1', '0.00', '28.18', '称重', '2019-07-19 11:23:26', '2019-07-19 11:23:26', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152056358259314690', '9', '2', '2', '33.51', '999999.00', '称重', '2019-07-19 11:23:35', '2019-07-19 11:23:35', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152056407101984770', '9', '2', '3', '28.19', '33.50', '称重', '2019-07-19 11:23:46', '2019-07-19 11:23:46', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152056466518495234', '10', '2', '1', '0.00', '31.75', '称重', '2019-07-19 11:24:00', '2019-07-19 11:24:00', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152056509921153026', '10', '2', '2', '38.41', '999999.00', '称重', '2019-07-19 11:24:11', '2019-07-19 11:24:11', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152056670739156994', '10', '2', '3', '31.76', '38.40', '称重', '2019-07-19 11:24:49', '2019-07-19 11:24:49', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152056794391433217', '11', '2', '1', '0.00', '36.09', '称重', '2019-07-19 11:25:19', '2019-07-19 11:25:19', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152056846740541442', '11', '2', '2', '44.09', '999999.00', '称重', '2019-07-19 11:25:31', '2019-07-19 11:25:31', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152056887614033922', '11', '2', '3', '36.10', '44.08', '称重', '2019-07-19 11:25:41', '2019-07-19 11:25:41', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152056943113064449', '12', '2', '1', '0.00', '40.76', '称重', '2019-07-19 11:25:54', '2019-07-19 11:25:54', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152057001929789442', '12', '2', '2', '49.54', '999999.00', '称重', '2019-07-19 11:26:08', '2019-07-19 11:26:08', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152057046657847297', '12', '2', '3', '40.77', '49.53', '称重', '2019-07-19 11:26:19', '2019-07-19 11:26:19', '1148558816162746369');
INSERT INTO `standard_tb` VALUES ('1152057308617297922', '3', '1', '1', '0.00', '92.09', '尺量', '2019-07-19 11:27:21', '2019-07-19 11:27:36', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152057475416379394', '3', '1', '2', '93.00', '96.70', '尺量', '2019-07-19 11:28:01', '2019-07-19 11:28:01', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152057648045543426', '3', '1', '3', '96.80', '100.60', '尺量', '2019-07-19 11:28:42', '2019-07-19 11:28:42', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152057838076874753', '3', '1', '4', '100.70', '300.00', '尺量', '2019-07-19 11:29:27', '2019-07-19 11:29:27', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152057936219394049', '4', '1', '1', '0.00', '100.10', '尺量', '2019-07-19 11:29:51', '2019-07-19 11:29:51', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058004305530881', '4', '1', '2', '100.20', '104.00', '尺量', '2019-07-19 11:30:07', '2019-07-19 11:30:07', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058067878596609', '4', '1', '3', '104.10', '108.10', '尺量', '2019-07-19 11:30:22', '2019-07-19 11:30:22', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058123084025858', '4', '1', '4', '108.20', '300.00', '尺量', '2019-07-19 11:30:35', '2019-07-19 11:30:35', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058202079547393', '5', '1', '1', '0.00', '106.90', '尺量', '2019-07-19 11:30:54', '2019-07-19 11:30:54', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058337748504577', '5', '1', '2', '107.00', '111.20', '尺量', '2019-07-19 11:31:27', '2019-07-19 11:31:27', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058384309473282', '5', '1', '3', '111.30', '115.60', '尺量', '2019-07-19 11:31:38', '2019-07-19 11:31:38', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058430266462210', '5', '1', '4', '115.70', '300.00', '尺量', '2019-07-19 11:31:49', '2019-07-19 11:31:49', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058597782769665', '6', '1', '1', '0.00', '113.00', '尺量', '2019-07-19 11:32:29', '2019-07-19 11:32:29', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058636856905730', '6', '1', '2', '113.10', '117.60', '尺量', '2019-07-19 11:32:38', '2019-07-19 11:32:38', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058678745419777', '6', '1', '3', '117.70', '122.30', '尺量', '2019-07-19 11:32:48', '2019-07-19 11:32:48', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058712702504962', '6', '1', '4', '122.40', '300.00', '尺量', '2019-07-19 11:32:56', '2019-07-19 11:32:56', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058802976509953', '7', '1', '1', '0.00', '118.90', '尺量', '2019-07-19 11:33:18', '2019-07-19 11:33:18', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058839903162370', '7', '1', '2', '119.00', '123.90', '尺量', '2019-07-19 11:33:26', '2019-07-19 11:33:26', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058875206619138', '7', '1', '3', '124.00', '129.00', '尺量', '2019-07-19 11:33:35', '2019-07-19 11:33:35', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058905913118721', '7', '1', '4', '129.10', '300.00', '尺量', '2019-07-19 11:33:42', '2019-07-19 11:33:42', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152058989178441730', '8', '1', '1', '0.00', '124.50', '尺量', '2019-07-19 11:34:02', '2019-07-19 11:34:02', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059052176887810', '8', '1', '2', '124.60', '129.90', '尺量', '2019-07-19 11:34:17', '2019-07-19 11:34:17', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059099501219842', '8', '1', '3', '130.00', '135.40', '尺量', '2019-07-19 11:34:28', '2019-07-19 11:34:28', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059130920751106', '8', '1', '4', '135.50', '300.00', '尺量', '2019-07-19 11:34:36', '2019-07-19 11:34:36', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059195634667521', '9', '1', '1', '0.00', '129.50', '尺量', '2019-07-19 11:34:51', '2019-07-19 11:34:51', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059236118089730', '9', '1', '2', '129.60', '135.30', '尺量', '2019-07-19 11:35:01', '2019-07-19 11:35:01', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059287695446018', '9', '1', '3', '135.40', '141.10', '尺量', '2019-07-19 11:35:13', '2019-07-19 11:35:13', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059323128926210', '9', '1', '4', '141.20', '300.00', '尺量', '2019-07-19 11:35:22', '2019-07-19 11:35:22', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059364262465537', '10', '1', '1', '0.00', '133.90', '尺量', '2019-07-19 11:35:31', '2019-07-19 11:35:31', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059404334845953', '10', '1', '2', '134.00', '140.10', '尺量', '2019-07-19 11:35:41', '2019-07-19 11:35:41', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059454662299649', '10', '1', '3', '140.20', '146.30', '尺量', '2019-07-19 11:35:53', '2019-07-19 11:35:53', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059499121922050', '10', '1', '4', '146.40', '300.00', '尺量', '2019-07-19 11:36:03', '2019-07-19 11:36:03', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059579790970881', '11', '1', '1', '0.00', '138.60', '尺量', '2019-07-19 11:36:23', '2019-07-19 11:36:23', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059619309703169', '11', '1', '2', '138.70', '145.20', '尺量', '2019-07-19 11:36:32', '2019-07-19 11:36:32', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059665111502850', '11', '1', '3', '145.30', '152.00', '尺量', '2019-07-19 11:36:43', '2019-07-19 11:36:43', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059707734020098', '11', '1', '4', '152.10', '300.00', '尺量', '2019-07-19 11:36:53', '2019-07-19 11:36:53', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059753158332418', '12', '1', '1', '0.00', '144.50', '尺量', '2019-07-19 11:37:04', '2019-07-19 11:37:04', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059797324353538', '12', '1', '2', '144.60', '151.80', '尺量', '2019-07-19 11:37:15', '2019-07-19 11:37:15', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059839460331522', '12', '1', '3', '151.90', '159.30', '尺量', '2019-07-19 11:37:25', '2019-07-19 11:37:25', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059879293636609', '12', '1', '4', '159.40', '300.00', '尺量', '2019-07-19 11:37:34', '2019-07-19 11:37:34', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152059965868265474', '3', '2', '1', '0.00', '91.70', '尺量', '2019-07-19 11:37:55', '2019-07-19 11:37:55', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060012454400002', '3', '2', '2', '91.80', '95.50', '尺量', '2019-07-19 11:38:06', '2019-07-19 11:38:06', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060055555067906', '3', '2', '3', '95.60', '99.30', '尺量', '2019-07-19 11:38:16', '2019-07-19 11:38:16', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060088820092930', '3', '2', '4', '99.40', '300.00', '尺量', '2019-07-19 11:38:24', '2019-07-19 11:38:24', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060141118869506', '4', '2', '1', '0.00', '99.10', '尺量', '2019-07-19 11:38:37', '2019-07-19 11:38:37', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060326414831617', '4', '2', '2', '99.20', '103.00', '尺量', '2019-07-19 11:39:21', '2019-07-19 11:39:21', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060365333778434', '4', '2', '3', '103.10', '106.90', '尺量', '2019-07-19 11:39:30', '2019-07-19 11:39:30', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060412402257922', '4', '2', '4', '107.00', '300.00', '尺量', '2019-07-19 11:39:41', '2019-07-19 11:39:41', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060461832130562', '5', '2', '1', '0.00', '105.90', '尺量', '2019-07-19 11:39:53', '2019-07-19 11:39:53', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060502437187585', '5', '2', '2', '106.00', '110.10', '尺量', '2019-07-19 11:40:03', '2019-07-19 11:40:03', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060542417293314', '5', '2', '3', '110.20', '114.40', '尺量', '2019-07-19 11:40:12', '2019-07-19 11:40:12', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060594837704706', '5', '2', '4', '114.50', '300.00', '尺量', '2019-07-19 11:40:25', '2019-07-19 11:40:25', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060661170622466', '6', '2', '1', '0.00', '111.90', '尺量', '2019-07-19 11:40:41', '2019-07-19 11:40:41', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060699334594562', '6', '2', '2', '112.00', '116.50', '尺量', '2019-07-19 11:40:50', '2019-07-19 11:40:50', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060755940921346', '6', '2', '3', '116.60', '121.10', '尺量', '2019-07-19 11:41:03', '2019-07-19 11:41:03', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060796030078978', '6', '2', '4', '121.20', '300.00', '尺量', '2019-07-19 11:41:13', '2019-07-19 11:41:13', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060874081882114', '7', '2', '1', '0.00', '117.50', '尺量', '2019-07-19 11:41:31', '2019-07-19 11:41:31', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060909175623682', '7', '2', '2', '117.60', '122.40', '尺量', '2019-07-19 11:41:40', '2019-07-19 11:41:40', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152060960316772354', '7', '2', '3', '122.50', '127.50', '尺量', '2019-07-19 11:41:52', '2019-07-19 11:41:52', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061001181876226', '7', '2', '4', '127.60', '300.00', '尺量', '2019-07-19 11:42:02', '2019-07-19 11:42:02', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061046887206913', '8', '2', '1', '0.00', '123.00', '尺量', '2019-07-19 11:42:12', '2019-07-19 11:42:12', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061090143064065', '8', '2', '2', '123.10', '128.40', '尺量', '2019-07-19 11:42:23', '2019-07-19 11:42:23', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061131708616705', '8', '2', '3', '128.50', '133.80', '尺量', '2019-07-19 11:42:33', '2019-07-19 11:42:33', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061173681016833', '8', '2', '4', '133.90', '300.00', '尺量', '2019-07-19 11:42:43', '2019-07-19 11:42:43', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061215447896065', '9', '2', '1', '0.00', '128.20', '尺量', '2019-07-19 11:42:53', '2019-07-19 11:42:53', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061246502522881', '9', '2', '2', '128.30', '134.00', '尺量', '2019-07-19 11:43:00', '2019-07-19 11:43:00', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061291566125057', '9', '2', '3', '134.10', '139.80', '尺量', '2019-07-19 11:43:11', '2019-07-19 11:43:11', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061328610217985', '9', '2', '4', '139.90', '300.00', '尺量', '2019-07-19 11:43:20', '2019-07-19 11:43:20', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061372927234049', '10', '2', '1', '0.00', '133.70', '尺量', '2019-07-19 11:43:30', '2019-07-19 11:43:30', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061418670313474', '10', '2', '2', '133.80', '140.00', '尺量', '2019-07-19 11:43:41', '2019-07-19 11:43:41', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061456159002626', '10', '2', '3', '140.10', '146.30', '尺量', '2019-07-19 11:43:50', '2019-07-19 11:43:50', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061490170613761', '10', '2', '4', '146.40', '300.00', '尺量', '2019-07-19 11:43:58', '2019-07-19 11:43:58', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061545694810113', '11', '2', '1', '0.00', '139.90', '尺量', '2019-07-19 11:44:11', '2019-07-19 11:44:11', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061587231002626', '11', '2', '2', '140.00', '146.50', '尺量', '2019-07-19 11:44:21', '2019-07-19 11:44:21', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061624157655041', '11', '2', '3', '146.60', '153.20', '尺量', '2019-07-19 11:44:30', '2019-07-19 11:44:30', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061656348938242', '11', '2', '4', '153.30', '300.00', '尺量', '2019-07-19 11:44:38', '2019-07-19 11:44:38', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061700053585921', '12', '2', '1', '0.00', '145.80', '尺量', '2019-07-19 11:44:48', '2019-07-19 11:44:48', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061737714241537', '12', '2', '2', '145.90', '152.30', '尺量', '2019-07-19 11:44:57', '2019-07-19 11:44:57', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061781293060098', '12', '2', '3', '152.40', '158.70', '尺量', '2019-07-19 11:45:08', '2019-07-19 11:45:08', '1148558693387079682');
INSERT INTO `standard_tb` VALUES ('1152061811408162818', '12', '2', '4', '158.80', '300.00', '尺量', '2019-07-19 11:45:15', '2019-07-19 11:45:15', '1148558693387079682');
