/*
Navicat MySQL Data Transfer

Source Server         : 192.2.2.12
Source Server Version : 50726
Source Host           : 192.2.2.12:3306
Source Database       : hss_proxy_service

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2021-09-26 17:11:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `hss_relation`
-- ----------------------------
DROP TABLE IF EXISTS `hss_relation`;
CREATE TABLE `hss_relation` (
  `imsi` varchar(32) NOT NULL DEFAULT '',
  `mdn` varchar(32) NOT NULL DEFAULT '',
  `belong` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`imsi`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of hss_relation
-- ----------------------------

