/*
Navicat MySQL Data Transfer

Source Server         : 120.2.0.21
Source Server Version : 50726
Source Host           : 120.2.0.21:3306
Source Database       : group

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2022-01-10 18:24:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ext_contact
-- ----------------------------
DROP TABLE IF EXISTS `ext_contact`;
CREATE TABLE `ext_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `unit_id` int(11) NOT NULL COMMENT '所属域id',
  `number` varchar(50) NOT NULL COMMENT '号码',
  `display_name` varchar(50) NOT NULL COMMENT '名称',
  `uri` varchar(50) NOT NULL COMMENT 'sip账号',
  `creator` varchar(50) NOT NULL COMMENT '创建者',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



-- ----------------------------
-- Table structure for ext_contact_entry
-- ----------------------------
DROP TABLE IF EXISTS `ext_contact_entry`;
CREATE TABLE `ext_contact_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `unit_id` int(11) NOT NULL COMMENT '所属域id',
  `number` varchar(50) NOT NULL COMMENT '号码',
  `display_name` varchar(50) NOT NULL COMMENT '名称',
  `uri` varchar(50) NOT NULL COMMENT 'sip账号',
  `parent_id` int(11) NOT NULL COMMENT '组id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `parent_id_number` (`number`,`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for group
-- ----------------------------
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` int(11) DEFAULT NULL COMMENT '上级id',
  `unit_id` int(11) NOT NULL COMMENT '单位id',
  `group_no` varchar(50) NOT NULL COMMENT '组号',
  `group_uri` varchar(50) NOT NULL COMMENT 'sip账号',
  `display_name` varchar(50) NOT NULL COMMENT '组名称',
  `max` smallint(6) NOT NULL DEFAULT '0' COMMENT '最大成员数量',
  `members` smallint(6) NOT NULL DEFAULT '0' COMMENT '内部成员数量',
  `ext_members` smallint(6) NOT NULL DEFAULT '0' COMMENT '外部成员数量',
  `creator` varchar(50) NOT NULL COMMENT '创建者',
  `service_type_id` tinyint(4) NOT NULL COMMENT '组业务类型id',
  `leaf` TINYINT(4) DEFAULT 0  NOT NULL COMMENT '是否包含子组',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `local_level` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_no_unique` (`group_no`)
) ENGINE=InnoDB AUTO_INCREMENT=5303 DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for group_entry
-- ----------------------------
DROP TABLE IF EXISTS `group_entry`;
CREATE TABLE `group_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` int(11) NOT NULL COMMENT '组id',
  `unit_id` int(11) NOT NULL COMMENT '单位id',
  `uri` varchar(50) NOT NULL COMMENT 'sip账号',
  `number` varchar(50) NOT NULL COMMENT '号码',
  `display_name` varchar(50) NOT NULL COMMENT '名称',
  `shake_halo` tinyint(4) NOT NULL COMMENT '是否遥晕 0 否 1 是',
  `shake_death` tinyint(4) NOT NULL COMMENT '是否遥毙 0 否 1 是',
  `device_name` varchar(10) NOT NULL COMMENT '设备类型名称',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `local_level` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `parent_id_number` (`parent_id`,`number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=800 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;


-- ----------------------------
-- Table structure for linkman
-- ----------------------------
DROP TABLE IF EXISTS `linkman`;
CREATE TABLE `linkman` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_no` varchar(17) NOT NULL COMMENT '用户号码',
  `linkman_no` varchar(17) NOT NULL COMMENT '联系人号码',
  `linkman_name` varchar(17) NOT NULL COMMENT '联系人名称',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `userNo_linkmanNo` (`user_no`,`linkman_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of linkman
-- ----------------------------

-- ----------------------------
-- Table structure for service_device
-- ----------------------------
DROP TABLE IF EXISTS `service_device`;
CREATE TABLE `service_device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_type_id` tinyint(4) NOT NULL,
  `device_type` varchar(10) CHARACTER SET latin1 NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of service_device
-- ----------------------------
INSERT INTO `service_device` VALUES ('1', '1', 'TR', '2021-09-14 15:48:58', '2021-09-14 15:48:58');
INSERT INTO `service_device` VALUES ('2', '1', 'DISP', '2021-09-14 15:49:16', '2021-09-14 15:49:16');
INSERT INTO `service_device` VALUES ('3', '1', 'SOP', '2021-09-14 15:49:32', '2021-09-14 15:49:32');
INSERT INTO `service_device` VALUES ('4', '1', 'SIP', '2021-09-14 15:49:47', '2021-09-14 15:49:47');
INSERT INTO `service_device` VALUES ('5', '1', 'IMS', '2021-09-14 15:49:59', '2021-09-14 15:49:59');
INSERT INTO `service_device` VALUES ('6', '2', 'TR', '2021-09-14 15:50:19', '2021-09-14 15:50:56');
INSERT INTO `service_device` VALUES ('7', '2', 'SOP', '2021-09-14 15:50:52', '2021-09-14 15:50:52');
INSERT INTO `service_device` VALUES ('8', '2', 'SIP', '2021-09-14 15:51:10', '2021-09-14 15:51:10');
INSERT INTO `service_device` VALUES ('9', '2', 'IMS', '2021-09-14 15:51:29', '2021-09-14 15:51:29');
INSERT INTO `service_device` VALUES ('10', '3', 'TR', '2021-09-14 15:51:37', '2021-09-14 15:51:37');
INSERT INTO `service_device` VALUES ('11', '4', 'JZ', '2021-09-14 15:52:28', '2021-09-18 14:32:02');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('5', 'CDMA');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('5', 'DISP');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('5', 'GSM');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('5', 'IMS');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('5', 'JZ');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('5', 'RADIO');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('5', 'SIP');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('5', 'SOP');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('5', 'TD');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('5', 'TETRA');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('5', 'TR');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('5', 'WCDMA');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('5', 'YD');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('6', 'DISP');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('6', 'TR');
INSERT INTO `service_device` (`service_type_id`, `device_type`) VALUES ('6', 'IMS');


-- ----------------------------
-- Table structure for service_type
-- ----------------------------
DROP TABLE IF EXISTS `service_type`;
CREATE TABLE `service_type` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cn_name` varchar(17) NOT NULL COMMENT '中文名称',
  `en_name` varchar(17) NOT NULL COMMENT '英文名称',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of service_type
-- ----------------------------
INSERT INTO `service_type` VALUES ('1', '动态组', 'dynamic', '2021-09-14 15:40:17', '2021-09-14 15:42:24');
INSERT INTO `service_type` VALUES ('2', '集群组', 'trunk', '2021-09-14 15:40:17', '2021-09-14 15:42:36');
INSERT INTO `service_type` VALUES ('3', '全呼组', 'groupall', '2021-09-14 15:40:17', '2021-09-14 15:42:48');
INSERT INTO `service_type` VALUES ('4', '基站动态组', 'dynamic_jz', '2021-09-18 14:37:46', '2021-09-18 14:37:46');
INSERT INTO `service_type` (`id`, `cn_name`, `en_name`) VALUES ('5', '常规组', 'normal');
INSERT INTO `service_type` (`id`, `cn_name`, `en_name`) VALUES ('6', '个人组', 'personal');


ALTER TABLE `group`.`group_entry` ADD CONSTRAINT `foreign_key_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `group`.`group`(`id`) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `group`.`ext_contact_entry` ADD CONSTRAINT `foreign_key_id` FOREIGN KEY (`parent_id`) REFERENCES `group`.`group`(`id`) ON UPDATE CASCADE ON DELETE CASCADE;
