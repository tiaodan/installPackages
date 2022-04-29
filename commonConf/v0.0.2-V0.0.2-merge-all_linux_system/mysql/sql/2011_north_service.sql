/*
Navicat MySQL Data Transfer

Source Server         : 120.2.0.31
Source Server Version : 50726
Source Host           : 120.2.0.31:3306
Source Database       : 2011_north_service

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2022-01-20 21:43:01
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
INSERT INTO `collect_record` VALUES ('1', '2021-10-07 00:15:00');
INSERT INTO `collect_record` VALUES ('2', '2021-10-07 00:15:00');
INSERT INTO `collect_record` VALUES ('3', '2021-10-07 00:15:00');
INSERT INTO `collect_record` VALUES ('4', '2021-10-07 04:00:00');

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
INSERT INTO `station_info` VALUES ('01', '站点01', '站点01描述信息', '172.16.0.60');
INSERT INTO `station_info` VALUES ('02', '站点02', '站点02描述信息', '172.16.0.60');
