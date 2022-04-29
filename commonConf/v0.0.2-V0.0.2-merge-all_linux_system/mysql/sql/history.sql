/*
Navicat MySQL Data Transfer

Source Server         : 192.1.1.60
Source Server Version : 50726
Source Host           : 192.1.1.60:3306
Source Database       : history

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2021-09-22 17:07:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `historyCall`
-- ----------------------------
DROP TABLE IF EXISTS `historyCall`;
CREATE TABLE `historyCall` (
  `index` int(255) NOT NULL AUTO_INCREMENT,
  `beginTime` datetime DEFAULT NULL,
  `direction` varchar(255) DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `length` varchar(255) DEFAULT NULL,
  `remoteNumber` varchar(255) DEFAULT NULL,
  `peerNumber` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`index`)
) ENGINE=MyISAM AUTO_INCREMENT=4251 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of historyCall
-- ----------------------------


-- ----------------------------
-- Table structure for `historyMessage`
-- ----------------------------
DROP TABLE IF EXISTS `historyMessage`;
CREATE TABLE `historyMessage` (
  `index` int(255) NOT NULL AUTO_INCREMENT,
  `localMsgID` varchar(255) NOT NULL,
  `remote` varchar(24) NOT NULL,
  `peer` varchar(24) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `timeStamp` varchar(255) DEFAULT NULL,
  `msgType` int(24) DEFAULT NULL,
  `state` int(24) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `isout` int(24) DEFAULT NULL,
  `isRead` int(24) DEFAULT NULL,
  PRIMARY KEY (`index`)
) ENGINE=MyISAM AUTO_INCREMENT=3918 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of historyMessage
-- ----------------------------


