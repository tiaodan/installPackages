/*
 Navicat Premium Data Transfer

 Source Server         : 208-调度
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : 120.1.1.11:3306
 Source Schema         : data_dispatch

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 05/01/2022 16:37:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gps_track_line
-- ----------------------------
DROP TABLE IF EXISTS `gps_track_line`;
CREATE TABLE `gps_track_line`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `startTime` datetime(0) NULL DEFAULT NULL,
  `endTime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uuid_index`(`uuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gps_track_line
-- ----------------------------
INSERT INTO `gps_track_line` VALUES (1, '57c30c84-dc73-4976-bdea-ac17211df047', '19080020201', '2022-01-05 11:10:53', NULL);
INSERT INTO `gps_track_line` VALUES (2, 'e3ec8c1b-18ff-44b0-81c1-5884d3e1aec0', '19080020213', '2022-01-05 11:12:08', NULL);

-- ----------------------------
-- Table structure for gps_track_point
-- ----------------------------
DROP TABLE IF EXISTS `gps_track_point`;
CREATE TABLE `gps_track_point`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `line_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `timestamp` datetime(0) NULL DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;


-- ----------------------------
-- Records of gps_track_point
-- ----------------------------

-- ----------------------------
-- Table structure for plot_relation
-- ----------------------------
DROP TABLE IF EXISTS `plot_relation`;
CREATE TABLE `plot_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `relation_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `relation_from` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `relation_to` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of plot_relation
-- ----------------------------

-- ----------------------------
-- Table structure for plot_user_off
-- ----------------------------
DROP TABLE IF EXISTS `plot_user_off`;
CREATE TABLE `plot_user_off`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `relation_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `plot_from` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `plot_to` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `plot_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of plot_user_off
-- ----------------------------

-- ----------------------------
-- Table structure for push_gps_point
-- ----------------------------
DROP TABLE IF EXISTS `push_gps_point`;
CREATE TABLE `push_gps_point`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `UUUID` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `groupNum` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `longitude` double NOT NULL,
  `latitude` double NOT NULL,
  `high` double NULL DEFAULT NULL,
  `direction` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `date` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of push_gps_point
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
