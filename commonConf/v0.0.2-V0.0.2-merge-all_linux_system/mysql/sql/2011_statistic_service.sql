/*
Navicat MySQL Data Transfer

Source Server         : 192.1.1.79
Source Server Version : 50728
Source Host           : 192.1.1.79:3306
Source Database       : 2011_statistic_service

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2022-01-21 10:18:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `collect_record`
-- ----------------------------
DROP TABLE IF EXISTS `collect_record`;
CREATE TABLE `collect_record` (
  `id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of collect_record
-- ----------------------------
INSERT INTO `collect_record` VALUES ('1', '分组数据', '2022-03-17 01:00:00');
INSERT INTO `collect_record` VALUES ('2', '用户入网', '2022-03-17 01:00:00');
INSERT INTO `collect_record` VALUES ('3', '短信数据', '2022-03-17 01:00:00');
INSERT INTO `collect_record` VALUES ('4', '单呼数据', '2022-03-17 01:00:00');
INSERT INTO `collect_record` VALUES ('5', '组呼数据', '2022-03-17 01:00:00');

-- ----------------------------
-- Table structure for `net_gateway_statistic`
-- ----------------------------
DROP TABLE IF EXISTS `net_gateway_statistic`;
CREATE TABLE `net_gateway_statistic` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip_network_port` varchar(50) NOT NULL,
  `net` int(11) NOT NULL,
  `net_name` varchar(50) NOT NULL,
  `total_data_flow` bigint(20) NOT NULL,
  `change_data_flow` bigint(20) NOT NULL,
  `type` int(4) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of net_gateway_statistic
-- ----------------------------
