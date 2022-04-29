/*
Navicat MySQL Data Transfer

Source Server         : 172.16.0.200（aj好的测试环境）
Source Server Version : 50505
Source Host           : 172.16.0.200:3306
Source Database       : aj03_alarm_service

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2022-02-18 17:21:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `alarm_history`
-- ----------------------------
DROP TABLE IF EXISTS `alarm_history`;
CREATE TABLE `alarm_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `alarm_source` varchar(255) NOT NULL COMMENT '告警具体设备',
  `alarm_code` varchar(255) NOT NULL COMMENT '告警码(外键)',
  `alarm_number` bigint(20) DEFAULT NULL COMMENT '告警累计次数',
  `start_time` varchar(255) DEFAULT NULL COMMENT '发生时间',
  `last_update_time` varchar(255) DEFAULT NULL COMMENT '最后更新时间',
  `ack_status` varchar(255) DEFAULT NULL COMMENT '确认状态',
  `ack_time` varchar(255) DEFAULT NULL COMMENT '确认时间',
  `ack_user_name` varchar(255) DEFAULT NULL COMMENT '确认人',
  `ack_comments` varchar(255) DEFAULT NULL COMMENT '确认备注',
  `clear_time` varchar(255) DEFAULT NULL COMMENT '清除时间',
  `clear_user_name` varchar(255) DEFAULT NULL COMMENT '清除人',
  `clear_comments` varchar(255) DEFAULT NULL COMMENT '清除备注',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  `alarm_unit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `5` (`alarm_code`) USING BTREE,
  KEY `time` (`start_time`) USING BTREE,
  KEY `resource` (`alarm_source`) USING BTREE,
  CONSTRAINT `5` FOREIGN KEY (`alarm_code`) REFERENCES `alarm_warehouse` (`alarm_code`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of alarm_history
-- ----------------------------
INSERT INTO `alarm_history` VALUES ('1', '172.16.0.28', '000015', '2', '2021-04-23 16:47:16', '2021-04-23 16:47:17', '0', null, null, null, '2021-04-23 16:47:18', '设备上报清除', null, '2021-04-23 16:47:18', '0');
INSERT INTO `alarm_history` VALUES ('2', '172.16.0.28', '000015', '2', '2021-04-23 16:47:33', '2021-04-23 16:47:34', '0', null, null, null, '2021-04-23 16:47:35', '设备上报清除', null, '2021-04-23 16:47:35', '0');
INSERT INTO `alarm_history` VALUES ('3', '172.16.0.28', '000015', '1', '2021-04-23 16:49:16', '2021-04-23 16:49:16', '0', null, null, null, '2021-04-23 16:49:17', '设备上报清除', null, '2021-04-23 16:49:17', '0');
INSERT INTO `alarm_history` VALUES ('4', '172.16.0.28', '000015', '2', '2021-04-23 16:49:32', '2021-04-23 16:49:33', '0', null, null, null, '2021-04-23 16:49:34', '设备上报清除', null, '2021-04-23 16:49:34', '0');
INSERT INTO `alarm_history` VALUES ('5', '172.16.0.28', '000015', '1', '2021-04-23 16:49:51', '2021-04-23 16:49:51', '0', null, null, null, '2021-04-23 16:49:52', '设备上报清除', null, '2021-04-23 16:49:52', '0');
INSERT INTO `alarm_history` VALUES ('6', '172.16.0.28', '000015', '1', '2021-04-23 16:49:56', '2021-04-23 16:49:56', '0', null, null, null, '2021-04-23 16:49:57', '设备上报清除', null, '2021-04-23 16:49:57', '0');
INSERT INTO `alarm_history` VALUES ('7', '172.16.0.28', '000015', '1', '2021-04-23 16:50:01', '2021-04-23 16:50:01', '0', null, null, null, '2021-04-23 16:50:02', '设备上报清除', null, '2021-04-23 16:50:02', '0');
INSERT INTO `alarm_history` VALUES ('8', '172.16.0.28', '000015', '1', '2021-04-23 16:50:06', '2021-04-23 16:50:06', '0', null, null, null, '2021-04-23 16:50:07', '设备上报清除', null, '2021-04-23 16:50:07', '0');
INSERT INTO `alarm_history` VALUES ('9', '172.16.0.28', '000015', '1', '2021-04-23 16:50:16', '2021-04-23 16:50:16', '0', null, null, null, '2021-04-23 16:50:17', '设备上报清除', null, '2021-04-23 16:50:17', '0');
INSERT INTO `alarm_history` VALUES ('10', '172.16.0.28', '000015', '2', '2021-04-23 16:50:32', '2021-04-23 16:50:33', '0', null, null, null, '2021-04-23 16:50:34', '设备上报清除', null, '2021-04-23 16:50:34', '0');
INSERT INTO `alarm_history` VALUES ('11', '172.16.0.28', '000015', '1', '2021-04-23 16:50:47', '2021-04-23 16:50:47', '0', null, null, null, '2021-04-23 16:50:48', '设备上报清除', null, '2021-04-23 16:50:48', '0');
INSERT INTO `alarm_history` VALUES ('12', '172.16.0.28', '000015', '1', '2021-04-23 16:51:33', '2021-04-23 16:51:33', '0', null, null, null, '2021-04-23 16:51:34', '设备上报清除', null, '2021-04-23 16:51:34', '0');
INSERT INTO `alarm_history` VALUES ('13', '172.16.0.28', '000015', '2', '2021-04-23 16:52:33', '2021-04-23 16:52:34', '0', null, null, null, '2021-04-23 16:52:35', '设备上报清除', null, '2021-04-23 16:52:35', '0');
INSERT INTO `alarm_history` VALUES ('14', '172.16.0.28', '000015', '1', '2021-04-23 16:53:16', '2021-04-23 16:53:16', '0', null, null, null, '2021-04-23 16:53:17', '设备上报清除', null, '2021-04-23 16:53:17', '0');
INSERT INTO `alarm_history` VALUES ('15', '172.16.0.28', '000015', '1', '2021-04-23 16:53:34', '2021-04-23 16:53:34', '0', null, null, null, '2021-04-23 16:53:35', '设备上报清除', null, '2021-04-23 16:53:35', '0');
INSERT INTO `alarm_history` VALUES ('16', '172.16.0.28', '000015', '1', '2021-04-23 16:53:42', '2021-04-23 16:53:42', '0', null, null, null, '2021-04-23 16:53:43', '设备上报清除', null, '2021-04-23 16:53:43', '0');
INSERT INTO `alarm_history` VALUES ('17', '10.105.0.150', '000110', '11', '2022-02-17 18:23:38', '2022-02-17 18:43:08', '1', '2022-02-18 10:06:07', 'admin', '', '2022-02-18 10:06:34', 'admin', '', '2022-02-18 10:06:34', '0');
INSERT INTO `alarm_history` VALUES ('18', '10.105.0.150', '000001', '1', '2022-02-17 18:44:41', '2022-02-17 18:44:41', '1', '2022-02-18 10:06:15', 'admin', '', '2022-02-18 10:06:37', 'admin', '', '2022-02-18 10:06:37', '0');

-- ----------------------------
-- Table structure for `alarm_now`
-- ----------------------------
DROP TABLE IF EXISTS `alarm_now`;
CREATE TABLE `alarm_now` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `alarm_source` varchar(255) NOT NULL COMMENT '告警具体设备',
  `alarm_code` varchar(255) NOT NULL COMMENT '告警码(外键)',
  `alarm_number` bigint(20) DEFAULT NULL COMMENT '告警累计次数',
  `start_time` varchar(255) DEFAULT NULL COMMENT '发生时间',
  `last_update_time` varchar(255) DEFAULT NULL COMMENT '最后更新时间',
  `ack_status` varchar(255) DEFAULT '0' COMMENT '确认状态',
  `ack_time` varchar(255) DEFAULT NULL COMMENT '确认时间',
  `ack_user_name` varchar(255) DEFAULT NULL COMMENT '确认人',
  `ack_comments` varchar(255) DEFAULT NULL COMMENT '确认备注',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  `alarm_unit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `4` (`alarm_code`) USING BTREE,
  CONSTRAINT `4` FOREIGN KEY (`alarm_code`) REFERENCES `alarm_warehouse` (`alarm_code`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of alarm_now
-- ----------------------------
INSERT INTO `alarm_now` VALUES ('1', '172.16.0.60', '000001', '5', '2021-09-29 11:08:38', '2021-09-29 11:26:41', '0', null, null, null, '2021-09-29 11:26:41', '0');

-- ----------------------------
-- Table structure for `alarm_resource_type`
-- ----------------------------
DROP TABLE IF EXISTS `alarm_resource_type`;
CREATE TABLE `alarm_resource_type` (
  `resource_type_id` int(11) NOT NULL COMMENT '资源类型主键',
  `resource_name` varchar(255) DEFAULT NULL COMMENT '资源类型名称',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`resource_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of alarm_resource_type
-- ----------------------------
INSERT INTO `alarm_resource_type` VALUES ('1', '1001', '2020-11-16 16:33:28');
INSERT INTO `alarm_resource_type` VALUES ('2', '1002', '2020-11-16 16:33:28');
INSERT INTO `alarm_resource_type` VALUES ('3', '1003', '2020-11-16 16:33:28');
INSERT INTO `alarm_resource_type` VALUES ('4', '1004', '2020-11-16 16:33:28');
INSERT INTO `alarm_resource_type` VALUES ('5', '1005', '2020-11-16 16:33:28');
INSERT INTO `alarm_resource_type` VALUES ('6', '1006', '2021-02-03 16:44:05');
INSERT INTO `alarm_resource_type` VALUES ('10', '1007', '2021-04-19 11:08:49');
INSERT INTO `alarm_resource_type` VALUES ('11', '1008', '2021-04-19 11:08:49');
INSERT INTO `alarm_resource_type` VALUES ('12', '1009', '2021-04-19 11:08:49');
INSERT INTO `alarm_resource_type` VALUES ('13', '1010', '2021-04-19 11:08:49');
INSERT INTO `alarm_resource_type` VALUES ('14', '1011', '2021-04-19 11:08:49');

-- ----------------------------
-- Table structure for `alarm_severity`
-- ----------------------------
DROP TABLE IF EXISTS `alarm_severity`;
CREATE TABLE `alarm_severity` (
  `severity_id` int(11) NOT NULL COMMENT '告警程度类型主键',
  `severity_name` varchar(255) DEFAULT NULL COMMENT '告警程度名称',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`severity_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of alarm_severity
-- ----------------------------
INSERT INTO `alarm_severity` VALUES ('1', '紧急告警', '2020-06-03 11:17:49');
INSERT INTO `alarm_severity` VALUES ('2', '主要告警', '2020-06-03 11:17:49');
INSERT INTO `alarm_severity` VALUES ('3', '次要告警', '2020-06-03 11:17:49');
INSERT INTO `alarm_severity` VALUES ('4', '通知告警', '2020-06-03 11:17:49');
INSERT INTO `alarm_severity` VALUES ('5', '未知告警', '2020-06-03 11:17:49');

-- ----------------------------
-- Table structure for `alarm_type`
-- ----------------------------
DROP TABLE IF EXISTS `alarm_type`;
CREATE TABLE `alarm_type` (
  `type_id` int(11) NOT NULL COMMENT '告警类型主键',
  `type_name` varchar(255) DEFAULT NULL COMMENT '告警类型名称',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of alarm_type
-- ----------------------------
INSERT INTO `alarm_type` VALUES ('1', '硬件故障', '2020-06-03 11:17:49');
INSERT INTO `alarm_type` VALUES ('2', '软件告警', '2020-06-03 11:17:49');
INSERT INTO `alarm_type` VALUES ('3', '链路传输', '2020-06-03 11:17:49');
INSERT INTO `alarm_type` VALUES ('4', '通知告警', '2019-08-26 17:19:35');
INSERT INTO `alarm_type` VALUES ('5', '设备告警', '2019-08-26 17:19:36');
INSERT INTO `alarm_type` VALUES ('6', '数据处理告警', '2019-08-26 17:19:37');
INSERT INTO `alarm_type` VALUES ('7', '服务质量告警', '2019-08-26 17:19:38');
INSERT INTO `alarm_type` VALUES ('8', '环境告警', '2019-08-26 17:19:39');
INSERT INTO `alarm_type` VALUES ('9', '完整性告警', '2019-08-26 17:19:40');
INSERT INTO `alarm_type` VALUES ('10', '安全告警', '2019-08-26 17:19:41');
INSERT INTO `alarm_type` VALUES ('11', '时区告警', '2019-08-26 17:19:42');
INSERT INTO `alarm_type` VALUES ('12', '操作告警', '2019-08-26 17:19:43');
INSERT INTO `alarm_type` VALUES ('13', '物理告警', '2019-08-26 17:19:44');
INSERT INTO `alarm_type` VALUES ('14', '信令告警', '2019-08-26 17:19:45');
INSERT INTO `alarm_type` VALUES ('15', '网络告警', '2019-08-26 17:19:46');
INSERT INTO `alarm_type` VALUES ('21', '板卡告警', '2019-08-26 17:19:47');
INSERT INTO `alarm_type` VALUES ('22', '接口告警', '2019-08-26 17:19:48');
INSERT INTO `alarm_type` VALUES ('31', '软件告警', '2019-08-26 17:19:48');
INSERT INTO `alarm_type` VALUES ('32', '进程重启', '2019-08-26 17:19:50');
INSERT INTO `alarm_type` VALUES ('41', '与阈值有关的告警', '2019-08-26 17:19:51');
INSERT INTO `alarm_type` VALUES ('42', '与阈值无关的告警', '2019-08-26 17:19:52');

-- ----------------------------
-- Table structure for `alarm_warehouse`
-- ----------------------------
DROP TABLE IF EXISTS `alarm_warehouse`;
CREATE TABLE `alarm_warehouse` (
  `alarm_code` varchar(255) NOT NULL,
  `resource_type_id` int(11) NOT NULL COMMENT '告警资源类别(外键)',
  `type_id` int(11) NOT NULL COMMENT '告警类型(外键)',
  `severity_id` int(11) NOT NULL COMMENT '告警等级(外键)',
  `alarm_description` varchar(255) DEFAULT NULL COMMENT '告警描述',
  `alarm_cause` varchar(255) DEFAULT NULL COMMENT '告警可能原因',
  `alarm_treatment` varchar(255) DEFAULT NULL COMMENT '处理建议',
  `limit_strategy` int(11) DEFAULT 0 COMMENT '处理限制策略:0表示不限流，1表示按次数限流，2表示按时间限流',
  `push_strategy` int(11) DEFAULT 0 COMMENT '推送限制策略:0表示不限制推送，1表示按次数推送，2表示按时间推送',
  `auto_clear_enable` int(11) DEFAULT 0 COMMENT '超时清除开关:0表示关闭，1表示开启',
  `auto_clear_timeout` int(11) DEFAULT 60 COMMENT '超时清除时间:以秒为单位',
  `alarm_suppress` int(11) DEFAULT 0 COMMENT '告警抑制:0表示关闭，1表示开启',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`alarm_code`) USING BTREE,
  KEY `1` (`resource_type_id`) USING BTREE,
  KEY `2` (`type_id`) USING BTREE,
  KEY `3` (`severity_id`) USING BTREE,
  CONSTRAINT `1` FOREIGN KEY (`resource_type_id`) REFERENCES `alarm_resource_type` (`resource_type_id`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`type_id`) REFERENCES `alarm_type` (`type_id`) ON DELETE CASCADE,
  CONSTRAINT `3` FOREIGN KEY (`severity_id`) REFERENCES `alarm_severity` (`severity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of alarm_warehouse
-- ----------------------------
INSERT INTO `alarm_warehouse` VALUES ('000001', '1', '14', '2', '设备失去连接(SNMP_ALARM_LINKLOST)', '失去连接', '1.检查网络 2.检查设备是否正常', '1', '1', '1', null, '0', '2020-12-28 09:22:33');
INSERT INTO `alarm_warehouse` VALUES ('000006', '1', '14', '4', '软件启动告警(SNMP_ALARM_NE_START)', '初始化或者发生重启', '检查新进程启动原因', '1', '1', '1', null, '60', '2020-12-28 09:22:33');
INSERT INTO `alarm_warehouse` VALUES ('000007', '1', '14', '4', '模块停止通知(SNMP_ALARM_NE_STOP)', '检查是否有人进行重启操作', '检查启动原因', '1', '1', '1', null, '0', '2020-12-28 09:22:33');
INSERT INTO `alarm_warehouse` VALUES ('000009', '1', '14', '2', '软件手动退出告警(OAM_ALARM_CODE_NE_LOSE)', '异常或者人为停止', '根据告警原因查找软件退出原因', '1', '1', '1', null, '0', '2020-12-28 09:22:33');
INSERT INTO `alarm_warehouse` VALUES ('000015', '1', '14', '2', 'CPU占用率过高(OAM_ALARM_CODE_THRESHOLD_CPU)', 'CPU占用率过高', '若持续时间过长需查看哪些进程占用', '1', '1', '1', null, '0', '2021-04-20 10:01:46');
INSERT INTO `alarm_warehouse` VALUES ('000016', '1', '14', '3', 'CPU占用率过高(OAM_ALARM_CODE_THRESHOLD_CPU)', 'CPU占用率过高', '若持续时间过长需查看哪些进程占用', '1', '1', '1', null, '0', '2021-04-19 10:49:10');
INSERT INTO `alarm_warehouse` VALUES ('000017', '1', '14', '2', '磁盘剩余空间不足(OAM_ALARM_CODE_THRESHOLD_DISK)', '可能为录音服务器容量不足', '进行文件清理或扩充空间', '1', '1', '1', null, '0', '2020-12-28 09:22:33');
INSERT INTO `alarm_warehouse` VALUES ('000110', '1', '14', '1', '板卡掉电告警', '板卡掉电', '检查板卡状态', '1', '1', '1', null, '0', '2021-04-19 10:48:17');
INSERT INTO `alarm_warehouse` VALUES ('111111', '1', '14', '2', 'AJ内部异常', 'AJ内部异常', '1.检查网络 2.检查内部设备是否正常', '1', '1', '1', null, '0', '2020-12-28 09:22:33');
INSERT INTO `alarm_warehouse` VALUES ('1234', '3', '1', '2', '', '', '', '1', '1', '1', '0', '0', '2021-07-23 15:58:33');
INSERT INTO `alarm_warehouse` VALUES ('200000', '5', '14', '1', 'IMS服务器内存占用率过高', '内存占用率过高', '若持续时间过长需查看哪些进程占用', '1', '1', '1', null, '0', '2021-08-07 11:09:48');
INSERT INTO `alarm_warehouse` VALUES ('200001', '5', '14', '1', '数字网关CPU占用率过高', 'CPU占用率过高', '若持续时间过长需查看哪些进程占用', '1', '1', '1', null, '0', '2020-12-28 09:22:33');
INSERT INTO `alarm_warehouse` VALUES ('200002', '5', '14', '1', '风扇告警', '风扇告警', '检查风扇', '1', '1', '1', null, '0', '2020-12-28 09:22:33');
INSERT INTO `alarm_warehouse` VALUES ('200003', '5', '14', '1', '电源告警', '电源告警', '检查电源', '1', '1', '1', null, '0', '2020-12-28 09:22:33');
INSERT INTO `alarm_warehouse` VALUES ('300000', '4', '14', '1', '接口网关板卡告警', '板卡掉电', '检查板卡', '1', '1', '1', null, '0', '2020-12-28 09:22:33');
