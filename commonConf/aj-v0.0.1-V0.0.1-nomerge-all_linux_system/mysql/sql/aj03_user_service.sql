/*
Navicat MySQL Data Transfer

Source Server         : 172.16.0.200（aj好的测试环境）
Source Server Version : 50505
Source Host           : 172.16.0.200:3306
Source Database       : aj03_user_service

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2022-02-18 17:22:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `auc`
-- ----------------------------
DROP TABLE IF EXISTS `auc`;
CREATE TABLE `auc` (
  `imsi` varchar(32) NOT NULL DEFAULT 'NULL',
  `k` varchar(48) NOT NULL DEFAULT 'FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF',
  `op` varchar(48) NOT NULL DEFAULT 'FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF',
  `opc` varchar(48) NOT NULL DEFAULT 'FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF',
  `amf` varchar(6) NOT NULL DEFAULT 'F2 4C',
  `sqn` varchar(18) NOT NULL DEFAULT '00 00 00 00 00 00',
  `rand` varchar(48) NOT NULL DEFAULT '00 00 00 00 00 00',
  `tstamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `start` time NOT NULL DEFAULT '00:00:00',
  `stop` time NOT NULL DEFAULT '23:59:59',
  `belonghss` varchar(10) DEFAULT NULL COMMENT '分库的标识',
  PRIMARY KEY (`imsi`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of auc
-- ----------------------------
INSERT INTO `auc` VALUES ('222222222222222', 'FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF', 'FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF', 'FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF', '72 4C', '00 00 00 00 00 00', '00 00 00 00 00 00', '2021-04-28 16:47:40', '00:00:00', '23:59:59', '1');
INSERT INTO `auc` VALUES ('444444444444444', 'FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF', 'FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF', 'FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF', '72 4C', '00 00 00 00 00 00', '00 00 00 00 00 00', '2021-04-28 18:03:44', '00:00:00', '23:59:59', '1');

-- ----------------------------
-- Table structure for `bear_tft_module`
-- ----------------------------
DROP TABLE IF EXISTS `bear_tft_module`;
CREATE TABLE `bear_tft_module` (
  `tft_id` varchar(255) NOT NULL,
  `index` varchar(255) NOT NULL,
  `src_ip` varchar(255) DEFAULT NULL,
  `dst_ip` varchar(255) DEFAULT NULL,
  `src_port_start` varchar(255) DEFAULT NULL,
  `src_port_stop` varchar(255) DEFAULT NULL,
  `dst_port_start` varchar(255) DEFAULT NULL,
  `dst_port_end` varchar(255) DEFAULT NULL,
  `diff_serv` varchar(255) DEFAULT NULL,
  `protocl` varchar(255) DEFAULT NULL,
  `pkt_len_min` varchar(255) DEFAULT NULL,
  `pkt_len_max` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tft_id`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bear_tft_module
-- ----------------------------

-- ----------------------------
-- Table structure for `department`
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of department
-- ----------------------------

-- ----------------------------
-- Table structure for `epc_data`
-- ----------------------------
DROP TABLE IF EXISTS `epc_data`;
CREATE TABLE `epc_data` (
  `imsi` varchar(32) NOT NULL DEFAULT '',
  `apn` varchar(64) NOT NULL DEFAULT 'sunkaisens',
  `type` int(11) NOT NULL DEFAULT 0,
  `qci` int(11) NOT NULL DEFAULT 9,
  `aggregate_max_ul_bitrate` int(11) NOT NULL DEFAULT 25000,
  `aggregate_max_dl_bitrate` int(11) NOT NULL DEFAULT 35000,
  `guaranteed_ul_bitrate` int(11) NOT NULL DEFAULT 0,
  `guaranteed_dl_bitrate` int(11) NOT NULL DEFAULT 0,
  `max_ul_bitrate` int(11) NOT NULL DEFAULT 0,
  `max_dl_bitrate` int(11) NOT NULL DEFAULT 0,
  `pdn_type` int(11) NOT NULL DEFAULT 0,
  `priority_lvl` int(11) NOT NULL DEFAULT 1,
  `pre_emption_cap` int(11) NOT NULL DEFAULT 1,
  `pre_emption_vulnerability` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`imsi`,`apn`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of epc_data
-- ----------------------------
INSERT INTO `epc_data` VALUES ('222222222222222', 'ctnet', '0', '9', '50000', '100000', '50000', '100000', '50000', '100000', '0', '1', '1', '0');
INSERT INTO `epc_data` VALUES ('444444444444444', 'ctnet', '0', '9', '50000', '100000', '50000', '100000', '50000', '100000', '0', '1', '1', '0');

-- ----------------------------
-- Table structure for `epc_tft`
-- ----------------------------
DROP TABLE IF EXISTS `epc_tft`;
CREATE TABLE `epc_tft` (
  `imsi` varchar(32) NOT NULL DEFAULT '',
  `src_ip` varchar(64) NOT NULL DEFAULT '0.0.0.0',
  `dst_ip` varchar(64) NOT NULL DEFAULT '0.0.0.0',
  `src_port_start` int(11) NOT NULL DEFAULT 0,
  `src_port_end` int(11) NOT NULL DEFAULT 0,
  `dst_port_start` int(11) NOT NULL DEFAULT 0,
  `dst_port_end` int(11) NOT NULL DEFAULT 0,
  `diff_serv_start` int(11) NOT NULL DEFAULT 0,
  `diff_serv_end` int(11) NOT NULL DEFAULT 0,
  `pkt_len_min` int(11) NOT NULL DEFAULT 0,
  `pkt_len_max` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`imsi`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of epc_tft
-- ----------------------------
INSERT INTO `epc_tft` VALUES ('222222222222222', '0.0.0.0', '0.0.0.0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `epc_tft` VALUES ('444444444444444', '0.0.0.0', '0.0.0.0', '0', '0', '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `hlr`
-- ----------------------------
DROP TABLE IF EXISTS `hlr`;
CREATE TABLE `hlr` (
  `imsi` varchar(32) NOT NULL DEFAULT '',
  `mdn` varchar(32) NOT NULL DEFAULT '',
  `esn` varchar(32) DEFAULT '',
  `tmsi` varchar(32) DEFAULT '',
  `rncloc` varchar(32) NOT NULL DEFAULT '0000-0000',
  `geoloc` varchar(32) NOT NULL DEFAULT '0000-0000',
  `msprofile` int(11) NOT NULL DEFAULT 0,
  `msprofile_extra` int(11) NOT NULL DEFAULT 0,
  `msprofile_ps` int(11) NOT NULL COMMENT 'hlrps数据库的基本业务开关',
  `region` int(11) NOT NULL COMMENT '分组业务的开关',
  `msvocodec` int(11) NOT NULL DEFAULT 0,
  `acount_num` varchar(32) NOT NULL DEFAULT '',
  `currloc` varchar(128) NOT NULL DEFAULT '@',
  `mscAddr` varchar(128) DEFAULT NULL,
  `gwAddr` varchar(128) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tstamp` timestamp NULL DEFAULT current_timestamp(),
  `numofsms` int(11) NOT NULL DEFAULT 0,
  `numofvm` int(11) NOT NULL DEFAULT 0,
  `aggregate_max_ul_bitrate` int(11) NOT NULL DEFAULT 25000,
  `aggregate_max_dl_bitrate` int(11) NOT NULL DEFAULT 35000,
  `status` int(11) NOT NULL DEFAULT 0,
  `vlraddr` varchar(128) NOT NULL DEFAULT '@',
  `devicetype` int(11) NOT NULL DEFAULT 0,
  `monitorip` varchar(100) DEFAULT NULL COMMENT '监听地址',
  `monitorport` varchar(100) DEFAULT NULL COMMENT '监听端口',
  `domain` varchar(50) DEFAULT 'test.com' COMMENT '域名',
  `uepassword` varchar(128) DEFAULT NULL COMMENT '终端密码',
  `antijam` int(11) DEFAULT NULL COMMENT '是否支持抗干扰模式。 1：支持，0：不支持',
  `emergency` int(11) DEFAULT NULL COMMENT '是否支持应急模式。 1：支持，0：不支持',
  `general` int(11) DEFAULT NULL COMMENT '是否支持抗常规模式。 1：支持，0：不支持',
  `unitid` bigint(20) DEFAULT NULL COMMENT '单位Id',
  `groupnum` varchar(11) DEFAULT NULL COMMENT '单位的组号',
  `belonghss` varchar(32) DEFAULT NULL COMMENT '分库的字段',
  `syn_data_center` tinyint(4) DEFAULT 0 COMMENT '是否已向数据中心同步（0-否 1-是）',
  `domainid` int(11) DEFAULT NULL COMMENT '分域ID',
  `dev_acc_type` varchar(20) DEFAULT NULL,
  `display_name` varchar(50) DEFAULT NULL,
  `station_id` varchar(50) DEFAULT NULL,
  `netNo` int(11) DEFAULT NULL,
  PRIMARY KEY (`imsi`) USING BTREE,
  UNIQUE KEY `MDN` (`mdn`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of hlr
-- ----------------------------
INSERT INTO `hlr` VALUES ('444444444444444', '00000123456', '00000000', '', '0000-0000', '0000-0000', '-267973120', '16777216', '786432', '1', '40', '', '@', null, null, '2021-04-28 18:03:44', '2021-09-09 10:14:37', '2021-04-28 18:03:44', '0', '0', '50000', '100000', '0', '@', '5', '', '9654', 'test.com', '123456', '1', '1', '0', '1', null, '1', '0', null, null, null, null, null);

-- ----------------------------
-- Table structure for `hlr_groupnum`
-- ----------------------------
DROP TABLE IF EXISTS `hlr_groupnum`;
CREATE TABLE `hlr_groupnum` (
  `imsi` varchar(32) NOT NULL DEFAULT '' COMMENT '终端号',
  `group_num` varchar(20) NOT NULL DEFAULT '' COMMENT '组号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of hlr_groupnum
-- ----------------------------

-- ----------------------------
-- Table structure for `hlr_roaming_in`
-- ----------------------------
DROP TABLE IF EXISTS `hlr_roaming_in`;
CREATE TABLE `hlr_roaming_in` (
  `mdn` varchar(32) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 0,
  `gw_addr` varchar(80) DEFAULT NULL,
  `msc_addr` varchar(80) DEFAULT NULL,
  `currloc` varchar(80) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`mdn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hlr_roaming_in
-- ----------------------------
INSERT INTO `hlr_roaming_in` VALUES ('1', '0', null, null, null, '2021-09-09 09:37:09', '2021-09-09 09:37:09');
INSERT INTO `hlr_roaming_in` VALUES ('2', '1', null, null, null, '2021-09-09 09:37:14', '2021-09-09 09:37:49');
INSERT INTO `hlr_roaming_in` VALUES ('3', '1', null, null, null, '2021-09-09 09:37:19', '2021-09-09 09:37:38');
INSERT INTO `hlr_roaming_in` VALUES ('4', '1', null, null, null, '2021-09-09 09:37:24', '2021-09-09 09:37:39');
INSERT INTO `hlr_roaming_in` VALUES ('5', '0', null, null, null, '2021-09-09 09:37:29', '2021-09-09 09:37:29');
INSERT INTO `hlr_roaming_in` VALUES ('6', '0', null, null, null, '2021-09-09 09:37:32', '2021-09-09 09:37:32');
INSERT INTO `hlr_roaming_in` VALUES ('7', '0', null, null, null, '2021-09-09 09:37:36', '2021-09-09 09:37:36');

-- ----------------------------
-- Table structure for `hss_device_type`
-- ----------------------------
DROP TABLE IF EXISTS `hss_device_type`;
CREATE TABLE `hss_device_type` (
  `id` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `enable` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of hss_device_type
-- ----------------------------
INSERT INTO `hss_device_type` VALUES ('0', 'UNKNOW', '0');
INSERT INTO `hss_device_type` VALUES ('1', 'SIP', '1');
INSERT INTO `hss_device_type` VALUES ('2', 'CDMA', '0');
INSERT INTO `hss_device_type` VALUES ('3', 'GSM', '0');
INSERT INTO `hss_device_type` VALUES ('4', 'WCDMA', '0');
INSERT INTO `hss_device_type` VALUES ('5', '宽带用户', '1');
INSERT INTO `hss_device_type` VALUES ('6', 'YD', '0');
INSERT INTO `hss_device_type` VALUES ('7', 'TR', '0');
INSERT INTO `hss_device_type` VALUES ('8', 'DISP', '0');
INSERT INTO `hss_device_type` VALUES ('9', 'TETRA', '0');
INSERT INTO `hss_device_type` VALUES ('10', 'ANALOG', '0');
INSERT INTO `hss_device_type` VALUES ('11', 'RADIO', '0');
INSERT INTO `hss_device_type` VALUES ('12', 'IMS', '1');
INSERT INTO `hss_device_type` VALUES ('13', 'LTE-CPE', '0');
INSERT INTO `hss_device_type` VALUES ('14', 'JZ', '0');

-- ----------------------------
-- Table structure for `hss_device_voice`
-- ----------------------------
DROP TABLE IF EXISTS `hss_device_voice`;
CREATE TABLE `hss_device_voice` (
  `device` int(11) NOT NULL,
  `voice` int(11) NOT NULL,
  PRIMARY KEY (`device`,`voice`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of hss_device_voice
-- ----------------------------
INSERT INTO `hss_device_voice` VALUES ('1', '0');
INSERT INTO `hss_device_voice` VALUES ('1', '8');
INSERT INTO `hss_device_voice` VALUES ('1', '18');
INSERT INTO `hss_device_voice` VALUES ('5', '40');
INSERT INTO `hss_device_voice` VALUES ('12', '0');
INSERT INTO `hss_device_voice` VALUES ('12', '8');
INSERT INTO `hss_device_voice` VALUES ('12', '18');

-- ----------------------------
-- Table structure for `hss_net_net_policy`
-- ----------------------------
DROP TABLE IF EXISTS `hss_net_net_policy`;
CREATE TABLE `hss_net_net_policy` (
  `net` varchar(32) NOT NULL,
  `net_name` varchar(32) NOT NULL,
  `target_net_json` varchar(255) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp() COMMENT '修改时间',
  PRIMARY KEY (`net`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hss_net_net_policy
-- ----------------------------

-- ----------------------------
-- Table structure for `hss_priority`
-- ----------------------------
DROP TABLE IF EXISTS `hss_priority`;
CREATE TABLE `hss_priority` (
  `id` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  `enable` int(11) NOT NULL,
  `userType` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- ----------------------------
-- Records of hss_priority
-- ----------------------------
INSERT INTO `hss_priority` VALUES ('1', '1', '1', '1', '0');
INSERT INTO `hss_priority` VALUES ('2', '2', '2', '1', '0');
INSERT INTO `hss_priority` VALUES ('3', '3', '3', '1', '0');
INSERT INTO `hss_priority` VALUES ('4', '4', '4', '1', '0');
INSERT INTO `hss_priority` VALUES ('5', '5', '5', '1', '0');
INSERT INTO `hss_priority` VALUES ('6', '6', '6', '0', '0');
INSERT INTO `hss_priority` VALUES ('7', '7', '7', '0', '0');
INSERT INTO `hss_priority` VALUES ('8', '8', '8', '0', '0');
INSERT INTO `hss_priority` VALUES ('9', '9', '9', '0', '0');
INSERT INTO `hss_priority` VALUES ('10', '10', '10', '0', '0');
INSERT INTO `hss_priority` VALUES ('11', '1', '11', '0', '1');
INSERT INTO `hss_priority` VALUES ('12', '2', '12', '0', '1');
INSERT INTO `hss_priority` VALUES ('13', '3', '13', '0', '1');
INSERT INTO `hss_priority` VALUES ('14', '4', '14', '0', '1');
INSERT INTO `hss_priority` VALUES ('15', '5', '15', '0', '1');

-- ----------------------------
-- Table structure for `hss_terminal_type`
-- ----------------------------
DROP TABLE IF EXISTS `hss_terminal_type`;
CREATE TABLE `hss_terminal_type` (
  `id` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `enable` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of hss_terminal_type
-- ----------------------------
INSERT INTO `hss_terminal_type` VALUES ('0', '卫星普通型手持终端', '1');
INSERT INTO `hss_terminal_type` VALUES ('1', '卫星增强型手持终端', '1');
INSERT INTO `hss_terminal_type` VALUES ('3', '卫星便携终端', '1');
INSERT INTO `hss_terminal_type` VALUES ('5', '卫星车载终端', '1');

-- ----------------------------
-- Table structure for `hss_user_net_policy`
-- ----------------------------
DROP TABLE IF EXISTS `hss_user_net_policy`;
CREATE TABLE `hss_user_net_policy` (
  `mdn` varchar(20) NOT NULL,
  `targetNetJson` varchar(255) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp() COMMENT '修改时间',
  PRIMARY KEY (`mdn`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of hss_user_net_policy
-- ----------------------------

-- ----------------------------
-- Table structure for `hss_voice_type`
-- ----------------------------
DROP TABLE IF EXISTS `hss_voice_type`;
CREATE TABLE `hss_voice_type` (
  `id` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `enable` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of hss_voice_type
-- ----------------------------
INSERT INTO `hss_voice_type` VALUES ('0', 'PCMU', '1');
INSERT INTO `hss_voice_type` VALUES ('8', 'PCMA', '1');
INSERT INTO `hss_voice_type` VALUES ('18', 'G.729', '1');
INSERT INTO `hss_voice_type` VALUES ('35', 'EVRC', '1');
INSERT INTO `hss_voice_type` VALUES ('38', 'AHELP', '1');
INSERT INTO `hss_voice_type` VALUES ('39', 'ACELP', '1');
INSERT INTO `hss_voice_type` VALUES ('40', 'AMR', '1');
INSERT INTO `hss_voice_type` VALUES ('42', 'VC40', '1');
INSERT INTO `hss_voice_type` VALUES ('43', 'VC24', '1');
INSERT INTO `hss_voice_type` VALUES ('44', 'VC12', '1');
INSERT INTO `hss_voice_type` VALUES ('45', 'VC06', '1');
INSERT INTO `hss_voice_type` VALUES ('46', 'NVOC', '1');

-- ----------------------------
-- Table structure for `msservice`
-- ----------------------------
DROP TABLE IF EXISTS `msservice`;
CREATE TABLE `msservice` (
  `imsi` varchar(32) NOT NULL DEFAULT '',
  `status` varchar(32) NOT NULL DEFAULT 'inactive',
  `directfwdnum` varchar(32) NOT NULL DEFAULT '',
  `fwdonbusynum` varchar(32) NOT NULL DEFAULT '',
  `fwdnoanswernum` varchar(32) NOT NULL DEFAULT '',
  `voicemailnum` varchar(32) NOT NULL DEFAULT '',
  `fwdnanum` varchar(32) NOT NULL DEFAULT '',
  `wiretapaddr` varchar(32) NOT NULL DEFAULT '',
  `belonghss` varchar(10) DEFAULT NULL COMMENT '分库的标识',
  PRIMARY KEY (`imsi`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of msservice
-- ----------------------------
INSERT INTO `msservice` VALUES ('222222222222222', '', '', '', '', '', '', '', '1');
INSERT INTO `msservice` VALUES ('444444444444444', '', '', '', '', '', '', '', '1');

-- ----------------------------
-- Table structure for `task`
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(255) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `mdns` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task
-- ----------------------------

-- ----------------------------
-- Table structure for `terminalinfo`
-- ----------------------------
DROP TABLE IF EXISTS `terminalinfo`;
CREATE TABLE `terminalinfo` (
  `imsi` varchar(32) NOT NULL,
  `terminal_id` varchar(30) NOT NULL DEFAULT '',
  `terminal_type` int(11) DEFAULT NULL,
  `power_level` int(11) DEFAULT NULL,
  `suport_buss` int(11) DEFAULT NULL,
  `gw_id` int(11) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `user_type` int(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `user_info` varchar(255) DEFAULT NULL,
  `service_priority` int(11) DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT current_timestamp(),
  `belonghss` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`imsi`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of terminalinfo
-- ----------------------------

-- ----------------------------
-- Table structure for `tt_bear_qos_profile`
-- ----------------------------
DROP TABLE IF EXISTS `tt_bear_qos_profile`;
CREATE TABLE `tt_bear_qos_profile` (
  `imsi` varchar(32) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `bear_id` int(11) NOT NULL DEFAULT 0,
  `priority_lvl` int(11) NOT NULL DEFAULT 0,
  `tft_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`imsi`,`bear_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tt_bear_qos_profile
-- ----------------------------

-- ----------------------------
-- Table structure for `user_omc_addr`
-- ----------------------------
DROP TABLE IF EXISTS `user_omc_addr`;
CREATE TABLE `user_omc_addr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(20) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user_omc_addr
-- ----------------------------
INSERT INTO `user_omc_addr` VALUES ('1', '172.16.2.12', '9523', 'HSS代理');
