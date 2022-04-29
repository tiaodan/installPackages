/*
Navicat MySQL Data Transfer

Source Server         : 192.1.1.60
Source Server Version : 50726
Source Host           : 192.1.1.60:3306
Source Database       : imserver

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2021-09-22 17:08:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `cpim_expandheads`
-- ----------------------------
DROP TABLE IF EXISTS `cpim_expandheads`;
CREATE TABLE `cpim_expandheads` (
  `msgext_localmsgid` varchar(255) NOT NULL,
  `msgext_msgtype` varchar(255) DEFAULT NULL,
  `msgext_msgreport` varchar(255) DEFAULT NULL,
  `msgext_time_to_deliver` varchar(255) DEFAULT NULL,
  `msgext_report_type` varchar(255) DEFAULT NULL,
  `msgext_report_id` varchar(255) DEFAULT NULL,
  `msgext_done_time` varchar(255) DEFAULT NULL,
  `msgext_submit_time` varchar(255) DEFAULT NULL,
  `msgext_src_prority` varchar(255) DEFAULT NULL,
  `msgext_error_code` varchar(255) DEFAULT NULL,
  `msgext_has_attachment` varchar(255) DEFAULT NULL,
  `msgext_history_msg_notify` varchar(255) DEFAULT NULL,
  `msgext_op_type` varchar(255) DEFAULT NULL,
  `msgext_anon_msg` varchar(255) DEFAULT NULL,
  `imdn_disposition_notification` varchar(255) DEFAULT NULL,
  `imdn_message_id` varchar(255) DEFAULT NULL,
  `content_type` varchar(255) DEFAULT NULL,
  `content_transfer_encoding` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`msgext_localmsgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cpim_expandheads
-- ----------------------------

