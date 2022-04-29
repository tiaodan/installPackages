/*
Navicat MySQL Data Transfer

Source Server         : 192.1.1.156
Source Server Version : 50728
Source Host           : 192.1.1.156:3306
Source Database       : myomc

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2021-05-21 14:52:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `alarm`
-- ----------------------------
DROP TABLE IF EXISTS `alarm`;
CREATE TABLE `alarm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alarm
-- ----------------------------

-- ----------------------------
-- Table structure for `brbussiness`
-- ----------------------------
DROP TABLE IF EXISTS `brbussiness`;
CREATE TABLE `brbussiness` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `enable` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of brbussiness
-- ----------------------------
INSERT INTO `brbussiness` VALUES ('1', 'default', '1');
INSERT INTO `brbussiness` VALUES ('2', 'network', '1');

-- ----------------------------
-- Table structure for `card`
-- ----------------------------
DROP TABLE IF EXISTS `card`;
CREATE TABLE `card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `cardNum` int(11) NOT NULL DEFAULT '0',
  `slotId` int(11) NOT NULL DEFAULT '0',
  `ip` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of card
-- ----------------------------
INSERT INTO `card` VALUES ('2', 'zhuban', '0', '1', '127.0.0.1');

-- ----------------------------
-- Table structure for `common`
-- ----------------------------
DROP TABLE IF EXISTS `common`;
CREATE TABLE `common` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of common
-- ----------------------------

-- ----------------------------
-- Table structure for `config`
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `sole` tinyint(4) DEFAULT '0',
  `moduleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `moduleId` (`moduleId`),
  CONSTRAINT `config_ibfk_1` FOREIGN KEY (`moduleId`) REFERENCES `module` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES ('1', 'application.properties', null, null, '0', '21');
INSERT INTO `config` VALUES ('2', 'application.properties', null, null, '0', '22');
INSERT INTO `config` VALUES ('3', 'conf/groupCluster.conf', null, null, '1', '23');
INSERT INTO `config` VALUES ('4', 'conf/Service.properties', null, null, '0', '23');
INSERT INTO `config` VALUES ('5', 'conf/Syn.properties', null, null, '0', '23');
INSERT INTO `config` VALUES ('6', 'conf/imserver.properties', null, null, '0', '24');
INSERT INTO `config` VALUES ('7', 'conf/imCluster.conf', null, null, '1', '24');
INSERT INTO `config` VALUES ('8', 'conf/sipstack.properties', null, null, '0', '24');
INSERT INTO `config` VALUES ('9', 'conf/devicetype.properties', null, null, '0', '25');
INSERT INTO `config` VALUES ('10', 'conf/expires.properties', null, null, '0', '25');
INSERT INTO `config` VALUES ('11', 'conf/presence.properties', null, null, '0', '25');
INSERT INTO `config` VALUES ('12', '/conf/presenceCluster.conf', null, null, '1', '25');
INSERT INTO `config` VALUES ('13', 'conf/DcsgXCAPProxy.properties', null, null, '0', '26');
INSERT INTO `config` VALUES ('14', 'conf/deviceType.properties', null, null, '0', '26');
INSERT INTO `config` VALUES ('15', 'conf/logprinter.properties', null, null, '0', '26');
INSERT INTO `config` VALUES ('16', 'conf/datadispatcher.properties', null, null, '0', '27');
INSERT INTO `config` VALUES ('17', 'conf/ddsCluster.conf', null, null, '1', '27');
INSERT INTO `config` VALUES ('18', 'conf/agw.properties', null, null, '0', '28');
INSERT INTO `config` VALUES ('19', 'conf/agwCluster.conf', null, null, '1', '28');
INSERT INTO `config` VALUES ('20', 'conf/appserver.properties', null, null, '0', '28');
INSERT INTO `config` VALUES ('24', 'hss.config', null, null, '0', '256');
INSERT INTO `config` VALUES ('25', 'bill.config', null, null, '0', '257');

-- ----------------------------
-- Table structure for `configUserPriority`
-- ----------------------------
DROP TABLE IF EXISTS `configUserPriority`;
CREATE TABLE `configUserPriority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  `enable` int(11) NOT NULL,
  `userType` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of configUserPriority
-- ----------------------------
INSERT INTO `configUserPriority` VALUES ('1', '1', '1', '1', '0');
INSERT INTO `configUserPriority` VALUES ('2', '2', '2', '1', '0');
INSERT INTO `configUserPriority` VALUES ('3', '3', '3', '1', '0');
INSERT INTO `configUserPriority` VALUES ('4', '4', '4', '1', '0');
INSERT INTO `configUserPriority` VALUES ('5', '5', '5', '1', '0');
INSERT INTO `configUserPriority` VALUES ('6', '6', '6', '1', '0');
INSERT INTO `configUserPriority` VALUES ('7', '7', '7', '1', '0');
INSERT INTO `configUserPriority` VALUES ('8', '8', '8', '1', '0');
INSERT INTO `configUserPriority` VALUES ('9', '9', '9', '1', '0');
INSERT INTO `configUserPriority` VALUES ('10', '10', '10', '1', '0');
INSERT INTO `configUserPriority` VALUES ('11', '11', '11', '1', '0');
INSERT INTO `configUserPriority` VALUES ('12', '12', '12', '1', '0');
INSERT INTO `configUserPriority` VALUES ('13', '13', '13', '1', '0');
INSERT INTO `configUserPriority` VALUES ('14', '14', '14', '1', '0');
INSERT INTO `configUserPriority` VALUES ('15', '15', '15', '1', '0');

-- ----------------------------
-- Table structure for `entity`
-- ----------------------------
DROP TABLE IF EXISTS `entity`;
CREATE TABLE `entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `instId` int(11) NOT NULL,
  `status` int(11) DEFAULT '0',
  `type` int(11) DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `moduleId` int(11) DEFAULT NULL,
  `cardId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `moduleId` (`moduleId`),
  KEY `cardId` (`cardId`),
  CONSTRAINT `entity_ibfk_1` FOREIGN KEY (`moduleId`) REFERENCES `module` (`id`),
  CONSTRAINT `entity_ibfk_2` FOREIGN KEY (`cardId`) REFERENCES `card` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of entity
-- ----------------------------
INSERT INTO `entity` VALUES ('1', 'webrtc', '1', '0', '1', '0.0.1', '21', '2');
INSERT INTO `entity` VALUES ('2', 'recoding', '1', '0', '1', '0.0.1', '22', '2');
INSERT INTO `entity` VALUES ('3', 'group', '1', '0', '1', '1.1.0', '23', '2');
INSERT INTO `entity` VALUES ('4', 'imseerver', '1', '0', '1', '2.2.0', '24', '2');
INSERT INTO `entity` VALUES ('5', 'presence', '1', '0', '1', '2.3.1', '25', '2');
INSERT INTO `entity` VALUES ('6', 'dcsg', '1', '0', '1', '1.5.0', '26', '2');
INSERT INTO `entity` VALUES ('7', 'dds', '1', '0', '1', '2.2.0', '27', '2');
INSERT INTO `entity` VALUES ('8', 'agw', '1', '0', '1', '2.3.1', '28', '2');
INSERT INTO `entity` VALUES ('14', 'hss', '1', '0', '1', 'R.220', '256', '2');
INSERT INTO `entity` VALUES ('15', 'bill', '1', '0', '1', 'R.', '257', '2');

-- ----------------------------
-- Table structure for `hssBusiness`
-- ----------------------------
DROP TABLE IF EXISTS `hssBusiness`;
CREATE TABLE `hssBusiness` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `i18n` varchar(25) NOT NULL,
  `basic` tinyint(4) NOT NULL DEFAULT '1',
  `enable` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hssBusiness
-- ----------------------------
INSERT INTO `hssBusiness` VALUES ('1', 'groupdata', 'GroupData', '1', '1');
INSERT INTO `hssBusiness` VALUES ('2', 'shortMsg', 'MessageTraffic', '1', '1');
INSERT INTO `hssBusiness` VALUES ('3', 'internationality', 'InternationalTraffic', '1', '1');
INSERT INTO `hssBusiness` VALUES ('4', 'callWaitting', 'CallTraffic', '1', '1');
INSERT INTO `hssBusiness` VALUES ('5', 'threeWay', 'Three-way-calling', '1', '1');
INSERT INTO `hssBusiness` VALUES ('6', 'callInLimit', 'Incoming-Call-Barring', '1', '1');
INSERT INTO `hssBusiness` VALUES ('7', 'callOutLimit', 'Outgoing-Call-Barring', '1', '1');
INSERT INTO `hssBusiness` VALUES ('8', 'pairNet', 'Dual-Network-Business', '1', '1');
INSERT INTO `hssBusiness` VALUES ('9', 'secrecy', 'Secrecy-Business', '1', '1');
INSERT INTO `hssBusiness` VALUES ('10', 'callerAllow', 'callerAllow', '1', '1');
INSERT INTO `hssBusiness` VALUES ('11', 'callerHide', 'callerHide', '1', '1');
INSERT INTO `hssBusiness` VALUES ('12', 'ims', 'IMSInformation', '0', '1');
INSERT INTO `hssBusiness` VALUES ('13', 'jtyw', 'ListeningBusiness', '0', '1');
INSERT INTO `hssBusiness` VALUES ('14', 'fzye', 'GroupingBusiness', '0', '1');
INSERT INTO `hssBusiness` VALUES ('15', 'ddyw', 'ScheduingBusiness', '0', '1');
INSERT INTO `hssBusiness` VALUES ('16', 'bcyw', 'SupplementaryServices', '0', '1');
INSERT INTO `hssBusiness` VALUES ('17', 'groupInfo', 'GroupMessage', '0', '1');
INSERT INTO `hssBusiness` VALUES ('18', 'auc', 'AUC', '0', '1');
INSERT INTO `hssBusiness` VALUES ('19', 'tft', 'TFTSetting', '0', '1');
INSERT INTO `hssBusiness` VALUES ('20', 'zdxx', 'TerminalInformation', '0', '1');
INSERT INTO `hssBusiness` VALUES ('21', 'epc', 'EPCInfo', '0', '1');

-- ----------------------------
-- Table structure for `hssDeviceType`
-- ----------------------------
DROP TABLE IF EXISTS `hssDeviceType`;
CREATE TABLE `hssDeviceType` (
  `id` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `enable` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hssDeviceType
-- ----------------------------
INSERT INTO `hssDeviceType` VALUES ('0', 'UNKNOW', '1');
INSERT INTO `hssDeviceType` VALUES ('1', 'SIP', '1');
INSERT INTO `hssDeviceType` VALUES ('2', 'CDMA', '1');
INSERT INTO `hssDeviceType` VALUES ('3', 'GSM', '1');
INSERT INTO `hssDeviceType` VALUES ('4', 'WCDMA', '1');
INSERT INTO `hssDeviceType` VALUES ('5', 'LTE/TD', '1');
INSERT INTO `hssDeviceType` VALUES ('6', 'YD', '1');
INSERT INTO `hssDeviceType` VALUES ('7', 'TR', '1');
INSERT INTO `hssDeviceType` VALUES ('8', 'DISP', '1');
INSERT INTO `hssDeviceType` VALUES ('9', 'TETRA', '1');
INSERT INTO `hssDeviceType` VALUES ('10', 'ANALOG', '1');
INSERT INTO `hssDeviceType` VALUES ('11', 'RADIO', '1');
INSERT INTO `hssDeviceType` VALUES ('12', 'IMS', '1');
INSERT INTO `hssDeviceType` VALUES ('13', 'LTE-CPE', '1');

-- ----------------------------
-- Table structure for `hssViewItem`
-- ----------------------------
DROP TABLE IF EXISTS `hssViewItem`;
CREATE TABLE `hssViewItem` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `enable` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hssViewItem
-- ----------------------------
INSERT INTO `hssViewItem` VALUES ('0', 'IMSI', '1');
INSERT INTO `hssViewItem` VALUES ('1', 'MDN', '1');
INSERT INTO `hssViewItem` VALUES ('2', 'DeviceName', '1');
INSERT INTO `hssViewItem` VALUES ('3', 'SpeechCodec', '1');
INSERT INTO `hssViewItem` VALUES ('4', 'MscAddr', '1');
INSERT INTO `hssViewItem` VALUES ('5', 'GateWayAddr', '1');
INSERT INTO `hssViewItem` VALUES ('6', 'bmNum', '1');
INSERT INTO `hssViewItem` VALUES ('7', 'UeDestroy', '1');
INSERT INTO `hssViewItem` VALUES ('8', 'LastUpdateTime', '1');
INSERT INTO `hssViewItem` VALUES ('9', 'Update', '1');
INSERT INTO `hssViewItem` VALUES ('10', 'UeSwoon', '1');

-- ----------------------------
-- Table structure for `hssVoiceType`
-- ----------------------------
DROP TABLE IF EXISTS `hssVoiceType`;
CREATE TABLE `hssVoiceType` (
  `id` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `enable` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hssVoiceType
-- ----------------------------
INSERT INTO `hssVoiceType` VALUES ('0', 'PCMU', '1');
INSERT INTO `hssVoiceType` VALUES ('8', 'PCMA', '1');
INSERT INTO `hssVoiceType` VALUES ('18', 'G_729', '1');
INSERT INTO `hssVoiceType` VALUES ('35', 'EVRC', '1');
INSERT INTO `hssVoiceType` VALUES ('38', 'AHELP', '1');
INSERT INTO `hssVoiceType` VALUES ('39', 'ACELP', '1');
INSERT INTO `hssVoiceType` VALUES ('40', 'AMR', '1');
INSERT INTO `hssVoiceType` VALUES ('42', 'VC40', '1');
INSERT INTO `hssVoiceType` VALUES ('43', 'VC24', '1');
INSERT INTO `hssVoiceType` VALUES ('44', 'VC12', '1');
INSERT INTO `hssVoiceType` VALUES ('45', 'VC06', '1');

-- ----------------------------
-- Table structure for `ipDns`
-- ----------------------------
DROP TABLE IF EXISTS `ipDns`;
CREATE TABLE `ipDns` (
  `cardNum` int(11) NOT NULL,
  `eth` varchar(20) NOT NULL,
  `ip` varchar(20) NOT NULL,
  `dnsStr` text,
  PRIMARY KEY (`cardNum`,`eth`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ipDns
-- ----------------------------

-- ----------------------------
-- Table structure for `item`
-- ----------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `val` text,
  `description` varchar(255) DEFAULT '',
  `formtype` varchar(50) DEFAULT 'textbox',
  `min` int(11) DEFAULT NULL,
  `max` int(11) DEFAULT NULL,
  `minLen` int(11) NOT NULL DEFAULT '0',
  `maxLen` int(11) NOT NULL DEFAULT '9999',
  `multiline` tinyint(4) NOT NULL DEFAULT '0',
  `required` tinyint(4) NOT NULL DEFAULT '1',
  `orderNum` int(11) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `configId` int(11) DEFAULT NULL,
  `relevanceId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parentId` (`parentId`),
  KEY `configId` (`configId`),
  KEY `relevanceId` (`relevanceId`),
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `item` (`id`),
  CONSTRAINT `item_ibfk_2` FOREIGN KEY (`configId`) REFERENCES `config` (`id`),
  CONSTRAINT `item_ibfk_3` FOREIGN KEY (`relevanceId`) REFERENCES `relevance` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=595 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of item
-- ----------------------------
INSERT INTO `item` VALUES ('1', 'server.port', '8090', 'server.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('2', 'spring.messages.basename', 'i18n/messages', 'spring.messages.basename', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('3', 'server.tomcat.uri-encoding', 'UTF-8', 'server.tomcat.uri-encoding', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('4', 'server.tomcat.max-http-header-size', '10240000', 'server.tomcat.max-http-header-size', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('5', 'spring.http.encoding.charset', 'UTF-8', 'spring.http.encoding.charset', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('6', 'spring.http.encoding.enabled', 'true', 'spring.http.encoding.enabled', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('7', 'spring.http.encoding.force', 'true', 'spring.http.encoding.force', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('8', 'spring.messages.encoding', 'UTF-8', 'spring.messages.encoding', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('9', 'spring.servlet.multipart.max-file-size', '100MB', 'spring.servlet.multipart.max-file-size', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('10', 'spring.servlet.multipart.max-request-size', '1000MB', 'spring.servlet.multipart.max-request-size', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('11', 'spring.thymeleaf.encoding', 'UTF-8', 'spring.thymeleaf.encoding', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('12', 'spring.thymeleaf.cache', 'false', 'spring.thymeleaf.cache', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('13', 'mqttIp', '192.1.1.101', 'mqttIp', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('14', 'mqttPort', '1883', 'mqttPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('15', 'localIp', '192.1.1.101', 'localIp', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('16', 'localPort', '5081', 'localPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('17', 'localDomain', 'test.com', 'localDomain', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('18', 'pcscfDomain', '192.1.1.200', 'pcscfDomain', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('19', 'pcscfPort', '4060', 'pcscfPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('20', 'registerPeriod', '60', 'registerPeriod', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('21', 'imserverIp', '192.1.1.101', 'imserverIp', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('22', 'imserverPort', '5090', 'imserverPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('23', 'imserverHttpPort', '8010', 'imserverHttpPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('24', 'gisIp', '192.1.1.101', 'gisIp', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('25', 'gisPort', '8090', 'gisPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('26', 'cacheExpireSecond', '100', 'cacheExpireSecond', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('27', 'CPIMDatePattern', 'yyyy-MM-dd HH:mm:ss.SSS Z', 'CPIMDatePattern', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('28', 'SIPDatePattern', 'EEE, dd MMM yyyy HH:mm:ss zzz', 'SIPDatePattern', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('29', 'server.ssl.key-store', 'server.keystore', 'server.ssl.key-store', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('30', 'server.ssl.key-alias', 'tomcat', 'server.ssl.key-alias', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('31', 'server.ssl.enabled', 'true', 'server.ssl.enabled', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('32', 'server.ssl.key-store-password', '123456', 'server.ssl.key-store-password', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('33', 'server.ssl.key-store-type', 'JKS', 'server.ssl.key-store-type', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('34', 'voiceMeetingPrefix', '123', 'voiceMeetingPrefix', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('35', 'kmsUrl', 'ws://192.1.1.101:8888/kurento', 'kmsUrl', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('36', 'kmsIp', '192.1.1.101', 'kmsIp', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('37', 'groupAllCall', '60999', 'groupAllCall', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('38', 'broadcastAll', '66050', 'broadcastAll', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('39', 'mybatis.mapper-locations', 'classpath:mapping/*.mapper.xml', 'mybatis.mapper-locations', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('40', 'spring.datasource.db1.jdbc-url', 'jdbc:mysql://192.1.1.101/history', 'spring.datasource.db1.jdbc-url', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('41', 'spring.datasource.db1.username', 'root', 'spring.datasource.db1.username', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('42', 'spring.datasource.db1.password', 'sunkaisens', 'spring.datasource.db1.password', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('43', 'spring.datasource.db1.driver-class-name', 'com.mysql.jdbc.Driver', 'spring.datasource.db1.driver-class-name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('44', 'spring.datasource.db2.jdbc-url', 'jdbc:mysql://192.1.1.200/lz', 'spring.datasource.db2.jdbc-url', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('45', 'spring.datasource.db2.username', 'root', 'spring.datasource.db2.username', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('46', 'spring.datasource.db2.password', 'sunkaisens', 'spring.datasource.db2.password', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('47', 'spring.datasource.db2.driver-class-name', 'com.mysql.jdbc.Driver', 'spring.datasource.db2.driver-class-name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('48', 'pagehelper.helper-dialect', 'mysql', 'pagehelper.helper-dialect', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('49', 'pagehelper.reasonable', 'true', 'pagehelper.reasonable', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('50', 'pagehelper.support-methods-arguments', 'true', 'pagehelper.support-methods-arguments', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('51', 'pagehelper.params', 'countSql', 'pagehelper.params', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('52', 'lzIp', '192.1.1.200', 'lzIp', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('53', 'localLzPort', '9123', 'localLzPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('54', 'liPort', '9654', 'liPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('55', 'server.port', '8021', 'server.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '2', null);
INSERT INTO `item` VALUES ('56', 'server.servlet.context-path', '/recoding', 'server.servlet.context-path', 'textbox', null, null, '1', '9999', '0', '1', null, null, '2', null);
INSERT INTO `item` VALUES ('57', 'spring.resources.static-locations', 'classpath:/static/uploadFile,file:/root/.NE/26-1/LiMediafiles', 'spring.resources.static-locations', 'textbox', null, null, '1', '9999', '0', '1', null, null, '2', null);
INSERT INTO `item` VALUES ('58', 'localip', 'test.com', 'localip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '2', null);
INSERT INTO `item` VALUES ('59', 'spring.servlet.multipart.max-file-size', '100MB', 'spring.servlet.multipart.max-file-size', 'textbox', null, null, '1', '9999', '0', '1', null, null, '2', null);
INSERT INTO `item` VALUES ('60', 'spring.servlet.multipart.max-request-size', '1000MB', 'spring.servlet.multipart.max-request-size', 'textbox', null, null, '1', '9999', '0', '1', null, null, '2', null);
INSERT INTO `item` VALUES ('61', 'conf/groupCluster.conf', '172.16.0.223:7800', 'conf/groupCluster.conf', 'textbox', null, null, '1', '9999', '1', '0', null, null, '3', null);
INSERT INTO `item` VALUES ('62', 'group.number.pre', '0', 'group.number.pre', 'textbox', null, null, '1', '9999', '0', '1', null, null, '4', null);
INSERT INTO `item` VALUES ('63', 'publicgroup.number.pre', '01', 'publicgroup.number.pre', 'textbox', null, null, '1', '9999', '0', '1', null, null, '4', null);
INSERT INTO `item` VALUES ('64', 'servicegroup.number.pre', '02', 'servicegroup.number.pre', 'textbox', null, null, '1', '9999', '0', '1', null, null, '4', null);
INSERT INTO `item` VALUES ('65', 'globalgroup.number.pre', '03', 'globalgroup.number.pre', 'textbox', null, null, '1', '9999', '0', '1', null, null, '4', null);
INSERT INTO `item` VALUES ('66', 'publicgroup.member.unique', 'true', 'publicgroup.member.unique', 'textbox', null, null, '1', '9999', '0', '1', null, null, '4', null);
INSERT INTO `item` VALUES ('67', 'group.max.system', '200', 'group.max.system', 'textbox', null, null, '1', '9999', '0', '1', null, null, '4', null);
INSERT INTO `item` VALUES ('68', 'group.max.default', '200', 'group.max.default', 'textbox', null, null, '1', '9999', '0', '1', null, null, '4', null);
INSERT INTO `item` VALUES ('69', 'Switch', 'on', 'Switch', 'textbox', null, null, '1', '9999', '0', '1', null, null, '5', null);
INSERT INTO `item` VALUES ('70', 'Force', 'false', 'Force', 'textbox', null, null, '1', '9999', '0', '1', null, null, '5', null);
INSERT INTO `item` VALUES ('71', 'dns.server.ip', '192.1.1.101', 'dns.server.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('72', 'imserver.release', 'false', 'imserver.release', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('73', 'server.domain', 'test.com', 'server.domain', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('74', 'server.pubnet', 'false', 'server.pubnet', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('75', 'server.im.pubnet.addr', 'test.com', 'server.im.pubnet.addr', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('76', 'server.im.name', 'imserver', 'server.im.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('77', 'server.im.addr', 'appserver.test.com', 'server.im.addr', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('78', 'server.im.sip.port', '5090', 'server.im.sip.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('79', 'server.im.sip.transport', 'udp', 'server.im.sip.transport', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('80', 'server.im.http.port', '8010', 'server.im.http.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('81', 'server.cscf.name', 'orig', 'server.cscf.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('82', 'server.cscf.addr', 'scscf.test.com', 'server.cscf.addr', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('83', 'server.cscf.port', '6060', 'server.cscf.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('84', 'server.group.addr', 'appserver.test.com', 'server.group.addr', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('85', 'server.group.port', '1000', 'server.group.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('86', 'snmp.open', 'false', 'snmp.open', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('87', 'server.snmp.addr', 'test.com', 'server.snmp.addr', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('88', 'server.snmp.port', '1620', 'server.snmp.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('89', 'server.sop.addr', 'appserver.test.com', 'server.sop.addr', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('90', 'server.sop.port', '5050', 'server.sop.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('91', 'jgroups.cluster.name', 'im', 'jgroups.cluster.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('92', 'jgroups.local.bind_port', '7830', 'jgroups.local.bind_port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('93', 'jgroups.network.beefy.level', '1', 'jgroups.network.beefy.level', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('94', 'expires.imserver.historyMessage', '15', 'expires.imserver.historyMessage', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('95', 'expires.subscribe.group', '600', 'expires.subscribe.group', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('96', 'http.option.heartbeat', '60', 'http.option.heartbeat', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('97', 'device.im.1', 'DISP', 'device.im.1', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('98', 'device.im.2', 'IMS', 'device.im.2', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('99', 'terminal.inside.prefix.1', '0', 'terminal.inside.prefix.1', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('100', 'terminal.inside.prefix.2', '1', 'terminal.inside.prefix.2', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('101', 'terminal.inside.prefix.3', '2', 'terminal.inside.prefix.3', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('102', 'terminal.inside.prefix.4', '3', 'terminal.inside.prefix.4', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('103', 'terminal.inside.prefix.5', '4', 'terminal.inside.prefix.5', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('104', 'terminal.inside.prefix.6', '5', 'terminal.inside.prefix.6', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('105', 'terminal.inside.prefix.7', '6', 'terminal.inside.prefix.7', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('106', 'terminal.inside.prefix.8', '7', 'terminal.inside.prefix.8', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('107', 'terminal.inside.prefix.9', '8', 'terminal.inside.prefix.9', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('108', 'terminal.inside.prefix.10', '9', 'terminal.inside.prefix.10', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('109', 'number.prefix.sop', '10658', 'number.prefix.sop', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('110', 'number.prefix.tr', '10659', 'number.prefix.tr', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('111', 'dispatcher.number.chief', '1000', 'dispatcher.number.chief', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('112', 'imserver.filetransfer.dir', 'files', 'imserver.filetransfer.dir', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('113', 'imserver.message.max', '10000', 'imserver.message.max', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('114', 'imserver.file.freeusage', '100M', 'imserver.file.freeusage', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('115', 'welcome.open', 'false', 'welcome.open', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('116', 'welcome.content', '\\u60A8\\u597D\\uFF1A\\u60A8\\u5DF2\\u8FDB\\u5165\\u9633\\u5149\\u51EF\\u8BAF\\u65E0\\u7EBF\\u7EFC\\u5408\\u4E1A\\u52A1\\u901A\\u4FE1\\u7F51\\u7EDC\\uFF0C\\u5982\\u9700\\u5E2E\\u52A9\\u8BF7\\u62E8\\u62531000', 'welcome.content', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('117', 'oam.local.ip', 'oam.localhost.test.com', 'oam.local.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('118', 'oam.local.port', '6125', 'oam.local.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('119', 'oam.remote.ip', 'oam.localhost.test.com', 'oam.remote.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('120', 'oam.remote.port', '9999', 'oam.remote.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('121', 'oam.status.send', 'true', 'oam.status.send', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('122', 'oam.status.period', '60', 'oam.status.period', 'textbox', null, null, '1', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('123', 'conf/imCluster.conf', '192.1.1.101:7830', 'conf/imCluster.conf', 'textbox', null, null, '1', '9999', '1', '0', null, null, '7', null);
INSERT INTO `item` VALUES ('124', 'javax.sip.STACK_NAME', 'com.sunkaisens.sipstack', 'javax.sip.STACK_NAME', 'textbox', null, null, '1', '9999', '0', '1', null, null, '8', null);
INSERT INTO `item` VALUES ('125', 'javax.sip.ROUTER_PATH', 'com.google.code.rfc3263.DefaultRouter', 'javax.sip.ROUTER_PATH', 'textbox', null, null, '1', '9999', '0', '1', null, null, '8', null);
INSERT INTO `item` VALUES ('126', 'javax.sip.AUTOMATIC_DIALOG_SUPPORT', 'ON', 'javax.sip.AUTOMATIC_DIALOG_SUPPORT', 'textbox', null, null, '1', '9999', '0', '1', null, null, '8', null);
INSERT INTO `item` VALUES ('127', 'devicetype.register.check.1', 'DISP', 'devicetype.register.check.1', 'textbox', null, null, '1', '9999', '0', '1', null, null, '9', null);
INSERT INTO `item` VALUES ('128', 'devicetype.register.check.2', 'IMS', 'devicetype.register.check.2', 'textbox', null, null, '1', '9999', '0', '1', null, null, '9', null);
INSERT INTO `item` VALUES ('129', 'device.support.presenceData.1', 'DISP', 'device.support.presenceData.1', 'textbox', null, null, '1', '9999', '0', '1', null, null, '9', null);
INSERT INTO `item` VALUES ('130', 'device.support.presenceData.2', 'SOP', 'device.support.presenceData.2', 'textbox', null, null, '1', '9999', '0', '1', null, null, '9', null);
INSERT INTO `item` VALUES ('131', 'device.support.presenceData.3', 'ANY', 'device.support.presenceData.3', 'textbox', null, null, '1', '9999', '0', '1', null, null, '9', null);
INSERT INTO `item` VALUES ('132', 'device.support.publishData.1', 'DISP', 'device.support.publishData.1', 'textbox', null, null, '1', '9999', '0', '1', null, null, '9', null);
INSERT INTO `item` VALUES ('133', 'device.support.publishData.2', 'SOP', 'device.support.publishData.2', 'textbox', null, null, '1', '9999', '0', '1', null, null, '9', null);
INSERT INTO `item` VALUES ('134', 'expires.register.default', '300', 'expires.register.default', 'textbox', null, null, '1', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('135', 'expires.register.response.plus', '0', 'expires.register.response.plus', 'textbox', null, null, '1', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('136', 'expires.subscribe.presence.min', '60', 'expires.subscribe.presence.min', 'textbox', null, null, '1', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('137', 'expires.subscribe.presence.max', '3600', 'expires.subscribe.presence.max', 'textbox', null, null, '1', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('138', 'expires.subscribe.group', '600', 'expires.subscribe.group', 'textbox', null, null, '1', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('139', 'expires.publish.min', '1800', 'expires.publish.min', 'textbox', null, null, '1', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('140', 'expires.publish.agw.tick', '130', 'expires.publish.agw.tick', 'textbox', null, null, '1', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('141', 'group.http.options', '60', 'group.http.options', 'textbox', null, null, '1', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('142', 'presence.release', 'false', 'presence.release', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('143', 'dns.server.ip', '192.1.1.101', 'dns.server.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('144', 'server.domain', 'test.com', 'server.domain', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('145', 'server.presence.name', 'presence', 'server.presence.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('146', 'server.presence.addr', 'appserver.test.com', 'server.presence.addr', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('147', 'server.presence.port', '5065', 'server.presence.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('148', 'server.group.ip', 'appserver.test.com', 'server.group.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('149', 'server.group.port.http', '1000', 'server.group.port.http', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('150', 'scscf.name', 'scscf', 'scscf.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('151', 'scscf.ip', 'test.com', 'scscf.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('152', 'scscf.port', '6060', 'scscf.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('153', 'sop.name', 'sop', 'sop.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('154', 'sop.ip', 'appserver.test.com', 'sop.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('155', 'sop.port', '5050', 'sop.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('156', 'sop.usernum.prefix', '10658', 'sop.usernum.prefix', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('157', 'jgroups.cluster.name', 'presence', 'jgroups.cluster.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('158', 'jgroups.local.bind_port', '7810', 'jgroups.local.bind_port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('159', 'jgroups.network.beefy.level', '0', 'jgroups.network.beefy.level', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('160', 'agw.useragent', 'Sunkaisens-AGW', 'agw.useragent', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('161', 'server.support.rls', 'false', 'server.support.rls', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('162', 'oam.local.ip', 'oam.localhost.test.com', 'oam.local.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('163', 'oam.local.port', '6125', 'oam.local.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('164', 'oam.remote.ip', 'oam.localhost.test.com', 'oam.remote.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('165', 'oam.remote.port', '9999', 'oam.remote.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('166', 'oam.status.send', 'true', 'oam.status.send', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('167', 'oam.status.period', '60', 'oam.status.period', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('168', 'mqtt.enable', 'true', 'mqtt.enable', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('169', 'mqtt.ip', '192.1.1.101', 'mqtt.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('170', 'mqtt.port', '1883', 'mqtt.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('171', 'mqtt.clientId', 'Presence@192.1.1.101', 'mqtt.clientId', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('172', 'mqtt.server.name', 'emqx@127.0.0.1', 'mqtt.server.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('173', 'exprise.control', 'false', 'exprise.control', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('174', 'unKnown.period', '60', 'unKnown.period', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('175', 'parsePerson', 'false', 'parsePerson', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('176', 'registerExpire', '60', 'registerExpire', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('177', 'autoControl', 'false', 'autoControl', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('178', 'hss.ip1', '127.0.0.1', 'hss.ip1', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('179', 'hss.port1', '8888', 'hss.port1', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('180', 'hss.ip2', '127.0.0.1', 'hss.ip2', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('181', 'hss.port2', '9999', 'hss.port2', 'textbox', null, null, '1', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('182', '/conf/presenceCluster.conf', '192.1.1.101:7810\n', '/conf/presenceCluster.conf', 'textbox', null, null, '1', '9999', '1', '0', null, null, '12', null);
INSERT INTO `item` VALUES ('183', 'dns.server.ip', '192.1.1.101', 'dns.server.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('184', 'dcsgxcapproxy.release', 'false', 'dcsgxcapproxy.release', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('185', 'local.hostname', 'dcsgxcapproxy', 'local.hostname', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('186', 'local.domain', 'test.com', 'local.domain', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('187', 'local.ip', 'appserver.test.com', 'local.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('188', 'local.port.sip', '5085', 'local.port.sip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('189', 'local.port.cc', '9906', 'local.port.cc', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('190', 'groupserver.domain', 'test.com', 'groupserver.domain', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('191', 'groupserver.ip', 'appserver.test.com', 'groupserver.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('192', 'groupserver.http.port', '1000', 'groupserver.http.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('193', 'scscf.domain', 'scscf.test.com', 'scscf.domain', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('194', 'scscf.port', '6060', 'scscf.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('195', 'subscribe.expires.default', '300', 'subscribe.expires.default', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('196', 'http.option.heartbeat', '60', 'http.option.heartbeat', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('197', 'oam.local.ip', 'oam.localhost.test.com', 'oam.local.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('198', 'oam.local.port', '6036', 'oam.local.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('199', 'oam.remote.ip', 'oam.localhost.test.com', 'oam.remote.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('200', 'oam.remote.port', '9999', 'oam.remote.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('201', 'oam.status.send', 'true', 'oam.status.send', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('202', 'oam.status.period', '60', 'oam.status.period', 'textbox', null, null, '1', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('203', 'UNKNOWN', '0', 'UNKNOWN', 'textbox', null, null, '1', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('204', 'SIP', '1', 'SIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('205', 'CDMA', '2', 'CDMA', 'textbox', null, null, '1', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('206', 'GSM', '3', 'GSM', 'textbox', null, null, '1', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('207', 'WCDMA', '4', 'WCDMA', 'textbox', null, null, '1', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('208', 'TD', '5', 'TD', 'textbox', null, null, '1', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('209', 'YD', '6', 'YD', 'textbox', null, null, '1', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('210', 'TR', '7', 'TR', 'textbox', null, null, '1', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('211', 'DISP', '8', 'DISP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('212', 'TETRA', '9', 'TETRA', 'textbox', null, null, '1', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('213', 'ANALOG', '10', 'ANALOG', 'textbox', null, null, '1', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('214', 'RADIO', '11', 'RADIO', 'textbox', null, null, '1', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('215', 'IMS', '12', 'IMS', 'textbox', null, null, '1', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('216', 'log.group_status.enable', 'false', 'log.group_status.enable', 'textbox', null, null, '1', '9999', '0', '1', null, null, '15', null);
INSERT INTO `item` VALUES ('217', 'log.group_status.period', '30', 'log.group_status.period', 'textbox', null, null, '1', '9999', '0', '1', null, null, '15', null);
INSERT INTO `item` VALUES ('218', 'dns.server.ip', '192.1.1.101', 'dns.server.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('219', 'dds.release', 'false', 'dds.release', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('220', 'dds.sipName', 'dds', 'dds.sipName', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('221', 'server.domain', 'test.com', 'server.domain', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('222', 'local.ip', 'appserver.test.com', 'local.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('223', 'local.sip.port', '5095', 'local.sip.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('224', 'remoteGroup.ip', 'appserver.test.com', 'remoteGroup.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('225', 'remoteGroup.port', '1000', 'remoteGroup.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('226', 'group.subscribe.expires', '300', 'group.subscribe.expires', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('227', 'group.options.period', '60', 'group.options.period', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('228', 'cscf.ip', 'test.com', 'cscf.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('229', 'cscf.server.port', '6060', 'cscf.server.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('230', 'sop.ip', 'appserver.test.com', 'sop.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('231', 'sop.port', '5050', 'sop.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('232', 'sop.prefix', '10658', 'sop.prefix', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('233', 'jgroups.cluster.name', 'dds', 'jgroups.cluster.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('234', 'jgroups.local.bind_port', '7840', 'jgroups.local.bind_port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('235', 'jgroups.network.beefy.level', '0', 'jgroups.network.beefy.level', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('236', 'terminal.sendgps.defaultPeriod', '5', 'terminal.sendgps.defaultPeriod', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('237', 'oam.local.ip', 'oam.localhost.test.com', 'oam.local.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('238', 'oam.local.port', '6039', 'oam.local.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('239', 'oam.remote.ip', 'oam.localhost.test.com', 'oam.remote.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('240', 'oam.remote.port', '9999', 'oam.remote.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('241', 'oam.status.send', 'true', 'oam.status.send', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('242', 'oam.status.period', '60', 'oam.status.period', 'textbox', null, null, '1', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('243', 'conf/ddsCluster.conf', '172.16.0.223:7840\n', 'conf/ddsCluster.conf', 'textbox', null, null, '1', '9999', '1', '0', null, null, '17', null);
INSERT INTO `item` VALUES ('244', 'dns.server.ip', '192.1.1.101', 'dns.server.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('245', 'agw.release', 'false', 'agw.release', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('246', 'agw.useragent', 'Sunkaisens-AGW', 'agw.useragent', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('247', 'agw.name', 'agw', 'agw.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('248', 'agw.domain', 'test.com', 'agw.domain', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('249', 'agw.addr', 'appserver.test.com', 'agw.addr', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('250', 'agw.port', '5070', 'agw.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('251', 'access.switch.addr.1', 'test.com', 'access.switch.addr.1', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('252', 'publish.interval.milliseconds', '20', 'publish.interval.milliseconds', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('253', 'options.period.seconds', '60', 'options.period.seconds', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('254', 'redis.enable', 'true', 'redis.enable', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('255', 'redis.ip', 'appserver.test.com', 'redis.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('256', 'redis.port', '6379', 'redis.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('257', 'jgroups.cluster.name', 'agw', 'jgroups.cluster.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('258', 'jgroups.local.bind_port', '7820', 'jgroups.local.bind_port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('259', 'jgroups.network.beefy.level', '0', 'jgroups.network.beefy.level', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('260', 'oam.local.ip', 'oam.localhost.test.com', 'oam.local.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('261', 'oam.local.port', '6034', 'oam.local.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('262', 'oam.remote.ip', 'oam.localhost.test.com', 'oam.remote.ip', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('263', 'oam.remote.port', '9999', 'oam.remote.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('264', 'oam.status.send', 'true', 'oam.status.send', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('265', 'oam.status.period', '60', 'oam.status.period', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('266', 'sipop.port', '15060', 'sipop.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('267', 'agw.register.expire', '150', 'agw.register.expire', 'textbox', null, null, '1', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('268', 'conf/agwCluster.conf', '172.16.0.223:7820', 'conf/agwCluster.conf', 'textbox', null, null, '1', '9999', '1', '0', null, null, '19', null);
INSERT INTO `item` VALUES ('269', 'server.presence.enable', 'true', 'server.presence.enable', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('270', 'server.presence.name', 'presence', 'server.presence.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('271', 'server.presence.addr', 'appserver.test.com', 'server.presence.addr', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('272', 'server.presence.port', '5065', 'server.presence.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('273', 'server.im.name', 'im', 'server.im.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('274', 'server.im.enable', 'true', 'server.im.enable', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('275', 'server.im.addr', 'appserver.test.com', 'server.im.addr', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('276', 'server.im.port', '5090', 'server.im.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('277', 'server.group.name', 'group', 'server.group.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('278', 'server.group.enable', 'false', 'server.group.enable', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('279', 'server.group.addr', 'appserver.test.com', 'server.group.addr', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('280', 'server.group.port', '5075', 'server.group.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('281', 'server.dds.name', 'dds', 'server.dds.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('282', 'server.dds.enable', 'true', 'server.dds.enable', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('283', 'server.dds.addr', 'appserver.test.com', 'server.dds.addr', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('284', 'server.dds.port', '5095', 'server.dds.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('285', 'server.wx.name', 'wx', 'server.wx.name', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('286', 'server.wx.enable', 'true', 'server.wx.enable', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('287', 'server.wx.addr', '172.16.0.223', 'server.wx.addr', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('288', 'server.wx.port', '5060', 'server.wx.port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '20', null);
INSERT INTO `item` VALUES ('484', 'LocalIP', 'local.sk', 'LocalIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('485', 'LocalPort', '9904', 'LocalPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('486', 'RemoteSLFIP', 'local.sk', 'RemoteSLFIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('487', 'RemoteSLFPort', '9904', 'RemoteSLFPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('488', 'LocalOAMIP', 'oam.sk', 'LocalOAMIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('489', 'LocalOAMPort', '9915', 'LocalOAMPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('490', 'RemoteOAMIP', 'oam.sk', 'RemoteOAMIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('491', 'RemoteOAMPort', '6123', 'RemoteOAMPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('492', 'RemoteAppIP', 'local.sk', 'RemoteAppIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('493', 'RemoteAppPort', '9999', 'RemoteAppPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('494', 'RemoteApp2IP', 'local.sk', 'RemoteApp2IP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('495', 'RemoteApp2Port', '9999', 'RemoteApp2Port', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('496', 'RemoteMapIP', 'local.sk', 'RemoteMapIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('497', 'RemoteMapPort', '9906', 'RemoteMapPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('498', 'RemoteAuCFunc', 'NO', 'RemoteAuCFunc', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('499', 'RemoteBillFunc', 'YES', 'RemoteBillFunc', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('500', 'RemoteBCIP', 'local.sk', 'RemoteBCIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('501', 'RemoteBCPort', '9916', 'RemoteBCPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('502', 'TrSecFunc', 'YES', 'TrSecFunc', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('503', 'RemoteSecIP', 'local.sk', 'RemoteSecIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('504', 'RemoteSecPort', '9999', 'RemoteSecPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('505', 'SkipCompareESN', 'YES', 'SkipCompareESN', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('506', 'ImplicitRegFunc', 'YES', 'ImplicitRegFunc', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('507', 'UEPeriodicRegTime(s)', '1800', 'UEPeriodicRegTime(s)', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('508', 'BackupFunc', 'NO', 'BackupFunc', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('509', 'RemoteAuCIP', 'local.sk', 'RemoteAuCIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('510', 'RemoteAuCPort', '9905', 'RemoteAuCPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('511', 'RootDir', '.', 'RootDir', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('512', 'InitData2Memory', 'YES', 'InitData2Memory', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('513', 'DBSyncCount', '2', 'DBSyncCount', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('514', 'DebugFlag', '0x3f', 'DebugFlag', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('515', 'ProxyFunc', 'NO', 'ProxyFunc', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('516', 'ProxyMDNPrefix', '199', 'ProxyMDNPrefix', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('517', 'ProxyUEDevType', 'CDMA', 'ProxyUEDevType', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('518', 'ProxyDBName', 'HSS_Proxy', 'ProxyDBName', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('519', 'ProxyDBIP', '127.0.0.1', 'ProxyDBIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('520', 'ProxyDBPort', '3306', 'ProxyDBPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('521', 'ProxyDBUser', 'provision', 'ProxyDBUser', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('522', 'ProxyDBPwd', 'smg123', 'ProxyDBPwd', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('523', 'ProxyHSSDir', 'UE_Proxy', 'ProxyHSSDir', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('524', 'SLFInterfaceIP', 'local.sk', 'SLFInterfaceIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('525', 'SLFInterfacePort', '9907', 'SLFInterfacePort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('526', 'SLFGroupIP', '239.66.66.65', 'SLFGroupIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('527', 'SLFGroupPort', '9998', 'SLFGroupPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('528', 'SLFMulticastFwdFunc', 'NO', 'SLFMulticastFwdFunc', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('529', 'SLFMaxForwardNum', '12', 'SLFMaxForwardNum', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('530', 'SLFUnicastFunc', 'YES', 'SLFUnicastFunc', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('531', 'SLFUEFunc', 'YES', 'SLFUEFunc', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('532', 'SLFDBName', 'HSS_Reduancy', 'SLFDBName', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('533', 'SLFDBIP', '127.0.0.1', 'SLFDBIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('534', 'SLFDBPort', '3306', 'SLFDBPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('535', 'SLFDBUser', 'provision', 'SLFDBUser', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('536', 'SLFDBPwd', 'smg123', 'SLFDBPwd', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('537', 'SLFHSSDir', 'UE_Reduancy', 'SLFHSSDir', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('538', 'NbrDetectFunc', 'YES', 'NbrDetectFunc', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('539', 'Nbr2VCSFunc', 'NO', 'Nbr2VCSFunc', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('540', 'DefaultWireTapFunc', 'YES', 'DefaultWireTapFunc', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('541', 'WireTapServerIP', 'local.sk', 'WireTapServerIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('542', 'WireTapServerPort', '9654', 'WireTapServerPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('543', 'DBInfo', 'hss|127.0.0.1|3306|provision|smg123|UE1|0|0|END', 'DBInfo', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('544', 'NbrSLFUnicastAddr', '192.168.1.9:9907', 'NbrSLFUnicastAddr', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('545', 'NbrHSSUnicastFunc', 'YES', 'NbrHSSUnicastFunc', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('546', 'NbrHSSIP', 'local.sk:9906', 'NbrHSSIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('547', 'ConfigID', 'default\ndefault', 'ConfigID', 'textbox', null, null, '1', '9999', '1', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('548', 'InSysNum', '153\n133\n189', 'InSysNum', 'textbox', null, null, '1', '9999', '1', '1', null, null, '24', null);
INSERT INTO `item` VALUES ('549', 'ConfigID', 'default', 'ConfigID', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('550', 'LocalIP', '192.1.1.156', 'LocalIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('551', 'LocalPort', '9916', 'LocalPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('552', 'OcrDbUrl', 'provision:smg123@127.0.0.1:3306/ocr', 'OcrDbUrl', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('553', 'HssDbUrl', 'provision:smg123@127.0.0.1:3306/hss', 'HssDbUrl', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('554', 'DBIP', '127.0.0.1', 'DBIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('555', 'DBPort', '3306', 'DBPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('556', 'CDRTurn', 'NO', 'CDRTurn', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('557', 'AlertInval(s)', '64', 'AlertInval(s)', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('558', 'ConnectInval(s)', '128', 'ConnectInval(s)', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('559', 'TickInval(s)', '70', 'TickInval(s)', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('560', 'TickPSInval(s)', '70', 'TickPSInval(s)', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('561', 'GroupTickInval(s)', '70', 'GroupTickInval(s)', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('562', 'CDRHour', '23', 'CDRHour', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('563', 'CDRInval(hour)', '24', 'CDRInval(hour)', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('564', 'DBMaxLine', '10000', 'DBMaxLine', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('565', 'BillingThreadNum', '1', 'BillingThreadNum', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('566', 'SmscThreadNum', '1', 'SmscThreadNum', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('567', 'PacketThreadNum', '1', 'PacketThreadNum', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('568', 'GroupCallThreadNum', '1', 'GroupCallThreadNum', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('569', 'AsPrefix', '3|1259|1288|1277', 'AsPrefix', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('570', 'RootDir', '.', 'RootDir', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('571', 'DebugFlag', '0xff', 'DebugFlag', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('572', 'DebugNumOfFile', '16', 'DebugNumOfFile', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('573', 'LocalOamIP', '127.0.0.1', 'LocalOamIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('574', 'LocalOamPort', '0', 'LocalOamPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('575', 'RemoteOamIP', '127.0.0.1', 'RemoteOamIP', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('576', 'RemoteOamPort', '9999', 'RemoteOamPort', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('577', 'StatFilterBilling', '', 'StatFilterBilling', 'textbox', null, null, '1', '9999', '0', '0', null, null, '25', null);
INSERT INTO `item` VALUES ('578', 'StatFilterSmsc', '', 'StatFilterSmsc', 'textbox', null, null, '1', '9999', '0', '0', null, null, '25', null);
INSERT INTO `item` VALUES ('579', 'SmscDBStore', 'true', 'SmscDBStore', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('580', 'PacketDBStore', 'true', 'PacketDBStore', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('581', 'BillingDBStore', 'true', 'BillingDBStore', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('582', 'GroupCallDBStore', 'true', 'GroupCallDBStore', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('583', 'SmscContentParse', 'false', 'SmscContentParse', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('584', 'SmscMoackProcess', 'false', 'SmscMoackProcess', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('585', 'SmsSynInterval(ms)', '500', 'SmsSynInterval(ms)', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('586', 'SmscDedupInterval(ms)', '500', 'SmscDedupInterval(ms)', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('587', 'BillingDedupInterval(ms)', '500', 'BillingDedupInterval(ms)', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('588', 'GroupCallDedupInterval(ms)', '500', 'GroupCallDedupInterval(ms)', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('589', 'SmscDupStore', 'false', 'SmscDupStore', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('590', 'BillingDupStore', 'true', 'BillingDupStore', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('591', 'GroupCallDupStore', 'false', 'GroupCallDupStore', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('592', 'IPMaster', '192.1.1.155', 'IPMaster', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('593', 'IPSlave', '192.168.0.3', 'IPSlave', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);
INSERT INTO `item` VALUES ('594', 'JoinGroupCallStartLocation', 'true', 'JoinGroupCallStartLocation', 'textbox', null, null, '1', '9999', '0', '1', null, null, '25', null);

-- ----------------------------
-- Table structure for `log`
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `success` tinyint(4) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `createDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=525 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES ('1', 'ViewTerminalUser', 'nouser', '1', null, '2020-01-18 02:48:49');
INSERT INTO `log` VALUES ('2', 'CardList', 'nouser', '1', null, '2020-01-19 17:39:39');
INSERT INTO `log` VALUES ('3', 'CardList', 'nouser', '1', null, '2020-01-19 17:47:56');
INSERT INTO `log` VALUES ('4', 'CardList', 'nouser', '1', null, '2020-01-19 17:49:06');
INSERT INTO `log` VALUES ('5', 'CardList', 'nouser', '1', null, '2020-01-19 17:49:07');
INSERT INTO `log` VALUES ('6', 'ViewTerminalUser', 'nouser', '1', null, '2020-01-19 18:23:01');
INSERT INTO `log` VALUES ('7', 'ViewGroupCallGroup', 'nouser', '1', null, '2020-01-19 18:24:01');
INSERT INTO `log` VALUES ('8', 'ViewGroupCallGroup', 'nouser', '1', null, '2020-01-19 18:24:08');
INSERT INTO `log` VALUES ('9', 'CardList', 'nouser', '1', null, '2020-01-19 18:24:37');
INSERT INTO `log` VALUES ('10', 'CardList', 'nouser', '1', null, '2020-01-19 18:24:53');
INSERT INTO `log` VALUES ('11', 'CardList', 'nouser', '1', null, '2020-01-19 18:25:23');
INSERT INTO `log` VALUES ('12', 'CardList', 'nouser', '1', null, '2020-01-19 18:26:13');
INSERT INTO `log` VALUES ('13', 'CardList', 'nouser', '1', null, '2020-01-19 18:26:25');
INSERT INTO `log` VALUES ('14', 'CardList', 'nouser', '1', null, '2020-01-19 18:27:40');
INSERT INTO `log` VALUES ('15', 'CardList', 'nouser', '1', null, '2020-01-19 18:27:59');
INSERT INTO `log` VALUES ('16', 'CardList', 'nouser', '1', null, '2020-01-19 18:28:11');
INSERT INTO `log` VALUES ('17', 'CardList', 'nouser', '1', null, '2020-01-19 18:28:12');
INSERT INTO `log` VALUES ('18', 'CardList', 'nouser', '1', null, '2020-01-19 18:28:12');
INSERT INTO `log` VALUES ('19', 'CardList', 'nouser', '1', null, '2020-01-19 18:28:13');
INSERT INTO `log` VALUES ('20', 'CardList', 'nouser', '1', null, '2020-01-19 18:28:13');
INSERT INTO `log` VALUES ('21', 'CardList', 'nouser', '1', null, '2020-01-19 18:28:13');
INSERT INTO `log` VALUES ('22', 'CardList', 'nouser', '1', null, '2020-01-19 18:28:14');
INSERT INTO `log` VALUES ('23', 'CardList', 'nouser', '1', null, '2020-01-19 18:28:15');
INSERT INTO `log` VALUES ('24', 'CardList', 'nouser', '1', null, '2020-01-19 18:28:15');
INSERT INTO `log` VALUES ('25', 'CardList', 'nouser', '1', null, '2020-01-19 18:28:31');
INSERT INTO `log` VALUES ('26', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:28:42');
INSERT INTO `log` VALUES ('27', 'CardList', 'nouser', '1', null, '2020-01-19 18:44:24');
INSERT INTO `log` VALUES ('28', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:44:27');
INSERT INTO `log` VALUES ('29', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:44:28');
INSERT INTO `log` VALUES ('30', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:44:29');
INSERT INTO `log` VALUES ('31', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:44:29');
INSERT INTO `log` VALUES ('32', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:44:29');
INSERT INTO `log` VALUES ('33', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:44:29');
INSERT INTO `log` VALUES ('34', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:44:30');
INSERT INTO `log` VALUES ('35', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:44:30');
INSERT INTO `log` VALUES ('36', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:44:30');
INSERT INTO `log` VALUES ('37', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:44:30');
INSERT INTO `log` VALUES ('38', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:44:30');
INSERT INTO `log` VALUES ('39', 'SinglePackageUpload', 'nouser', '1', null, '2020-01-19 18:45:05');
INSERT INTO `log` VALUES ('40', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:45:06');
INSERT INTO `log` VALUES ('41', 'SinglePackageUpload', 'nouser', '0', 'PromptContent65', '2020-01-19 18:45:44');
INSERT INTO `log` VALUES ('42', 'SinglePackageUpload', 'nouser', '0', 'PromptContent59', '2020-01-19 18:48:19');
INSERT INTO `log` VALUES ('43', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:52:02');
INSERT INTO `log` VALUES ('44', 'SinglePackageUpload', 'nouser', '0', 'PromptContent65', '2020-01-19 18:52:22');
INSERT INTO `log` VALUES ('45', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:59:39');
INSERT INTO `log` VALUES ('46', 'SinglePackageUpload', 'nouser', '1', null, '2020-01-19 18:59:57');
INSERT INTO `log` VALUES ('47', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 18:59:58');
INSERT INTO `log` VALUES ('48', 'SinglePackageUpload', 'nouser', '1', null, '2020-01-19 19:02:52');
INSERT INTO `log` VALUES ('49', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 19:02:52');
INSERT INTO `log` VALUES ('50', 'SinglePackageUpload', 'nouser', '0', 'PromptContent65', '2020-01-19 19:03:08');
INSERT INTO `log` VALUES ('51', 'SinglePackageUpload', 'nouser', '1', null, '2020-01-19 19:04:30');
INSERT INTO `log` VALUES ('52', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 19:04:30');
INSERT INTO `log` VALUES ('53', 'SinglePackageUpload', 'nouser', '0', 'PromptContent65', '2020-01-19 19:04:46');
INSERT INTO `log` VALUES ('54', 'SinglePackageUpload', 'nouser', '0', 'PromptContent66', '2020-01-19 19:05:59');
INSERT INTO `log` VALUES ('55', 'SinglePackageUpload', 'nouser', '0', 'PromptContent66', '2020-01-19 19:06:04');
INSERT INTO `log` VALUES ('56', 'SinglePackageUpload', 'nouser', '0', 'PromptContent66', '2020-01-19 19:06:32');
INSERT INTO `log` VALUES ('57', 'SinglePackageUpload', 'nouser', '0', 'PromptContent66', '2020-01-19 19:07:59');
INSERT INTO `log` VALUES ('58', 'SinglePackageUpload', 'nouser', '1', null, '2020-01-19 19:14:17');
INSERT INTO `log` VALUES ('59', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 19:14:17');
INSERT INTO `log` VALUES ('60', 'SinglePackageUpload', 'nouser', '1', null, '2020-01-19 19:15:10');
INSERT INTO `log` VALUES ('61', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 19:15:11');
INSERT INTO `log` VALUES ('62', 'SinglePackageUpload', 'nouser', '1', null, '2020-01-19 19:15:58');
INSERT INTO `log` VALUES ('63', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 19:15:59');
INSERT INTO `log` VALUES ('64', 'SinglePackageUpload', 'nouser', '1', null, '2020-01-19 19:16:47');
INSERT INTO `log` VALUES ('65', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 19:16:48');
INSERT INTO `log` VALUES ('66', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 19:16:51');
INSERT INTO `log` VALUES ('67', 'SendNE', 'nouser', '0', 'CncpReason20', '2020-01-19 19:17:12');
INSERT INTO `log` VALUES ('68', 'SendNE', 'nouser', '0', 'CncpReason20', '2020-01-19 19:17:31');
INSERT INTO `log` VALUES ('69', 'CardList', 'nouser', '1', null, '2020-01-19 19:19:31');
INSERT INTO `log` VALUES ('70', 'CardList', 'nouser', '1', null, '2020-01-19 19:19:32');
INSERT INTO `log` VALUES ('71', 'CardList', 'nouser', '1', null, '2020-01-19 19:19:33');
INSERT INTO `log` VALUES ('72', 'CardList', 'nouser', '1', null, '2020-01-19 19:19:33');
INSERT INTO `log` VALUES ('73', 'CardList', 'nouser', '1', null, '2020-01-19 19:19:33');
INSERT INTO `log` VALUES ('74', 'CardList', 'nouser', '1', null, '2020-01-19 19:19:34');
INSERT INTO `log` VALUES ('75', 'CardList', 'nouser', '1', null, '2020-01-19 19:19:34');
INSERT INTO `log` VALUES ('76', 'CardList', 'nouser', '1', null, '2020-01-19 19:19:34');
INSERT INTO `log` VALUES ('77', 'CardList', 'nouser', '1', null, '2020-01-19 19:19:34');
INSERT INTO `log` VALUES ('78', 'CardList', 'nouser', '1', null, '2020-01-19 19:19:35');
INSERT INTO `log` VALUES ('79', 'CardList', 'nouser', '1', null, '2020-01-19 19:19:35');
INSERT INTO `log` VALUES ('80', 'CardList', 'nouser', '1', null, '2020-01-19 19:53:54');
INSERT INTO `log` VALUES ('81', 'CardList', 'nouser', '1', null, '2020-01-19 19:54:06');
INSERT INTO `log` VALUES ('82', 'CardList', 'nouser', '1', null, '2020-01-19 19:55:49');
INSERT INTO `log` VALUES ('83', 'CardList', 'nouser', '1', null, '2020-01-19 19:55:51');
INSERT INTO `log` VALUES ('84', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 19:55:53');
INSERT INTO `log` VALUES ('85', 'SendNE', 'nouser', '0', 'CncpReason20', '2020-01-19 19:56:07');
INSERT INTO `log` VALUES ('86', 'CardList', 'nouser', '1', null, '2020-01-19 20:18:52');
INSERT INTO `log` VALUES ('87', 'CardList', 'nouser', '1', null, '2020-01-19 20:18:54');
INSERT INTO `log` VALUES ('88', 'CardList', 'nouser', '1', null, '2020-01-19 20:18:55');
INSERT INTO `log` VALUES ('89', 'CardList', 'nouser', '1', null, '2020-01-19 20:18:55');
INSERT INTO `log` VALUES ('90', 'CardList', 'nouser', '1', null, '2020-01-19 20:18:55');
INSERT INTO `log` VALUES ('91', 'CardList', 'nouser', '1', null, '2020-01-19 20:18:56');
INSERT INTO `log` VALUES ('92', 'CardList', 'nouser', '1', null, '2020-01-19 20:18:56');
INSERT INTO `log` VALUES ('93', 'CardList', 'nouser', '1', null, '2020-01-19 20:18:56');
INSERT INTO `log` VALUES ('94', 'CardList', 'nouser', '1', null, '2020-01-19 20:18:56');
INSERT INTO `log` VALUES ('95', 'CardList', 'nouser', '1', null, '2020-01-19 20:18:57');
INSERT INTO `log` VALUES ('96', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:44');
INSERT INTO `log` VALUES ('97', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:45');
INSERT INTO `log` VALUES ('98', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:45');
INSERT INTO `log` VALUES ('99', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:45');
INSERT INTO `log` VALUES ('100', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:45');
INSERT INTO `log` VALUES ('101', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:46');
INSERT INTO `log` VALUES ('102', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:46');
INSERT INTO `log` VALUES ('103', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:46');
INSERT INTO `log` VALUES ('104', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:46');
INSERT INTO `log` VALUES ('105', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:47');
INSERT INTO `log` VALUES ('106', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:47');
INSERT INTO `log` VALUES ('107', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:47');
INSERT INTO `log` VALUES ('108', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:48');
INSERT INTO `log` VALUES ('109', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:48');
INSERT INTO `log` VALUES ('110', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:49');
INSERT INTO `log` VALUES ('111', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:49');
INSERT INTO `log` VALUES ('112', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 20:19:51');
INSERT INTO `log` VALUES ('113', 'CardList', 'nouser', '1', null, '2020-01-19 20:19:55');
INSERT INTO `log` VALUES ('114', 'DeleteCard', 'nouser', '1', null, '2020-01-19 20:21:07');
INSERT INTO `log` VALUES ('115', 'CardList', 'nouser', '1', null, '2020-01-19 20:21:07');
INSERT INTO `log` VALUES ('116', 'DeleteCard', 'nouser', '1', null, '2020-01-19 20:21:12');
INSERT INTO `log` VALUES ('117', 'CardList', 'nouser', '1', null, '2020-01-19 20:21:12');
INSERT INTO `log` VALUES ('118', 'DeleteCard', 'nouser', '1', null, '2020-01-19 20:21:23');
INSERT INTO `log` VALUES ('119', 'CardList', 'nouser', '1', null, '2020-01-19 20:21:23');
INSERT INTO `log` VALUES ('120', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 20:31:46');
INSERT INTO `log` VALUES ('121', 'ViewTerminalUser', 'nouser', '1', null, '2020-01-19 20:31:48');
INSERT INTO `log` VALUES ('122', 'CardList', 'nouser', '1', null, '2020-01-19 20:31:51');
INSERT INTO `log` VALUES ('123', 'CardList', 'nouser', '1', null, '2020-01-19 20:31:53');
INSERT INTO `log` VALUES ('124', 'CardList', 'nouser', '1', null, '2020-01-19 20:31:53');
INSERT INTO `log` VALUES ('125', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:23');
INSERT INTO `log` VALUES ('126', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:36');
INSERT INTO `log` VALUES ('127', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:49');
INSERT INTO `log` VALUES ('128', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:50');
INSERT INTO `log` VALUES ('129', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:50');
INSERT INTO `log` VALUES ('130', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:50');
INSERT INTO `log` VALUES ('131', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:50');
INSERT INTO `log` VALUES ('132', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:51');
INSERT INTO `log` VALUES ('133', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:51');
INSERT INTO `log` VALUES ('134', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:51');
INSERT INTO `log` VALUES ('135', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:52');
INSERT INTO `log` VALUES ('136', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:52');
INSERT INTO `log` VALUES ('137', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:52');
INSERT INTO `log` VALUES ('138', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:52');
INSERT INTO `log` VALUES ('139', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:52');
INSERT INTO `log` VALUES ('140', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:52');
INSERT INTO `log` VALUES ('141', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:52');
INSERT INTO `log` VALUES ('142', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:53');
INSERT INTO `log` VALUES ('143', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:53');
INSERT INTO `log` VALUES ('144', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:53');
INSERT INTO `log` VALUES ('145', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:53');
INSERT INTO `log` VALUES ('146', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:53');
INSERT INTO `log` VALUES ('147', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:53');
INSERT INTO `log` VALUES ('148', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:53');
INSERT INTO `log` VALUES ('149', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:53');
INSERT INTO `log` VALUES ('150', 'CardList', 'nouser', '1', null, '2020-01-19 20:32:54');
INSERT INTO `log` VALUES ('151', 'ViewResourcePackage', 'nouser', '1', null, '2020-01-19 20:33:25');
INSERT INTO `log` VALUES ('152', 'SendNE', 'nouser', '1', null, '2020-01-19 20:33:36');
INSERT INTO `log` VALUES ('153', 'SendNE', 'nouser', '1', null, '2020-01-19 20:33:51');
INSERT INTO `log` VALUES ('154', 'SendNE', 'nouser', '1', null, '2020-01-19 20:34:07');
INSERT INTO `log` VALUES ('155', 'SendNE', 'nouser', '1', null, '2020-01-19 20:35:31');
INSERT INTO `log` VALUES ('156', 'SendNE', 'nouser', '1', null, '2020-01-19 20:35:44');
INSERT INTO `log` VALUES ('157', 'SendNE', 'nouser', '1', null, '2020-01-19 20:35:55');
INSERT INTO `log` VALUES ('158', 'SendNE', 'nouser', '1', null, '2020-01-19 20:36:04');
INSERT INTO `log` VALUES ('159', 'SendNE', 'nouser', '1', null, '2020-01-19 20:36:15');
INSERT INTO `log` VALUES ('160', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-17 12:35:43');
INSERT INTO `log` VALUES ('161', 'CardList', 'nouser', '1', null, '2021-03-17 12:35:45');
INSERT INTO `log` VALUES ('162', 'CardList', 'nouser', '1', null, '2021-03-18 11:09:50');
INSERT INTO `log` VALUES ('163', 'CardList', 'nouser', '1', null, '2021-03-18 11:10:08');
INSERT INTO `log` VALUES ('164', 'CardList', 'nouser', '1', null, '2021-03-18 11:13:23');
INSERT INTO `log` VALUES ('165', 'CardList', 'nouser', '1', null, '2021-03-18 11:14:03');
INSERT INTO `log` VALUES ('166', 'SystembrManager', 'nouser', '1', null, '2021-03-18 11:14:55');
INSERT INTO `log` VALUES ('167', 'SystemBackUpList', 'nouser', '1', null, '2021-03-18 11:14:56');
INSERT INTO `log` VALUES ('168', 'SystemUpManager', 'nouser', '1', null, '2021-03-18 11:14:56');
INSERT INTO `log` VALUES ('169', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-18 11:14:58');
INSERT INTO `log` VALUES ('170', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-18 11:15:00');
INSERT INTO `log` VALUES ('171', 'ViewConfigPage', 'nouser', '1', null, '2021-03-18 11:15:02');
INSERT INTO `log` VALUES ('172', 'ViewConfigParameter', 'nouser', '1', null, '2021-03-18 11:15:03');
INSERT INTO `log` VALUES ('173', 'ViewConfigFile', 'nouser', '1', null, '2021-03-18 11:15:03');
INSERT INTO `log` VALUES ('174', 'NEParameterConfig', 'nouser', '1', null, '2021-03-18 11:15:05');
INSERT INTO `log` VALUES ('175', 'OneKeyImportAndExport', 'nouser', '1', null, '2021-03-18 11:15:09');
INSERT INTO `log` VALUES ('176', 'OneKeyImportAndExport', 'nouser', '1', null, '2021-03-18 11:15:10');
INSERT INTO `log` VALUES ('177', 'ViewLog', 'nouser', '1', null, '2021-03-18 11:15:13');
INSERT INTO `log` VALUES ('178', 'StartupCheck', 'nouser', '1', null, '2021-03-18 11:15:14');
INSERT INTO `log` VALUES ('179', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 11:15:16');
INSERT INTO `log` VALUES ('180', 'StartupCheck', 'nouser', '1', null, '2021-03-18 11:15:17');
INSERT INTO `log` VALUES ('181', 'StartupCheck', 'nouser', '1', null, '2021-03-18 11:15:18');
INSERT INTO `log` VALUES ('182', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 11:15:22');
INSERT INTO `log` VALUES ('183', 'StartupCheck', 'nouser', '1', null, '2021-03-18 11:15:23');
INSERT INTO `log` VALUES ('184', 'StartupCheck', 'nouser', '1', null, '2021-03-18 11:15:29');
INSERT INTO `log` VALUES ('185', 'StartupCheck', 'nouser', '1', null, '2021-03-18 11:15:46');
INSERT INTO `log` VALUES ('186', 'StartupCheck', 'nouser', '1', null, '2021-03-18 11:20:20');
INSERT INTO `log` VALUES ('187', 'RtCheck', 'nouser', '1', null, '2021-03-18 11:20:25');
INSERT INTO `log` VALUES ('188', 'ViewAlarm', 'nouser', '1', null, '2021-03-18 11:20:30');
INSERT INTO `log` VALUES ('189', 'OneKeyImportAndExport', 'nouser', '1', null, '2021-03-18 11:20:32');
INSERT INTO `log` VALUES ('190', 'NEParameterConfig', 'nouser', '1', null, '2021-03-18 11:20:33');
INSERT INTO `log` VALUES ('191', 'ViewConfigItem', 'nouser', '1', null, '2021-03-18 11:20:36');
INSERT INTO `log` VALUES ('192', 'ViewConfigFile', 'nouser', '1', null, '2021-03-18 11:20:39');
INSERT INTO `log` VALUES ('193', 'ViewConfigParameter', 'nouser', '1', null, '2021-03-18 11:20:41');
INSERT INTO `log` VALUES ('194', 'ViewConfigPage', 'nouser', '1', null, '2021-03-18 11:20:43');
INSERT INTO `log` VALUES ('195', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-18 11:20:45');
INSERT INTO `log` VALUES ('196', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-18 11:20:46');
INSERT INTO `log` VALUES ('197', 'CardList', 'nouser', '1', null, '2021-03-18 11:20:54');
INSERT INTO `log` VALUES ('198', 'SystembrManager', 'nouser', '1', null, '2021-03-18 11:20:57');
INSERT INTO `log` VALUES ('199', 'SystemBackUpList', 'nouser', '1', null, '2021-03-18 11:20:57');
INSERT INTO `log` VALUES ('200', 'SystemUpManager', 'nouser', '1', null, '2021-03-18 11:20:58');
INSERT INTO `log` VALUES ('201', 'SystembrManager', 'nouser', '1', null, '2021-03-18 11:20:59');
INSERT INTO `log` VALUES ('202', 'SystemBackUpList', 'nouser', '1', null, '2021-03-18 11:21:00');
INSERT INTO `log` VALUES ('203', 'SystemUpManager', 'nouser', '1', null, '2021-03-18 11:21:00');
INSERT INTO `log` VALUES ('204', 'StartupCheck', 'nouser', '1', null, '2021-03-18 12:27:07');
INSERT INTO `log` VALUES ('205', 'RtCheck', 'nouser', '1', null, '2021-03-18 12:27:09');
INSERT INTO `log` VALUES ('206', 'CardList', 'nouser', '1', null, '2021-03-18 12:28:05');
INSERT INTO `log` VALUES ('207', 'SystembrManager', 'nouser', '1', null, '2021-03-18 12:28:08');
INSERT INTO `log` VALUES ('208', 'SystemBackUpList', 'nouser', '1', null, '2021-03-18 12:28:08');
INSERT INTO `log` VALUES ('209', 'SystemUpManager', 'nouser', '1', null, '2021-03-18 12:28:09');
INSERT INTO `log` VALUES ('210', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-18 12:28:13');
INSERT INTO `log` VALUES ('211', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-18 12:28:15');
INSERT INTO `log` VALUES ('212', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-18 12:28:17');
INSERT INTO `log` VALUES ('213', 'SinglePackageUpload', 'nouser', '0', '/usr/share/tomcat/temp/xxxxx3878881819455829448.tmp', '2021-03-18 12:29:00');
INSERT INTO `log` VALUES ('214', 'SinglePackageUpload', 'nouser', '0', '/usr/share/tomcat/temp/xxxxx7322514007020195033.tmp', '2021-03-18 12:29:04');
INSERT INTO `log` VALUES ('215', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-18 12:29:14');
INSERT INTO `log` VALUES ('216', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-18 12:29:15');
INSERT INTO `log` VALUES ('217', 'UploadDynamicLibrary', 'nouser', '0', '/usr/share/tomcat/temp/xxxxx7742933039650848957fffff', '2021-03-18 12:29:30');
INSERT INTO `log` VALUES ('218', 'ViewConfigPage', 'nouser', '1', null, '2021-03-18 12:29:34');
INSERT INTO `log` VALUES ('219', 'ViewConfigParameter', 'nouser', '1', null, '2021-03-18 12:29:41');
INSERT INTO `log` VALUES ('220', 'ViewConfigParameter', 'nouser', '1', null, '2021-03-18 12:29:45');
INSERT INTO `log` VALUES ('221', 'ViewConfigFile', 'nouser', '1', null, '2021-03-18 12:29:45');
INSERT INTO `log` VALUES ('222', 'ViewConfigItem', 'nouser', '1', null, '2021-03-18 12:29:56');
INSERT INTO `log` VALUES ('223', 'SendNE', 'nouser', '1', null, '2021-03-18 12:30:26');
INSERT INTO `log` VALUES ('224', 'NEParameterConfig', 'nouser', '1', null, '2021-03-18 12:31:53');
INSERT INTO `log` VALUES ('225', 'NEParameterConfig', 'nouser', '1', null, '2021-03-18 12:31:56');
INSERT INTO `log` VALUES ('226', 'ViewLog', 'nouser', '1', null, '2021-03-18 12:32:04');
INSERT INTO `log` VALUES ('227', 'ViewAlarm', 'nouser', '1', null, '2021-03-18 12:32:06');
INSERT INTO `log` VALUES ('228', 'StartupCheck', 'nouser', '1', null, '2021-03-18 12:32:08');
INSERT INTO `log` VALUES ('229', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 12:32:09');
INSERT INTO `log` VALUES ('230', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 12:32:10');
INSERT INTO `log` VALUES ('231', 'StartupCheck', 'nouser', '1', null, '2021-03-18 12:32:11');
INSERT INTO `log` VALUES ('232', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 12:32:12');
INSERT INTO `log` VALUES ('233', 'StartupCheck', 'nouser', '1', null, '2021-03-18 12:32:13');
INSERT INTO `log` VALUES ('234', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 12:32:14');
INSERT INTO `log` VALUES ('235', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 12:32:23');
INSERT INTO `log` VALUES ('236', 'StartupCheck', 'nouser', '1', null, '2021-03-18 12:32:31');
INSERT INTO `log` VALUES ('237', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 12:32:32');
INSERT INTO `log` VALUES ('238', 'StartupCheck', 'nouser', '1', null, '2021-03-18 12:32:34');
INSERT INTO `log` VALUES ('239', 'ISUP', 'nouser', '0', null, '2021-03-18 12:32:58');
INSERT INTO `log` VALUES ('240', 'TUP', 'nouser', '0', null, '2021-03-18 12:32:59');
INSERT INTO `log` VALUES ('241', 'ISUP2', 'nouser', '0', null, '2021-03-18 12:33:00');
INSERT INTO `log` VALUES ('242', 'TUP2', 'nouser', '0', null, '2021-03-18 12:33:00');
INSERT INTO `log` VALUES ('243', 'ViewUser', 'nouser', '1', null, '2021-03-18 12:33:02');
INSERT INTO `log` VALUES ('244', 'CardList', 'nouser', '1', null, '2021-03-18 12:33:11');
INSERT INTO `log` VALUES ('245', 'CardList', 'nouser', '1', null, '2021-03-18 12:33:45');
INSERT INTO `log` VALUES ('246', 'CardList', 'nouser', '1', null, '2021-03-18 12:33:48');
INSERT INTO `log` VALUES ('247', 'CardList', 'nouser', '1', null, '2021-03-18 12:33:48');
INSERT INTO `log` VALUES ('248', 'CardList', 'nouser', '1', null, '2021-03-18 12:33:49');
INSERT INTO `log` VALUES ('249', 'CardList', 'nouser', '1', null, '2021-03-18 12:33:49');
INSERT INTO `log` VALUES ('250', 'CardList', 'nouser', '1', null, '2021-03-18 12:34:05');
INSERT INTO `log` VALUES ('251', 'CardList', 'nouser', '1', null, '2021-03-18 12:34:06');
INSERT INTO `log` VALUES ('252', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 12:36:48');
INSERT INTO `log` VALUES ('253', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 12:37:04');
INSERT INTO `log` VALUES ('254', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 12:37:13');
INSERT INTO `log` VALUES ('255', 'StartupCheck', 'nouser', '1', null, '2021-03-18 12:37:21');
INSERT INTO `log` VALUES ('256', 'StartupCheck', 'nouser', '1', null, '2021-03-18 12:37:31');
INSERT INTO `log` VALUES ('257', 'StartupCheck', 'nouser', '1', null, '2021-03-18 12:37:51');
INSERT INTO `log` VALUES ('258', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 12:37:55');
INSERT INTO `log` VALUES ('259', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 12:38:02');
INSERT INTO `log` VALUES ('260', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 12:40:30');
INSERT INTO `log` VALUES ('261', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 12:40:54');
INSERT INTO `log` VALUES ('262', 'ViewTerminalUser', 'nouser', '1', null, '2021-03-18 15:12:31');
INSERT INTO `log` VALUES ('263', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 15:12:36');
INSERT INTO `log` VALUES ('264', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 15:13:27');
INSERT INTO `log` VALUES ('265', 'StartupCheck', 'nouser', '1', null, '2021-03-18 15:13:29');
INSERT INTO `log` VALUES ('266', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 15:13:29');
INSERT INTO `log` VALUES ('267', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 15:13:30');
INSERT INTO `log` VALUES ('268', 'StartupCheck', 'nouser', '1', null, '2021-03-18 15:13:31');
INSERT INTO `log` VALUES ('269', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 15:13:32');
INSERT INTO `log` VALUES ('270', 'StartupCheck', 'nouser', '1', null, '2021-03-18 15:13:33');
INSERT INTO `log` VALUES ('271', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 15:14:52');
INSERT INTO `log` VALUES ('272', 'StartupCheck', 'nouser', '1', null, '2021-03-18 15:18:41');
INSERT INTO `log` VALUES ('273', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 15:18:50');
INSERT INTO `log` VALUES ('274', 'StartupCheck', 'nouser', '1', null, '2021-03-18 15:18:57');
INSERT INTO `log` VALUES ('275', 'StartupCheck', 'nouser', '1', null, '2021-03-18 15:19:06');
INSERT INTO `log` VALUES ('276', 'StartupCheck', 'nouser', '1', null, '2021-03-18 15:19:08');
INSERT INTO `log` VALUES ('277', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-18 15:19:10');
INSERT INTO `log` VALUES ('278', 'RtCheck', 'nouser', '0', 'A JSONObject text must begin with \'{\' at character 0 of ', '2021-03-23 14:09:28');
INSERT INTO `log` VALUES ('279', 'RtCheck', 'nouser', '1', null, '2021-03-23 14:30:41');
INSERT INTO `log` VALUES ('280', 'StartupCheck', 'nouser', '1', null, '2021-03-23 14:31:21');
INSERT INTO `log` VALUES ('281', 'RtCheck', 'nouser', '1', null, '2021-03-23 14:31:28');
INSERT INTO `log` VALUES ('282', 'RtCheck', 'nouser', '1', null, '2021-03-23 14:31:31');
INSERT INTO `log` VALUES ('283', 'StartupCheck', 'nouser', '1', null, '2021-03-23 14:31:36');
INSERT INTO `log` VALUES ('284', 'RtCheck', 'nouser', '1', null, '2021-03-23 14:31:37');
INSERT INTO `log` VALUES ('285', 'StartupCheck', 'nouser', '1', null, '2021-03-23 14:31:39');
INSERT INTO `log` VALUES ('286', 'RtCheck', 'nouser', '1', null, '2021-03-23 14:31:40');
INSERT INTO `log` VALUES ('287', 'StartupCheck', 'nouser', '1', null, '2021-03-23 14:31:43');
INSERT INTO `log` VALUES ('288', 'RtCheck', 'nouser', '1', null, '2021-03-23 14:31:44');
INSERT INTO `log` VALUES ('289', 'StartupCheck', 'nouser', '1', null, '2021-03-23 14:31:49');
INSERT INTO `log` VALUES ('290', 'RtCheck', 'nouser', '1', null, '2021-03-23 14:31:50');
INSERT INTO `log` VALUES ('291', 'CardList', 'nouser', '1', null, '2021-03-23 14:38:21');
INSERT INTO `log` VALUES ('292', 'CardList', 'nouser', '1', null, '2021-03-23 14:40:15');
INSERT INTO `log` VALUES ('293', 'SystembrManager', 'nouser', '1', null, '2021-03-23 14:40:17');
INSERT INTO `log` VALUES ('294', 'SystemBackUpList', 'nouser', '1', null, '2021-03-23 14:40:17');
INSERT INTO `log` VALUES ('295', 'SystemUpManager', 'nouser', '1', null, '2021-03-23 14:40:18');
INSERT INTO `log` VALUES ('296', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 14:40:22');
INSERT INTO `log` VALUES ('297', 'SinglePackageUpload', 'nouser', '0', '/usr/share/tomcat/temp/xxxxx6375589627774302596.tmp', '2021-03-23 14:40:49');
INSERT INTO `log` VALUES ('298', 'SinglePackageUpload', 'nouser', '0', '/usr/share/tomcat/temp/xxxxx7294192984131863840.tmp', '2021-03-23 14:40:51');
INSERT INTO `log` VALUES ('299', 'SinglePackageUpload', 'nouser', '0', '/usr/share/tomcat/temp/xxxxx4824292028068791294.tmp', '2021-03-23 14:41:00');
INSERT INTO `log` VALUES ('300', 'SinglePackageUpload', 'nouser', '0', '/usr/share/tomcat/temp/xxxxx265578862042626634.tmp', '2021-03-23 14:41:03');
INSERT INTO `log` VALUES ('301', 'SinglePackageUpload', 'nouser', '0', '/usr/share/tomcat/temp/xxxxx6856292076319360526.tmp', '2021-03-23 14:41:14');
INSERT INTO `log` VALUES ('302', 'SinglePackageUpload', 'nouser', '0', '/usr/share/tomcat/temp/xxxxx3882893058572839402.tmp', '2021-03-23 14:41:19');
INSERT INTO `log` VALUES ('303', 'SinglePackageUpload', 'nouser', '0', '/usr/share/tomcat/temp/xxxxx2953942381561786600.tmp', '2021-03-23 14:41:35');
INSERT INTO `log` VALUES ('304', 'SinglePackageUpload', 'nouser', '0', '/usr/share/tomcat/temp/xxxxx7024108351931750406.tmp', '2021-03-23 14:41:38');
INSERT INTO `log` VALUES ('305', 'SinglePackageUpload', 'nouser', '0', '/usr/share/tomcat/temp/xxxxx7574701820025445433.tmp', '2021-03-23 14:41:40');
INSERT INTO `log` VALUES ('306', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 14:41:52');
INSERT INTO `log` VALUES ('307', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 14:42:47');
INSERT INTO `log` VALUES ('308', 'SinglePackageUpload', 'nouser', '0', '/usr/share/tomcat/temp/xxxxx910743894229262661.tmp', '2021-03-23 14:42:58');
INSERT INTO `log` VALUES ('309', 'SinglePackageUpload', 'nouser', '1', null, '2021-03-23 14:44:27');
INSERT INTO `log` VALUES ('310', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 14:44:34');
INSERT INTO `log` VALUES ('311', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-23 14:46:06');
INSERT INTO `log` VALUES ('312', 'UploadDynamicLibrary', 'nouser', '1', null, '2021-03-23 14:47:22');
INSERT INTO `log` VALUES ('313', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-23 14:47:22');
INSERT INTO `log` VALUES ('314', 'DeleteDynamicLibrary', 'nouser', '1', null, '2021-03-23 14:50:10');
INSERT INTO `log` VALUES ('315', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-23 14:50:10');
INSERT INTO `log` VALUES ('316', 'ViewConfigPage', 'nouser', '1', null, '2021-03-23 14:50:12');
INSERT INTO `log` VALUES ('317', 'ViewConfigParameter', 'nouser', '1', null, '2021-03-23 14:50:16');
INSERT INTO `log` VALUES ('318', 'ViewConfigFile', 'nouser', '1', null, '2021-03-23 14:50:17');
INSERT INTO `log` VALUES ('319', 'ViewConfigItem', 'nouser', '1', null, '2021-03-23 14:50:19');
INSERT INTO `log` VALUES ('320', 'ViewConfigItem', 'nouser', '1', null, '2021-03-23 14:50:22');
INSERT INTO `log` VALUES ('321', 'SendNE', 'nouser', '1', null, '2021-03-23 14:50:40');
INSERT INTO `log` VALUES ('322', 'CardList', 'nouser', '1', null, '2021-03-23 16:16:07');
INSERT INTO `log` VALUES ('323', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 16:16:12');
INSERT INTO `log` VALUES ('324', 'DeleteResourcePackage', 'nouser', '0', 'PromptContent68', '2021-03-23 16:16:21');
INSERT INTO `log` VALUES ('325', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-23 16:16:24');
INSERT INTO `log` VALUES ('326', 'DeleteNE', 'nouser', '1', null, '2021-03-23 16:16:36');
INSERT INTO `log` VALUES ('327', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 16:16:45');
INSERT INTO `log` VALUES ('328', 'DeleteResourcePackage', 'nouser', '1', null, '2021-03-23 16:16:49');
INSERT INTO `log` VALUES ('329', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 16:16:49');
INSERT INTO `log` VALUES ('330', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-23 16:16:52');
INSERT INTO `log` VALUES ('331', 'UploadDynamicLibrary', 'nouser', '1', null, '2021-03-23 16:17:01');
INSERT INTO `log` VALUES ('332', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-23 16:17:01');
INSERT INTO `log` VALUES ('333', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 16:17:11');
INSERT INTO `log` VALUES ('334', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-23 16:17:12');
INSERT INTO `log` VALUES ('335', 'DeleteDynamicLibrary', 'nouser', '1', null, '2021-03-23 16:17:15');
INSERT INTO `log` VALUES ('336', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-23 16:17:15');
INSERT INTO `log` VALUES ('337', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 16:17:17');
INSERT INTO `log` VALUES ('338', 'SinglePackageUpload', 'nouser', '1', null, '2021-03-23 16:17:31');
INSERT INTO `log` VALUES ('339', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 16:17:45');
INSERT INTO `log` VALUES ('340', 'SendNE', 'nouser', '1', null, '2021-03-23 16:18:03');
INSERT INTO `log` VALUES ('341', 'StartNE', 'nouser', '1', null, '2021-03-23 16:32:30');
INSERT INTO `log` VALUES ('342', 'StartNE', 'nouser', '1', null, '2021-03-23 16:33:12');
INSERT INTO `log` VALUES ('343', 'NEParameterConfig', 'nouser', '1', null, '2021-03-23 16:33:21');
INSERT INTO `log` VALUES ('344', 'StartupCheck', 'nouser', '1', null, '2021-03-23 16:33:25');
INSERT INTO `log` VALUES ('345', 'RtCheck', 'nouser', '1', null, '2021-03-23 16:33:27');
INSERT INTO `log` VALUES ('346', 'ViewUser', 'nouser', '1', null, '2021-03-23 16:33:33');
INSERT INTO `log` VALUES ('347', 'ViewRights', 'nouser', '1', null, '2021-03-23 16:33:33');
INSERT INTO `log` VALUES ('348', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 16:39:07');
INSERT INTO `log` VALUES ('349', 'SinglePackageUpload', 'nouser', '1', null, '2021-03-23 16:39:16');
INSERT INTO `log` VALUES ('350', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 16:39:21');
INSERT INTO `log` VALUES ('351', 'DeleteResourcePackage', 'nouser', '1', null, '2021-03-23 16:39:50');
INSERT INTO `log` VALUES ('352', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 16:39:51');
INSERT INTO `log` VALUES ('353', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 16:50:08');
INSERT INTO `log` VALUES ('354', 'StartNE', 'nouser', '1', null, '2021-03-23 16:50:15');
INSERT INTO `log` VALUES ('355', 'StartNE', 'nouser', '1', null, '2021-03-23 16:50:40');
INSERT INTO `log` VALUES ('356', 'StartNE', 'nouser', '1', null, '2021-03-23 16:52:00');
INSERT INTO `log` VALUES ('357', 'CardList', 'nouser', '1', null, '2021-03-23 17:25:31');
INSERT INTO `log` VALUES ('358', 'CardList', 'nouser', '1', null, '2021-03-23 17:25:57');
INSERT INTO `log` VALUES ('359', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 17:27:09');
INSERT INTO `log` VALUES ('360', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-23 17:27:10');
INSERT INTO `log` VALUES ('361', 'ViewConfigPage', 'nouser', '1', null, '2021-03-23 17:27:12');
INSERT INTO `log` VALUES ('362', 'NEParameterConfig', 'nouser', '1', null, '2021-03-23 17:27:14');
INSERT INTO `log` VALUES ('363', 'NEParameterConfig', 'nouser', '1', null, '2021-03-23 17:27:16');
INSERT INTO `log` VALUES ('364', 'NEParameterConfig', 'nouser', '1', null, '2021-03-23 17:27:18');
INSERT INTO `log` VALUES ('365', 'StartupCheck', 'nouser', '1', null, '2021-03-23 17:27:22');
INSERT INTO `log` VALUES ('366', 'RtCheck', 'nouser', '1', null, '2021-03-23 17:27:23');
INSERT INTO `log` VALUES ('367', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-23 17:27:30');
INSERT INTO `log` VALUES ('368', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-23 17:27:31');
INSERT INTO `log` VALUES ('369', 'ViewConfigFile', 'nouser', '1', null, '2021-03-23 17:27:34');
INSERT INTO `log` VALUES ('370', 'ViewConfigItem', 'nouser', '1', null, '2021-03-23 17:27:35');
INSERT INTO `log` VALUES ('371', 'NEParameterConfig', 'nouser', '1', null, '2021-03-23 17:27:43');
INSERT INTO `log` VALUES ('372', 'StartNE', 'nouser', '1', null, '2021-03-23 17:27:51');
INSERT INTO `log` VALUES ('373', 'CardList', 'nouser', '1', null, '2021-03-23 19:28:08');
INSERT INTO `log` VALUES ('374', 'CardList', 'nouser', '1', null, '2021-03-24 10:09:57');
INSERT INTO `log` VALUES ('375', 'CardList', 'nouser', '1', null, '2021-03-24 10:14:02');
INSERT INTO `log` VALUES ('376', 'CardList', 'nouser', '1', null, '2021-03-24 11:01:58');
INSERT INTO `log` VALUES ('377', 'CardList', 'nouser', '1', null, '2021-03-24 11:02:08');
INSERT INTO `log` VALUES ('378', 'DeleteCard', 'nouser', '1', null, '2021-03-24 11:02:13');
INSERT INTO `log` VALUES ('379', 'CardList', 'nouser', '1', null, '2021-03-24 11:02:14');
INSERT INTO `log` VALUES ('380', 'CardList', 'nouser', '1', null, '2021-03-24 11:02:23');
INSERT INTO `log` VALUES ('381', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-24 11:02:48');
INSERT INTO `log` VALUES ('382', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-24 11:02:49');
INSERT INTO `log` VALUES ('383', 'ViewConfigPage', 'nouser', '1', null, '2021-03-24 11:02:50');
INSERT INTO `log` VALUES ('384', 'ViewConfigParameter', 'nouser', '1', null, '2021-03-24 11:02:51');
INSERT INTO `log` VALUES ('385', 'ViewConfigFile', 'nouser', '1', null, '2021-03-24 11:02:52');
INSERT INTO `log` VALUES ('386', 'ViewConfigItem', 'nouser', '1', null, '2021-03-24 11:02:54');
INSERT INTO `log` VALUES ('387', 'NEParameterConfig', 'nouser', '1', null, '2021-03-24 11:02:57');
INSERT INTO `log` VALUES ('388', 'StartupCheck', 'nouser', '1', null, '2021-03-24 11:03:04');
INSERT INTO `log` VALUES ('389', 'RtCheck', 'nouser', '1', null, '2021-03-24 11:03:05');
INSERT INTO `log` VALUES ('390', 'CardList', 'nouser', '1', null, '2021-03-24 11:04:38');
INSERT INTO `log` VALUES ('391', 'CardList', 'nouser', '1', null, '2021-03-24 11:05:00');
INSERT INTO `log` VALUES ('392', 'CardList', 'nouser', '1', null, '2021-03-24 11:05:05');
INSERT INTO `log` VALUES ('393', 'DeleteCard', 'nouser', '1', null, '2021-03-24 11:05:10');
INSERT INTO `log` VALUES ('394', 'CardList', 'nouser', '1', null, '2021-03-24 11:05:10');
INSERT INTO `log` VALUES ('395', 'CardList', 'nouser', '1', null, '2021-03-24 11:05:13');
INSERT INTO `log` VALUES ('396', 'SystemUpManager', 'nouser', '1', null, '2021-03-24 11:09:34');
INSERT INTO `log` VALUES ('397', 'SystembrManager', 'nouser', '1', null, '2021-03-24 11:09:41');
INSERT INTO `log` VALUES ('398', 'SystemBackUpList', 'nouser', '1', null, '2021-03-24 11:09:42');
INSERT INTO `log` VALUES ('399', 'CardList', 'nouser', '1', null, '2021-03-24 11:49:46');
INSERT INTO `log` VALUES ('400', 'SystemUpManager', 'nouser', '1', null, '2021-03-24 11:49:49');
INSERT INTO `log` VALUES ('401', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-24 11:49:51');
INSERT INTO `log` VALUES ('402', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-24 11:49:53');
INSERT INTO `log` VALUES ('403', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-24 11:49:55');
INSERT INTO `log` VALUES ('404', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-24 11:49:57');
INSERT INTO `log` VALUES ('405', 'ViewConfigPage', 'nouser', '1', null, '2021-03-24 11:49:58');
INSERT INTO `log` VALUES ('406', 'ViewConfigParameter', 'nouser', '1', null, '2021-03-24 11:49:59');
INSERT INTO `log` VALUES ('407', 'ViewConfigFile', 'nouser', '1', null, '2021-03-24 11:50:00');
INSERT INTO `log` VALUES ('408', 'ViewConfigItem', 'nouser', '1', null, '2021-03-24 11:50:01');
INSERT INTO `log` VALUES ('409', 'NEParameterConfig', 'nouser', '1', null, '2021-03-24 11:50:04');
INSERT INTO `log` VALUES ('410', 'StartupCheck', 'nouser', '1', null, '2021-03-24 11:50:07');
INSERT INTO `log` VALUES ('411', 'RtCheck', 'nouser', '1', null, '2021-03-24 11:50:08');
INSERT INTO `log` VALUES ('412', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-24 11:50:11');
INSERT INTO `log` VALUES ('413', 'DeleteResourcePackage', 'nouser', '0', 'PromptContent68', '2021-03-24 11:50:19');
INSERT INTO `log` VALUES ('414', 'DeleteNE', 'nouser', '0', 'CncpReason4', '2021-03-24 11:50:26');
INSERT INTO `log` VALUES ('415', 'StopNE', 'nouser', '0', 'CncpReason4', '2021-03-24 11:50:29');
INSERT INTO `log` VALUES ('416', 'DeleteNE', 'nouser', '0', 'CncpReason4', '2021-03-24 11:50:36');
INSERT INTO `log` VALUES ('417', 'DeleteNE', 'nouser', '0', 'CncpReason4', '2021-03-24 11:50:41');
INSERT INTO `log` VALUES ('418', 'NEParameterConfig', 'nouser', '1', null, '2021-03-24 11:50:45');
INSERT INTO `log` VALUES ('419', 'DeleteNE', 'nouser', '0', 'CncpReason4', '2021-03-24 11:52:41');
INSERT INTO `log` VALUES ('420', 'DeleteNE', 'nouser', '0', 'CncpReason4', '2021-03-24 11:53:03');
INSERT INTO `log` VALUES ('421', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-24 11:55:16');
INSERT INTO `log` VALUES ('422', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-24 11:55:17');
INSERT INTO `log` VALUES ('423', 'NEParameterConfig', 'nouser', '1', null, '2021-03-24 11:55:18');
INSERT INTO `log` VALUES ('424', 'DeleteNE', 'nouser', '0', 'CncpReason4', '2021-03-24 11:55:25');
INSERT INTO `log` VALUES ('425', 'DeleteNE', 'nouser', '0', 'CncpReason4', '2021-03-24 11:55:29');
INSERT INTO `log` VALUES ('426', 'DeleteNE', 'nouser', '1', null, '2021-03-24 12:00:35');
INSERT INTO `log` VALUES ('427', 'DeleteNE', 'nouser', '1', null, '2021-03-24 12:00:38');
INSERT INTO `log` VALUES ('428', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-24 12:00:43');
INSERT INTO `log` VALUES ('429', 'DeleteResourcePackage', 'nouser', '1', null, '2021-03-24 12:00:48');
INSERT INTO `log` VALUES ('430', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-24 12:00:48');
INSERT INTO `log` VALUES ('431', 'NEParameterConfig', 'nouser', '1', null, '2021-03-24 13:39:26');
INSERT INTO `log` VALUES ('432', 'StartNE', 'nouser', '0', 'CncpReason4', '2021-03-24 13:39:33');
INSERT INTO `log` VALUES ('433', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-24 13:39:48');
INSERT INTO `log` VALUES ('434', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-24 13:39:49');
INSERT INTO `log` VALUES ('435', 'SinglePackageUpload', 'nouser', '1', null, '2021-03-24 13:39:58');
INSERT INTO `log` VALUES ('436', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-24 13:40:14');
INSERT INTO `log` VALUES ('437', 'SendNE', 'nouser', '1', null, '2021-03-24 13:40:44');
INSERT INTO `log` VALUES ('438', 'CdEntityLog', 'nouser', '1', null, '2021-03-24 13:40:59');
INSERT INTO `log` VALUES ('439', 'StartupOnBoot', 'nouser', '1', null, '2021-03-24 13:41:05');
INSERT INTO `log` VALUES ('440', 'StartNE', 'nouser', '1', null, '2021-03-24 13:41:11');
INSERT INTO `log` VALUES ('441', 'CdEntityLog', 'nouser', '1', null, '2021-03-24 13:41:15');
INSERT INTO `log` VALUES ('442', 'CdEntityLog', 'nouser', '1', null, '2021-03-24 13:41:21');
INSERT INTO `log` VALUES ('443', 'DeleteNE', 'nouser', '1', null, '2021-03-24 13:42:21');
INSERT INTO `log` VALUES ('444', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-24 13:42:24');
INSERT INTO `log` VALUES ('445', 'DeleteResourcePackage', 'nouser', '1', null, '2021-03-24 13:42:29');
INSERT INTO `log` VALUES ('446', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-24 13:42:32');
INSERT INTO `log` VALUES ('447', 'DeleteResourcePackage', 'nouser', '0', null, '2021-03-24 13:42:33');
INSERT INTO `log` VALUES ('448', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-24 13:42:49');
INSERT INTO `log` VALUES ('449', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-24 13:42:50');
INSERT INTO `log` VALUES ('450', 'StartupCheck', 'nouser', '1', null, '2021-03-24 13:42:52');
INSERT INTO `log` VALUES ('451', 'RtCheck', 'nouser', '1', null, '2021-03-24 13:42:53');
INSERT INTO `log` VALUES ('452', 'NEParameterConfig', 'nouser', '1', null, '2021-03-24 13:42:57');
INSERT INTO `log` VALUES ('453', 'CardList', 'nouser', '1', null, '2021-03-24 13:43:35');
INSERT INTO `log` VALUES ('454', 'SystembrManager', 'nouser', '1', null, '2021-03-24 13:43:42');
INSERT INTO `log` VALUES ('455', 'SystemBackUpList', 'nouser', '1', null, '2021-03-24 13:43:42');
INSERT INTO `log` VALUES ('456', 'SystemUpManager', 'nouser', '1', null, '2021-03-24 13:45:18');
INSERT INTO `log` VALUES ('457', 'SystembrManager', 'nouser', '1', null, '2021-03-24 13:45:21');
INSERT INTO `log` VALUES ('458', 'SystemBackUpList', 'nouser', '1', null, '2021-03-24 13:45:21');
INSERT INTO `log` VALUES ('459', 'SystemUpManager', 'nouser', '1', null, '2021-03-24 13:45:22');
INSERT INTO `log` VALUES ('460', 'SystembrManager', 'nouser', '1', null, '2021-03-24 13:45:31');
INSERT INTO `log` VALUES ('461', 'SystemBackUpList', 'nouser', '1', null, '2021-03-24 13:45:32');
INSERT INTO `log` VALUES ('462', 'CardList', 'nouser', '1', null, '2021-03-24 13:45:34');
INSERT INTO `log` VALUES ('463', 'SystembrManager', 'nouser', '1', null, '2021-03-24 13:45:45');
INSERT INTO `log` VALUES ('464', 'SystemBackUpList', 'nouser', '1', null, '2021-03-24 13:45:45');
INSERT INTO `log` VALUES ('465', 'CardList', 'nouser', '1', null, '2021-03-24 18:53:58');
INSERT INTO `log` VALUES ('466', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-24 18:54:02');
INSERT INTO `log` VALUES ('467', 'SendNE', 'nouser', '1', null, '2021-03-24 18:54:20');
INSERT INTO `log` VALUES ('468', 'ViewTerminalUser', 'nouser', '1', null, '2021-03-25 22:55:22');
INSERT INTO `log` VALUES ('469', 'CardList', 'nouser', '1', null, '2021-03-25 22:55:40');
INSERT INTO `log` VALUES ('470', 'CardList', 'nouser', '1', null, '2021-03-25 22:55:43');
INSERT INTO `log` VALUES ('471', 'SystembrManager', 'nouser', '1', null, '2021-03-25 22:55:49');
INSERT INTO `log` VALUES ('472', 'SystemBackUpList', 'nouser', '1', null, '2021-03-25 22:55:50');
INSERT INTO `log` VALUES ('473', 'SystemUpManager', 'nouser', '1', null, '2021-03-25 22:55:51');
INSERT INTO `log` VALUES ('474', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-25 22:55:55');
INSERT INTO `log` VALUES ('475', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-03-25 22:56:00');
INSERT INTO `log` VALUES ('476', 'ViewConfigPage', 'nouser', '1', null, '2021-03-25 22:56:01');
INSERT INTO `log` VALUES ('477', 'ViewConfigParameter', 'nouser', '1', null, '2021-03-25 22:56:02');
INSERT INTO `log` VALUES ('478', 'ViewConfigItem', 'nouser', '1', null, '2021-03-25 22:56:04');
INSERT INTO `log` VALUES ('479', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-25 22:56:04');
INSERT INTO `log` VALUES ('480', 'NEParameterConfig', 'nouser', '1', null, '2021-03-25 22:56:12');
INSERT INTO `log` VALUES ('481', 'OneKeyImportAndExport', 'nouser', '1', null, '2021-03-25 22:56:15');
INSERT INTO `log` VALUES ('482', 'ViewLog', 'nouser', '1', null, '2021-03-25 22:56:17');
INSERT INTO `log` VALUES ('483', 'ViewAlarm', 'nouser', '1', null, '2021-03-25 22:56:18');
INSERT INTO `log` VALUES ('484', 'StartupCheck', 'nouser', '1', null, '2021-03-25 22:56:21');
INSERT INTO `log` VALUES ('485', 'RtCheck', 'nouser', '1', null, '2021-03-25 22:56:23');
INSERT INTO `log` VALUES ('486', 'ISUP', 'nouser', '0', null, '2021-03-25 22:56:36');
INSERT INTO `log` VALUES ('487', 'TUP', 'nouser', '0', null, '2021-03-25 22:56:37');
INSERT INTO `log` VALUES ('488', 'ISUP2', 'nouser', '0', null, '2021-03-25 22:56:38');
INSERT INTO `log` VALUES ('489', 'TUP2', 'nouser', '0', null, '2021-03-25 22:56:39');
INSERT INTO `log` VALUES ('490', 'ViewUser', 'nouser', '1', null, '2021-03-25 22:56:45');
INSERT INTO `log` VALUES ('491', 'ViewTerminalUser', 'nouser', '1', null, '2021-03-25 22:56:48');
INSERT INTO `log` VALUES ('492', 'ViewGroupCallGroup', 'nouser', '1', null, '2021-03-25 22:56:50');
INSERT INTO `log` VALUES ('493', 'MeetingGroupManage', 'nouser', '1', null, '2021-03-25 22:56:50');
INSERT INTO `log` VALUES ('494', 'ViewMeetingGroup', 'nouser', '1', null, '2021-03-25 22:56:53');
INSERT INTO `log` VALUES ('495', 'ViewTerminalUser', 'nouser', '1', null, '2021-03-25 22:56:54');
INSERT INTO `log` VALUES ('496', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-25 22:58:27');
INSERT INTO `log` VALUES ('497', 'SinglePackageUpload', 'nouser', '1', null, '2021-03-25 22:58:41');
INSERT INTO `log` VALUES ('498', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-25 22:58:58');
INSERT INTO `log` VALUES ('499', 'SendNE', 'nouser', '1', null, '2021-03-25 22:59:24');
INSERT INTO `log` VALUES ('500', 'StartNE', 'nouser', '1', null, '2021-03-25 22:59:30');
INSERT INTO `log` VALUES ('501', 'ViewResourcePackage', 'nouser', '1', null, '2021-03-25 22:59:43');
INSERT INTO `log` VALUES ('502', 'ViewTerminalUser', 'nouser', '1', null, '2021-03-25 23:00:56');
INSERT INTO `log` VALUES ('503', 'ViewIMSUser', 'nouser', '1', null, '2021-03-25 23:00:59');
INSERT INTO `log` VALUES ('504', 'CardList', 'nouser', '1', null, '2021-03-25 23:06:52');
INSERT INTO `log` VALUES ('505', 'DeleteNE', 'nouser', '1', null, '2021-03-25 23:18:58');
INSERT INTO `log` VALUES ('506', 'StopNE', 'nouser', '1', null, '2021-03-25 23:19:50');
INSERT INTO `log` VALUES ('507', 'StartNE', 'nouser', '1', null, '2021-03-25 23:19:59');
INSERT INTO `log` VALUES ('508', 'ViewTerminalUser', 'nouser', '1', null, '2021-04-18 14:16:52');
INSERT INTO `log` VALUES ('509', 'ViewResourcePackage', 'nouser', '1', null, '2021-04-18 14:16:56');
INSERT INTO `log` VALUES ('510', 'ViewDynamicLibrary', 'nouser', '1', null, '2021-04-18 14:17:04');
INSERT INTO `log` VALUES ('511', 'CardList', 'nouser', '1', null, '2021-04-18 14:17:17');
INSERT INTO `log` VALUES ('512', 'ViewResourcePackage', 'nouser', '1', null, '2021-05-05 09:26:45');
INSERT INTO `log` VALUES ('513', 'CardList', 'nouser', '1', null, '2021-05-05 09:26:48');
INSERT INTO `log` VALUES ('514', 'ViewResourcePackage', 'nouser', '1', null, '2021-05-05 09:26:51');
INSERT INTO `log` VALUES ('515', 'SinglePackageUpload', 'nouser', '1', null, '2021-05-05 09:27:39');
INSERT INTO `log` VALUES ('516', 'ViewResourcePackage', 'nouser', '1', null, '2021-05-05 09:27:40');
INSERT INTO `log` VALUES ('517', 'SendNE', 'nouser', '1', null, '2021-05-05 10:44:45');
INSERT INTO `log` VALUES ('518', 'StartupOnBoot', 'nouser', '1', null, '2021-05-05 10:45:35');
INSERT INTO `log` VALUES ('519', 'StartNE', 'nouser', '1', null, '2021-05-05 10:46:34');
INSERT INTO `log` VALUES ('520', 'StopNE', 'nouser', '1', null, '2021-05-05 10:47:04');
INSERT INTO `log` VALUES ('521', 'StartNE', 'nouser', '1', null, '2021-05-05 10:47:07');
INSERT INTO `log` VALUES ('522', 'StartupOnBoot', 'nouser', '1', null, '2021-05-05 10:47:09');
INSERT INTO `log` VALUES ('523', 'ReStartNE', 'nouser', '1', null, '2021-05-05 10:49:20');
INSERT INTO `log` VALUES ('524', 'StartupOnBoot', 'nouser', '1', null, '2021-05-05 10:49:23');

-- ----------------------------
-- Table structure for `module`
-- ----------------------------
DROP TABLE IF EXISTS `module`;
CREATE TABLE `module` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `belong` int(11) DEFAULT '0',
  `description` varchar(255) DEFAULT '',
  `version` varchar(255) DEFAULT '',
  `exe` varchar(255) NOT NULL,
  `log` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of module
-- ----------------------------
INSERT INTO `module` VALUES ('21', 'appserver-springboot-webrtc-0.0.1-SNAPSHOT', '0', 'appserver-springboot-webrtc-0.0.1-SNAPSHOT', '0.0.1', './webrtc start', 'logs');
INSERT INTO `module` VALUES ('22', 'recoding', '0', 'recoding', '0.0.1', './recoding start', 'logs');
INSERT INTO `module` VALUES ('23', 'group', '0', 'group', '1.1.0', './group start', 'logs');
INSERT INTO `module` VALUES ('24', 'imserver', '0', 'imserver', '2.2.0', './imserver start', 'logs');
INSERT INTO `module` VALUES ('25', 'presence', '0', 'presence', '2.3.1', './presence start', 'logs');
INSERT INTO `module` VALUES ('26', 'dcsg', '0', 'dcsg', '1.5.0', './dcsgxcapproxy start', 'logs');
INSERT INTO `module` VALUES ('27', 'dds', '0', 'dds', '2.2.0', './dds start', 'logs');
INSERT INTO `module` VALUES ('28', 'agw', '0', 'agw', '2.3.1', './agw start', 'logs');
INSERT INTO `module` VALUES ('256', 'HSS', '0', '归属用户服务', 'R.220', './m_hss_r220_aarch64_20200226_CentOS7.6 -x', 'Log');
INSERT INTO `module` VALUES ('257', 'bill', '0', '计费模块', 'R.', './m_bill_20201120r1 -x', 'Log');

-- ----------------------------
-- Table structure for `options`
-- ----------------------------
DROP TABLE IF EXISTS `options`;
CREATE TABLE `options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(50) NOT NULL,
  `val` varchar(255) NOT NULL,
  `itemId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `itemId` (`itemId`),
  CONSTRAINT `options_ibfk_1` FOREIGN KEY (`itemId`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of options
-- ----------------------------

-- ----------------------------
-- Table structure for `privilege`
-- ----------------------------
DROP TABLE IF EXISTS `privilege`;
CREATE TABLE `privilege` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `leaf` tinyint(4) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `url` (`url`),
  KEY `parentId` (`parentId`),
  CONSTRAINT `privilege_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `privilege` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of privilege
-- ----------------------------
INSERT INTO `privilege` VALUES ('1', 'TerminalUserManager', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('2', 'HSSManager', null, 'hss/listUI', null, '0', '1');
INSERT INTO `privilege` VALUES ('3', 'AddTerminalUser', null, 'hss/add', null, '1', '2');
INSERT INTO `privilege` VALUES ('4', 'DeleteTerminalUser', null, 'hss/delete', null, '1', '2');
INSERT INTO `privilege` VALUES ('5', 'UpdateTerminalUser', null, 'hss/update', null, '1', '2');
INSERT INTO `privilege` VALUES ('6', 'ViewTerminalUser', null, 'hss/list', null, '1', '2');
INSERT INTO `privilege` VALUES ('7', 'InitUserInfo', null, 'card/initUserInfo', null, '1', '2');
INSERT INTO `privilege` VALUES ('8', 'UeDestroy', null, 'hss/ueDestroy', null, '1', '2');
INSERT INTO `privilege` VALUES ('9', 'UeRestore', null, 'hss/ueRestore', null, '1', '2');
INSERT INTO `privilege` VALUES ('10', 'UeSwoon', null, 'hss/ueSwoon', null, '1', '2');
INSERT INTO `privilege` VALUES ('11', 'HSSReduancyManager', null, 'hss/reduancyListUI', null, '1', '1');
INSERT INTO `privilege` VALUES ('12', 'IMSUserManager', null, 'ims/listUI', null, '0', '1');
INSERT INTO `privilege` VALUES ('13', 'AddIMSUser', null, 'ims/add', null, '1', '12');
INSERT INTO `privilege` VALUES ('14', 'DeleteIMSUser', null, 'ims/delete', null, '1', '12');
INSERT INTO `privilege` VALUES ('15', 'UpdateIMSUser', null, 'ims/update', null, '1', '12');
INSERT INTO `privilege` VALUES ('16', 'ViewIMSUser', null, 'ims/list', null, '1', '12');
INSERT INTO `privilege` VALUES ('17', 'GroupCallGroupManage', null, 'hssGroup/listUI', null, '0', '1');
INSERT INTO `privilege` VALUES ('18', 'AddGroupCallGroup', null, 'hssGroup/add', null, '1', '17');
INSERT INTO `privilege` VALUES ('19', 'DeleteGroupCallGroup', null, 'hssGroup/delete', null, '1', '17');
INSERT INTO `privilege` VALUES ('20', 'UpdateGroupCallGroup', null, 'hssGroup/update', null, '1', '17');
INSERT INTO `privilege` VALUES ('21', 'ViewGroupCallGroup', null, 'hssGroup/list', null, '1', '17');
INSERT INTO `privilege` VALUES ('22', 'MeetingGroupManage', null, 'meetingGroup/listUI2', null, '0', '1');
INSERT INTO `privilege` VALUES ('23', 'AddMeetingGroup', null, 'meetingGroup/add', null, '1', '22');
INSERT INTO `privilege` VALUES ('24', 'DeleteMeetingGroup', null, 'meetingGroup/delete', null, '1', '22');
INSERT INTO `privilege` VALUES ('25', 'UpdateMeetingGroup', null, 'meetingGroup/update', null, '1', '22');
INSERT INTO `privilege` VALUES ('26', 'ViewMeetingGroup', null, 'meetingGroup/list', null, '1', '22');
INSERT INTO `privilege` VALUES ('27', 'priorityManage', null, 'hss/listMdnUI', null, '0', '1');
INSERT INTO `privilege` VALUES ('28', 'priorityModifity', null, 'hss/updatePriority', null, '1', '27');
INSERT INTO `privilege` VALUES ('29', 'HssItemConf', null, 'hssParam/listUI', null, '0', '1');
INSERT INTO `privilege` VALUES ('30', 'HssParamUpdate', null, 'hssParam/update', null, '1', '29');
INSERT INTO `privilege` VALUES ('31', 'userGroupPriority', null, 'hss/userGroupListUI', null, '1', '1');
INSERT INTO `privilege` VALUES ('32', 'SystemManager', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('33', 'NetworkManager', null, 'eth/listUI', null, '0', '32');
INSERT INTO `privilege` VALUES ('34', 'ViewableDns', null, 'omc/viewableDns', null, '1', '33');
INSERT INTO `privilege` VALUES ('35', 'EthActivateUpdate', null, 'eth/activateUpdate', null, '1', '33');
INSERT INTO `privilege` VALUES ('36', 'EthActivateAdd', null, 'eth/activateAdd', null, '1', '33');
INSERT INTO `privilege` VALUES ('37', 'EthStaticAdd', null, 'eth/staticAdd', null, '1', '33');
INSERT INTO `privilege` VALUES ('38', 'EthStaticUpdate', null, 'eth/staticUpdate', null, '1', '33');
INSERT INTO `privilege` VALUES ('39', 'EthDelete', null, 'eth/delete', null, '1', '33');
INSERT INTO `privilege` VALUES ('40', 'Active', null, 'eth/active', null, '1', '33');
INSERT INTO `privilege` VALUES ('41', 'EthViewData', null, 'eth/viewData', null, '1', '33');
INSERT INTO `privilege` VALUES ('42', 'RouteManager', null, 'route/listUI', null, '0', '32');
INSERT INTO `privilege` VALUES ('43', 'DefaultRoute', null, 'route/defaultRoute', null, '1', '42');
INSERT INTO `privilege` VALUES ('44', 'AddRoute', null, 'route/addRoute', null, '1', '42');
INSERT INTO `privilege` VALUES ('45', 'RouteViewData', null, 'route/viewData', null, '1', '42');
INSERT INTO `privilege` VALUES ('46', 'DeleteRoute', null, 'route/deleteRoute', null, '1', '42');
INSERT INTO `privilege` VALUES ('47', 'OSPF', null, 'route/ospf', null, '1', '42');
INSERT INTO `privilege` VALUES ('48', 'HostAddressManager', null, 'hostaddr/listUI', null, '0', '32');
INSERT INTO `privilege` VALUES ('49', 'AddHost', null, 'hostaddr/add', null, '1', '48');
INSERT INTO `privilege` VALUES ('50', 'DeleteHost', null, 'hostaddr/delete', null, '1', '48');
INSERT INTO `privilege` VALUES ('51', 'ViewData', null, 'hostaddr/view', null, '1', '48');
INSERT INTO `privilege` VALUES ('52', 'HostNameAndDNSManager', null, 'dns/listUI', null, '1', '32');
INSERT INTO `privilege` VALUES ('53', 'CardManager', null, 'card/listUI', null, '0', '32');
INSERT INTO `privilege` VALUES ('54', 'CardList', null, 'card/list', null, '1', '53');
INSERT INTO `privilege` VALUES ('55', 'addCard', null, 'card/add', null, '1', '53');
INSERT INTO `privilege` VALUES ('56', 'DeleteCard', null, 'card/delete', null, '1', '53');
INSERT INTO `privilege` VALUES ('57', 'DnsManager', null, 'dnsServer/listUI', null, '1', '32');
INSERT INTO `privilege` VALUES ('58', 'LicenseManager', null, 'license/listUI', null, '1', '32');
INSERT INTO `privilege` VALUES ('59', 'SystembrManager', null, 'card/sysListUI1', null, '1', '32');
INSERT INTO `privilege` VALUES ('60', 'SetBasePoint', null, 'card/setBasePoint', null, '1', '59');
INSERT INTO `privilege` VALUES ('61', 'SystemBackUpList', null, 'card/sysList', null, '1', '59');
INSERT INTO `privilege` VALUES ('62', 'SetFactoryPoint', null, 'card/setFactoryPoint', null, '1', '59');
INSERT INTO `privilege` VALUES ('63', 'SystemUpManager', null, 'card/sysListUI2', null, '0', '32');
INSERT INTO `privilege` VALUES ('64', 'SystemUpgradeManager', null, 'omc/listUI', null, '1', '32');
INSERT INTO `privilege` VALUES ('65', 'ResourceLibraryManager', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('66', 'ResourcePackageManager', null, 'module/listUI', null, '0', '65');
INSERT INTO `privilege` VALUES ('67', 'SinglePackageUpload', null, 'module/upload', null, '1', '66');
INSERT INTO `privilege` VALUES ('68', 'MultiplePackageUpload', null, 'module/uploadAll', null, '1', '66');
INSERT INTO `privilege` VALUES ('69', 'DeleteResourcePackage', null, 'module/delete', null, '1', '66');
INSERT INTO `privilege` VALUES ('70', 'UpdateBasicInformation', null, 'module/update', null, '1', '66');
INSERT INTO `privilege` VALUES ('71', 'ViewResourcePackage', null, 'module/list', null, '1', '66');
INSERT INTO `privilege` VALUES ('72', 'DynamicLibraryManager', null, 'so/listUI', null, '0', '65');
INSERT INTO `privilege` VALUES ('73', 'UploadDynamicLibrary', null, 'so/upload', null, '1', '72');
INSERT INTO `privilege` VALUES ('74', 'DeleteDynamicLibrary', null, 'so/delete', null, '1', '72');
INSERT INTO `privilege` VALUES ('75', 'ViewDynamicLibrary', null, 'so/list', null, '1', '72');
INSERT INTO `privilege` VALUES ('76', 'ConfigPageManager', null, 'common/listUI', null, '0', '65');
INSERT INTO `privilege` VALUES ('77', 'AddConfigPage', null, 'common/save', null, '1', '76');
INSERT INTO `privilege` VALUES ('78', 'DeleteConfigPage', null, 'common/delete', null, '1', '76');
INSERT INTO `privilege` VALUES ('79', 'UpdateConfigPage', null, 'common/update', null, '1', '76');
INSERT INTO `privilege` VALUES ('80', 'ViewConfigPage', null, 'common/list', null, '1', '76');
INSERT INTO `privilege` VALUES ('81', 'ViewThisPageConfigItem', null, 'common/show', null, '1', '76');
INSERT INTO `privilege` VALUES ('82', 'ConfigParameterManager', null, 'relevance/listUI', null, '0', '65');
INSERT INTO `privilege` VALUES ('83', 'AddConfigParameter', null, 'relevance/save', null, '1', '82');
INSERT INTO `privilege` VALUES ('84', 'DeleteConfigParameter', null, 'relevance/delete', null, '1', '82');
INSERT INTO `privilege` VALUES ('85', 'UpdateConfigParameter', null, 'relevance/update', null, '1', '82');
INSERT INTO `privilege` VALUES ('86', 'ViewConfigParameter', null, 'relevance/list', null, '1', '82');
INSERT INTO `privilege` VALUES ('87', 'ViewAssociatedConfigItem', null, 'relevance/show', null, '1', '82');
INSERT INTO `privilege` VALUES ('88', 'ConfigFileManager', null, 'config/listUI', null, '0', '65');
INSERT INTO `privilege` VALUES ('89', 'UploadConfigFile', null, 'config/upload', null, '1', '88');
INSERT INTO `privilege` VALUES ('90', 'DeleteConfigFile', null, 'config/delete', null, '1', '88');
INSERT INTO `privilege` VALUES ('91', 'UpdateConfigFile', null, 'config/update', null, '1', '88');
INSERT INTO `privilege` VALUES ('92', 'ViewConfigFile', null, 'config/list', null, '1', '88');
INSERT INTO `privilege` VALUES ('93', 'ConfigItemManager', null, 'item/listUI', null, '0', '65');
INSERT INTO `privilege` VALUES ('94', 'AddConfigItem', null, 'item/save', null, '1', '93');
INSERT INTO `privilege` VALUES ('95', 'DeleteConfigItem', null, 'item/delete', null, '1', '93');
INSERT INTO `privilege` VALUES ('96', 'UpdateConfigItem', null, 'item/update', null, '1', '93');
INSERT INTO `privilege` VALUES ('97', 'ViewConfigItem', null, 'item/list', null, '1', '93');
INSERT INTO `privilege` VALUES ('98', 'NEPlanningAndManager', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('99', 'ExecuteNEManager', null, 'entity/listUI', null, '0', '98');
INSERT INTO `privilege` VALUES ('100', 'addNE', null, 'entity/add', null, '1', '99');
INSERT INTO `privilege` VALUES ('101', 'SendNE', null, 'entity/save', null, '1', '99');
INSERT INTO `privilege` VALUES ('102', 'DeleteNE', null, 'entity/delete', null, '1', '99');
INSERT INTO `privilege` VALUES ('103', 'CdEntityLog', null, 'entity/listLog', null, '1', '99');
INSERT INTO `privilege` VALUES ('104', 'UpdateNEBasicInformation', null, 'entity/update', null, '1', '99');
INSERT INTO `privilege` VALUES ('105', 'StartNE', null, 'entity/start', null, '1', '99');
INSERT INTO `privilege` VALUES ('106', 'StopNE', null, 'entity/stop', null, '1', '99');
INSERT INTO `privilege` VALUES ('107', 'ReStartNE', null, 'entity/restart', null, '1', '99');
INSERT INTO `privilege` VALUES ('108', 'StartupOnBoot', null, 'entity/startup', null, '1', '99');
INSERT INTO `privilege` VALUES ('109', 'ShutdownOnBoot', null, 'entity/shutdown', null, '1', '99');
INSERT INTO `privilege` VALUES ('110', 'NEParameterConfig', null, 'common/page', null, '0', '98');
INSERT INTO `privilege` VALUES ('111', 'ViewNEConfigParameter', null, 'common/component', null, '1', '110');
INSERT INTO `privilege` VALUES ('112', 'UpdateNEConfigParameter', null, 'common/modify', null, '1', '110');
INSERT INTO `privilege` VALUES ('113', 'NetWorkingConfigUI', null, 'entity/netWorkingConfigUI', null, '1', '98');
INSERT INTO `privilege` VALUES ('114', 'OneKeyImportAndExport', null, 'onekey/view', null, '1', null);
INSERT INTO `privilege` VALUES ('115', 'LogAndAlarm', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('116', 'LogManager', null, 'log/listUI', null, '0', '115');
INSERT INTO `privilege` VALUES ('117', 'DeleteLog', null, 'log/delete', null, '1', '116');
INSERT INTO `privilege` VALUES ('118', 'ViewLog', null, 'log/list', null, '1', '116');
INSERT INTO `privilege` VALUES ('119', 'AlarmManager', null, 'alarm/listUI', null, '0', '115');
INSERT INTO `privilege` VALUES ('120', 'DeleteAlarm', null, 'alarm/delete', null, '1', '119');
INSERT INTO `privilege` VALUES ('121', 'ViewAlarm', null, 'alarm/list', null, '1', '119');
INSERT INTO `privilege` VALUES ('122', 'SelfCheck', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('123', 'StartupCheck', null, 'selfCheck/startupCheck', null, '1', '122');
INSERT INTO `privilege` VALUES ('124', 'RtCheck', null, 'selfCheck/rtCheck', null, '1', '122');
INSERT INTO `privilege` VALUES ('125', 'Out', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('126', 'ISUP', null, 'out/isup', null, '1', '125');
INSERT INTO `privilege` VALUES ('127', 'TUP', null, 'out/tup', null, '1', '125');
INSERT INTO `privilege` VALUES ('128', 'ISUP2', null, 'out/isup2', null, '1', '125');
INSERT INTO `privilege` VALUES ('129', 'TUP2', null, 'out/tup2', null, '1', '125');
INSERT INTO `privilege` VALUES ('130', 'SwitchArgument', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('131', 'NumberTranslation', null, 'switch/listUI', null, '0', '130');
INSERT INTO `privilege` VALUES ('132', 'AddSwitch', null, 'switch/addSwitch', null, '1', '131');
INSERT INTO `privilege` VALUES ('133', 'DeleteSwitch', null, 'switch/deleteSwitch', null, '1', '131');
INSERT INTO `privilege` VALUES ('134', 'SwitchViewData', null, 'switch/switchViewData', null, '1', '131');
INSERT INTO `privilege` VALUES ('135', 'SwitchSave', null, 'switch/switchSave', null, '1', '131');
INSERT INTO `privilege` VALUES ('136', 'OperatorsManager', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('137', 'UserManager', null, 'user/listUI', null, '0', '136');
INSERT INTO `privilege` VALUES ('138', 'AddUser', null, 'user/add', null, '1', '137');
INSERT INTO `privilege` VALUES ('139', 'DeleteUser', null, 'user/delete', null, '1', '137');
INSERT INTO `privilege` VALUES ('140', 'UpdateUser', null, 'user/update', null, '1', '137');
INSERT INTO `privilege` VALUES ('141', 'ViewUser', null, 'user/list', null, '1', '137');
INSERT INTO `privilege` VALUES ('142', 'RightsManager', null, 'role/listUI', null, '0', '136');
INSERT INTO `privilege` VALUES ('143', 'AddRights', null, 'role/add', null, '1', '142');
INSERT INTO `privilege` VALUES ('144', 'DeleteRights', null, 'role/delete', null, '1', '142');
INSERT INTO `privilege` VALUES ('145', 'UpdateRights', null, 'role/update', null, '1', '142');
INSERT INTO `privilege` VALUES ('146', 'ViewRights', null, 'role/list', null, '1', '142');

-- ----------------------------
-- Table structure for `relevance`
-- ----------------------------
DROP TABLE IF EXISTS `relevance`;
CREATE TABLE `relevance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `val` text,
  `description` varchar(255) DEFAULT '',
  `formtype` varchar(50) DEFAULT 'textbox',
  `min` int(11) DEFAULT NULL,
  `max` int(11) DEFAULT NULL,
  `minLen` int(11) NOT NULL,
  `maxLen` int(11) NOT NULL,
  `multiline` tinyint(4) NOT NULL DEFAULT '0',
  `required` tinyint(4) NOT NULL DEFAULT '1',
  `orderNum` int(11) DEFAULT NULL,
  `commonId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `commonId` (`commonId`),
  CONSTRAINT `relevance_ibfk_1` FOREIGN KEY (`commonId`) REFERENCES `common` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of relevance
-- ----------------------------

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------

-- ----------------------------
-- Table structure for `role_privilege`
-- ----------------------------
DROP TABLE IF EXISTS `role_privilege`;
CREATE TABLE `role_privilege` (
  `roleId` int(11) NOT NULL,
  `privilegeId` int(11) NOT NULL,
  PRIMARY KEY (`roleId`,`privilegeId`),
  KEY `privilegeId` (`privilegeId`),
  CONSTRAINT `role_privilege_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`),
  CONSTRAINT `role_privilege_ibfk_2` FOREIGN KEY (`privilegeId`) REFERENCES `privilege` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_privilege
-- ----------------------------

-- ----------------------------
-- Table structure for `so`
-- ----------------------------
DROP TABLE IF EXISTS `so`;
CREATE TABLE `so` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `updateDate` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of so
-- ----------------------------

-- ----------------------------
-- Table structure for `terminalType`
-- ----------------------------
DROP TABLE IF EXISTS `terminalType`;
CREATE TABLE `terminalType` (
  `terminalId` int(11) NOT NULL,
  `terminalName` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of terminalType
-- ----------------------------
INSERT INTO `terminalType` VALUES ('0', 'SatelliteOrdinaryHandheldTermina');
INSERT INTO `terminalType` VALUES ('1', 'SatelliteEnhancedHandheldTermina');
INSERT INTO `terminalType` VALUES ('3', 'SatellitePortableTermina');
INSERT INTO `terminalType` VALUES ('5', 'SatelliteCarTermina');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'nouser', 'a249681c33f044bc05b93c7ed4f4c482');

-- ----------------------------
-- Table structure for `user_role`
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `userId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`roleId`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
