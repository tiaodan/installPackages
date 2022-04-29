/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50727
Source Host           : localhost:3306
Source Database       : myomc_cdma

Target Server Type    : MYSQL
Target Server Version : 50727
File Encoding         : 65001

Date: 2022-02-18 11:53:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskStartTime` varchar(255) DEFAULT NULL,
  `taskStopTime` varchar(255) DEFAULT NULL,
  `taskDescribe` varchar(255) DEFAULT NULL,
  `syn` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
