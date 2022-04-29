/*
Navicat MySQL Data Transfer

Source Server         : 172.16.0.200（aj好的测试环境）
Source Server Version : 50505
Source Host           : 172.16.0.200:3306
Source Database       : aj03_north_service

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2022-02-18 17:21:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `collect_record`
-- ----------------------------
DROP TABLE IF EXISTS `collect_record`;
CREATE TABLE `collect_record` (
  `id` int(11) NOT NULL,
  `offLineTime` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of collect_record
-- ----------------------------
INSERT INTO `collect_record` VALUES ('1', '2021-09-30 16:45:00');
INSERT INTO `collect_record` VALUES ('2', '2021-09-30 16:45:00');
INSERT INTO `collect_record` VALUES ('3', '2021-09-30 16:45:00');
INSERT INTO `collect_record` VALUES ('4', '2021-10-05 04:00:00');

-- ----------------------------
-- Table structure for `device_relation`
-- ----------------------------
DROP TABLE IF EXISTS `device_relation`;
CREATE TABLE `device_relation` (
  `device_type` int(11) NOT NULL,
  `system_id` int(11) NOT NULL,
  PRIMARY KEY (`device_type`,`system_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of device_relation
-- ----------------------------
INSERT INTO `device_relation` VALUES ('1', '1');
INSERT INTO `device_relation` VALUES ('3', '9');
INSERT INTO `device_relation` VALUES ('4', '15');
INSERT INTO `device_relation` VALUES ('5', '17');
INSERT INTO `device_relation` VALUES ('12', '8');

-- ----------------------------
-- Table structure for `station_info`
-- ----------------------------
DROP TABLE IF EXISTS `station_info`;
CREATE TABLE `station_info` (
  `station_id` varchar(255) NOT NULL,
  `station_name` varchar(255) DEFAULT NULL,
  `station_desc` varchar(255) DEFAULT NULL,
  `station_ip` varchar(255) NOT NULL,
  PRIMARY KEY (`station_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of station_info
-- ----------------------------
INSERT INTO `station_info` VALUES ('01', '站点01', '站点01描述信息', '10.106.0.200');
INSERT INTO `station_info` VALUES ('02', '站点02', '站点02描述信息', '10.106.0.200');
