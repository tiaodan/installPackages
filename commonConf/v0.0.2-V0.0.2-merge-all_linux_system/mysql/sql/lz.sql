/*
Navicat MySQL Data Transfer

Source Server         : 192.168.20.18
Source Server Version : 50541
Source Host           : 192.168.20.18:3306
Source Database       : lz

Target Server Type    : MYSQL
Target Server Version : 50541
File Encoding         : 65001

Date: 2021-11-06 11:28:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `test`
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `w_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `w_path` varchar(256) NOT NULL,
  `w_time_start` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `w_time_end` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `w_caller` varchar(20) DEFAULT NULL,
  `w_callee` varchar(20) DEFAULT NULL,
  `w_duration` int(11) DEFAULT NULL,
  `w_back2` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`w_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test
-- ----------------------------

-- ----------------------------
-- Table structure for `wave_path`
-- ----------------------------
DROP TABLE IF EXISTS `wave_path`;
CREATE TABLE `wave_path` (
  `w_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `w_path` varchar(256) NOT NULL,
  `w_time_start` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `w_time_end` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `w_caller` varchar(20) DEFAULT NULL,
  `w_callee` varchar(20) DEFAULT NULL,
  `w_duration` int(11) DEFAULT NULL,
  `w_back2` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`w_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wave_path
-- ----------------------------

