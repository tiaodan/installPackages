/*
 Navicat Premium Data Transfer

 Source Server         : 172.16.0.244(aj-home-测试)
 Source Server Type    : MySQL
 Source Server Version : 100309
 Source Host           : 172.16.0.244:3306
 Source Schema         : aj03_resource_service

 Target Server Type    : MySQL
 Target Server Version : 100309
 File Encoding         : 65001

 Date: 15/04/2022 15:10:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dev
-- ----------------------------
DROP TABLE IF EXISTS `dev`;
CREATE TABLE `dev`  (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type_id` int UNSIGNED NOT NULL COMMENT '设备类型ID',
  `serial_number` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '序列号',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备显示名称',
  `device_display_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备别名',
  `ctrl` int NULL DEFAULT 0 COMMENT ' 0未监控1监控',
  `status` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '状态: 故障（2），上线（1），下线（0）',
  `alarm` int NOT NULL DEFAULT 0 COMMENT '告警标志位(0无告警大于0有告警)',
  `manage_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理IP',
  `port` int NULL DEFAULT NULL COMMENT '端口',
  `snmp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'SNMP:{\"version\":\"snmpV2\",\"port\":161,\"OID\":null,\"read\":\"public\",\"write\":\"public\"}',
  `attr_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'attr_value:{\"12\":\"23r\",\"2\":\"8\"}',
  `cascade_device` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联级设备',
  `affiliation_company` int NULL DEFAULT NULL COMMENT '归属单位',
  `longitude` decimal(20, 10) NULL DEFAULT 116 COMMENT '经度',
  `latitude` decimal(20, 10) NULL DEFAULT 39 COMMENT '纬度',
  `dev_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备图片',
  `dev_jigui_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备机柜里的图',
  `line_type` int NULL DEFAULT NULL COMMENT '拓扑线类型(0直线,1折线)',
  `line_direction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '拓扑线方向',
  `cabinet_id` int UNSIGNED NULL DEFAULT NULL COMMENT '机柜外键',
  `cabinet_location` int NULL DEFAULT NULL COMMENT '所在机柜位置',
  `updatetime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间戳',
  `beam_id` int NULL DEFAULT 0 COMMENT '抗干扰设备波束号（0列表显示1不显示）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type_id_2`(`type_id`) USING BTREE,
  INDEX `dev_ibfk_2`(`cabinet_id`) USING BTREE,
  CONSTRAINT `dev_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `dev_type` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dev_ibfk_2` FOREIGN KEY (`cabinet_id`) REFERENCES `dev_cabinet` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dev
-- ----------------------------
INSERT INTO `dev` VALUES ('10-01-00-1011-01', 20, '1011', 'A局', 'A局', 1, 2, 1, '172.16.0.38', NULL, 'null', 'null', '', 0, 116.5000000000, 39.0000000000, 'static/nodeImg/ATCA.png', ' static/nodeImg/ATCA.png', NULL, NULL, NULL, NULL, '2022-04-15 15:06:47', 1);
INSERT INTO `dev` VALUES ('15-6434', 11, '15-6434', '网管服务器', NULL, 0, 1, 1, '172.16.0.244', NULL, 'null', 'null', '10-01-00-1011-01', 0, 116.4600000000, 39.9200000000, 'static/nodeImg/tyxzgl.png', 'static/nodeImg/tyxzgl.png', NULL, NULL, 2, 6, '2022-04-15 15:07:13', 0);
INSERT INTO `dev` VALUES ('20-8330', 10, '20-8330', '核心网服务器1', NULL, 1, 0, 0, '172.16.0.123', NULL, 'null', 'null', '10-01-00-1011-01', 0, 108.9500000000, 34.2700000000, 'static/nodeImg/ATCA.png', ' static/nodeImg/ATCA.png', NULL, NULL, NULL, NULL, '2022-04-06 11:24:20', 0);
INSERT INTO `dev` VALUES ('21-4617', 16, '21-4617', '机动式模拟', NULL, 1, 2, 1, '172.16.0.122', NULL, 'null', 'null', '10-01-00-1011-01', 0, 108.9500000000, 34.2700000000, NULL, NULL, NULL, NULL, NULL, NULL, '2022-04-15 15:09:43', 0);
INSERT INTO `dev` VALUES ('23-3882', 10, '23-3882', '核心网服务器2', NULL, 1, 0, 0, '172.16.0.124', NULL, 'null', 'null', '10-01-00-1011-01', 0, 108.9500000000, 34.2700000000, 'static/nodeImg/ATCA.png', ' static/nodeImg/ATCA.png', NULL, NULL, NULL, NULL, '2022-04-06 11:24:41', 0);
INSERT INTO `dev` VALUES ('43-3651', 10, '43-3651', '核心网服务器3', NULL, 1, 0, 0, '172.16.0.125', NULL, 'null', 'null', '10-01-00-1011-01', 0, 108.9500000000, 34.2700000000, 'static/nodeImg/ATCA.png', ' static/nodeImg/ATCA.png', NULL, NULL, NULL, NULL, '2022-04-06 11:25:04', 0);

-- ----------------------------
-- Table structure for dev_attr
-- ----------------------------
DROP TABLE IF EXISTS `dev_attr`;
CREATE TABLE `dev_attr`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_id` int UNSIGNED NOT NULL COMMENT '设备类型ID',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '属性名称',
  `display_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '显示名称',
  `device_attr` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '静态属性（0），动态属性（1），配置属性（2）',
  `device_attr_default` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '静态属性默认值',
  `updatetime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type_id_1`(`type_id`) USING BTREE,
  CONSTRAINT `dev_attr_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `dev_type` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dev_attr
-- ----------------------------

-- ----------------------------
-- Table structure for dev_cabinet
-- ----------------------------
DROP TABLE IF EXISTS `dev_cabinet`;
CREATE TABLE `dev_cabinet`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cabinet_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机柜名称',
  `cabinet_capacity` int NULL DEFAULT NULL COMMENT '机柜容量',
  `updatetime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dev_cabinet
-- ----------------------------
INSERT INTO `dev_cabinet` VALUES (1, '机柜1-1', 17, '2021-03-31 18:15:39');
INSERT INTO `dev_cabinet` VALUES (2, '机柜1-2', 17, '2021-03-31 18:15:39');

-- ----------------------------
-- Table structure for dev_card
-- ----------------------------
DROP TABLE IF EXISTS `dev_card`;
CREATE TABLE `dev_card`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `device_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备id',
  `unit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '板卡槽位号',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备/板卡名称',
  `device_type` int NULL DEFAULT NULL COMMENT '板卡类型',
  `status` int NULL DEFAULT NULL COMMENT '状态',
  `mac` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'MAC地址mac_s6',
  `mac2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'MAC地址mac_v6',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP',
  `ip2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP2',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `device_id`(`device_id`) USING BTREE,
  CONSTRAINT `device_id` FOREIGN KEY (`device_id`) REFERENCES `dev` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dev_card
-- ----------------------------

-- ----------------------------
-- Table structure for dev_card_info
-- ----------------------------
DROP TABLE IF EXISTS `dev_card_info`;
CREATE TABLE `dev_card_info`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `card_num` int NULL DEFAULT NULL,
  `slot_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `device_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `card_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `card_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `card_ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '板卡ip',
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `manager_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备ip',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dev_card_info
-- ----------------------------

-- ----------------------------
-- Table structure for dev_category
-- ----------------------------
DROP TABLE IF EXISTS `dev_category`;
CREATE TABLE `dev_category`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `category_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源类别名称',
  `updatetime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`, `category_id`) USING BTREE,
  INDEX `category_id`(`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dev_category
-- ----------------------------
INSERT INTO `dev_category` VALUES (10, '00-01-00', 'A局核心网设备', '2021-03-31 18:15:39');
INSERT INTO `dev_category` VALUES (11, '01-01-00', 'IMS服务器', '2021-03-31 18:15:39');
INSERT INTO `dev_category` VALUES (12, '02-01-00', '数据承载设备', '2021-03-31 18:15:39');
INSERT INTO `dev_category` VALUES (13, '03-01-00', '认证鉴权设备', '2021-03-31 18:15:39');
INSERT INTO `dev_category` VALUES (14, '04-01-00', '会话边界控制设备', '2021-03-31 18:15:39');
INSERT INTO `dev_category` VALUES (15, '05-01-00', '联想服务器', '2021-03-31 18:15:39');
INSERT INTO `dev_category` VALUES (16, '06-01-00', '机动式设备', '2021-03-31 18:15:39');
INSERT INTO `dev_category` VALUES (17, '07-01-00', 'IP密码机前交换机', '2021-03-31 18:15:39');
INSERT INTO `dev_category` VALUES (18, '08-01-00', 'IMS核心网', '2021-03-31 18:15:39');
INSERT INTO `dev_category` VALUES (19, '09-01-00', '电信鉴权服务器', '2021-03-31 18:15:39');
INSERT INTO `dev_category` VALUES (20, '10-01-00', 'A局', '2021-03-31 18:15:39');

-- ----------------------------
-- Table structure for dev_digital_gateway
-- ----------------------------
DROP TABLE IF EXISTS `dev_digital_gateway`;
CREATE TABLE `dev_digital_gateway`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `slot_id` int NULL DEFAULT NULL COMMENT '槽位号',
  `device_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备id',
  `card_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '板卡名称',
  `card_type` int NULL DEFAULT NULL COMMENT '板卡类型  1电口 2光口',
  `card_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `status` int NULL DEFAULT 1 COMMENT '状态',
  `alarm_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '告警码',
  `memory` int NULL DEFAULT NULL COMMENT '内存',
  `cpu` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cpu',
  `fan` int NULL DEFAULT NULL COMMENT '风扇',
  `power` int NULL DEFAULT NULL COMMENT '电源',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dev_digital_gateway
-- ----------------------------

-- ----------------------------
-- Table structure for dev_link
-- ----------------------------
DROP TABLE IF EXISTS `dev_link`;
CREATE TABLE `dev_link`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dev_from` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备id,链路上游设备,外键',
  `dev_to` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备id,链路下游设备,外键',
  `line_status` int(4) UNSIGNED ZEROFILL NULL DEFAULT 0000 COMMENT '链路状态(0下线,1正常,2故障)',
  `line_type` int NOT NULL COMMENT '拓扑线类型(0直线,1折线)',
  `line_direction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '拓扑线方向',
  `line_shears` int NULL DEFAULT NULL COMMENT '链路是否有箭头(0没有,1有)',
  `updatetime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `line_dev1`(`dev_from`) USING BTREE,
  INDEX `line_dev2`(`dev_to`) USING BTREE,
  CONSTRAINT `from` FOREIGN KEY (`dev_from`) REFERENCES `dev` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `to` FOREIGN KEY (`dev_to`) REFERENCES `dev` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dev_link
-- ----------------------------

-- ----------------------------
-- Table structure for dev_status_record
-- ----------------------------
DROP TABLE IF EXISTS `dev_status_record`;
CREATE TABLE `dev_status_record`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `port` int NULL DEFAULT NULL COMMENT '端口',
  `type_id` int NULL DEFAULT NULL COMMENT '类型ID',
  `status` int NULL DEFAULT 0 COMMENT '状态',
  `access_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接入时间',
  `exit_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退出时间',
  `update_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dev_status_record
-- ----------------------------
INSERT INTO `dev_status_record` VALUES (1, '172.16.0.34', 7900, 16, 0, '2021-03-15 11:26:12', '2021-03-16 11:26:12', '2021-03-16 11:26:12');
INSERT INTO `dev_status_record` VALUES (2, '172.16.0.40', 7900, 16, 0, '2021-03-17 11:26:12', '2021-03-18 11:26:12', '2021-03-16 11:26:12');
INSERT INTO `dev_status_record` VALUES (4, '172.16.0.122', NULL, 16, 1, '2022-04-06 16:38:41', NULL, '2022-04-06 16:38:41');

-- ----------------------------
-- Table structure for dev_task
-- ----------------------------
DROP TABLE IF EXISTS `dev_task`;
CREATE TABLE `dev_task`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `port` int NULL DEFAULT 0 COMMENT '端口',
  `access_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接入时间',
  `exit_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退出时间',
  `update_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dev_task
-- ----------------------------
INSERT INTO `dev_task` VALUES (1, '172.16.0.60', 0, '2021-09-26 11:27:00', '2021-09-29 11:27:00', '2021-09-26 15:10:09');
INSERT INTO `dev_task` VALUES (2, '172.16.0.215', 0, '2021-09-26 11:22:00', '2021-10-01 11:22:00', '2021-09-26 11:22:59');

-- ----------------------------
-- Table structure for dev_type
-- ----------------------------
DROP TABLE IF EXISTS `dev_type`;
CREATE TABLE `dev_type`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资源类别',
  `model` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备型号',
  `display_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',
  `manufacturer` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备厂商',
  `period` int UNSIGNED NULL DEFAULT NULL COMMENT '设备上报周期（秒）',
  `picture_url` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片选择',
  `device_url` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备URL',
  `updatetime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type_id_3`(`category_id`) USING BTREE,
  CONSTRAINT `dev_type_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `dev_category` (`category_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dev_type
-- ----------------------------
INSERT INTO `dev_type` VALUES (10, '00-01-00', '1001', 'A局核心网设备', 'sunkaisens', 2, 'static/nodeImg/ATCA.png', ' static/nodeImg/ATCA.png', '2021-03-31 18:15:39');
INSERT INTO `dev_type` VALUES (11, '01-01-00', '1002', 'IMS服务器', 'sunkaisens', 2, 'static/nodeImg/tyxzgl.png', 'static/nodeImg/tyxzgl.png', '2021-03-31 18:15:39');
INSERT INTO `dev_type` VALUES (12, '02-01-00', '1003', '数据承载设备(UPF服务器)', 'sunkaisens', 2, 'static/nodeImg/tyxzgl.png', 'static/nodeImg/tyxzgl.png', '2021-03-31 18:15:39');
INSERT INTO `dev_type` VALUES (13, '03-01-00', '1004', '认证鉴权设备(UDM服务器)', 'sunkaisens', 2, 'static/nodeImg/tyxzgl.png', 'static/nodeImg/tyxzgl.png', '2021-03-31 18:15:39');
INSERT INTO `dev_type` VALUES (14, '04-01-00', '1005', '会话边界控制设备', 'sunkaisens', 2, 'static/nodeImg/tyxzgl.png', 'static/nodeImg/tyxzgl.png', '2021-03-31 18:15:39');
INSERT INTO `dev_type` VALUES (15, '05-01-00', '1006', 'EPC核心网', 'sunkaisens', 2, 'static/nodeImg/tyxzgl.png', 'static/nodeImg/tyxzgl.png', '2021-03-31 18:15:39');
INSERT INTO `dev_type` VALUES (16, '06-01-00', '1007', '机动式设备', 'sunkaisens', 2, NULL, NULL, '2021-03-31 18:15:39');
INSERT INTO `dev_type` VALUES (17, '07-01-00', '1008', 'IP密码机前交换机', 'sunkaisens', 2, NULL, NULL, '2021-03-31 18:15:39');
INSERT INTO `dev_type` VALUES (18, '08-01-00', '1009', 'IMS核心网', 'sunkaisens', 2, NULL, NULL, '2021-03-31 18:15:39');
INSERT INTO `dev_type` VALUES (19, '09-01-00', '1010', '电信鉴权服务器', 'sunkaisens', 2, NULL, NULL, '2021-03-31 18:15:39');
INSERT INTO `dev_type` VALUES (20, '10-01-00', '1011', 'A局', 'sunkaisens', 2, NULL, NULL, '2021-03-31 18:15:39');

SET FOREIGN_KEY_CHECKS = 1;
