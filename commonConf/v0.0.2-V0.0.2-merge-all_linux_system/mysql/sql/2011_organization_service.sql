/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50727
Source Host           : localhost:3306
Source Database       : 2011_organization_service

Target Server Type    : MYSQL
Target Server Version : 50727
File Encoding         : 65001

Date: 2021-10-20 10:21:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_arms
-- ----------------------------
DROP TABLE IF EXISTS `t_arms`;
CREATE TABLE `t_arms` (
  `arms_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '战区ID',
  `arms_name` varchar(50) NOT NULL COMMENT '战区名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`arms_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_arms
-- ----------------------------
INSERT INTO `t_arms` VALUES ('0', '全军', '2021-03-20 11:19:00', '2021-03-20 11:19:02');
INSERT INTO `t_arms` VALUES ('1', '海军', '2019-09-19 15:14:42', '2019-09-19 15:14:46');
INSERT INTO `t_arms` VALUES ('2', '陆军', '2019-09-19 18:43:48', null);
INSERT INTO `t_arms` VALUES ('3', '空军', '2019-09-19 18:43:48', '2019-09-26 09:55:33');
INSERT INTO `t_arms` VALUES ('4', '火箭军', '2019-11-05 09:10:27', '2019-11-05 09:10:34');
INSERT INTO `t_arms` VALUES ('5', '战略支援部队', '2019-11-05 09:12:02', '2019-11-05 09:12:08');
INSERT INTO `t_arms` VALUES ('6', '武警部队', '2019-11-05 09:13:03', '2019-11-05 09:13:07');

-- ----------------------------
-- Table structure for t_theater
-- ----------------------------
DROP TABLE IF EXISTS `t_theater`;
CREATE TABLE `t_theater` (
  `theater_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '战区id',
  `theater_name` varchar(255) NOT NULL COMMENT '战区名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`theater_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

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
-- Table structure for t_theater_city
-- ----------------------------
DROP TABLE IF EXISTS `t_theater_city`;
CREATE TABLE `t_theater_city` (
  `theater_city_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '城市id',
  `theater_city_name` varchar(255) NOT NULL COMMENT '城市名称',
  `theater_id` int(10) NOT NULL COMMENT '城市所属地区id',
  `longitude` varchar(20) DEFAULT NULL COMMENT '经度',
  `latitude` varchar(20) DEFAULT NULL COMMENT '纬度',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`theater_city_id`),
  KEY `region_id` (`theater_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_theater_city
-- ----------------------------
INSERT INTO `t_theater_city` VALUES ('1', '北京', '1', '116.395645038', '39.9299857781', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('2', '西安', '1', '108.953098279', '34.2777998978', '2019-09-09 18:10:11', '2019-09-16 10:16:29');
INSERT INTO `t_theater_city` VALUES ('3', '福州', '2', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('4', '湖州', '2', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('5', '徐州', '2', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('6', '南京', '2', '118.778074408', '32.0572355018', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('7', '舟山', '2', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('8', '黄山', '2', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('9', '拉萨', '3', '91.111890896', '29.6625570621', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('10', '成都', '3', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('11', '昆明', '3', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('12', '重庆', '3', '106.530635013', '29.5446061089', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('13', '西安', '4', '108.953098279', '34.2777998978', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('14', '宝鸡', '4', null, null, '2019-09-09 18:10:11', '2019-09-16 10:16:29');
INSERT INTO `t_theater_city` VALUES ('15', '喀什', '4', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('16', '兰州', '4', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('17', '乌鲁木齐', '4', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('18', '惠州', '5', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('19', '柳州', '5', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('20', '广州', '5', '113.307649675', '23.1200491021', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('21', '湛江', '5', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('22', '丹东', '6', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('23', '锦州', '6', null, null, '2019-09-09 18:10:11', '2019-09-16 10:16:29');
INSERT INTO `t_theater_city` VALUES ('24', '通化', '6', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('25', '沈阳', '6', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('26', '长春', '6', '125.313642427', '43.8983376071', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('27', '济南', '7', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('28', '青岛', '7', '120.384428184', '36.1052149013', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('29', '潍坊', '7', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('30', '湛江', '7', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('31', '保定', '8', '115.494810169', '38.886564548', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('32', '北京', '8', null, null, '2019-09-09 18:10:11', '2019-09-16 10:16:29');
INSERT INTO `t_theater_city` VALUES ('33', '开封', '8', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('34', '新乡', '8', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('35', '张家口', '8', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('36', '石家庄', '8', '114.522081844', '38.0489583146', '2019-09-09 18:10:11', '2019-09-16 16:48:05');
INSERT INTO `t_theater_city` VALUES ('37', '洛阳', '8', null, null, '2019-09-09 18:10:11', '2019-09-16 16:48:05');

-- ----------------------------
-- Table structure for t_unit
-- ----------------------------
DROP TABLE IF EXISTS `t_unit`;
CREATE TABLE `t_unit` (
  `unit_id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '单位ID',
  `unit_name` varchar(50) NOT NULL COMMENT '单位名称',
  `parent_id` bigint(10) NOT NULL COMMENT '上级单位ID',
  `theater_city_id` bigint(10) NOT NULL COMMENT '战区ID',
  `arms_id` bigint(10) NOT NULL COMMENT '军种Id',
  `auth` varchar(255) DEFAULT NULL,
  `group_max` bigint(10) DEFAULT NULL,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `station` bigint(10) NOT NULL COMMENT '站点1:北京 2:重庆 3：易县 4：门头沟',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0-分级 1-分域',
  `syn_data_center` tinyint(4) NOT NULL DEFAULT '0' COMMENT '同步位仅限于type=1的记录',
  PRIMARY KEY (`unit_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2105 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
-- ----------------------------
-- Records of t_unit
-- ----------------------------
INSERT INTO `t_unit` VALUES (1, '武警机关', 0, 1, 0, '', 200, '2021-03-08 08:17:29', '2021-03-12 12:01:44', 0, 0, 0);
INSERT INTO `t_unit` VALUES (2, '武警总队', 1, 1, 0, '', 200, '2021-03-08 08:17:29', '2021-03-12 12:01:44', 0, 0, 0);
INSERT INTO `t_unit` VALUES (3, '武警一支队', 2, 1, 0, '', 200, '2021-03-08 08:17:29', '2021-03-12 12:01:44', 0, 0, 0);
INSERT INTO `t_unit` VALUES (4, '武警二支队', 2, 1, 0, '', 200, '2021-03-08 08:17:29', '2021-03-12 12:01:44', 0, 0, 0);