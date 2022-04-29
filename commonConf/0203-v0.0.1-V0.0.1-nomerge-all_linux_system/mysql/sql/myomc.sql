/*
Navicat MySQL Data Transfer

Source Server         : 172.16.0.200（aj好的测试环境）
Source Server Version : 50505
Source Host           : 172.16.0.200:3306
Source Database       : myomc

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2022-02-18 17:22:38
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
  `createDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of alarm
-- ----------------------------

-- ----------------------------
-- Table structure for `card`
-- ----------------------------
DROP TABLE IF EXISTS `card`;
CREATE TABLE `card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `cardNum` int(11) NOT NULL DEFAULT 0,
  `slotId` int(11) NOT NULL DEFAULT 0,
  `ip` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of card
-- ----------------------------

-- ----------------------------
-- Table structure for `common`
-- ----------------------------
DROP TABLE IF EXISTS `common`;
CREATE TABLE `common` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
  `sole` tinyint(4) DEFAULT 0,
  `moduleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `moduleId` (`moduleId`) USING BTREE,
  CONSTRAINT `config_ibfk_1` FOREIGN KEY (`moduleId`) REFERENCES `module` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES ('1', 'net', '', '网络配置', '0', null);
INSERT INTO `config` VALUES ('2', 'tls', '', 'TLS参数配置', '0', null);
INSERT INTO `config` VALUES ('3', 'performance', '', '性能参数配置', '0', null);
INSERT INTO `config` VALUES ('4', 'service', '', '基本服务配置', '0', null);
INSERT INTO `config` VALUES ('5', 'runtime', '', '运行参数配置', '0', null);
INSERT INTO `config` VALUES ('6', 'board', '', '板卡规划配置', '0', null);
INSERT INTO `config` VALUES ('7', 'startup', '', '开机启动', '0', null);
INSERT INTO `config` VALUES ('8', 'groupManage', '', '组配置', '0', null);
INSERT INTO `config` VALUES ('9', 'groupPolicy', '', '组策略配置', '0', null);
INSERT INTO `config` VALUES ('10', 'groupEnsure', '', '用户优先保障策略', '0', null);
INSERT INTO `config` VALUES ('11', 'acl', '', 'ACLInfo', '0', null);
INSERT INTO `config` VALUES ('12', 'blacklist', '', '黑名单', '0', null);
INSERT INTO `config` VALUES ('13', 'spite', '', '恶意访问检测策略', '0', null);
INSERT INTO `config` VALUES ('14', 'business', '', '业务限制策略', '0', null);
INSERT INTO `config` VALUES ('15', 'media', '', '媒体链路信息', '0', null);
INSERT INTO `config` VALUES ('16', 'status', '', '用户注册状态', '0', null);
INSERT INTO `config` VALUES ('17', 'boardStatus', '', '板卡状态', '0', null);
INSERT INTO `config` VALUES ('18', 'alarm', '', '运行告警', '0', null);
INSERT INTO `config` VALUES ('19', 'statistics', '', '统计信息', '0', null);

-- ----------------------------
-- Table structure for `configuserpriority`
-- ----------------------------
DROP TABLE IF EXISTS `configuserpriority`;
CREATE TABLE `configuserpriority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  `enable` int(11) NOT NULL,
  `userType` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of configuserpriority
-- ----------------------------
INSERT INTO `configuserpriority` VALUES ('1', '1', '1', '1', '0');
INSERT INTO `configuserpriority` VALUES ('2', '2', '2', '1', '0');
INSERT INTO `configuserpriority` VALUES ('3', '3', '3', '1', '0');
INSERT INTO `configuserpriority` VALUES ('4', '4', '4', '1', '0');
INSERT INTO `configuserpriority` VALUES ('5', '5', '5', '1', '0');
INSERT INTO `configuserpriority` VALUES ('6', '6', '6', '1', '0');
INSERT INTO `configuserpriority` VALUES ('7', '7', '7', '1', '0');
INSERT INTO `configuserpriority` VALUES ('8', '8', '8', '1', '0');
INSERT INTO `configuserpriority` VALUES ('9', '9', '9', '1', '0');
INSERT INTO `configuserpriority` VALUES ('10', '10', '10', '1', '0');
INSERT INTO `configuserpriority` VALUES ('11', '11', '11', '1', '0');
INSERT INTO `configuserpriority` VALUES ('12', '12', '12', '1', '0');
INSERT INTO `configuserpriority` VALUES ('13', '13', '13', '1', '0');
INSERT INTO `configuserpriority` VALUES ('14', '14', '14', '1', '0');
INSERT INTO `configuserpriority` VALUES ('15', '15', '15', '1', '0');

-- ----------------------------
-- Table structure for `entity`
-- ----------------------------
DROP TABLE IF EXISTS `entity`;
CREATE TABLE `entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `instId` int(11) NOT NULL,
  `status` int(11) DEFAULT 0,
  `type` int(11) DEFAULT 0,
  `description` varchar(255) DEFAULT NULL,
  `moduleId` int(11) DEFAULT NULL,
  `cardId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `moduleId` (`moduleId`) USING BTREE,
  KEY `cardId` (`cardId`) USING BTREE,
  CONSTRAINT `entity_ibfk_1` FOREIGN KEY (`moduleId`) REFERENCES `module` (`id`),
  CONSTRAINT `entity_ibfk_2` FOREIGN KEY (`cardId`) REFERENCES `card` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of entity
-- ----------------------------

-- ----------------------------
-- Table structure for `hssbusiness`
-- ----------------------------
DROP TABLE IF EXISTS `hssbusiness`;
CREATE TABLE `hssbusiness` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `i18n` varchar(25) NOT NULL,
  `basic` tinyint(4) NOT NULL DEFAULT 1,
  `enable` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of hssbusiness
-- ----------------------------
INSERT INTO `hssbusiness` VALUES ('1', 'groupdata', 'GroupData', '1', '0');
INSERT INTO `hssbusiness` VALUES ('2', 'shortMsg', 'MessageTraffic', '1', '1');
INSERT INTO `hssbusiness` VALUES ('3', 'internationality', 'InternationalTraffic', '1', '0');
INSERT INTO `hssbusiness` VALUES ('4', 'callWaitting', 'CallTraffic', '1', '1');
INSERT INTO `hssbusiness` VALUES ('5', 'threeWay', 'Three-way-calling', '1', '1');
INSERT INTO `hssbusiness` VALUES ('6', 'callInLimit', 'Incoming-Call-Barring', '1', '1');
INSERT INTO `hssbusiness` VALUES ('7', 'callOutLimit', 'Outgoing-Call-Barring', '1', '1');
INSERT INTO `hssbusiness` VALUES ('8', 'pairNet', 'Dual-Network-Business', '1', '0');
INSERT INTO `hssbusiness` VALUES ('9', 'secrecy', 'Secrecy-Business', '1', '0');
INSERT INTO `hssbusiness` VALUES ('10', 'callerAllow', 'callerAllow', '1', '0');
INSERT INTO `hssbusiness` VALUES ('11', 'callerHide', 'callerHide', '1', '0');
INSERT INTO `hssbusiness` VALUES ('12', 'groupCall', 'groupCall', '1', '1');
INSERT INTO `hssbusiness` VALUES ('13', 'ims', 'IMSInformation', '0', '0');
INSERT INTO `hssbusiness` VALUES ('14', 'jtyw', 'ListeningBusiness', '0', '0');
INSERT INTO `hssbusiness` VALUES ('15', 'fzye', 'GroupingBusiness', '0', '1');
INSERT INTO `hssbusiness` VALUES ('16', 'ddyw', 'ScheduingBusiness', '0', '1');
INSERT INTO `hssbusiness` VALUES ('17', 'bcyw', 'SupplementaryServices', '0', '1');
INSERT INTO `hssbusiness` VALUES ('18', 'groupInfo', 'GroupMessage', '0', '1');
INSERT INTO `hssbusiness` VALUES ('19', 'auc', 'AUC', '0', '0');
INSERT INTO `hssbusiness` VALUES ('20', 'tft', 'TFTSetting', '0', '0');
INSERT INTO `hssbusiness` VALUES ('21', 'zdxx', 'TerminalInformation', '0', '1');
INSERT INTO `hssbusiness` VALUES ('22', 'epc', 'EPCInfo', '0', '0');
INSERT INTO `hssbusiness` VALUES ('23', 'slice', 'SliceService', '0', '1');

-- ----------------------------
-- Table structure for `hssdevicetype`
-- ----------------------------
DROP TABLE IF EXISTS `hssdevicetype`;
CREATE TABLE `hssdevicetype` (
  `id` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `enable` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of hssdevicetype
-- ----------------------------
INSERT INTO `hssdevicetype` VALUES ('0', 'UNKNOW', '0');
INSERT INTO `hssdevicetype` VALUES ('1', 'SIP', '0');
INSERT INTO `hssdevicetype` VALUES ('2', 'CDMA', '0');
INSERT INTO `hssdevicetype` VALUES ('3', 'GSM', '0');
INSERT INTO `hssdevicetype` VALUES ('4', 'WCDMA', '0');
INSERT INTO `hssdevicetype` VALUES ('5', 'LTE/TD', '1');
INSERT INTO `hssdevicetype` VALUES ('6', 'YD', '0');
INSERT INTO `hssdevicetype` VALUES ('7', 'TR', '0');
INSERT INTO `hssdevicetype` VALUES ('8', 'DISP', '0');
INSERT INTO `hssdevicetype` VALUES ('9', 'TETRA', '0');
INSERT INTO `hssdevicetype` VALUES ('10', 'ANALOG', '0');
INSERT INTO `hssdevicetype` VALUES ('11', 'RADIO', '0');
INSERT INTO `hssdevicetype` VALUES ('12', 'IMS', '0');
INSERT INTO `hssdevicetype` VALUES ('13', 'LTE-CPE', '0');

-- ----------------------------
-- Table structure for `hssusercount`
-- ----------------------------
DROP TABLE IF EXISTS `hssusercount`;
CREATE TABLE `hssusercount` (
  `hssName` varchar(11) NOT NULL,
  `hssCount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of hssusercount
-- ----------------------------
INSERT INTO `hssusercount` VALUES ('hss', '2032');
INSERT INTO `hssusercount` VALUES ('hss1', '508');
INSERT INTO `hssusercount` VALUES ('hss2', '508');
INSERT INTO `hssusercount` VALUES ('hss3', '508');
INSERT INTO `hssusercount` VALUES ('hss4', '508');

-- ----------------------------
-- Table structure for `hssviewitem`
-- ----------------------------
DROP TABLE IF EXISTS `hssviewitem`;
CREATE TABLE `hssviewitem` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `enable` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of hssviewitem
-- ----------------------------
INSERT INTO `hssviewitem` VALUES ('0', 'IMSI', '1');
INSERT INTO `hssviewitem` VALUES ('1', 'MDN', '1');
INSERT INTO `hssviewitem` VALUES ('2', 'DeviceName', '1');
INSERT INTO `hssviewitem` VALUES ('3', 'SpeechCodec', '1');
INSERT INTO `hssviewitem` VALUES ('4', 'MscAddr', '0');
INSERT INTO `hssviewitem` VALUES ('5', 'GateWayAddr', '0');
INSERT INTO `hssviewitem` VALUES ('6', 'bmNum', '0');
INSERT INTO `hssviewitem` VALUES ('7', 'UeDestroy', '0');
INSERT INTO `hssviewitem` VALUES ('8', 'LastUpdateTime', '1');
INSERT INTO `hssviewitem` VALUES ('9', 'Update', '1');
INSERT INTO `hssviewitem` VALUES ('10', 'UeSwoon', '0');

-- ----------------------------
-- Table structure for `hssvoicetype`
-- ----------------------------
DROP TABLE IF EXISTS `hssvoicetype`;
CREATE TABLE `hssvoicetype` (
  `id` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `enable` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of hssvoicetype
-- ----------------------------
INSERT INTO `hssvoicetype` VALUES ('0', 'PCMU', '0');
INSERT INTO `hssvoicetype` VALUES ('8', 'PCMA', '0');
INSERT INTO `hssvoicetype` VALUES ('18', 'G_729', '0');
INSERT INTO `hssvoicetype` VALUES ('35', 'EVRC', '0');
INSERT INTO `hssvoicetype` VALUES ('38', 'AHELP', '0');
INSERT INTO `hssvoicetype` VALUES ('39', 'ACELP', '0');
INSERT INTO `hssvoicetype` VALUES ('40', 'AMR', '0');
INSERT INTO `hssvoicetype` VALUES ('42', 'VC40', '1');
INSERT INTO `hssvoicetype` VALUES ('43', 'VC24', '1');
INSERT INTO `hssvoicetype` VALUES ('44', 'VC12', '1');
INSERT INTO `hssvoicetype` VALUES ('45', 'VC06', '0');

-- ----------------------------
-- Table structure for `ipdns`
-- ----------------------------
DROP TABLE IF EXISTS `ipdns`;
CREATE TABLE `ipdns` (
  `cardNum` int(11) NOT NULL DEFAULT 0,
  `eth` varchar(20) NOT NULL DEFAULT '',
  `ip` varchar(20) NOT NULL,
  `dnsStr` text DEFAULT NULL,
  PRIMARY KEY (`cardNum`,`eth`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ipdns
-- ----------------------------

-- ----------------------------
-- Table structure for `item`
-- ----------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `val` text DEFAULT NULL,
  `description` varchar(255) DEFAULT '',
  `formtype` varchar(50) DEFAULT 'textbox',
  `min` int(11) DEFAULT NULL,
  `max` int(11) DEFAULT NULL,
  `minLen` int(11) NOT NULL DEFAULT 0,
  `maxLen` int(11) NOT NULL DEFAULT 9999,
  `multiline` tinyint(4) NOT NULL DEFAULT 0,
  `required` tinyint(4) NOT NULL DEFAULT 1,
  `orderNum` int(11) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `configId` int(11) DEFAULT NULL,
  `relevanceId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `parentId` (`parentId`) USING BTREE,
  KEY `configId` (`configId`) USING BTREE,
  KEY `relevanceId` (`relevanceId`) USING BTREE,
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `item` (`id`),
  CONSTRAINT `item_ibfk_2` FOREIGN KEY (`configId`) REFERENCES `config` (`id`),
  CONSTRAINT `item_ibfk_3` FOREIGN KEY (`relevanceId`) REFERENCES `relevance` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of item
-- ----------------------------
INSERT INTO `item` VALUES ('1', 'UniNetworkAddr', null, '用户侧网络地址', 'ip', null, null, '0', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('2', 'UniNetworkPort', null, '用户侧端口', 'numberbox', '1', '65535', '0', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('3', 'NatUniNetwkAddr', null, '用户侧NAT地址', 'ip', null, null, '0', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('4', 'NniNetworkAddr', null, '网络侧网络地址', 'ip', null, null, '0', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('5', 'NniNetworkPort', null, '网络侧端口', 'numberbox', '1', '65535', '0', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('6', 'NatNniNetwkAddr', null, '网络侧NAT地址', 'ip', null, null, '0', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('7', 'MsrpServerIp', null, 'MSRP服务器地址', 'hidden', null, null, '0', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('8', 'MgcUniAddr', null, 'MGC服务器用户侧地址', 'hidden', null, null, '0', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('9', 'MgcNniAddr', null, 'MGC服务器网络侧地址', 'hidden', null, null, '0', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('10', 'RemoteCscfIp', null, 'PCSCF地址', 'ip', null, null, '0', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('11', 'RemoteCscfPort', null, 'PCSCF端口', 'numberbox', '0', '65535', '0', '9999', '0', '1', null, null, '1', null);
INSERT INTO `item` VALUES ('12', 'InitMode', null, '运行模式', 'combobox', null, null, '0', '9999', '0', '1', null, null, null, null);
INSERT INTO `item` VALUES ('13', 'BackupUniIp', null, '备板用户侧IP地址', 'ip', null, null, '0', '9999', '0', '1', null, null, null, null);
INSERT INTO `item` VALUES ('14', 'BackupNniIp', null, '备板网络侧地址', 'ip', null, null, '0', '9999', '0', '1', null, null, null, null);
INSERT INTO `item` VALUES ('15', 'TLSFunc', null, 'TLS功能开关', 'combobox', null, null, '0', '9999', '0', '1', null, null, '2', null);
INSERT INTO `item` VALUES ('16', 'ClientCertificate', null, '客户端证书文件', 'textbox', null, null, '0', '9999', '0', '1', null, null, '2', null);
INSERT INTO `item` VALUES ('17', 'ClientKey', null, '客户端键值文件', 'textbox', null, null, '0', '9999', '0', '1', null, null, '2', null);
INSERT INTO `item` VALUES ('18', 'ServerCertificate', null, '服务端证书文件', 'textbox', null, null, '0', '9999', '0', '1', null, null, '2', null);
INSERT INTO `item` VALUES ('19', 'ServerKey', null, '服务端键值文件', 'textbox', null, null, '0', '9999', '0', '1', null, null, '2', null);
INSERT INTO `item` VALUES ('20', 'CACertificate', null, 'CA证书文件', 'textbox', null, null, '0', '9999', '0', '1', null, null, '2', null);
INSERT INTO `item` VALUES ('21', 'MaxRegUserNum', null, '最大用户注册数', 'numberbox', '0', null, '0', '9999', '0', '1', null, null, '3', null);
INSERT INTO `item` VALUES ('22', 'MaxSessionNum', null, '最大会话数', 'numberbox', '0', null, '0', '9999', '0', '1', null, null, '3', null);
INSERT INTO `item` VALUES ('23', 'MaxCallSessionNum', null, '最大呼叫会话数', 'numberbox', '0', null, '0', '9999', '0', '1', null, null, '3', null);
INSERT INTO `item` VALUES ('24', 'MaxCpuUsed', null, '最大系统CPU使用率', 'numberbox', '1', '99', '0', '9999', '0', '1', null, null, '3', null);
INSERT INTO `item` VALUES ('25', 'MaxMemUsed', null, '最大系统MEM使用率', 'numberbox', '1', '99', '0', '9999', '0', '1', null, null, '3', null);
INSERT INTO `item` VALUES ('26', 'MaxLanRate', null, '最大网口速率', 'numberbox', '1', null, '0', '9999', '0', '1', null, null, '3', null);
INSERT INTO `item` VALUES ('27', 'MaxSigRate', null, '最大信令速率', 'numberbox', '1', null, '0', '9999', '0', '1', null, null, '3', null);
INSERT INTO `item` VALUES ('28', 'MaxBandWidthUsed', null, '最大媒体带宽速率', 'numberbox', '0', null, '0', '9999', '0', '1', null, null, '3', null);
INSERT INTO `item` VALUES ('29', 'MaxRegRate', null, '最大注册速率', 'numberbox', '1', null, '0', '9999', '0', '1', null, null, null, null);
INSERT INTO `item` VALUES ('30', 'MaxCallRate', null, '最大呼叫速率', 'numberbox', '1', null, '0', '9999', '0', '1', null, null, null, null);
INSERT INTO `item` VALUES ('31', 'SSH', null, 'SSH服务', 'combobox', null, null, '0', '9999', '0', '1', null, null, '4', null);
INSERT INTO `item` VALUES ('32', 'FTP', null, 'FTP服务', 'combobox', null, null, '0', '9999', '0', '1', null, null, '4', null);
INSERT INTO `item` VALUES ('33', 'HTTP', null, 'HTTP服务', 'combobox', null, null, '0', '9999', '0', '1', null, null, '4', null);
INSERT INTO `item` VALUES ('34', 'TFTP', null, 'TFTP服务', 'combobox', null, null, '0', '9999', '0', '1', null, null, '4', null);
INSERT INTO `item` VALUES ('35', 'DNS', null, 'DNS服务', 'combobox', null, null, '0', '9999', '0', '1', null, null, '4', null);
INSERT INTO `item` VALUES ('36', 'BlkTimerVal', null, '黑名单定时时长', 'numberbox', '1', '5', '0', '9999', '0', '1', null, null, '5', null);
INSERT INTO `item` VALUES ('37', 'SigBoard1_UniAddr', null, '信令板1用户侧IP地址', 'ip', null, null, '0', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('38', 'SigBoard1_NniAddr', null, '信令板1网络侧IP地址', 'ip', null, null, '0', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('39', 'SigBoard2_UniAddr', null, '信令板2用户侧IP地址', 'ip', null, null, '0', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('40', 'SigBoard2_NniAddr', null, '信令板2网络侧IP地址', 'ip', null, null, '0', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('41', 'MediaBoard_UniAddr', null, '媒体板用户侧IP地址', 'ip', null, null, '0', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('42', 'MediaBoard_NniAddr', null, '媒体板网络侧IP地址', 'ip', null, null, '0', '9999', '0', '1', null, null, '6', null);
INSERT INTO `item` VALUES ('43', 'StartType', null, '启动类型', 'numberbox', '0', '15', '0', '9999', '0', '1', null, null, '7', null);
INSERT INTO `item` VALUES ('44', 'GoupManage', null, '组配置', 'grid', null, null, '0', '9999', '0', '1', null, null, '8', null);
INSERT INTO `item` VALUES ('45', 'GroupCacProfileID', null, '组CAC配置项ID', 'combobox', '1', null, '0', '9999', '0', '1', null, '44', '8', null);
INSERT INTO `item` VALUES ('46', 'GroupID', null, '组ID', 'numberbox', '1', null, '0', '9999', '0', '1', null, '44', '8', null);
INSERT INTO `item` VALUES ('47', 'ParentGroupID', null, '所属组ID', 'numberbox', '1', null, '0', '9999', '0', '1', null, '44', '8', null);
INSERT INTO `item` VALUES ('48', 'GroupStartMdn', null, '组起始MDN', 'numberbox', null, null, '0', '9999', '0', '1', null, '44', '8', null);
INSERT INTO `item` VALUES ('49', 'GroupEndMdn', null, '组结束MDN', 'numberbox', null, null, '0', '9999', '0', '1', null, '44', '8', null);
INSERT INTO `item` VALUES ('50', 'GroupStartIp', null, '组开始IP', 'ip', null, null, '0', '9999', '0', '1', null, '44', '8', null);
INSERT INTO `item` VALUES ('51', 'GroupPolicy', null, '组策略配置', 'grid', null, null, '0', '9999', '0', '1', null, null, '9', null);
INSERT INTO `item` VALUES ('52', 'GroupPolicy_maxUserRegNum', null, '最大注册用户数', 'numberbox', '0', null, '0', '9999', '0', '1', null, '51', '9', null);
INSERT INTO `item` VALUES ('53', 'GroupPolicy_maxSessionNum', null, '最大会话数', 'numberbox', '0', null, '0', '9999', '0', '1', null, '51', '9', null);
INSERT INTO `item` VALUES ('54', 'GroupPolicy_sigQos', null, '组信令Qos', 'numberbox', '0', '63', '0', '9999', '0', '1', null, '51', '9', null);
INSERT INTO `item` VALUES ('55', 'GroupPolicy_meidaQos', null, '组媒体Qos', 'numberbox', '0', '63', '0', '9999', '0', '1', null, '51', '9', null);
INSERT INTO `item` VALUES ('56', 'GroupPolicy_sigRate', null, '最大信令速率', 'numberbox', '1', null, '0', '9999', '0', '1', null, '51', '9', null);
INSERT INTO `item` VALUES ('57', 'GroupPolicy_mediaRate', null, '最大媒体速率', 'numberbox', '0', null, '0', '9999', '0', '1', null, '51', '9', null);
INSERT INTO `item` VALUES ('58', 'GroupPolicy_sigRatePerUser', null, '最大单用户信令速率', 'numberbox', '0', null, '0', '9999', '0', '1', null, '51', '9', null);
INSERT INTO `item` VALUES ('59', 'GroupPolicy_mediaRatePerUser', null, '最大单用户媒体速率', 'numberbox', '1', null, '0', '9999', '0', '1', null, '51', '9', null);
INSERT INTO `item` VALUES ('60', 'GroupPolicy_cpuUsed', null, '最大CPU使用率', 'numberbox', '1', null, '0', '9999', '0', '1', null, '51', '9', null);
INSERT INTO `item` VALUES ('61', 'GroupPolicy_maxRegRate', null, '最大注册速率', 'numberbox', '0', null, '0', '9999', '0', '1', null, '51', '9', null);
INSERT INTO `item` VALUES ('62', 'GroupPolicy_maxCallRate', null, '最大呼叫速率', 'numberbox', '0', null, '0', '9999', '0', '1', null, '51', '9', null);
INSERT INTO `item` VALUES ('63', 'GroupPolicy_cacProfileID', null, '组CAC配置ID', 'numberbox', '1', null, '0', '9999', '0', '1', null, '51', '9', null);
INSERT INTO `item` VALUES ('64', 'Level0_UserPriority', null, '0级保障用户级别', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('65', 'Level0_CPUUsed', null, '0级保障CPU使用率', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('66', 'Level0_BWUsed', null, '0级保障媒体使用率', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('67', 'Level1_UserPriority', null, '1级保障用户级别', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('68', 'Level1_CPUUsed', null, '1级保障CPU使用率', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('69', 'Level1_BWUsed', null, '1级保障媒体使用率', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('70', 'Level2_UserPriority', null, '2级保障用户级别', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('71', 'Level2_CPUUsed', null, '2级保障CPU使用率', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('72', 'Level2_BWUsed', null, '2级保障媒体使用率', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('73', 'Acl', null, 'ACLInfo', 'grid', null, null, '0', '9999', '0', '1', null, null, '11', null);
INSERT INTO `item` VALUES ('74', 'ProtoType', null, '协议类型', 'combobox', null, null, '0', '9999', '0', '1', null, '73', '11', null);
INSERT INTO `item` VALUES ('75', 'SrcAddr', null, '源IP地址', 'ip', null, null, '0', '9999', '0', '1', null, '73', '11', null);
INSERT INTO `item` VALUES ('76', 'DstAddr', null, '目的IP地址', 'ip', null, null, '0', '9999', '0', '1', null, '73', '11', null);
INSERT INTO `item` VALUES ('77', 'DstPort', null, '目的端口号', 'numberbox', '0', '65535', '0', '9999', '0', '1', null, '73', '11', null);
INSERT INTO `item` VALUES ('78', 'SrcPort', null, '源端口号', 'textbox', '0', '65535', '0', '9999', '0', '1', null, '73', '11', null);
INSERT INTO `item` VALUES ('79', 'AccessType', null, '用户连接状态', 'combobox', null, null, '0', '9999', '0', '1', null, '73', '11', null);
INSERT INTO `item` VALUES ('80', 'Blacklist', null, '黑名单', 'grid', null, null, '0', '9999', '0', '1', null, null, '12', null);
INSERT INTO `item` VALUES ('81', 'ProtoType', null, '协议类型', 'combobox', null, null, '0', '9999', '0', '1', null, '80', '12', null);
INSERT INTO `item` VALUES ('82', 'Port', null, '端口号', 'numberbox', '0', '65535', '0', '9999', '0', '1', null, '80', '12', null);
INSERT INTO `item` VALUES ('83', 'Addr', null, 'IP地址', 'ip', null, null, '0', '9999', '0', '1', null, '80', '12', null);
INSERT INTO `item` VALUES ('84', 'MaxBadSipMsgRate', null, '最大畸形消息速率', 'numberbox', '0', '20000', '0', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('85', 'MaxInviteReqRate', null, '最大呼叫请求速率', 'numberbox', '0', '20000', '0', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('86', 'MaxRegReqRate', null, '最大注册请求速率', 'numberbox', '0', '20000', '0', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('87', 'Business', null, '业务限制策略', 'grid', null, null, '0', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('88', 'RegLimitIp', null, '注册限制IP', 'ip', null, null, '0', '9999', '0', '1', null, '87', '14', null);
INSERT INTO `item` VALUES ('89', 'RegLimitMdn', null, '注册限制MDN', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('90', 'CallLimitIn', null, '主叫SIP URI限制', 'textbox', null, null, '0', '9999', '0', '1', null, '87', '14', null);
INSERT INTO `item` VALUES ('91', 'CallLimitOut', null, '被叫SIP URI限制', 'textbox', null, null, '0', '9999', '0', '1', null, '87', '14', null);
INSERT INTO `item` VALUES ('92', 'DstIPLimit', null, '目的IP限制', 'ip', null, null, '0', '9999', '0', '1', null, '87', '14', null);
INSERT INTO `item` VALUES ('93', 'SrcIPLimit', null, '源IP限制', 'ip', null, null, '0', '9999', '0', '1', null, null, '14', null);
INSERT INTO `item` VALUES ('94', 'Media', null, '媒体链路信息', 'grid', null, null, '0', '9999', '0', '1', null, null, '15', null);
INSERT INTO `item` VALUES ('95', 'LinkId', null, '链路ID', 'numberbox', '1', null, '0', '9999', '0', '1', null, '94', '15', null);
INSERT INTO `item` VALUES ('96', 'SrcAddr', null, '源地址', 'ip', null, null, '0', '9999', '0', '1', null, '94', '15', null);
INSERT INTO `item` VALUES ('97', 'DstAddr', null, '目的地址', 'ip', null, null, '0', '9999', '0', '1', null, '94', '15', null);
INSERT INTO `item` VALUES ('98', 'SrcPort', null, '源端口', 'numberbox', '0', '65535', '0', '9999', '0', '1', null, '94', '15', null);
INSERT INTO `item` VALUES ('99', 'DstPort', null, '目的端口', 'numberbox', '0', '65535', '0', '9999', '0', '1', null, '94', '15', null);
INSERT INTO `item` VALUES ('100', 'QosVal', null, 'Qos值', 'numberbox', '0', '31', '0', '9999', '0', '1', null, '94', '15', null);
INSERT INTO `item` VALUES ('101', 'Status', null, '用户注册状态', 'grid', null, null, '0', '9999', '0', '1', null, null, '16', null);
INSERT INTO `item` VALUES ('102', 'UserId', null, '用户ID', 'numberbox', '1', null, '0', '9999', '0', '1', null, null, null, null);
INSERT INTO `item` VALUES ('103', 'GroupNo', null, '组号', 'numberbox', '1', null, '0', '9999', '0', '1', null, '101', '16', null);
INSERT INTO `item` VALUES ('104', 'UserNo', null, '用户MDN', 'textbox', null, null, '0', '9999', '0', '1', null, '101', '16', null);
INSERT INTO `item` VALUES ('105', 'UeIp', null, '用户IP', 'ip', null, null, '0', '9999', '0', '1', null, '101', '16', null);
INSERT INTO `item` VALUES ('106', 'UePort', null, '用户端口', 'numberbox', '0', '65535', '0', '9999', '0', '1', null, '101', '16', null);
INSERT INTO `item` VALUES ('107', 'RegisterStatus', null, '注册状态', 'combobox', null, null, '0', '9999', '0', '1', null, '101', '16', null);
INSERT INTO `item` VALUES ('108', 'RegisterTime', null, '首次注册时间', 'textbox', null, null, '0', '9999', '0', '1', null, '101', '16', null);
INSERT INTO `item` VALUES ('109', 'LastRegisterTime', null, '上次注册时间', 'textbox', null, null, '0', '9999', '0', '1', null, '101', '16', null);
INSERT INTO `item` VALUES ('110', 'BoardStatusGrid', null, '板卡状态查询', 'grid', null, null, '0', '9999', '0', '1', null, null, '17', null);
INSERT INTO `item` VALUES ('111', 'BoardID', null, '板卡ID', 'numberbox', '1', '16', '0', '9999', '0', '1', null, '110', '17', null);
INSERT INTO `item` VALUES ('112', 'BoardType', null, '板卡类型', 'combobox', null, null, '0', '9999', '0', '1', null, '110', '17', null);
INSERT INTO `item` VALUES ('113', 'BoardStatus', null, '板卡状态', 'combobox', null, null, '0', '9999', '0', '1', null, '110', '17', null);
INSERT INTO `item` VALUES ('114', 'Reason', null, '异常原因', 'textbox', null, null, '0', '9999', '0', '1', null, '110', '17', null);
INSERT INTO `item` VALUES ('115', 'Alarm', null, '运行告警', 'grid', null, null, '0', '9999', '0', '1', null, null, '18', null);
INSERT INTO `item` VALUES ('116', 'WarnningID', null, '告警ID', 'numberbox', null, null, '0', '9999', '0', '1', null, '115', '18', null);
INSERT INTO `item` VALUES ('117', 'Level', null, '告警级别', 'numberbox', null, null, '0', '9999', '0', '1', null, '115', '18', null);
INSERT INTO `item` VALUES ('118', 'Description', null, '告警描述', 'textbox', null, null, '0', '9999', '0', '1', null, '115', '18', null);
INSERT INTO `item` VALUES ('119', 'Type', null, '告警类型', 'numberbox', null, null, '0', '9999', '0', '1', null, '115', '18', null);
INSERT INTO `item` VALUES ('120', 'UserRegisteredNum', null, '已注册用户数', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '19', null);
INSERT INTO `item` VALUES ('121', 'AliveCallNum', null, '呼叫保持会话数', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '19', null);
INSERT INTO `item` VALUES ('122', 'ProcedingCallNum', null, '呼叫进行会话数', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '19', null);
INSERT INTO `item` VALUES ('123', 'FailedCallNum', null, '呼叫失败会话数', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '19', null);
INSERT INTO `item` VALUES ('124', 'UsedCPU', null, 'CPU使用率', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '19', null);
INSERT INTO `item` VALUES ('125', 'MediaBWUsed', null, '媒体带宽使用率', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '19', null);
INSERT INTO `item` VALUES ('126', 'GroupEndIp', null, '组结束IP', 'ip', null, null, '0', '9999', '0', '1', null, '44', '8', null);
INSERT INTO `item` VALUES ('127', 'Level3_UserPriority', null, '3级保障用户级别', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('128', 'Level3_CPUUsed', null, '3级保障CPU使用率', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('129', 'Level3_BWUsed', null, '3级保障媒体使用率', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '10', null);
INSERT INTO `item` VALUES ('130', 'BlkInviteReqRate', null, '最大呼叫请求速率(黑名单)', 'numberbox', '0', '20000', '0', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('131', 'BlkRegReqRate', null, '最大注册请求速率(黑名单)', 'numberbox', '0', '20000', '0', '9999', '0', '1', null, null, '13', null);
INSERT INTO `item` VALUES ('132', 'LocalTlsIP', null, '本地地址', 'ip', null, null, '0', '9999', '0', '1', null, null, '2', null);
INSERT INTO `item` VALUES ('133', 'LocalTlsPort', null, '本地端口', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '2', null);
INSERT INTO `item` VALUES ('134', 'RemoteTlsIP', null, '远端地址', 'ip', null, null, '0', '9999', '0', '1', null, null, '2', null);
INSERT INTO `item` VALUES ('135', 'RemoteTlsPort', null, '本地地址', 'numberbox', null, null, '0', '9999', '0', '1', null, null, '2', null);

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
  `createDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of log
-- ----------------------------

-- ----------------------------
-- Table structure for `module`
-- ----------------------------
DROP TABLE IF EXISTS `module`;
CREATE TABLE `module` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `belong` int(11) DEFAULT 0,
  `description` varchar(255) DEFAULT '',
  `version` varchar(255) DEFAULT '',
  `exe` varchar(255) NOT NULL,
  `log` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of module
-- ----------------------------

-- ----------------------------
-- Table structure for `options`
-- ----------------------------
DROP TABLE IF EXISTS `options`;
CREATE TABLE `options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(50) NOT NULL,
  `val` varchar(255) NOT NULL,
  `itemId` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `itemId` (`itemId`) USING BTREE,
  CONSTRAINT `options_ibfk_1` FOREIGN KEY (`itemId`) REFERENCES `item` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of options
-- ----------------------------
INSERT INTO `options` VALUES ('1', '单板运行', '0', '12');
INSERT INTO `options` VALUES ('2', '主板运行', '1', '12');
INSERT INTO `options` VALUES ('3', '备板运行', '2', '12');
INSERT INTO `options` VALUES ('4', '关', '0', '15');
INSERT INTO `options` VALUES ('5', '开', '1', '15');
INSERT INTO `options` VALUES ('6', '关', '0', '31');
INSERT INTO `options` VALUES ('7', '开', '1', '31');
INSERT INTO `options` VALUES ('8', '关', '0', '32');
INSERT INTO `options` VALUES ('9', '开', '1', '32');
INSERT INTO `options` VALUES ('10', '关', '0', '33');
INSERT INTO `options` VALUES ('11', '开', '1', '33');
INSERT INTO `options` VALUES ('12', '关', '0', '34');
INSERT INTO `options` VALUES ('13', '开', '1', '34');
INSERT INTO `options` VALUES ('14', '关', '0', '35');
INSERT INTO `options` VALUES ('15', '开', '1', '35');
INSERT INTO `options` VALUES ('16', 'UDP', '1', '74');
INSERT INTO `options` VALUES ('17', 'TCP', '2', '74');
INSERT INTO `options` VALUES ('18', 'ICMP', '3', '74');
INSERT INTO `options` VALUES ('19', 'accept', '0', '79');
INSERT INTO `options` VALUES ('20', 'denied', '1', '79');
INSERT INTO `options` VALUES ('21', 'UDP', '1', '81');
INSERT INTO `options` VALUES ('22', 'TCP', '2', '81');
INSERT INTO `options` VALUES ('23', 'ICMP', '3', '81');
INSERT INTO `options` VALUES ('24', 'off', '0', '107');
INSERT INTO `options` VALUES ('25', 'on', '1', '107');
INSERT INTO `options` VALUES ('26', '信令板', '0', '112');
INSERT INTO `options` VALUES ('27', '媒体板', '1', '112');
INSERT INTO `options` VALUES ('28', '交换板', '2', '112');
INSERT INTO `options` VALUES ('29', '接口板', '3', '112');
INSERT INTO `options` VALUES ('30', '正常', '0', '113');
INSERT INTO `options` VALUES ('31', '链路故障', '1', '113');
INSERT INTO `options` VALUES ('32', '断电', '2', '113');

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE,
  UNIQUE KEY `url` (`url`) USING BTREE,
  KEY `parentId` (`parentId`) USING BTREE,
  CONSTRAINT `privilege_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `privilege` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of privilege
-- ----------------------------
INSERT INTO `privilege` VALUES ('1', 'TerminalUserManager', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('2', 'HSSManager', null, 'hss/listUI', null, '0', '1');
INSERT INTO `privilege` VALUES ('3', 'AddTerminalUser', null, 'hss/add', null, '1', '2');
INSERT INTO `privilege` VALUES ('4', 'DeleteTerminalUser', null, 'hss/delete', null, '1', '2');
INSERT INTO `privilege` VALUES ('5', 'UpdateTerminalUser', null, 'hss/update', null, '1', '2');
INSERT INTO `privilege` VALUES ('6', 'ViewTerminalUser', null, 'hss/list', null, '1', '2');
INSERT INTO `privilege` VALUES ('7', 'UeDestroy', null, 'hss/ueDestroy', null, '1', '2');
INSERT INTO `privilege` VALUES ('8', 'UeRestore', null, 'hss/ueRestore', null, '1', '2');
INSERT INTO `privilege` VALUES ('9', 'UeSwoon', null, 'hss/ueSwoon', null, '1', '2');
INSERT INTO `privilege` VALUES ('10', 'ImportExcel', null, 'hss/importExcel', null, '1', '2');
INSERT INTO `privilege` VALUES ('11', 'ImportUserData', null, 'hss/importUserData', null, '1', '2');
INSERT INTO `privilege` VALUES ('12', 'ExportUserData', null, 'hss/exportUserData', null, '1', '2');
INSERT INTO `privilege` VALUES ('13', 'HSSReduancyManager', null, 'hss/reduancyListUI', null, '1', '1');
INSERT INTO `privilege` VALUES ('14', 'IMSUserManager', null, 'ims/listUI', null, '0', '1');
INSERT INTO `privilege` VALUES ('15', 'AddIMSUser', null, 'ims/add', null, '1', '14');
INSERT INTO `privilege` VALUES ('16', 'DeleteIMSUser', null, 'ims/delete', null, '1', '14');
INSERT INTO `privilege` VALUES ('17', 'UpdateIMSUser', null, 'ims/update', null, '1', '14');
INSERT INTO `privilege` VALUES ('18', 'ViewIMSUser', null, 'ims/list', null, '1', '14');
INSERT INTO `privilege` VALUES ('19', 'GroupCallGroupManage', null, 'hssGroup/listUI', null, '0', '1');
INSERT INTO `privilege` VALUES ('20', 'AddGroupCallGroup', null, 'hssGroup/add', null, '1', '19');
INSERT INTO `privilege` VALUES ('21', 'DeleteGroupCallGroup', null, 'hssGroup/delete', null, '1', '19');
INSERT INTO `privilege` VALUES ('22', 'UpdateGroupCallGroup', null, 'hssGroup/update', null, '1', '19');
INSERT INTO `privilege` VALUES ('23', 'ViewGroupCallGroup', null, 'hssGroup/list', null, '1', '19');
INSERT INTO `privilege` VALUES ('24', 'MeetingGroupManage', null, 'meetingGroup/listUI2', null, '0', '1');
INSERT INTO `privilege` VALUES ('25', 'AddMeetingGroup', null, 'meetingGroup/add', null, '1', '24');
INSERT INTO `privilege` VALUES ('26', 'DeleteMeetingGroup', null, 'meetingGroup/delete', null, '1', '24');
INSERT INTO `privilege` VALUES ('27', 'UpdateMeetingGroup', null, 'meetingGroup/update', null, '1', '24');
INSERT INTO `privilege` VALUES ('28', 'ViewMeetingGroup', null, 'meetingGroup/list', null, '1', '24');
INSERT INTO `privilege` VALUES ('29', 'priorityManage', null, 'hss/listMdnUI', null, '0', '1');
INSERT INTO `privilege` VALUES ('30', 'priorityModifity', null, 'hss/updatePriority', null, '1', '29');
INSERT INTO `privilege` VALUES ('31', 'HssItemConf', null, 'hssParam/listUI', null, '0', '1');
INSERT INTO `privilege` VALUES ('32', 'HssParamUpdate', null, 'hssParam/update', null, '1', '31');
INSERT INTO `privilege` VALUES ('33', 'userGroupPriority', null, 'hss/userGroupListUI', null, '0', '1');
INSERT INTO `privilege` VALUES ('34', 'SystemManager', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('35', 'NetworkManager', null, 'eth/listUI', null, '0', '34');
INSERT INTO `privilege` VALUES ('36', 'ViewableDns', null, 'omc/viewableDns', null, '1', '35');
INSERT INTO `privilege` VALUES ('37', 'EthActivateUpdate', null, 'eth/activateUpdate', null, '1', '35');
INSERT INTO `privilege` VALUES ('38', 'EthActivateAdd', null, 'eth/activateAdd', null, '1', '35');
INSERT INTO `privilege` VALUES ('39', 'EthStaticAdd', null, 'eth/staticAdd', null, '1', '35');
INSERT INTO `privilege` VALUES ('40', 'EthStaticUpdate', null, 'eth/staticUpdate', null, '1', '35');
INSERT INTO `privilege` VALUES ('41', 'EthDelete', null, 'eth/delete', null, '1', '35');
INSERT INTO `privilege` VALUES ('42', 'Active', null, 'eth/active', null, '1', '35');
INSERT INTO `privilege` VALUES ('43', 'goActive', null, 'eth/goActive', null, '1', '35');
INSERT INTO `privilege` VALUES ('44', 'EthViewData', null, 'eth/viewData', null, '1', '35');
INSERT INTO `privilege` VALUES ('45', 'RouteManager', null, 'route/listUI', null, '0', '34');
INSERT INTO `privilege` VALUES ('46', 'HostAddressManager', null, 'hostaddr/listUI', null, '0', '34');
INSERT INTO `privilege` VALUES ('47', 'AddHost', null, 'hostaddr/add', null, '1', '46');
INSERT INTO `privilege` VALUES ('48', 'DeleteHost', null, 'hostaddr/delete', null, '1', '46');
INSERT INTO `privilege` VALUES ('49', 'ViewData', null, 'hostaddr/view', null, '1', '46');
INSERT INTO `privilege` VALUES ('50', 'DefaultRoute', null, 'route/defaultRoute', null, '1', '45');
INSERT INTO `privilege` VALUES ('51', 'AddRoute', null, 'route/addRoute', null, '1', '45');
INSERT INTO `privilege` VALUES ('52', 'RouteViewData', null, 'route/viewData', null, '1', '45');
INSERT INTO `privilege` VALUES ('53', 'DeleteRoute', null, 'route/deleteRoute', null, '1', '45');
INSERT INTO `privilege` VALUES ('54', 'OSPF', null, 'route/ospf', null, '1', '45');
INSERT INTO `privilege` VALUES ('55', 'HostNameAndDNSManager', null, 'dns/listUI', null, '0', '34');
INSERT INTO `privilege` VALUES ('56', 'CardManager', null, 'card/listUI', null, '0', '34');
INSERT INTO `privilege` VALUES ('57', 'DnsManager', null, 'dnsServer/listUI', null, '0', '34');
INSERT INTO `privilege` VALUES ('58', 'ResourceLibraryManager', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('59', 'ResourcePackageManager', null, 'module/listUI', null, '0', '58');
INSERT INTO `privilege` VALUES ('60', 'SinglePackageUpload', null, 'module/upload', null, '1', '59');
INSERT INTO `privilege` VALUES ('61', 'MultiplePackageUpload', null, 'module/uploadAll', null, '1', '59');
INSERT INTO `privilege` VALUES ('62', 'DeleteResourcePackage', null, 'module/delete', null, '1', '59');
INSERT INTO `privilege` VALUES ('63', 'UpdateBasicInformation', null, 'module/update', null, '1', '59');
INSERT INTO `privilege` VALUES ('64', 'ViewResourcePackage', null, 'module/list', null, '1', '59');
INSERT INTO `privilege` VALUES ('65', 'DynamicLibraryManager', null, 'so/listUI', null, '0', '58');
INSERT INTO `privilege` VALUES ('66', 'UploadDynamicLibrary', null, 'so/upload', null, '1', '65');
INSERT INTO `privilege` VALUES ('67', 'DeleteDynamicLibrary', null, 'so/delete', null, '1', '65');
INSERT INTO `privilege` VALUES ('68', 'ViewDynamicLibrary', null, 'so/list', null, '1', '65');
INSERT INTO `privilege` VALUES ('69', 'ConfigPageManager', null, 'common/listUI', null, '0', '58');
INSERT INTO `privilege` VALUES ('70', 'AddConfigPage', null, 'common/save', null, '1', '69');
INSERT INTO `privilege` VALUES ('71', 'DeleteConfigPage', null, 'common/delete', null, '1', '69');
INSERT INTO `privilege` VALUES ('72', 'UpdateConfigPage', null, 'common/update', null, '1', '69');
INSERT INTO `privilege` VALUES ('73', 'ViewConfigPage', null, 'common/list', null, '1', '69');
INSERT INTO `privilege` VALUES ('74', 'ViewThisPageConfigItem', null, 'common/show', null, '1', '69');
INSERT INTO `privilege` VALUES ('75', 'ConfigParameterManager', null, 'relevance/listUI', null, '0', '58');
INSERT INTO `privilege` VALUES ('76', 'AddConfigParameter', null, 'relevance/save', null, '1', '75');
INSERT INTO `privilege` VALUES ('77', 'DeleteConfigParameter', null, 'relevance/delete', null, '1', '75');
INSERT INTO `privilege` VALUES ('78', 'UpdateConfigParameter', null, 'relevance/update', null, '1', '75');
INSERT INTO `privilege` VALUES ('79', 'ViewConfigParameter', null, 'relevance/list', null, '1', '75');
INSERT INTO `privilege` VALUES ('80', 'ViewAssociatedConfigItem', null, 'relevance/show', null, '1', '75');
INSERT INTO `privilege` VALUES ('81', 'ConfigFileManager', null, 'config/listUI', null, '0', '58');
INSERT INTO `privilege` VALUES ('82', 'UploadConfigFile', null, 'config/upload', null, '1', '81');
INSERT INTO `privilege` VALUES ('83', 'DeleteConfigFile', null, 'config/delete', null, '1', '81');
INSERT INTO `privilege` VALUES ('84', 'UpdateConfigFile', null, 'config/update', null, '1', '81');
INSERT INTO `privilege` VALUES ('85', 'ViewConfigFile', null, 'config/list', null, '1', '81');
INSERT INTO `privilege` VALUES ('86', 'ConfigItemManager', null, 'item/listUI', null, '0', '58');
INSERT INTO `privilege` VALUES ('87', 'AddConfigItem', null, 'item/save', null, '1', '86');
INSERT INTO `privilege` VALUES ('88', 'DeleteConfigItem', null, 'item/delete', null, '1', '86');
INSERT INTO `privilege` VALUES ('89', 'UpdateConfigItem', null, 'item/update', null, '1', '86');
INSERT INTO `privilege` VALUES ('90', 'ViewConfigItem', null, 'item/list', null, '1', '86');
INSERT INTO `privilege` VALUES ('91', 'NEPlanningAndManager', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('92', 'ExecuteNEManager', null, 'entity/listUI', null, '0', '91');
INSERT INTO `privilege` VALUES ('93', 'SendNE', null, 'entity/save', null, '1', '92');
INSERT INTO `privilege` VALUES ('94', 'DeleteNE', null, 'entity/delete', null, '1', '92');
INSERT INTO `privilege` VALUES ('95', 'CdEntityLog', null, 'entity/listLog', null, '1', '92');
INSERT INTO `privilege` VALUES ('96', 'UpdateNEBasicInformation', null, 'entity/update', null, '1', '92');
INSERT INTO `privilege` VALUES ('97', 'StartNE', null, 'entity/start', null, '1', '92');
INSERT INTO `privilege` VALUES ('98', 'StopNE', null, 'entity/stop', null, '1', '92');
INSERT INTO `privilege` VALUES ('99', 'ReStartNE', null, 'entity/restart', null, '1', '92');
INSERT INTO `privilege` VALUES ('100', 'StartupOnBoot', null, 'entity/startup', null, '1', '92');
INSERT INTO `privilege` VALUES ('101', 'ShutdownOnBoot', null, 'entity/shutdown', null, '1', '92');
INSERT INTO `privilege` VALUES ('102', 'NEParameterConfig', null, 'common/page', null, '0', '91');
INSERT INTO `privilege` VALUES ('103', 'ViewNEConfigParameter', null, 'common/component', null, '1', '102');
INSERT INTO `privilege` VALUES ('104', 'UpdateNEConfigParameter', null, 'common/modify', null, '1', '102');
INSERT INTO `privilege` VALUES ('105', 'OneKeyImportAndExport', null, 'onekey/view', null, '0', null);
INSERT INTO `privilege` VALUES ('106', 'LogAndAlarm', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('107', 'LogManager', null, 'log/listUI', null, '0', '106');
INSERT INTO `privilege` VALUES ('108', 'DeleteLog', null, 'log/delete', null, '1', '107');
INSERT INTO `privilege` VALUES ('109', 'ViewLog', null, 'log/list', null, '1', '107');
INSERT INTO `privilege` VALUES ('110', 'AlarmManager', null, 'alarm/listUI', null, '0', '106');
INSERT INTO `privilege` VALUES ('111', 'DeleteAlarm', null, 'alarm/delete', null, '1', '110');
INSERT INTO `privilege` VALUES ('112', 'ViewAlarm', null, 'alarm/list', null, '1', '110');
INSERT INTO `privilege` VALUES ('113', 'SelfCheck', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('114', 'StartupCheck', null, 'selfCheck/startupCheck', null, '1', '113');
INSERT INTO `privilege` VALUES ('115', 'RtCheck', null, 'selfCheck/rtCheck', null, '1', '113');
INSERT INTO `privilege` VALUES ('116', 'Out', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('117', 'ISUP', null, 'out/isup', null, '1', '116');
INSERT INTO `privilege` VALUES ('118', 'TUP', null, 'out/tup', null, '1', '116');
INSERT INTO `privilege` VALUES ('119', 'ISUP2', null, 'out/isup2', null, '1', '116');
INSERT INTO `privilege` VALUES ('120', 'TUP2', null, 'out/tup2', null, '1', '116');
INSERT INTO `privilege` VALUES ('121', 'SwitchArgument', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('122', 'NumberTranslation', null, 'switch/listUI', null, '0', '121');
INSERT INTO `privilege` VALUES ('123', 'AddSwitch', null, 'switch/addSwitch', null, '1', '122');
INSERT INTO `privilege` VALUES ('124', 'DeleteSwitch', null, 'switch/deleteSwitch', null, '1', '122');
INSERT INTO `privilege` VALUES ('125', 'SwitchViewData', null, 'switch/switchViewData', null, '1', '122');
INSERT INTO `privilege` VALUES ('126', 'SwitchSave', null, 'switch/switchSave', null, '1', '122');
INSERT INTO `privilege` VALUES ('127', 'OperatorsManager', null, null, null, '0', null);
INSERT INTO `privilege` VALUES ('128', 'UserManager', null, 'user/listUI', null, '0', '127');
INSERT INTO `privilege` VALUES ('129', 'AddUser', null, 'user/add', null, '1', '128');
INSERT INTO `privilege` VALUES ('130', 'DeleteUser', null, 'user/delete', null, '1', '128');
INSERT INTO `privilege` VALUES ('131', 'UpdateUser', null, 'user/update', null, '1', '128');
INSERT INTO `privilege` VALUES ('132', 'ViewUser', null, 'user/list', null, '1', '128');
INSERT INTO `privilege` VALUES ('133', 'RightsManager', null, 'role/listUI', null, '0', '127');
INSERT INTO `privilege` VALUES ('134', 'AddRights', null, 'role/add', null, '1', '133');
INSERT INTO `privilege` VALUES ('135', 'DeleteRights', null, 'role/delete', null, '1', '133');
INSERT INTO `privilege` VALUES ('136', 'UpdateRights', null, 'role/update', null, '1', '133');
INSERT INTO `privilege` VALUES ('137', 'ViewRights', null, 'role/list', null, '1', '133');

-- ----------------------------
-- Table structure for `relevance`
-- ----------------------------
DROP TABLE IF EXISTS `relevance`;
CREATE TABLE `relevance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `val` text DEFAULT NULL,
  `description` varchar(255) DEFAULT '',
  `formtype` varchar(50) DEFAULT 'textbox',
  `min` int(11) DEFAULT NULL,
  `max` int(11) DEFAULT NULL,
  `minLen` int(11) NOT NULL,
  `maxLen` int(11) NOT NULL,
  `multiline` tinyint(4) NOT NULL DEFAULT 0,
  `required` tinyint(4) NOT NULL DEFAULT 1,
  `orderNum` int(11) DEFAULT NULL,
  `commonId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `commonId` (`commonId`) USING BTREE,
  CONSTRAINT `relevance_ibfk_1` FOREIGN KEY (`commonId`) REFERENCES `common` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'admin', 'password');

-- ----------------------------
-- Table structure for `role_privilege`
-- ----------------------------
DROP TABLE IF EXISTS `role_privilege`;
CREATE TABLE `role_privilege` (
  `roleId` int(11) NOT NULL,
  `privilegeId` int(11) NOT NULL,
  PRIMARY KEY (`roleId`,`privilegeId`) USING BTREE,
  KEY `privilegeId` (`privilegeId`) USING BTREE,
  CONSTRAINT `role_privilege_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`),
  CONSTRAINT `role_privilege_ibfk_2` FOREIGN KEY (`privilegeId`) REFERENCES `privilege` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role_privilege
-- ----------------------------
INSERT INTO `role_privilege` VALUES ('1', '1');
INSERT INTO `role_privilege` VALUES ('1', '2');
INSERT INTO `role_privilege` VALUES ('1', '3');
INSERT INTO `role_privilege` VALUES ('1', '4');
INSERT INTO `role_privilege` VALUES ('1', '5');
INSERT INTO `role_privilege` VALUES ('1', '6');
INSERT INTO `role_privilege` VALUES ('1', '10');
INSERT INTO `role_privilege` VALUES ('1', '11');
INSERT INTO `role_privilege` VALUES ('1', '12');

-- ----------------------------
-- Table structure for `so`
-- ----------------------------
DROP TABLE IF EXISTS `so`;
CREATE TABLE `so` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `updateDate` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of so
-- ----------------------------

-- ----------------------------
-- Table structure for `task`
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskStartTime` varchar(255) DEFAULT NULL,
  `taskStopTime` varchar(255) DEFAULT NULL,
  `taskDescribe` varchar(255) DEFAULT NULL,
  `syn` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES ('9', '2021-09-26 11:05:00', '2021-09-30 11:05:00', '111', '0');
INSERT INTO `task` VALUES ('10', '2021-09-27 11:08:00', '2021-10-01 11:08:00', '222', '0');
INSERT INTO `task` VALUES ('11', '2021-09-27 11:08:00', '2021-10-01 11:08:00', '333', '0');
INSERT INTO `task` VALUES ('12', '2021-09-27 11:08:00', '2021-10-01 11:08:00', '444', '0');
INSERT INTO `task` VALUES ('13', '2021-09-26 11:22:00', '2021-10-01 11:22:00', '555', '0');
INSERT INTO `task` VALUES ('14', '2021-09-26 11:27:00', '2021-09-28 11:27:00', '666', '0');

-- ----------------------------
-- Table structure for `terminaltype`
-- ----------------------------
DROP TABLE IF EXISTS `terminaltype`;
CREATE TABLE `terminaltype` (
  `terminalId` int(11) NOT NULL,
  `terminalName` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of terminaltype
-- ----------------------------
INSERT INTO `terminaltype` VALUES ('0', '卫星普通型手持终端');
INSERT INTO `terminaltype` VALUES ('1', '卫星增强型手持终端');
INSERT INTO `terminaltype` VALUES ('3', '卫星便携终端');
INSERT INTO `terminaltype` VALUES ('5', '卫星车载终端');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'nouser', 'a249681c33f044bc05b93c7ed4f4c482');
INSERT INTO `user` VALUES ('2', 'admin', '5f4dcc3b5aa765d61d8327deb882cf99');
INSERT INTO `user` VALUES ('3', 'Jeremy', 'test');

-- ----------------------------
-- Table structure for `user_role`
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `userId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`roleId`) USING BTREE,
  KEY `roleId` (`roleId`) USING BTREE,
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('2', '1');
