/*
Navicat MySQL Data Transfer

Source Server         : 172.16.2.201
Source Server Version : 50728
Source Host           : 172.16.2.201:3306
Source Database       : 2011_devconfig_service

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2022-02-14 11:55:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `bts_base_config_info`
-- ----------------------------
DROP TABLE IF EXISTS `bts_base_config_info`;
CREATE TABLE `bts_base_config_info` (
  `id` varchar(50) NOT NULL,
  `bts_ip` varchar(20) NOT NULL,
  `bts_port` int(10) NOT NULL,
  `station_id` int(10) NOT NULL,
  `ctrl_port` int(10) DEFAULT NULL,
  `ctrl_ip` varchar(20) DEFAULT NULL,
  `remote_nmc_port` int(10) DEFAULT NULL,
  `remote_nmc_ip` varchar(20) DEFAULT NULL,
  `bts_service_port` int(10) DEFAULT NULL,
  `bts_service_ip` varchar(20) DEFAULT NULL,
  `switch_port` int(10) DEFAULT NULL,
  `switch_ip` varchar(20) DEFAULT NULL,
  `switch_back_port` int(10) DEFAULT NULL,
  `switch_back_ip` varchar(20) DEFAULT NULL,
  `bts_model` int(10) DEFAULT NULL,
  `bts_type` int(10) DEFAULT NULL,
  `bbu_sn` varchar(100) DEFAULT NULL,
  `rru_sn_json` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bts_base_config_info
-- ----------------------------

-- ----------------------------
-- Table structure for `bts_channel_info`
-- ----------------------------
DROP TABLE IF EXISTS `bts_channel_info`;
CREATE TABLE `bts_channel_info` (
  `id` varchar(50) NOT NULL,
  `phy_num` int(10) NOT NULL,
  `bts_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '基站ip',
  `bts_port` int(10) NOT NULL COMMENT '基站port',
  `station_id` int(10) NOT NULL COMMENT '基站id',
  `channel_type` int(10) DEFAULT NULL,
  `logic_num` int(10) DEFAULT NULL,
  `status` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`,`phy_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bts_channel_info
-- ----------------------------

-- ----------------------------
-- Table structure for `bts_cross_nbr_info`
-- ----------------------------
DROP TABLE IF EXISTS `bts_cross_nbr_info`;
CREATE TABLE `bts_cross_nbr_info` (
  `id` varchar(50) NOT NULL,
  `bts_ip` varchar(50) DEFAULT NULL,
  `bts_port` int(11) DEFAULT NULL,
  `bts_id` int(11) DEFAULT NULL,
  `bts_name` varchar(50) DEFAULT NULL,
  `n_id` varchar(50) NOT NULL,
  `nbr_ip` varchar(50) DEFAULT NULL,
  `nbr_port` int(11) DEFAULT NULL,
  `nbr_id` int(11) DEFAULT NULL,
  `nbr_name` varchar(50) DEFAULT NULL,
  `nbr_gkf` int(11) DEFAULT NULL,
  `nbr_gkpn` int(11) DEFAULT NULL,
  `nbr_mnc` int(11) DEFAULT NULL,
  `nbr_lai` int(11) DEFAULT NULL,
  `nbr_receive` varchar(255) DEFAULT NULL,
  `nbr_send` varchar(255) DEFAULT NULL,
  `nbr_freq_point` int(11) DEFAULT NULL,
  `nbr_sic_mode` int(11) DEFAULT NULL,
  `nbr_control_chan_num` int(11) DEFAULT NULL,
  `flag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`n_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bts_cross_nbr_info
-- ----------------------------

-- ----------------------------
-- Table structure for `bts_fre_info`
-- ----------------------------
DROP TABLE IF EXISTS `bts_fre_info`;
CREATE TABLE `bts_fre_info` (
  `id` varchar(50) NOT NULL,
  `num` int(10) NOT NULL COMMENT '载波号',
  `bts_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '基站ip',
  `bts_port` int(10) NOT NULL COMMENT '基站port',
  `station_id` int(10) NOT NULL COMMENT '基站id',
  `power` int(10) DEFAULT NULL,
  `receive` varchar(20) DEFAULT NULL,
  `send` varchar(20) DEFAULT NULL,
  `fre_num` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bts_fre_info
-- ----------------------------

-- ----------------------------
-- Table structure for `bts_network_config_info`
-- ----------------------------
DROP TABLE IF EXISTS `bts_network_config_info`;
CREATE TABLE `bts_network_config_info` (
  `id` varchar(50) NOT NULL,
  `bts_ip` varchar(20) NOT NULL,
  `bts_port` int(10) NOT NULL,
  `station_id` int(10) DEFAULT NULL,
  `nzi` int(10) DEFAULT NULL,
  `nai` int(10) DEFAULT NULL,
  `lai` int(10) DEFAULT NULL,
  `color_code` int(10) DEFAULT NULL,
  `sic_mode` int(10) DEFAULT NULL,
  `sic_par` int(10) DEFAULT NULL,
  `reg_window` int(10) DEFAULT NULL,
  `back_off` int(10) DEFAULT NULL,
  `wt` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bts_network_config_info
-- ----------------------------

-- ----------------------------
-- Table structure for `bts_position_info`
-- ----------------------------
DROP TABLE IF EXISTS `bts_position_info`;
CREATE TABLE `bts_position_info` (
  `id` varchar(50) NOT NULL,
  `rru_id` int(10) NOT NULL COMMENT '当id为0时为bbu  其余为rru',
  `bts_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '基站ip',
  `bts_port` int(10) NOT NULL COMMENT '基站port',
  `station_id` int(10) NOT NULL COMMENT '基站id',
  `ns` int(10) DEFAULT NULL COMMENT '南纬 0  \r\n北纬 1',
  `n_deg` int(10) DEFAULT NULL COMMENT '纬度的度值0-89',
  `n_min_mm` int(10) DEFAULT NULL COMMENT '纬度的分值 0-59',
  `n_min_f` int(10) DEFAULT NULL COMMENT '纬度的秒值 0-59',
  `ew` int(10) DEFAULT NULL COMMENT ' 0西经  1东经',
  `e_deg` int(10) DEFAULT NULL COMMENT '经度的度值 0-89',
  `e_min_mm` int(10) DEFAULT NULL COMMENT '经度的分值 0-59',
  `e_min_f` int(10) DEFAULT NULL COMMENT '经度的秒值 0-59',
  `height` int(10) DEFAULT NULL COMMENT '高度 单位m',
  PRIMARY KEY (`id`,`rru_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bts_position_info
-- ----------------------------

-- ----------------------------
-- Table structure for `switch_master_slaver_info`
-- ----------------------------
DROP TABLE IF EXISTS `switch_master_slaver_info`;
CREATE TABLE `switch_master_slaver_info` (
  `id` varchar(80) NOT NULL,
  `oam_ip` varchar(50) NOT NULL,
  `oam_port` varchar(10) NOT NULL,
  `ne_id` int(10) NOT NULL,
  `inst_id` int(10) NOT NULL,
  `local_nat_ip` varchar(20) DEFAULT NULL,
  `local_nat_gk_ip` varchar(20) DEFAULT NULL,
  `local_backup_ip` varchar(20) DEFAULT NULL,
  `remote_backup_ip` varchar(20) DEFAULT NULL,
  `backup_port` int(10) DEFAULT NULL,
  `cn_is_nat` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of switch_master_slaver_info
-- ----------------------------

-- ----------------------------
-- Table structure for `switch_running_info`
-- ----------------------------
DROP TABLE IF EXISTS `switch_running_info`;
CREATE TABLE `switch_running_info` (
  `id` varchar(80) NOT NULL,
  `oam_ip` varchar(50) NOT NULL,
  `oam_port` varchar(10) NOT NULL,
  `ne_id` int(10) NOT NULL,
  `inst_id` int(10) NOT NULL,
  `bts_id` int(10) DEFAULT NULL,
  `cell_id` int(10) DEFAULT NULL,
  `freq` int(10) DEFAULT NULL,
  `chan_num` int(10) DEFAULT NULL,
  `send_freq_num` varchar(10) DEFAULT NULL,
  `recv_freq_num` varchar(10) DEFAULT NULL,
  `authen_type` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of switch_running_info
-- ----------------------------

-- ----------------------------
-- Table structure for `switch_system_info`
-- ----------------------------
DROP TABLE IF EXISTS `switch_system_info`;
CREATE TABLE `switch_system_info` (
  `id` varchar(80) NOT NULL,
  `oam_ip` varchar(50) NOT NULL,
  `oam_port` varchar(10) NOT NULL,
  `ne_id` int(10) NOT NULL,
  `inst_id` int(10) NOT NULL,
  `bts_id` int(10) DEFAULT NULL,
  `cell_id` int(10) DEFAULT NULL,
  `gkf` int(10) DEFAULT NULL,
  `gkpn` int(10) DEFAULT NULL,
  `mnc` int(10) DEFAULT NULL,
  `net_work` int(10) DEFAULT NULL,
  `cc` int(10) DEFAULT NULL,
  `bc` int(10) DEFAULT NULL,
  `dm` varchar(10) DEFAULT NULL,
  `net_work_model` int(10) DEFAULT NULL,
  `nzi` int(10) DEFAULT NULL,
  `lai` int(10) DEFAULT NULL,
  `aie_type` int(10) DEFAULT NULL,
  `dia_num_len` int(10) DEFAULT NULL,
  `color_code` int(10) DEFAULT NULL,
  `cp_chan_num` int(10) DEFAULT NULL,
  `up_chan_num` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `neId` (`ne_id`) USING BTREE,
  KEY `instId` (`inst_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of switch_system_info
-- ----------------------------

-- ----------------------------
-- Table structure for `switch_timer_info`
-- ----------------------------
DROP TABLE IF EXISTS `switch_timer_info`;
CREATE TABLE `switch_timer_info` (
  `id` varchar(80) NOT NULL,
  `oam_ip` varchar(50) NOT NULL,
  `oam_port` varchar(10) NOT NULL,
  `ne_id` int(10) NOT NULL,
  `inst_id` int(10) NOT NULL,
  `group_call_delay_timer` int(10) DEFAULT NULL,
  `frtp_timeout_timer` int(10) DEFAULT NULL,
  `hrtp_timeout_timer` int(10) DEFAULT NULL,
  `grtp_timeout_timer` int(10) DEFAULT NULL,
  `crtp_timeout_timer` int(10) DEFAULT NULL,
  `ptt_timeout_timer` int(10) DEFAULT NULL,
  `call_alive_timer` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of switch_timer_info
-- ----------------------------
