/*
Navicat MySQL Data Transfer

Source Server         : 172.16.0.200（aj好的测试环境）
Source Server Version : 50505
Source Host           : 172.16.0.200:3306
Source Database       : aj03_organization_service

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2022-02-18 17:21:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_arms`
-- ----------------------------
DROP TABLE IF EXISTS `t_arms`;
CREATE TABLE `t_arms` (
  `arms_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '战区ID',
  `arms_name` varchar(50) NOT NULL COMMENT '战区名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`arms_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_arms
-- ----------------------------
INSERT INTO `t_arms` VALUES ('1', '海军', '2019-09-19 15:14:42', '2019-09-19 15:14:46');
INSERT INTO `t_arms` VALUES ('2', '陆军', '2019-09-19 18:43:48', null);
INSERT INTO `t_arms` VALUES ('3', '空军', '2019-09-19 18:43:48', '2019-09-26 09:55:33');
INSERT INTO `t_arms` VALUES ('4', '火箭军', '2019-11-05 09:10:27', '2019-11-05 09:10:34');
INSERT INTO `t_arms` VALUES ('5', '战略支援部队', '2019-11-05 09:12:02', '2019-11-05 09:12:08');
INSERT INTO `t_arms` VALUES ('6', '武警部队', '2019-11-05 09:13:03', '2019-11-05 09:13:07');

-- ----------------------------
-- Table structure for `t_theater`
-- ----------------------------
DROP TABLE IF EXISTS `t_theater`;
CREATE TABLE `t_theater` (
  `theater_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '战区id',
  `theater_name` varchar(255) NOT NULL COMMENT '战区名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`theater_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_theater
-- ----------------------------
INSERT INTO `t_theater` VALUES ('1', '总部', '2019-11-05 11:19:06', '2019-11-05 11:19:09');
INSERT INTO `t_theater` VALUES ('2', '东部', '2019-11-05 11:19:06', '2019-11-05 11:19:09');
INSERT INTO `t_theater` VALUES ('3', '西部（成都）', '2019-11-05 11:19:06', '2019-11-05 11:19:09');
INSERT INTO `t_theater` VALUES ('4', '西部（兰州）', '2019-11-05 11:19:06', '2019-11-05 11:19:09');
INSERT INTO `t_theater` VALUES ('5', '南部', '2019-11-05 11:19:06', '2019-11-05 11:19:09');
INSERT INTO `t_theater` VALUES ('6', '北部（沈阳）', '2019-11-05 11:19:06', '2019-11-05 11:19:09');
INSERT INTO `t_theater` VALUES ('7', '北部（济南）', '2019-11-05 11:24:40', '2019-11-05 11:24:44');
INSERT INTO `t_theater` VALUES ('8', '中部', '2019-11-05 11:25:18', '2019-11-05 11:25:22');

-- ----------------------------
-- Table structure for `t_theater_city`
-- ----------------------------
DROP TABLE IF EXISTS `t_theater_city`;
CREATE TABLE `t_theater_city` (
  `theater_city_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '城市id',
  `theater_city_name` varchar(255) NOT NULL COMMENT '城市名称',
  `theater_id` int(11) NOT NULL COMMENT '城市所属地区id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`theater_city_id`) USING BTREE,
  KEY `region_id` (`theater_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_theater_city
-- ----------------------------
INSERT INTO `t_theater_city` VALUES ('1', '北京', '1', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('2', '西安', '1', '2019-09-09 18:10:11', '2019-09-16 10:16:29');
INSERT INTO `t_theater_city` VALUES ('3', '福州', '2', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('4', '湖州', '2', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('5', '徐州', '2', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('6', '南京', '2', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('7', '舟山', '2', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('8', '黄山', '2', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('9', '拉萨', '3', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('10', '成都', '3', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('11', '昆明', '3', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('12', '重庆', '3', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('13', '西安', '4', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('14', '宝鸡', '4', '2019-09-09 18:10:11', '2019-09-16 10:16:29');
INSERT INTO `t_theater_city` VALUES ('15', '喀什', '4', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('16', '兰州', '4', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('17', '乌鲁木齐', '4', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('18', '惠州', '5', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('19', '柳州', '5', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('20', '广州', '5', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('21', '湛江', '5', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('22', '丹东', '6', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('23', '锦州', '6', '2019-09-09 18:10:11', '2019-09-16 10:16:29');
INSERT INTO `t_theater_city` VALUES ('24', '通化', '6', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('25', '沈阳', '6', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('26', '长春', '6', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('27', '济南', '7', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('28', '青岛', '7', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('29', '潍坊', '7', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('30', '湛江', '7', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('31', '保定', '8', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('32', '北京', '8', '2019-09-09 18:10:11', '2019-09-16 10:16:29');
INSERT INTO `t_theater_city` VALUES ('33', '开封', '8', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('34', '新乡', '8', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('35', '张家口', '8', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('36', '石家庄', '8', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('37', '洛阳', '8', '2019-09-09 18:10:11', '2019-09-16 16:48:05');

-- ----------------------------
-- Table structure for `t_unit`
-- ----------------------------
DROP TABLE IF EXISTS `t_unit`;
CREATE TABLE `t_unit` (
  `unit_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '单位ID',
  `unit_name` varchar(50) NOT NULL COMMENT '单位名称',
  `parent_id` bigint(20) NOT NULL COMMENT '上级单位ID',
  `theater_city_id` bigint(20) NOT NULL COMMENT '战区ID',
  `arms_id` bigint(20) NOT NULL COMMENT '军种Id',
  `auth` varchar(255) DEFAULT NULL,
  `group_max` bigint(10) DEFAULT NULL,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `station` bigint(10) NOT NULL COMMENT '站点1:北京 2:重庆 3：易县 4：门头沟',
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0-分级 1-分域',
  `syn_data_center` tinyint(4) NOT NULL DEFAULT 0 COMMENT '同步位仅限于type=1的记录',
  PRIMARY KEY (`unit_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_unit
-- ----------------------------
INSERT INTO `t_unit` VALUES ('1', '阳光凯讯1', '0', '1', '3', null, null, '2019-09-06 15:57:08', '2019-11-27 14:42:34', '0', '0', '0');
INSERT INTO `t_unit` VALUES ('2', '阳光凯讯111', '1', '1', '3', null, null, '2019-09-06 15:57:08', '2019-12-12 06:32:27', '0', '0', '0');
INSERT INTO `t_unit` VALUES ('3', '阳光凯讯12', '1', '1', '3', null, null, '2019-09-06 15:57:08', '2019-09-16 10:18:59', '0', '0', '0');
INSERT INTO `t_unit` VALUES ('4', '阳光凯讯2', '0', '3', '4', null, null, '2019-09-06 15:57:08', '2020-01-02 02:44:14', '0', '0', '0');
INSERT INTO `t_unit` VALUES ('5', '阳光凯讯21', '4', '3', '4', null, null, '2019-09-06 15:57:08', '2019-09-16 10:18:59', '0', '0', '0');
INSERT INTO `t_unit` VALUES ('6', '阳光凯讯22', '4', '3', '4', null, null, '2019-09-06 15:57:08', '2019-09-16 10:18:59', '0', '0', '0');
INSERT INTO `t_unit` VALUES ('7', '阳光凯讯23', '4', '3', '4', null, null, '2019-09-06 15:57:08', '2019-09-16 10:18:59', '0', '0', '0');
INSERT INTO `t_unit` VALUES ('8', '阳光凯讯22', '4', '3', '4', null, null, '2019-09-06 15:57:08', '2019-09-16 10:18:59', '0', '0', '0');
INSERT INTO `t_unit` VALUES ('11', 'test1', '0', '3', '4', null, null, '2020-01-19 06:16:22', null, '0', '0', '0');
INSERT INTO `t_unit` VALUES ('16', 'BBBB1', '0', '1', '3', null, null, '2020-01-20 08:08:38', null, '0', '0', '0');
INSERT INTO `t_unit` VALUES ('19', 'BBBB11', '16', '1', '3', null, null, '2020-01-20 08:09:38', null, '0', '0', '0');
INSERT INTO `t_unit` VALUES ('20', 'BBBB111', '19', '1', '3', null, null, '2020-01-20 08:09:50', null, '0', '0', '0');
INSERT INTO `t_unit` VALUES ('21', 'aaa1', '0', '1', '1', null, null, '2020-01-21 01:21:46', null, '0', '0', '0');
