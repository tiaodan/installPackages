/*
Navicat MySQL Data Transfer

Source Server         : 192.1.1.79
Source Server Version : 50728
Source Host           : 192.1.1.79:3306
Source Database       : 2011_security_service

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2022-01-21 10:25:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_dept`
-- ----------------------------
DROP TABLE IF EXISTS `t_dept`;
CREATE TABLE `t_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门ID',
  `parent_id` bigint(20) NOT NULL COMMENT '上级部门ID',
  `dept_name` varchar(100) NOT NULL COMMENT '部门名称',
  `order_num` double(20,0) DEFAULT NULL COMMENT '排序',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_dept
-- ----------------------------
INSERT INTO `t_dept` VALUES ('1', '0', '开发部', '1', '2018-01-04 15:42:26', '2019-01-05 21:08:27');
INSERT INTO `t_dept` VALUES ('2', '1', '开发一部', '1', '2018-01-04 15:42:34', '2019-01-18 00:59:37');
INSERT INTO `t_dept` VALUES ('3', '1', '开发二部', '2', '2018-01-04 15:42:29', '2019-01-05 14:09:39');
INSERT INTO `t_dept` VALUES ('4', '0', '市场部', '2', '2018-01-04 15:42:36', '2019-01-23 06:27:56');
INSERT INTO `t_dept` VALUES ('5', '0', '人事部', '3', '2018-01-04 15:42:32', '2019-01-23 06:27:59');
INSERT INTO `t_dept` VALUES ('6', '0', '测试部', '4', '2018-01-04 15:42:38', '2019-01-17 08:15:47');

-- ----------------------------
-- Table structure for `t_dict`
-- ----------------------------
DROP TABLE IF EXISTS `t_dict`;
CREATE TABLE `t_dict` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典ID',
  `keyy` bigint(20) NOT NULL COMMENT '键',
  `valuee` varchar(100) NOT NULL COMMENT '值',
  `field_name` varchar(100) NOT NULL COMMENT '字段名称',
  `table_name` varchar(100) NOT NULL COMMENT '表名',
  PRIMARY KEY (`dict_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_dict
-- ----------------------------
INSERT INTO `t_dict` VALUES ('1', '0', '男', 'ssex', 't_user');
INSERT INTO `t_dict` VALUES ('2', '1', '女', 'ssex', 't_user');
INSERT INTO `t_dict` VALUES ('3', '2', '保密', 'ssex', 't_user');
INSERT INTO `t_dict` VALUES ('4', '1', '有效', 'status', 't_user');
INSERT INTO `t_dict` VALUES ('5', '0', '锁定', 'status', 't_user');
INSERT INTO `t_dict` VALUES ('6', '0', '菜单', 'type', 't_menu');
INSERT INTO `t_dict` VALUES ('7', '1', '按钮', 'type', 't_menu');
INSERT INTO `t_dict` VALUES ('30', '0', '正常', 'status', 't_job');
INSERT INTO `t_dict` VALUES ('31', '1', '暂停', 'status', 't_job');
INSERT INTO `t_dict` VALUES ('32', '0', '成功', 'status', 't_job_log');
INSERT INTO `t_dict` VALUES ('33', '1', '失败', 'status', 't_job_log');

-- ----------------------------
-- Table structure for `t_log`
-- ----------------------------
DROP TABLE IF EXISTS `t_log`;
CREATE TABLE `t_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `username` varchar(50) DEFAULT NULL COMMENT '操作用户',
  `operation` text COMMENT '操作内容',
  `ip` varchar(64) DEFAULT NULL COMMENT '操作者IP',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `location` varchar(50) DEFAULT NULL COMMENT '操作地点',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_log
-- ----------------------------

-- ----------------------------
-- Table structure for `t_login_log`
-- ----------------------------
DROP TABLE IF EXISTS `t_login_log`;
CREATE TABLE `t_login_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '登录日志的id',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `login_result` varchar(100) NOT NULL COMMENT '登录结果',
  `login_time` datetime DEFAULT NULL COMMENT '登录时间',
  `logout_time` datetime DEFAULT NULL COMMENT '登出时间',
  `location` varchar(255) DEFAULT NULL COMMENT '登录地点',
  `ip` varchar(100) DEFAULT NULL COMMENT 'IP地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for `t_menu`
-- ----------------------------
DROP TABLE IF EXISTS `t_menu`;
CREATE TABLE `t_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单/按钮ID',
  `parent_id` bigint(20) NOT NULL COMMENT '上级菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单/按钮名称',
  `path` varchar(255) DEFAULT NULL COMMENT '对应路由path',
  `component` varchar(255) DEFAULT NULL COMMENT '对应路由组件component',
  `perms` varchar(50) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  `type` char(2) NOT NULL COMMENT '类型 0菜单 1按钮',
  `order_num` double(20,0) DEFAULT NULL COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_menu
-- ----------------------------
INSERT INTO `t_menu` VALUES ('1', '0', '系统管理权限', '/system', 'Layout', '', 'table', '0', '1', '2017-12-27 16:39:07', '2019-01-05 11:13:14');
INSERT INTO `t_menu` VALUES ('3', '1', '系统用户管理', '/user/username', 'system/user/username', 'user:view', '', '0', '1', '2017-12-27 16:47:13', '2019-01-22 06:45:55');
INSERT INTO `t_menu` VALUES ('4', '1', '角色管理', '/role/list', 'system/role/list', 'role:view', '', '0', '2', '2017-12-27 16:48:09', '2018-04-25 09:01:12');
INSERT INTO `t_menu` VALUES ('5', '1', '操作日志', '/menu/menus', 'system/menu/menus', 'log:view', '', '0', '3', '2017-12-27 16:48:57', '2018-04-25 09:01:30');
INSERT INTO `t_menu` VALUES ('6', '1', '登录日志', '/department/list', 'system/department/list', 'loginLog:view', '', '0', '4', '2017-12-27 16:57:33', '2018-04-25 09:01:40');
INSERT INTO `t_menu` VALUES ('7', '1', '组织架构', '', '', 'organization:view', null, '0', '5', '2017-12-27 17:02:58', null);
INSERT INTO `t_menu` VALUES ('8', '1', '终端用户管理', '', '', 'organUser:view', null, '0', '6', '2017-12-27 17:04:07', null);
INSERT INTO `t_menu` VALUES ('9', '1', '通话详情', '', '', 'callDetails:view', null, '0', '7', '2017-12-27 17:04:58', null);
INSERT INTO `t_menu` VALUES ('10', '1', '短信详情', '', '', 'smsDetails:view', null, '0', '8', '2017-12-27 17:06:38', null);
INSERT INTO `t_menu` VALUES ('11', '1', '语音统计', '', '', 'voice:view', null, '0', '9', '2017-12-27 17:06:38', null);
INSERT INTO `t_menu` VALUES ('12', '1', '实时告警管理', '', '', 'realTime:view', null, '0', '10', '2017-12-27 17:06:38', null);
INSERT INTO `t_menu` VALUES ('13', '1', '历史告警管理', '', '', 'historicalAlarm:view', null, '0', '11', '2017-12-27 17:08:02', null);
INSERT INTO `t_menu` VALUES ('14', '1', '告警库重定义', '', '', 'alarmRedefinition:view', null, '0', '12', '2017-12-27 17:08:02', null);
INSERT INTO `t_menu` VALUES ('15', '1', '告警数据统计', '', '', 'alarmSummary:view', null, '0', '13', '2017-12-27 17:08:02', null);
INSERT INTO `t_menu` VALUES ('16', '1', '设备管理', '', '', 'equipment:view', null, '0', '14', '2017-12-27 17:09:24', null);
INSERT INTO `t_menu` VALUES ('17', '1', '设备清单', '', '', 'equipmentV:view', null, '0', '15', '2017-12-27 17:09:24', null);
INSERT INTO `t_menu` VALUES ('18', '1', '网关BBU配置', '', '', 'gatewayBBU:view', null, '0', '16', '2017-12-27 17:09:24', null);
INSERT INTO `t_menu` VALUES ('19', '1', '邻居小区配置', '', '', 'neighborVillage:view', null, '0', '17', '2017-12-27 17:11:13', null);
INSERT INTO `t_menu` VALUES ('20', '3', '添加用户', '', '', 'user:add', null, '1', '18', '2017-12-27 17:11:45', null);
INSERT INTO `t_menu` VALUES ('21', '3', '导出用户', null, null, 'user:export', null, '1', '19', '2019-01-23 06:35:16', null);
INSERT INTO `t_menu` VALUES ('22', '3', '编辑用户', null, null, 'user:update', null, '1', '20', '2021-03-19 11:44:32', '2021-03-19 11:44:37');
INSERT INTO `t_menu` VALUES ('23', '3', '删除用户', null, null, 'user:delete', null, '1', '21', '2021-03-19 11:45:11', null);
INSERT INTO `t_menu` VALUES ('24', '4', '添加角色', null, null, 'role:add', null, '1', '22', '2021-03-19 11:46:00', null);
INSERT INTO `t_menu` VALUES ('25', '4', '导出角色', null, null, 'role:export', null, '1', '23', '2021-03-19 11:46:30', null);
INSERT INTO `t_menu` VALUES ('26', '4', '编辑角色', null, null, 'role:update', null, '1', '24', '2021-03-19 11:47:09', null);
INSERT INTO `t_menu` VALUES ('27', '4', '删除角色', null, null, 'role:delete', null, '1', '25', '2021-03-19 11:47:36', null);
INSERT INTO `t_menu` VALUES ('28', '5', '导出操作日志', null, null, 'log:export', null, '1', '26', '2021-03-19 11:48:33', null);
INSERT INTO `t_menu` VALUES ('29', '5', '删除操作日志', null, null, 'log:delete', null, '1', '27', '2021-03-19 11:49:08', null);
INSERT INTO `t_menu` VALUES ('30', '6', '导出登录日志', null, null, 'loginLog:export', null, '1', '28', '2021-03-19 11:50:11', null);
INSERT INTO `t_menu` VALUES ('31', '6', '删除登录日志', null, null, 'loginLog:delete', null, '1', '29', '2021-03-19 11:50:52', null);
INSERT INTO `t_menu` VALUES ('32', '7', '添加组织', null, null, 'organization:add', null, '1', '30', '2021-03-19 11:52:38', null);
INSERT INTO `t_menu` VALUES ('33', '7', '同步数据中心数据', null, null, 'organization:synchronous', null, '1', '31', '2021-03-19 11:53:30', null);
INSERT INTO `t_menu` VALUES ('34', '7', '编辑组织', null, null, 'organization:update', null, '1', '32', '2021-03-19 11:54:10', null);
INSERT INTO `t_menu` VALUES ('35', '7', '删除组织', null, null, 'organization:delete', null, '1', '33', '2021-03-19 11:55:00', null);
INSERT INTO `t_menu` VALUES ('36', '8', '添加组织用户', null, null, 'organUser:add', null, '1', '34', '2021-03-19 11:55:51', null);
INSERT INTO `t_menu` VALUES ('37', '8', '批量添加组织用户', null, null, 'organUser:batchAdd', null, '1', '35', '2021-03-19 14:14:06', null);
INSERT INTO `t_menu` VALUES ('38', '8', '批量修改组织用户', null, null, 'organUser:batchUpdate', null, '1', '36', '2021-03-19 14:14:58', null);
INSERT INTO `t_menu` VALUES ('39', '8', '编辑组织用户', null, null, 'organUser:update', null, '1', '37', '2021-03-19 14:15:46', null);
INSERT INTO `t_menu` VALUES ('40', '8', '批量删除组织用户', null, null, 'organUser:batchDelete', null, '1', '38', '2021-03-19 14:16:36', null);
INSERT INTO `t_menu` VALUES ('41', '8', '删除组织用户', null, null, 'organUser:delete', null, '1', '39', '2021-03-19 14:18:45', null);
INSERT INTO `t_menu` VALUES ('42', '8', '导入组织用户', null, null, 'organUser:import', null, '1', '40', '2021-03-19 14:19:52', null);
INSERT INTO `t_menu` VALUES ('43', '8', '同步组织用户', null, null, 'organUser:synchronous', null, '1', '41', '2021-03-19 14:20:41', null);
INSERT INTO `t_menu` VALUES ('44', '12', '确认实时告警', null, null, 'realTime:sure', null, '1', '42', '2021-03-19 14:22:51', null);
INSERT INTO `t_menu` VALUES ('45', '12', '清除实时告警', null, null, 'realTime:delete', null, '1', '43', '2021-03-19 14:24:12', null);
INSERT INTO `t_menu` VALUES ('46', '13', '删除历史告警', null, null, 'historicalAlarm:delete', null, '1', '44', '2021-03-19 14:25:17', null);
INSERT INTO `t_menu` VALUES ('47', '13', '导出历史告警', null, null, 'historicalAlarm:export', null, '1', '45', '2021-03-19 14:27:51', null);
INSERT INTO `t_menu` VALUES ('48', '14', '添加告警库重定义', null, null, 'alarmRedefinition:add', null, '1', '46', '2021-03-19 14:28:49', null);
INSERT INTO `t_menu` VALUES ('49', '14', '编辑告警库', null, null, 'alarmRedefinition:update', null, '1', '47', '2021-03-19 14:30:07', null);
INSERT INTO `t_menu` VALUES ('50', '14', '删除告警库', null, null, 'alarmRedefinition:delete', null, '1', '48', '2021-03-19 14:31:09', null);
INSERT INTO `t_menu` VALUES ('53', '14', '导出告警库', null, null, 'alarmRedefinition:export', null, '1', '51', '2021-03-19 14:33:58', null);
INSERT INTO `t_menu` VALUES ('54', '17', '添加设备', null, null, 'equipmentV:add', null, '1', '52', '2021-03-19 14:35:42', null);
INSERT INTO `t_menu` VALUES ('55', '17', '删除设备', null, null, 'equipmentV:delete', null, '1', '53', '2021-03-19 14:36:11', null);
INSERT INTO `t_menu` VALUES ('56', '17', '网络参数配置', null, null, 'equipmentV:networkParameters', null, '1', '54', '2021-03-19 14:37:40', null);
INSERT INTO `t_menu` VALUES ('57', '17', '业务配置', null, null, 'equipmentV:business', null, '1', '55', '2021-03-19 14:38:31', null);
INSERT INTO `t_menu` VALUES ('58', '18', '添加网关BBU配置', null, null, 'gatewayBBU:add', null, '1', '56', '2021-03-19 14:39:16', null);
INSERT INTO `t_menu` VALUES ('59', '18', '删除网关BBU配置', null, null, 'gatewayBBU:delete', null, '1', '57', '2021-03-19 14:45:08', null);
INSERT INTO `t_menu` VALUES ('60', '18', '编辑网关BBU配置', null, null, 'gatewayBBU:update', null, '1', '58', '2021-03-19 14:45:47', null);
INSERT INTO `t_menu` VALUES ('61', '19', '添加邻居小区', null, null, 'neighborVillage:add', null, '1', '59', '2021-03-19 14:46:45', null);
INSERT INTO `t_menu` VALUES ('62', '19', '编辑邻居小区', null, null, 'neighborVillage:update', null, '1', '60', '2021-03-19 14:47:19', null);
INSERT INTO `t_menu` VALUES ('63', '17', '编辑设备', null, null, 'equipmentV:update', null, '1', '61', '2021-04-01 10:20:02', null);
INSERT INTO `t_menu` VALUES ('64', '14', '导入告警库', null, null, 'alarmRedefinition:import', null, '1', '62', '2021-04-01 10:21:23', null);
INSERT INTO `t_menu` VALUES ('65', '1', '组呼详情', null, null, 'terminalCommunication:view', null, '0', '63', '2021-05-10 10:34:28', null);

-- ----------------------------
-- Table structure for `t_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(10) NOT NULL COMMENT '角色名称',
  `remark` varchar(100) DEFAULT NULL COMMENT '角色描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', '超级管理员', '', '2017-12-27 16:23:11', '2021-03-26 17:12:10');
INSERT INTO `t_role` VALUES ('3', '普通用户', '', '2021-03-31 18:29:29', '2021-04-29 13:45:46');
INSERT INTO `t_role` VALUES ('4', '测试角色', '测试', '2021-12-15 15:53:30', '2021-12-21 11:00:05');

-- ----------------------------
-- Table structure for `t_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `t_role_menu`;
CREATE TABLE `t_role_menu` (
  `role_id` bigint(20) NOT NULL,
  `menu_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_menu
-- ----------------------------
INSERT INTO `t_role_menu` VALUES ('1', '1');
INSERT INTO `t_role_menu` VALUES ('1', '3');
INSERT INTO `t_role_menu` VALUES ('1', '20');
INSERT INTO `t_role_menu` VALUES ('1', '21');
INSERT INTO `t_role_menu` VALUES ('1', '22');
INSERT INTO `t_role_menu` VALUES ('1', '23');
INSERT INTO `t_role_menu` VALUES ('1', '4');
INSERT INTO `t_role_menu` VALUES ('1', '24');
INSERT INTO `t_role_menu` VALUES ('1', '25');
INSERT INTO `t_role_menu` VALUES ('1', '26');
INSERT INTO `t_role_menu` VALUES ('1', '27');
INSERT INTO `t_role_menu` VALUES ('1', '5');
INSERT INTO `t_role_menu` VALUES ('1', '28');
INSERT INTO `t_role_menu` VALUES ('1', '29');
INSERT INTO `t_role_menu` VALUES ('1', '6');
INSERT INTO `t_role_menu` VALUES ('1', '30');
INSERT INTO `t_role_menu` VALUES ('1', '31');
INSERT INTO `t_role_menu` VALUES ('1', '7');
INSERT INTO `t_role_menu` VALUES ('1', '32');
INSERT INTO `t_role_menu` VALUES ('1', '33');
INSERT INTO `t_role_menu` VALUES ('1', '34');
INSERT INTO `t_role_menu` VALUES ('1', '35');
INSERT INTO `t_role_menu` VALUES ('1', '8');
INSERT INTO `t_role_menu` VALUES ('1', '36');
INSERT INTO `t_role_menu` VALUES ('1', '37');
INSERT INTO `t_role_menu` VALUES ('1', '38');
INSERT INTO `t_role_menu` VALUES ('1', '39');
INSERT INTO `t_role_menu` VALUES ('1', '40');
INSERT INTO `t_role_menu` VALUES ('1', '41');
INSERT INTO `t_role_menu` VALUES ('1', '42');
INSERT INTO `t_role_menu` VALUES ('1', '43');
INSERT INTO `t_role_menu` VALUES ('1', '9');
INSERT INTO `t_role_menu` VALUES ('1', '10');
INSERT INTO `t_role_menu` VALUES ('1', '11');
INSERT INTO `t_role_menu` VALUES ('1', '12');
INSERT INTO `t_role_menu` VALUES ('1', '44');
INSERT INTO `t_role_menu` VALUES ('1', '45');
INSERT INTO `t_role_menu` VALUES ('1', '13');
INSERT INTO `t_role_menu` VALUES ('1', '46');
INSERT INTO `t_role_menu` VALUES ('1', '47');
INSERT INTO `t_role_menu` VALUES ('1', '14');
INSERT INTO `t_role_menu` VALUES ('1', '48');
INSERT INTO `t_role_menu` VALUES ('1', '15');
INSERT INTO `t_role_menu` VALUES ('1', '49');
INSERT INTO `t_role_menu` VALUES ('1', '50');
INSERT INTO `t_role_menu` VALUES ('1', '51');
INSERT INTO `t_role_menu` VALUES ('1', '52');
INSERT INTO `t_role_menu` VALUES ('1', '53');
INSERT INTO `t_role_menu` VALUES ('1', '64');
INSERT INTO `t_role_menu` VALUES ('1', '16');
INSERT INTO `t_role_menu` VALUES ('1', '17');
INSERT INTO `t_role_menu` VALUES ('1', '54');
INSERT INTO `t_role_menu` VALUES ('1', '55');
INSERT INTO `t_role_menu` VALUES ('1', '56');
INSERT INTO `t_role_menu` VALUES ('1', '57');
INSERT INTO `t_role_menu` VALUES ('1', '63');
INSERT INTO `t_role_menu` VALUES ('1', '18');
INSERT INTO `t_role_menu` VALUES ('1', '58');
INSERT INTO `t_role_menu` VALUES ('1', '59');
INSERT INTO `t_role_menu` VALUES ('1', '60');
INSERT INTO `t_role_menu` VALUES ('1', '19');
INSERT INTO `t_role_menu` VALUES ('1', '61');
INSERT INTO `t_role_menu` VALUES ('1', '62');
INSERT INTO `t_role_menu` VALUES ('1', '2');
INSERT INTO `t_role_menu` VALUES ('3', '3');
INSERT INTO `t_role_menu` VALUES ('3', '4');
INSERT INTO `t_role_menu` VALUES ('3', '5');
INSERT INTO `t_role_menu` VALUES ('3', '6');
INSERT INTO `t_role_menu` VALUES ('3', '7');
INSERT INTO `t_role_menu` VALUES ('3', '8');
INSERT INTO `t_role_menu` VALUES ('3', '9');
INSERT INTO `t_role_menu` VALUES ('3', '10');
INSERT INTO `t_role_menu` VALUES ('3', '11');
INSERT INTO `t_role_menu` VALUES ('3', '12');
INSERT INTO `t_role_menu` VALUES ('3', '13');
INSERT INTO `t_role_menu` VALUES ('3', '14');
INSERT INTO `t_role_menu` VALUES ('3', '15');
INSERT INTO `t_role_menu` VALUES ('3', '16');
INSERT INTO `t_role_menu` VALUES ('3', '17');
INSERT INTO `t_role_menu` VALUES ('3', '18');
INSERT INTO `t_role_menu` VALUES ('3', '19');
INSERT INTO `t_role_menu` VALUES ('3', '2');
INSERT INTO `t_role_menu` VALUES ('1', '65');
INSERT INTO `t_role_menu` VALUES ('3', '65');
INSERT INTO `t_role_menu` VALUES ('4', '22');
INSERT INTO `t_role_menu` VALUES ('4', '1');
INSERT INTO `t_role_menu` VALUES ('4', '23');
INSERT INTO `t_role_menu` VALUES ('4', '3');
INSERT INTO `t_role_menu` VALUES ('4', '4');
INSERT INTO `t_role_menu` VALUES ('4', '20');
INSERT INTO `t_role_menu` VALUES ('4', '24');
INSERT INTO `t_role_menu` VALUES ('4', '21');
INSERT INTO `t_role_menu` VALUES ('4', '25');
INSERT INTO `t_role_menu` VALUES ('4', '22');
INSERT INTO `t_role_menu` VALUES ('4', '26');
INSERT INTO `t_role_menu` VALUES ('4', '23');
INSERT INTO `t_role_menu` VALUES ('4', '27');
INSERT INTO `t_role_menu` VALUES ('4', '4');
INSERT INTO `t_role_menu` VALUES ('4', '5');
INSERT INTO `t_role_menu` VALUES ('4', '24');
INSERT INTO `t_role_menu` VALUES ('4', '28');
INSERT INTO `t_role_menu` VALUES ('4', '25');
INSERT INTO `t_role_menu` VALUES ('4', '6');
INSERT INTO `t_role_menu` VALUES ('4', '26');
INSERT INTO `t_role_menu` VALUES ('4', '30');
INSERT INTO `t_role_menu` VALUES ('4', '27');
INSERT INTO `t_role_menu` VALUES ('4', '7');
INSERT INTO `t_role_menu` VALUES ('4', '5');
INSERT INTO `t_role_menu` VALUES ('4', '32');
INSERT INTO `t_role_menu` VALUES ('4', '28');
INSERT INTO `t_role_menu` VALUES ('4', '33');
INSERT INTO `t_role_menu` VALUES ('4', '6');
INSERT INTO `t_role_menu` VALUES ('4', '34');
INSERT INTO `t_role_menu` VALUES ('4', '30');
INSERT INTO `t_role_menu` VALUES ('4', '35');
INSERT INTO `t_role_menu` VALUES ('4', '7');
INSERT INTO `t_role_menu` VALUES ('4', '8');
INSERT INTO `t_role_menu` VALUES ('4', '32');
INSERT INTO `t_role_menu` VALUES ('4', '36');
INSERT INTO `t_role_menu` VALUES ('4', '33');
INSERT INTO `t_role_menu` VALUES ('4', '37');
INSERT INTO `t_role_menu` VALUES ('4', '34');
INSERT INTO `t_role_menu` VALUES ('4', '38');
INSERT INTO `t_role_menu` VALUES ('4', '35');
INSERT INTO `t_role_menu` VALUES ('4', '39');
INSERT INTO `t_role_menu` VALUES ('4', '8');
INSERT INTO `t_role_menu` VALUES ('4', '40');
INSERT INTO `t_role_menu` VALUES ('4', '36');
INSERT INTO `t_role_menu` VALUES ('4', '41');
INSERT INTO `t_role_menu` VALUES ('4', '37');
INSERT INTO `t_role_menu` VALUES ('4', '42');
INSERT INTO `t_role_menu` VALUES ('4', '38');
INSERT INTO `t_role_menu` VALUES ('4', '43');
INSERT INTO `t_role_menu` VALUES ('4', '39');
INSERT INTO `t_role_menu` VALUES ('4', '9');
INSERT INTO `t_role_menu` VALUES ('4', '40');
INSERT INTO `t_role_menu` VALUES ('4', '10');
INSERT INTO `t_role_menu` VALUES ('4', '41');
INSERT INTO `t_role_menu` VALUES ('4', '11');
INSERT INTO `t_role_menu` VALUES ('4', '42');
INSERT INTO `t_role_menu` VALUES ('4', '12');
INSERT INTO `t_role_menu` VALUES ('4', '43');
INSERT INTO `t_role_menu` VALUES ('4', '44');
INSERT INTO `t_role_menu` VALUES ('4', '9');
INSERT INTO `t_role_menu` VALUES ('4', '45');
INSERT INTO `t_role_menu` VALUES ('4', '10');
INSERT INTO `t_role_menu` VALUES ('4', '13');
INSERT INTO `t_role_menu` VALUES ('4', '11');
INSERT INTO `t_role_menu` VALUES ('4', '46');
INSERT INTO `t_role_menu` VALUES ('4', '12');
INSERT INTO `t_role_menu` VALUES ('4', '47');
INSERT INTO `t_role_menu` VALUES ('4', '44');
INSERT INTO `t_role_menu` VALUES ('4', '14');
INSERT INTO `t_role_menu` VALUES ('4', '45');
INSERT INTO `t_role_menu` VALUES ('4', '48');
INSERT INTO `t_role_menu` VALUES ('4', '13');
INSERT INTO `t_role_menu` VALUES ('4', '49');
INSERT INTO `t_role_menu` VALUES ('4', '46');
INSERT INTO `t_role_menu` VALUES ('4', '50');
INSERT INTO `t_role_menu` VALUES ('4', '47');
INSERT INTO `t_role_menu` VALUES ('4', '53');
INSERT INTO `t_role_menu` VALUES ('4', '14');
INSERT INTO `t_role_menu` VALUES ('4', '64');
INSERT INTO `t_role_menu` VALUES ('4', '48');
INSERT INTO `t_role_menu` VALUES ('4', '15');
INSERT INTO `t_role_menu` VALUES ('4', '49');
INSERT INTO `t_role_menu` VALUES ('4', '16');
INSERT INTO `t_role_menu` VALUES ('4', '50');
INSERT INTO `t_role_menu` VALUES ('4', '17');
INSERT INTO `t_role_menu` VALUES ('4', '53');
INSERT INTO `t_role_menu` VALUES ('4', '54');
INSERT INTO `t_role_menu` VALUES ('4', '64');
INSERT INTO `t_role_menu` VALUES ('4', '55');
INSERT INTO `t_role_menu` VALUES ('4', '15');
INSERT INTO `t_role_menu` VALUES ('4', '56');
INSERT INTO `t_role_menu` VALUES ('4', '16');
INSERT INTO `t_role_menu` VALUES ('4', '57');
INSERT INTO `t_role_menu` VALUES ('4', '17');
INSERT INTO `t_role_menu` VALUES ('4', '63');
INSERT INTO `t_role_menu` VALUES ('4', '54');
INSERT INTO `t_role_menu` VALUES ('4', '18');
INSERT INTO `t_role_menu` VALUES ('4', '55');
INSERT INTO `t_role_menu` VALUES ('4', '58');
INSERT INTO `t_role_menu` VALUES ('4', '56');
INSERT INTO `t_role_menu` VALUES ('4', '59');
INSERT INTO `t_role_menu` VALUES ('4', '57');
INSERT INTO `t_role_menu` VALUES ('4', '60');
INSERT INTO `t_role_menu` VALUES ('4', '63');
INSERT INTO `t_role_menu` VALUES ('4', '19');
INSERT INTO `t_role_menu` VALUES ('4', '18');
INSERT INTO `t_role_menu` VALUES ('4', '61');
INSERT INTO `t_role_menu` VALUES ('4', '58');
INSERT INTO `t_role_menu` VALUES ('4', '62');
INSERT INTO `t_role_menu` VALUES ('4', '59');
INSERT INTO `t_role_menu` VALUES ('4', '65');
INSERT INTO `t_role_menu` VALUES ('4', '60');
INSERT INTO `t_role_menu` VALUES ('4', '19');
INSERT INTO `t_role_menu` VALUES ('4', '61');
INSERT INTO `t_role_menu` VALUES ('4', '62');
INSERT INTO `t_role_menu` VALUES ('4', '65');

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `user_id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(128) NOT NULL COMMENT '密码',
  `unit_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `email` varchar(128) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `status` char(1) NOT NULL COMMENT '状态 0锁定 1有效',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `last_login_time` datetime DEFAULT NULL COMMENT '最近访问时间',
  `ssex` char(1) DEFAULT NULL COMMENT '性别 0男 1女 2保密',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `avatar` varchar(100) DEFAULT NULL COMMENT '用户头像',
  `imsi` varchar(32) DEFAULT NULL COMMENT '终端号',
  `mdn` varchar(32) DEFAULT NULL COMMENT '终端电话号',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'admin', 'e47faf93c0d84bd34df6acc217877dd3', '0', 'admin@qq.com', '12345678901', '1', '2022-03-16 11:01:55', '2022-03-16 10:09:25', '2022-03-16 19:54:29', '0', 'admin', 'admin.png', '', '');
INSERT INTO `t_user` VALUES ('2', 'nouser', 'e86ce242f7761a50a2eb3b9e8436fbbc', 0, 'admin@qq.com', '12345678901', '1', '2022-03-16 11:01:55', '2022-03-16 06:44:28', '2022-03-16 18:07:14', '0', 'nouerdasdasd', 'admin.png', '', '');


-- ----------------------------
-- Table structure for `t_user_config`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_config`;
CREATE TABLE `t_user_config` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `theme` varchar(10) DEFAULT NULL COMMENT '系统主题 dark暗色风格，light明亮风格',
  `layout` varchar(10) DEFAULT NULL COMMENT '系统布局 side侧边栏，head顶部栏',
  `multi_page` char(1) DEFAULT NULL COMMENT '页面风格 1多标签页 0单页',
  `fix_siderbar` char(1) DEFAULT NULL COMMENT '页面滚动是否固定侧边栏 1固定 0不固定',
  `fix_header` char(1) DEFAULT NULL COMMENT '页面滚动是否固定顶栏 1固定 0不固定',
  `color` varchar(20) DEFAULT NULL COMMENT '主题颜色 RGB值',
  `organization` varchar(10) DEFAULT NULL COMMENT '组织架构',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_config
-- ----------------------------
INSERT INTO `t_user_config` VALUES ('1', 'light', 'side', '1', '1', '1', 'rgb(24, 144, 255)', '2,3,1');
INSERT INTO `t_user_config` VALUES ('2', 'dark', 'side', '0', '1', '1', 'rgb(66, 185, 131)', null);
INSERT INTO `t_user_config` VALUES ('4', 'dark', 'side', '0', '1', '1', 'rgb(66, 185, 131)', '1,0,0');
INSERT INTO `t_user_config` VALUES ('5', 'dark', 'side', '0', '1', '1', 'rgb(66, 185, 131)', null);
INSERT INTO `t_user_config` VALUES ('9', 'dark', 'side', '0', '1', '1', 'rgb(66, 185, 131)', null);
INSERT INTO `t_user_config` VALUES ('13', 'dark', 'side', '0', '1', '1', 'rgb(66, 185, 131)', null);
INSERT INTO `t_user_config` VALUES ('14', 'dark', 'side', '0', '1', '1', 'rgb(66, 185, 131)', null);
INSERT INTO `t_user_config` VALUES ('15', 'dark', 'side', '0', '1', '1', 'rgb(66, 185, 131)', null);

-- ----------------------------
-- Table structure for `t_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES ('2', '1');
INSERT INTO `t_user_role` VALUES ('9', '3');
INSERT INTO `t_user_role` VALUES ('5', '1');
INSERT INTO `t_user_role` VALUES ('1', '1');
INSERT INTO `t_user_role` VALUES ('13', '1');
INSERT INTO `t_user_role` VALUES ('14', '4');
INSERT INTO `t_user_role` VALUES ('15', '4');
