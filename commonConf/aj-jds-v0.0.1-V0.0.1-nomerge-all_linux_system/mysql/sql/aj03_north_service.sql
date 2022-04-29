/*
 Navicat Premium Data Transfer

 Source Server         : 172.16.0.122(aj-jds-home-测试)
 Source Server Type    : MySQL
 Source Server Version : 100309
 Source Host           : 172.16.0.122:3306
 Source Schema         : aj03_north_service

 Target Server Type    : MySQL
 Target Server Version : 100309
 File Encoding         : 65001

 Date: 15/04/2022 11:02:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for collect_record
-- ----------------------------
DROP TABLE IF EXISTS `collect_record`;
CREATE TABLE `collect_record`  (
  `id` int NOT NULL,
  `offLineTime` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of collect_record
-- ----------------------------
INSERT INTO `collect_record` VALUES (1, '2022-04-08 17:15:00');
INSERT INTO `collect_record` VALUES (2, '2022-04-08 18:00:00');
INSERT INTO `collect_record` VALUES (3, '2022-04-08 17:15:00');
INSERT INTO `collect_record` VALUES (4, '2022-04-09 00:00:00');

-- ----------------------------
-- Table structure for device_relation
-- ----------------------------
DROP TABLE IF EXISTS `device_relation`;
CREATE TABLE `device_relation`  (
  `device_type` int NOT NULL,
  `system_id` int NOT NULL,
  PRIMARY KEY (`device_type`, `system_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of device_relation
-- ----------------------------
INSERT INTO `device_relation` VALUES (1, 1);
INSERT INTO `device_relation` VALUES (3, 9);
INSERT INTO `device_relation` VALUES (4, 15);
INSERT INTO `device_relation` VALUES (5, 17);
INSERT INTO `device_relation` VALUES (12, 8);

-- ----------------------------
-- Table structure for station_info
-- ----------------------------
DROP TABLE IF EXISTS `station_info`;
CREATE TABLE `station_info`  (
  `station_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `station_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `station_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `station_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`station_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of station_info
-- ----------------------------
INSERT INTO `station_info` VALUES ('01', '站点01', '站点01描述信息', '10.106.0.200');
INSERT INTO `station_info` VALUES ('02', '站点02', '站点02描述信息', '10.106.0.200');

SET FOREIGN_KEY_CHECKS = 1;
