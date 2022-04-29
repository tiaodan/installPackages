/*
Navicat MySQL Data Transfer

Source Server         : 192.1.1.60
Source Server Version : 50726
Source Host           : 192.1.1.60:3306
Source Database       : ocr

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2021-09-23 17:15:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `dataRecord`
-- ----------------------------
DROP TABLE IF EXISTS `dataRecord`;
CREATE TABLE `dataRecord` (
  `billing_id` int(10) unsigned NOT NULL DEFAULT '0',
  `call_type` int(11) NOT NULL DEFAULT '0',
  `caller_id` varchar(32) NOT NULL DEFAULT '-',
  `caller_esn` varchar(32) NOT NULL DEFAULT '-',
  `caller_imsi` varchar(32) NOT NULL DEFAULT '-',
  `callee_id` varchar(32) NOT NULL DEFAULT '-',
  `callee_esn` varchar(32) NOT NULL DEFAULT '-',
  `call_refnum` varchar(64) NOT NULL DEFAULT '-',
  `start_location` varchar(64) NOT NULL DEFAULT '-',
  `stop_location` varchar(64) NOT NULL DEFAULT '-',
  `src_addr` varchar(64) NOT NULL DEFAULT '-',
  `start_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `stop_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `send_bytes` int(10) unsigned NOT NULL DEFAULT '0',
  `recv_bytes` int(10) unsigned NOT NULL DEFAULT '0',
  `service_opt` int(11) NOT NULL DEFAULT '0',
  `cdr_tag` char(1) NOT NULL DEFAULT '0',
  `mscId` int(11) NOT NULL DEFAULT '0',
  `beamId` int(11) NOT NULL DEFAULT '0',
  `gwType` int(11) NOT NULL DEFAULT '0',
  `isOrg` int(11) NOT NULL DEFAULT '0',
  `connType` int(11) NOT NULL DEFAULT '0',
  `billingType` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`billing_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of dataRecord
-- ----------------------------

-- ----------------------------
-- Table structure for `dataRecord_20210924`
-- ----------------------------
DROP TABLE IF EXISTS `dataRecord_20210924`;
CREATE TABLE `dataRecord_20210924` (
  `billing_id` int(10) unsigned NOT NULL DEFAULT '0',
  `call_type` int(11) NOT NULL DEFAULT '0',
  `caller_id` varchar(32) NOT NULL DEFAULT '-',
  `caller_esn` varchar(32) NOT NULL DEFAULT '-',
  `caller_imsi` varchar(32) NOT NULL DEFAULT '-',
  `callee_id` varchar(32) NOT NULL DEFAULT '-',
  `callee_esn` varchar(32) NOT NULL DEFAULT '-',
  `call_refnum` varchar(64) NOT NULL DEFAULT '-',
  `start_location` varchar(64) NOT NULL DEFAULT '-',
  `stop_location` varchar(64) NOT NULL DEFAULT '-',
  `src_addr` varchar(64) NOT NULL DEFAULT '-',
  `start_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `stop_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `send_bytes` int(10) unsigned NOT NULL DEFAULT '0',
  `recv_bytes` int(10) unsigned NOT NULL DEFAULT '0',
  `service_opt` int(11) NOT NULL DEFAULT '0',
  `cdr_tag` char(1) NOT NULL DEFAULT '0',
  `mscId` int(11) NOT NULL DEFAULT '0',
  `beamId` int(11) NOT NULL DEFAULT '0',
  `gwType` int(11) NOT NULL DEFAULT '0',
  `isOrg` int(11) NOT NULL DEFAULT '0',
  `connType` int(11) NOT NULL DEFAULT '0',
  `billingType` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`billing_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of dataRecord_20210924
-- ----------------------------

-- ----------------------------
-- Table structure for `groupCall`
-- ----------------------------
DROP TABLE IF EXISTS `groupCall`;
CREATE TABLE `groupCall` (
  `bid` int(10) unsigned NOT NULL DEFAULT '0',
  `crn` varchar(64) NOT NULL DEFAULT '-',
  `src_addr` varchar(64) NOT NULL DEFAULT '-',
  `caller_id` varchar(32) NOT NULL DEFAULT '-',
  `caller_imsi` varchar(32) NOT NULL DEFAULT '-',
  `callee_group` varchar(32) NOT NULL DEFAULT '-',
  `callee_id` varchar(32) NOT NULL DEFAULT '-',
  `callee_imsi` varchar(32) NOT NULL DEFAULT '-',
  `org_term` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `start_location` varchar(64) NOT NULL DEFAULT '-',
  `stop_location` varchar(64) NOT NULL DEFAULT '-',
  `service_opt` int(10) unsigned NOT NULL DEFAULT '0',
  `start_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `stop_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `tick_count` int(10) unsigned NOT NULL DEFAULT '0',
  `tick_time` int(10) unsigned NOT NULL DEFAULT '0',
  `term_reason` int(10) unsigned NOT NULL DEFAULT '0',
  `term_party` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`bid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of groupCall
-- ----------------------------

-- ----------------------------
-- Table structure for `groupCall_20210924`
-- ----------------------------
DROP TABLE IF EXISTS `groupCall_20210924`;
CREATE TABLE `groupCall_20210924` (
  `bid` int(10) unsigned NOT NULL DEFAULT '0',
  `crn` varchar(64) NOT NULL DEFAULT '-',
  `src_addr` varchar(64) NOT NULL DEFAULT '-',
  `caller_id` varchar(32) NOT NULL DEFAULT '-',
  `caller_imsi` varchar(32) NOT NULL DEFAULT '-',
  `callee_group` varchar(32) NOT NULL DEFAULT '-',
  `callee_id` varchar(32) NOT NULL DEFAULT '-',
  `callee_imsi` varchar(32) NOT NULL DEFAULT '-',
  `org_term` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `start_location` varchar(64) NOT NULL DEFAULT '-',
  `stop_location` varchar(64) NOT NULL DEFAULT '-',
  `service_opt` int(10) unsigned NOT NULL DEFAULT '0',
  `start_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `stop_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `tick_count` int(10) unsigned NOT NULL DEFAULT '0',
  `tick_time` int(10) unsigned NOT NULL DEFAULT '0',
  `term_reason` int(10) unsigned NOT NULL DEFAULT '0',
  `term_party` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`bid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of groupCall_20210924
-- ----------------------------

-- ----------------------------
-- Table structure for `smsRecord`
-- ----------------------------
DROP TABLE IF EXISTS `smsRecord`;
CREATE TABLE `smsRecord` (
  `billing_id` int(10) unsigned NOT NULL DEFAULT '0',
  `call_type` int(11) NOT NULL DEFAULT '0',
  `caller_id` varchar(32) NOT NULL DEFAULT '-',
  `caller_esn` varchar(32) NOT NULL DEFAULT '-',
  `caller_imsi` varchar(32) NOT NULL DEFAULT '-',
  `callee_id` varchar(32) NOT NULL DEFAULT '-',
  `callee_esn` varchar(32) NOT NULL DEFAULT '-',
  `callee_imsi` varchar(32) NOT NULL DEFAULT '-',
  `call_refnum` varchar(64) NOT NULL DEFAULT '-',
  `src_addr` varchar(64) NOT NULL DEFAULT '-',
  `record_times` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `stop_location` varchar(64) NOT NULL DEFAULT '-',
  `term_reason` int(11) NOT NULL DEFAULT '0',
  `term_party` int(11) NOT NULL DEFAULT '0',
  `cdr_tag` int(11) NOT NULL DEFAULT '0',
  `data_len` int(11) NOT NULL DEFAULT '0',
  `content` varchar(1024) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`billing_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of smsRecord
-- ----------------------------

-- ----------------------------
-- Table structure for `smsRecord_20210924`
-- ----------------------------
DROP TABLE IF EXISTS `smsRecord_20210924`;
CREATE TABLE `smsRecord_20210924` (
  `billing_id` int(10) unsigned NOT NULL DEFAULT '0',
  `call_type` int(11) NOT NULL DEFAULT '0',
  `caller_id` varchar(32) NOT NULL DEFAULT '-',
  `caller_esn` varchar(32) NOT NULL DEFAULT '-',
  `caller_imsi` varchar(32) NOT NULL DEFAULT '-',
  `callee_id` varchar(32) NOT NULL DEFAULT '-',
  `callee_esn` varchar(32) NOT NULL DEFAULT '-',
  `callee_imsi` varchar(32) NOT NULL DEFAULT '-',
  `call_refnum` varchar(64) NOT NULL DEFAULT '-',
  `src_addr` varchar(64) NOT NULL DEFAULT '-',
  `record_times` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `stop_location` varchar(64) NOT NULL DEFAULT '-',
  `term_reason` int(11) NOT NULL DEFAULT '0',
  `term_party` int(11) NOT NULL DEFAULT '0',
  `cdr_tag` int(11) NOT NULL DEFAULT '0',
  `data_len` int(11) NOT NULL DEFAULT '0',
  `content` varchar(1024) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`billing_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of smsRecord_20210924
-- ----------------------------

-- ----------------------------
-- Table structure for `vcRecord`
-- ----------------------------
DROP TABLE IF EXISTS `vcRecord`;
CREATE TABLE `vcRecord` (
  `billing_id` int(10) unsigned NOT NULL DEFAULT '0',
  `billing_type` int(11) NOT NULL DEFAULT '0',
  `call_type` int(11) NOT NULL DEFAULT '0',
  `caller_id` varchar(32) NOT NULL DEFAULT '-',
  `caller_esn` varchar(32) NOT NULL DEFAULT '-',
  `caller_imsi` varchar(32) NOT NULL DEFAULT '-',
  `callee_id` varchar(32) NOT NULL DEFAULT '-',
  `callee_esn` varchar(32) NOT NULL DEFAULT '-',
  `callee_imsi` varchar(32) NOT NULL DEFAULT '-',
  `call_refnum` varchar(64) NOT NULL DEFAULT '-',
  `start_location` varchar(64) NOT NULL DEFAULT '-',
  `stop_location` varchar(64) NOT NULL DEFAULT '-',
  `trans_from` varchar(64) NOT NULL DEFAULT '-',
  `trans_to` varchar(64) NOT NULL DEFAULT '-',
  `src_addr` varchar(64) NOT NULL DEFAULT '-',
  `service_opt` int(11) NOT NULL DEFAULT '0',
  `start_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `alert_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `connect_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `stop_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `tick_count` int(11) NOT NULL DEFAULT '0',
  `tick_time` int(11) NOT NULL DEFAULT '0',
  `term_reason` int(11) NOT NULL DEFAULT '0',
  `term_party` int(11) NOT NULL DEFAULT '0',
  `cdr_tag` int(11) NOT NULL DEFAULT '0',
  `service_change` int(11) NOT NULL DEFAULT '0',
  `fwd_type` int(11) NOT NULL DEFAULT '0',
  `mscId` int(11) NOT NULL DEFAULT '0',
  `beamId` int(11) NOT NULL DEFAULT '0',
  `gwType` int(11) NOT NULL DEFAULT '0',
  `isOrg` int(11) NOT NULL DEFAULT '0',
  `connType` int(11) NOT NULL DEFAULT '0',
  `billingType` int(10) unsigned NOT NULL DEFAULT '0',
  `fax` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`billing_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of vcRecord
-- ----------------------------

-- ----------------------------
-- Table structure for `vcRecord_20210924`
-- ----------------------------
DROP TABLE IF EXISTS `vcRecord_20210924`;
CREATE TABLE `vcRecord_20210924` (
  `billing_id` int(10) unsigned NOT NULL DEFAULT '0',
  `billing_type` int(11) NOT NULL DEFAULT '0',
  `call_type` int(11) NOT NULL DEFAULT '0',
  `caller_id` varchar(32) NOT NULL DEFAULT '-',
  `caller_esn` varchar(32) NOT NULL DEFAULT '-',
  `caller_imsi` varchar(32) NOT NULL DEFAULT '-',
  `callee_id` varchar(32) NOT NULL DEFAULT '-',
  `callee_esn` varchar(32) NOT NULL DEFAULT '-',
  `callee_imsi` varchar(32) NOT NULL DEFAULT '-',
  `call_refnum` varchar(64) NOT NULL DEFAULT '-',
  `start_location` varchar(64) NOT NULL DEFAULT '-',
  `stop_location` varchar(64) NOT NULL DEFAULT '-',
  `trans_from` varchar(64) NOT NULL DEFAULT '-',
  `trans_to` varchar(64) NOT NULL DEFAULT '-',
  `src_addr` varchar(64) NOT NULL DEFAULT '-',
  `service_opt` int(11) NOT NULL DEFAULT '0',
  `start_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `alert_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `connect_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `stop_time` timestamp NOT NULL DEFAULT '1970-01-01 12:00:00',
  `tick_count` int(11) NOT NULL DEFAULT '0',
  `tick_time` int(11) NOT NULL DEFAULT '0',
  `term_reason` int(11) NOT NULL DEFAULT '0',
  `term_party` int(11) NOT NULL DEFAULT '0',
  `cdr_tag` int(11) NOT NULL DEFAULT '0',
  `service_change` int(11) NOT NULL DEFAULT '0',
  `fwd_type` int(11) NOT NULL DEFAULT '0',
  `mscId` int(11) NOT NULL DEFAULT '0',
  `beamId` int(11) NOT NULL DEFAULT '0',
  `gwType` int(11) NOT NULL DEFAULT '0',
  `isOrg` int(11) NOT NULL DEFAULT '0',
  `connType` int(11) NOT NULL DEFAULT '0',
  `billingType` int(10) unsigned NOT NULL DEFAULT '0',
  `fax` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`billing_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of vcRecord_20210924
-- ----------------------------
