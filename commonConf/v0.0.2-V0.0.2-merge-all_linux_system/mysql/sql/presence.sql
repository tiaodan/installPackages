/*
Navicat MySQL Data Transfer

Source Server         : 192.1.1.60
Source Server Version : 50726
Source Host           : 192.1.1.60:3306
Source Database       : presence

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2021-09-22 17:08:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `register_record`
-- ----------------------------
DROP TABLE IF EXISTS `register_record`;
CREATE TABLE `register_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userNum` varchar(64) NOT NULL,
  `state` int(11) DEFAULT NULL,
  `domain` varchar(64) DEFAULT NULL,
  `imsi` varchar(64) DEFAULT NULL,
  `esn` varchar(64) DEFAULT NULL,
  `registerIp` varchar(64) DEFAULT NULL,
  `roaming` int(11) DEFAULT NULL,
  `deviceType` varchar(64) NOT NULL,
  `onlineTime` int(11) DEFAULT NULL,
  `updateTime` int(11) DEFAULT NULL,
  `offlineTime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2243 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of register_record
-- ----------------------------
