/*
Navicat MySQL Data Transfer

Source Server         : 192.1.1.79
Source Server Version : 50728
Source Host           : 192.1.1.79:3306
Source Database       : 2011_alarm_service

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2022-01-21 10:33:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `alarm_history`
-- ----------------------------
DROP TABLE IF EXISTS `alarm_history`;
CREATE TABLE `alarm_history` (
  `id` varchar(50) NOT NULL COMMENT '主键',
  `alarm_source` varchar(255) NOT NULL COMMENT '告警具体设备',
  `alarm_code` varchar(255) NOT NULL COMMENT '告警码(外键)',
  `port` int(10) DEFAULT NULL COMMENT '端口号',
  `alarm_unit` int(10) DEFAULT '0' COMMENT '板卡号',
  `alarm_number` bigint(10) DEFAULT NULL COMMENT '告警累计次数',
  `start_time` varchar(255) DEFAULT NULL COMMENT '发生时间',
  `last_update_time` varchar(255) DEFAULT NULL COMMENT '最后更新时间',
  `ack_status` varchar(255) DEFAULT NULL COMMENT '确认状态',
  `ack_time` varchar(255) DEFAULT NULL COMMENT '确认时间',
  `ack_user_name` varchar(255) DEFAULT NULL COMMENT '确认人',
  `ack_comments` varchar(255) DEFAULT NULL COMMENT '确认备注',
  `clear_time` varchar(255) DEFAULT NULL COMMENT '清除时间',
  `clear_user_name` varchar(255) DEFAULT NULL COMMENT '清除人',
  `clear_comments` varchar(255) DEFAULT NULL COMMENT '清除备注',
  `remark` text COMMENT '备注',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  `dev_source` varchar(255) DEFAULT NULL COMMENT '告警来源',
  PRIMARY KEY (`id`),
  KEY `5` (`alarm_code`) USING BTREE,
  KEY `time` (`start_time`) USING BTREE,
  KEY `resource` (`alarm_source`) USING BTREE,
  CONSTRAINT `alarm_history_ibfk_1` FOREIGN KEY (`alarm_code`) REFERENCES `alarm_warehouse` (`alarm_code`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alarm_history
-- ----------------------------

-- ----------------------------
-- Table structure for `alarm_now`
-- ----------------------------
DROP TABLE IF EXISTS `alarm_now`;
CREATE TABLE `alarm_now` (
  `id` varchar(50) NOT NULL COMMENT '主键',
  `alarm_source` varchar(255) NOT NULL COMMENT '告警具体设备',
  `alarm_code` varchar(255) NOT NULL COMMENT '告警码(外键)',
  `port` int(10) DEFAULT NULL COMMENT '端口号',
  `alarm_unit` int(10) DEFAULT '0' COMMENT '板卡号',
  `alarm_number` bigint(10) DEFAULT NULL COMMENT '告警累计次数',
  `start_time` varchar(255) DEFAULT NULL COMMENT '发生时间',
  `last_update_time` varchar(255) DEFAULT NULL COMMENT '最后更新时间',
  `ack_status` varchar(255) DEFAULT '0' COMMENT '确认状态',
  `ack_time` varchar(255) DEFAULT NULL COMMENT '确认时间',
  `ack_user_name` varchar(255) DEFAULT NULL COMMENT '确认人',
  `ack_comments` varchar(255) DEFAULT NULL COMMENT '确认备注',
  `remark` text COMMENT '备注',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  `dev_source` varchar(255) DEFAULT NULL COMMENT '告警来源',
  PRIMARY KEY (`id`),
  KEY `4` (`alarm_code`) USING BTREE,
  CONSTRAINT `alarm_now_ibfk_1` FOREIGN KEY (`alarm_code`) REFERENCES `alarm_warehouse` (`alarm_code`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alarm_now
-- ----------------------------

-- ----------------------------
-- Table structure for `alarm_relations`
-- ----------------------------
DROP TABLE IF EXISTS `alarm_relations`;
CREATE TABLE `alarm_relations` (
  `alarm_code_owner` varchar(255) NOT NULL COMMENT '本机告警码',
  `alarm_code_higher` varchar(255) NOT NULL COMMENT '上级告警码',
  `is_open` int(2) DEFAULT '0' COMMENT '是否打开0关闭1打开',
  `updatetime` varchar(255) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`alarm_code_owner`),
  KEY `alarm_code_higher` (`alarm_code_higher`) USING BTREE,
  CONSTRAINT `alarm_relations_ibfk_1` FOREIGN KEY (`alarm_code_owner`) REFERENCES `alarm_warehouse` (`alarm_code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `alarm_relations_ibfk_2` FOREIGN KEY (`alarm_code_higher`) REFERENCES `alarm_warehouse` (`alarm_code`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alarm_relations
-- ----------------------------
INSERT INTO `alarm_relations` VALUES ('000001', '000011', '1', null);
INSERT INTO `alarm_relations` VALUES ('000100', '000100', '1', null);
INSERT INTO `alarm_relations` VALUES ('1', '1', '1', null);
INSERT INTO `alarm_relations` VALUES ('10001', '10001', '1', null);
INSERT INTO `alarm_relations` VALUES ('10002', '10002', '1', null);
INSERT INTO `alarm_relations` VALUES ('10003', '10003', '1', null);
INSERT INTO `alarm_relations` VALUES ('10004', '10004', '1', null);
INSERT INTO `alarm_relations` VALUES ('10005', '10005', '1', null);
INSERT INTO `alarm_relations` VALUES ('10006', '10006', '1', null);
INSERT INTO `alarm_relations` VALUES ('10007', '10007', '1', null);
INSERT INTO `alarm_relations` VALUES ('10008', '10008', '1', null);
INSERT INTO `alarm_relations` VALUES ('10009', '10009', '1', null);
INSERT INTO `alarm_relations` VALUES ('10010', '10010', '1', null);
INSERT INTO `alarm_relations` VALUES ('10011', '10011', '1', null);
INSERT INTO `alarm_relations` VALUES ('10012', '10012', '1', null);
INSERT INTO `alarm_relations` VALUES ('15', '15', '1', null);
INSERT INTO `alarm_relations` VALUES ('16', '16', '1', null);
INSERT INTO `alarm_relations` VALUES ('17', '17', '1', null);
INSERT INTO `alarm_relations` VALUES ('77', '77', '1', null);
INSERT INTO `alarm_relations` VALUES ('88', '88', '1', null);

-- ----------------------------
-- Table structure for `alarm_resource_type`
-- ----------------------------
DROP TABLE IF EXISTS `alarm_resource_type`;
CREATE TABLE `alarm_resource_type` (
  `resource_type_id` int(10) NOT NULL COMMENT '资源类型主键',
  `resource_name` varchar(255) DEFAULT NULL COMMENT '资源类型名称',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`resource_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alarm_resource_type
-- ----------------------------
INSERT INTO `alarm_resource_type` VALUES ('1', '基站', '2019-12-11 18:48:37');
INSERT INTO `alarm_resource_type` VALUES ('2', '基站', '2019-12-11 18:48:37');
INSERT INTO `alarm_resource_type` VALUES ('3', '交换', '2019-12-11 18:48:37');
INSERT INTO `alarm_resource_type` VALUES ('4', '交换', '2019-12-11 18:48:37');
INSERT INTO `alarm_resource_type` VALUES ('5', '电路域接口单元', '2019-12-11 18:48:37');
INSERT INTO `alarm_resource_type` VALUES ('6', '综合网管单元', '2019-12-11 18:48:37');
INSERT INTO `alarm_resource_type` VALUES ('7', '指挥调度单元', '2019-12-11 18:48:37');
INSERT INTO `alarm_resource_type` VALUES ('8', 'ATCA(核心网)', '2019-12-11 18:48:37');
INSERT INTO `alarm_resource_type` VALUES ('9', '军用移动通信系统设备', '2019-12-11 18:48:38');
INSERT INTO `alarm_resource_type` VALUES ('10', '公安PDT交换设备', '2019-12-11 18:48:37');
INSERT INTO `alarm_resource_type` VALUES ('11', '军用PSTN设备', '2019-12-11 18:48:37');
INSERT INTO `alarm_resource_type` VALUES ('12', '网管', '2019-12-11 18:48:37');

-- ----------------------------
-- Table structure for `alarm_severity`
-- ----------------------------
DROP TABLE IF EXISTS `alarm_severity`;
CREATE TABLE `alarm_severity` (
  `severity_id` int(10) NOT NULL COMMENT '告警程度类型主键',
  `severity_name` varchar(255) DEFAULT NULL COMMENT '告警程度名称',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`severity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alarm_severity
-- ----------------------------
INSERT INTO `alarm_severity` VALUES ('1', '严重告警', '2019-08-26 17:19:35');
INSERT INTO `alarm_severity` VALUES ('2', '主要告警', '2019-08-26 17:19:36');
INSERT INTO `alarm_severity` VALUES ('3', '次要告警', '2019-08-26 17:19:37');
INSERT INTO `alarm_severity` VALUES ('4', '警告告警', '2019-08-26 17:19:35');
INSERT INTO `alarm_severity` VALUES ('5', '不确定告警', '2019-08-26 17:19:24');

-- ----------------------------
-- Table structure for `alarm_type`
-- ----------------------------
DROP TABLE IF EXISTS `alarm_type`;
CREATE TABLE `alarm_type` (
  `type_id` int(10) NOT NULL COMMENT '告警类型主键',
  `type_name` varchar(255) DEFAULT NULL COMMENT '告警类型名称',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alarm_type
-- ----------------------------
INSERT INTO `alarm_type` VALUES ('1', '通讯告警', '2019-08-26 17:19:35');
INSERT INTO `alarm_type` VALUES ('2', '设备告警', '2019-08-26 17:19:36');
INSERT INTO `alarm_type` VALUES ('3', '数据处理告警', '2019-08-26 17:19:37');
INSERT INTO `alarm_type` VALUES ('4', '服务质量告警', '2019-08-26 17:19:38');
INSERT INTO `alarm_type` VALUES ('5', '环境告警', '2019-08-26 17:19:39');
INSERT INTO `alarm_type` VALUES ('6', '完整性告警', '2019-08-26 17:19:40');
INSERT INTO `alarm_type` VALUES ('7', '安全告警', '2019-08-26 17:19:41');
INSERT INTO `alarm_type` VALUES ('8', '时区告警', '2019-08-26 17:19:42');
INSERT INTO `alarm_type` VALUES ('9', '操作告警', '2019-08-26 17:19:43');
INSERT INTO `alarm_type` VALUES ('10', '物理告警', '2019-08-26 17:19:44');
INSERT INTO `alarm_type` VALUES ('11', '信令告警', '2019-08-26 17:19:45');
INSERT INTO `alarm_type` VALUES ('12', '网络告警', '2019-08-26 17:19:46');
INSERT INTO `alarm_type` VALUES ('13', '链路告警', '2019-08-26 17:19:52');
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
  `resource_type_id` int(10) NOT NULL COMMENT '告警资源类别(外键)',
  `type_id` int(10) NOT NULL COMMENT '告警类型(外键)',
  `severity_id` int(10) NOT NULL COMMENT '告警等级(外键)',
  `alarm_description` varchar(255) DEFAULT NULL COMMENT '告警描述',
  `alarm_cause` varchar(255) DEFAULT NULL COMMENT '告警可能原因',
  `alarm_treatment` varchar(255) DEFAULT NULL COMMENT '处理建议',
  `limit_strategy` int(10) DEFAULT '0' COMMENT '处理限制策略:0表示不限流，1表示按次数限流，2表示按时间限流',
  `push_strategy` int(10) DEFAULT '0' COMMENT '推送限制策略:0表示不限制推送，1表示按次数推送，2表示按时间推送',
  `auto_clear_enable` int(10) DEFAULT '0' COMMENT '超时清除开关:0表示关闭，1表示开启',
  `auto_clear_timeout` int(10) DEFAULT '60' COMMENT '超时清除时间:以秒为单位',
  `alarm_suppress` int(10) DEFAULT '0' COMMENT '告警抑制:0表示关闭，1表示开启',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  `level` int(10) DEFAULT NULL,
  `owner` int(10) DEFAULT NULL,
  `auth` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`alarm_code`),
  KEY `1` (`resource_type_id`) USING BTREE,
  KEY `2` (`type_id`) USING BTREE,
  KEY `3` (`severity_id`) USING BTREE,
  CONSTRAINT `alarm_warehouse_ibfk_1` FOREIGN KEY (`resource_type_id`) REFERENCES `alarm_resource_type` (`resource_type_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `alarm_warehouse_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `alarm_type` (`type_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `alarm_warehouse_ibfk_3` FOREIGN KEY (`severity_id`) REFERENCES `alarm_severity` (`severity_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alarm_warehouse
-- ----------------------------
INSERT INTO `alarm_warehouse` VALUES ('000001', '1', '1', '2', '基站失去连接', '失去连接', '1.检查网络 2.检查设备是否正常', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('000011', '1', '1', '2', '下级网管中有基站失去连接', '失去连接', '1.检查网络 2.检查设备是否正常', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('000100', '3', '21', '1', '板卡掉电告警', '板卡掉电', '检查板卡状态', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('000111', '1', '1', '2', '下级网管中有基站失去连接', '失去连接', '1.检查网络 2.检查设备是否正常', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('1', '3', '1', '2', '设备失去连接', '失去连接', '1.检查网络 2.检查设备是否正常', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('10001', '1', '2', '1', '驻波比异常告警', '驻波比异常告警', '检查基站', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('10002', '1', '13', '1', 'BBU和RRU链路断开告警', 'BBU和RRU链路断开告警', '检查基站', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('10003', '1', '2', '1', 'BBU风扇告警', 'BBU风扇告警', '检查基站', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('10004', '1', '2', '1', 'BBU电源告警', 'BBU电源告警', '检查基站', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('10005', '1', '2', '1', 'BBU时钟异常告警', 'BBU时钟异常告警', '检查基站', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('10006', '1', '2', '1', '控制信道异常告警', '控制信道异常告警', '检查基站', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('10007', '1', '2', '1', 'RRU低噪干扰告警', 'RRU低噪干扰告警', '检查基站', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('10008', '1', '2', '1', 'RRU北斗失锁告警', 'RRU北斗失锁告警', '检查基站', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('10009', '1', '2', '1', 'RRU功放过流告警', 'RRU功放过流告警', '检查基站', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('10010', '1', '2', '1', 'RRU功放过温告警', 'RRU功放过温告警', '检查基站', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('10011', '1', '2', '1', '载波异常告警', '载波异常告警', '检查基站', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('10012', '1', '2', '1', 'BBU主控板告警（1/2）', 'BBU主控板告警（1/2）', '检查基站', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('15', '3', '41', '2', 'CPU占用率过高', 'CPU占用率过高', '若持续时间过长需查看哪些进程占用', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('16', '3', '41', '3', '内存占用率过高', '内存占用率过高', '若持续时间过长需查看哪些进程占用', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('17', '3', '41', '2', '磁盘剩余空间不足', '可能为服务器容量不足', '进行文件清理或扩充空间', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('77', '3', '31', '1', '进程告警', '进程掉线', '检查进程', '1', '1', '1', null, '0', null, null, '1', null);
INSERT INTO `alarm_warehouse` VALUES ('88', '3', '13', '1', 'PDT链路故障', 'PDT链路故障', '检查PDT链路状况', '1', '1', '1', null, '0', null, null, '1', null);
