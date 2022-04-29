/*
Navicat MySQL Data Transfer

Source Server         : 192.1.1.79
Source Server Version : 50728
Source Host           : 192.1.1.79:3306
Source Database       : 2011_resource_service

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2022-01-21 10:28:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `bbu_neighbor`
-- ----------------------------
DROP TABLE IF EXISTS `bbu_neighbor`;
CREATE TABLE `bbu_neighbor` (
  `from_serial_number` varchar(50) NOT NULL COMMENT '本bbu的设备id',
  `to_serial_number` varchar(50) NOT NULL COMMENT '邻居bbu的设备id',
  `send_type` int(10) DEFAULT '0' COMMENT '0保存1下发',
  PRIMARY KEY (`from_serial_number`,`to_serial_number`),
  KEY `to_serial_number` (`to_serial_number`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bbu_neighbor
-- ----------------------------

-- ----------------------------
-- Table structure for `dev`
-- ----------------------------
DROP TABLE IF EXISTS `dev`;
CREATE TABLE `dev` (
  `id` varchar(50) NOT NULL,
  `type_id` int(10) unsigned NOT NULL COMMENT '设备类型ID',
  `serial_number` varchar(255) DEFAULT '0' COMMENT '序列号',
  `bts_id` int(10) DEFAULT NULL COMMENT '基站id',
  `device_name` varchar(255) DEFAULT NULL COMMENT '设备显示名称',
  `status` tinyint(4) unsigned DEFAULT '0' COMMENT '状态: 故障（2），上线（1），下线（0）',
  `alarm` int(255) unsigned DEFAULT '0' COMMENT '告警标志位',
  `manage_ip` varchar(32) NOT NULL COMMENT '管理IP',
  `port` int(10) DEFAULT '0' COMMENT '端口',
  `cascade_device` varchar(50) DEFAULT NULL COMMENT '联级设备',
  `url` varchar(255) DEFAULT NULL COMMENT 'url',
  `brand` int(10) DEFAULT '0' COMMENT '0 设备 1 BBU 2 RRU',
  `snmp` varchar(255) DEFAULT NULL COMMENT 'SNMP:{"version":"snmpV2","port":161,"OID":null,"read":"public","write":"public"}',
  `attr_value` varchar(255) DEFAULT NULL COMMENT 'attr_value:{"12":"23r","2":"8"}',
  `statistics` varchar(255) DEFAULT NULL COMMENT '统计信息',
  `affiliation_company` int(10) DEFAULT NULL COMMENT '归属单位',
  `longitude` decimal(20,10) DEFAULT '116.3900000000' COMMENT '经度',
  `latitude` decimal(20,10) DEFAULT '39.9200000000' COMMENT '纬度',
  `height` decimal(20,10) DEFAULT '0.0000000000' COMMENT '高度',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  `pattern` int(10) DEFAULT '0' COMMENT '0:PDT,1:MDT',
  `mdt_number` varchar(50) DEFAULT NULL COMMENT 'mdt号码',
  `pdt_number` varchar(50) DEFAULT NULL COMMENT 'pdt号码',
  `gw_id` int(10) DEFAULT NULL COMMENT '网关id',
  `gw_group` int(10) DEFAULT NULL COMMENT '网关组号',
  `bts_json` text COMMENT '基站参数',
  `gw_json` text COMMENT '交换的参数',
  `vswr_status` int(10) DEFAULT NULL COMMENT 'RRU驻波比状态',
  `ctrl_port` int(10) DEFAULT NULL COMMENT '控制端口',
  `ctrl_ip` varchar(255) DEFAULT NULL COMMENT '控制IP',
  `dev_source` varchar(255) DEFAULT NULL,
  `dev_picture` varchar(255) DEFAULT NULL COMMENT '设备图片',
  `dev_jigui_picture` varchar(255) DEFAULT NULL COMMENT '设备机柜里的图',
  `cabinet_id` int(10) unsigned DEFAULT NULL COMMENT '机柜外键',
  `cabinet_location` int(10) DEFAULT NULL COMMENT '所在机柜位置',
  `hidden` int(10) DEFAULT '0' COMMENT '是否显示 0显示 1隐藏',
  `creation_method` int(5) DEFAULT '0' COMMENT '0自动创建1手动添加',
  `gw_config_status` int(10) DEFAULT '0' COMMENT '网关配置状态',
  `bts_config_status` int(10) DEFAULT '0' COMMENT '基站配置状态',
  PRIMARY KEY (`id`),
  KEY `type_id_2` (`type_id`) USING BTREE,
  KEY `serial_number` (`serial_number`) USING BTREE,
  CONSTRAINT `dev_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `dev_type` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dev
-- ----------------------------

-- ----------------------------
-- Table structure for `dev_attr`
-- ----------------------------
DROP TABLE IF EXISTS `dev_attr`;
CREATE TABLE `dev_attr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(10) unsigned NOT NULL COMMENT '设备类型ID',
  `name` varchar(32) NOT NULL COMMENT '属性名称',
  `display_name` varchar(255) NOT NULL COMMENT '显示名称',
  `device_attr` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '静态属性（0），动态属性（1），配置属性（2）',
  `device_attr_default` varchar(255) DEFAULT NULL COMMENT '静态属性默认值',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`),
  KEY `type_id_1` (`type_id`) USING BTREE,
  CONSTRAINT `dev_attr_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `dev_type` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dev_attr
-- ----------------------------

-- ----------------------------
-- Table structure for `dev_cabinet`
-- ----------------------------
DROP TABLE IF EXISTS `dev_cabinet`;
CREATE TABLE `dev_cabinet` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cabinet_name` varchar(255) DEFAULT NULL COMMENT '机柜名称',
  `cabinet_capacity` int(10) DEFAULT NULL COMMENT '机柜容量',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dev_cabinet
-- ----------------------------
INSERT INTO `dev_cabinet` VALUES ('1', '机柜_一', '42', '2019-12-26 10:49:03');
INSERT INTO `dev_cabinet` VALUES ('2', '机柜_二', '42', '2019-12-26 10:49:03');
INSERT INTO `dev_cabinet` VALUES ('3', '机柜_三', '42', '2019-12-26 10:49:03');
INSERT INTO `dev_cabinet` VALUES ('4', '机柜_四', '42', '2019-12-26 10:49:03');
INSERT INTO `dev_cabinet` VALUES ('5', '机柜_五', '42', '2019-12-26 10:49:03');

-- ----------------------------
-- Table structure for `dev_card_info`
-- ----------------------------
DROP TABLE IF EXISTS `dev_card_info`;
CREATE TABLE `dev_card_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `card_num` int(11) DEFAULT NULL COMMENT '板卡数量',
  `slot_id` varchar(20) DEFAULT NULL COMMENT '板卡号(与oam配置文件中板卡号对应)',
  `device_id` varchar(255) NOT NULL COMMENT '设备id',
  `card_name` varchar(20) DEFAULT NULL COMMENT '板卡名',
  `card_type` varchar(20) DEFAULT NULL COMMENT '类型(oam为1 E1为2)',
  `card_ip` varchar(64) DEFAULT NULL COMMENT 'ip对应dev表的manage_ip也就是主oam的ip',
  `status` varchar(10) DEFAULT '1' COMMENT '板卡状态',
  `monitor_ip` varchar(255) DEFAULT NULL COMMENT '每个板子的ip',
  `monitor_port` int(11) DEFAULT NULL COMMENT 'ssh连接端口',
  `monitor_user` varchar(255) DEFAULT NULL COMMENT 'ssh连接用户名',
  `monitor_password` varchar(255) DEFAULT NULL COMMENT 'ssh连接用户密码',
  `dev_source` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dev_card_info
-- ----------------------------

-- ----------------------------
-- Table structure for `dev_category`
-- ----------------------------
DROP TABLE IF EXISTS `dev_category`;
CREATE TABLE `dev_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) DEFAULT NULL COMMENT '资源类别名称',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dev_category
-- ----------------------------
INSERT INTO `dev_category` VALUES ('1', '基站', '2021-15-02 16:19:58');
INSERT INTO `dev_category` VALUES ('2', '区域交换中心', '2021-15-02 16:19:58');
INSERT INTO `dev_category` VALUES ('3', '移动交换机', '2021-15-02 16:19:58');
INSERT INTO `dev_category` VALUES ('4', '网管', '2021-15-02 16:19:58');
INSERT INTO `dev_category` VALUES ('5', '网系', '2021-15-02 16:19:58');

-- ----------------------------
-- Table structure for `dev_link`
-- ----------------------------
DROP TABLE IF EXISTS `dev_link`;
CREATE TABLE `dev_link` (
  `dev_from` varchar(255) NOT NULL COMMENT '设备id,链路上游设备,外键',
  `dev_to` varchar(255) NOT NULL COMMENT '设备id,链路下游设备,外键',
  `line_status` int(4) DEFAULT '0' COMMENT '链路状态(0下线,1正常,2故障)',
  `line_type` int(4) NOT NULL COMMENT '拓扑线类型(0直线,1折线)',
  `line_direction` varchar(255) NOT NULL COMMENT '拓扑线方向',
  `line_shears` int(4) DEFAULT NULL COMMENT '链路是否有箭头(0没有,1有)',
  `from_longitude` decimal(20,10) DEFAULT '0.0000000000' COMMENT '上游经度',
  `from_latitude` decimal(20,10) DEFAULT '0.0000000000' COMMENT '上游纬度',
  `to_longitude` decimal(20,10) DEFAULT '116.3900000000' COMMENT '下游经度',
  `to_latitude` decimal(20,10) DEFAULT '39.9200000000' COMMENT '下游纬度',
  `unit_id` int(20) DEFAULT '0' COMMENT '单位id form所属单位id',
  `is_display` int(4) DEFAULT '0' COMMENT '是否显示0显示1不显示',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  `dev_source` varchar(255) DEFAULT NULL COMMENT '设备来源',
  PRIMARY KEY (`dev_from`,`dev_to`),
  KEY `line_dev1` (`dev_from`) USING BTREE,
  KEY `line_dev2` (`dev_to`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dev_link
-- ----------------------------

-- ----------------------------
-- Table structure for `dev_monitor`
-- ----------------------------
DROP TABLE IF EXISTS `dev_monitor`;
CREATE TABLE `dev_monitor` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `device_id` varchar(255) DEFAULT NULL,
  `card_num` int(11) DEFAULT NULL,
  `memory` varchar(255) DEFAULT NULL,
  `cpu` varchar(255) DEFAULT NULL,
  `disk_space` varchar(255) DEFAULT NULL,
  `board_rx` varchar(50) DEFAULT NULL COMMENT '网络接收速率',
  `board_tx` varchar(50) DEFAULT NULL COMMENT '网络发射速率',
  `temperature` varchar(50) DEFAULT NULL COMMENT '温度',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dev_monitor
-- ----------------------------
INSERT INTO `dev_monitor` VALUES ('48', '516937cad9cf4ff9855ea495024ebd6c', '2', '', '100%', '', '0KB/s', '0KB/s', null);

-- ----------------------------
-- Table structure for `dev_type`
-- ----------------------------
DROP TABLE IF EXISTS `dev_type`;
CREATE TABLE `dev_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL COMMENT '资源类别',
  `model` varchar(32) DEFAULT NULL COMMENT '设备型号',
  `display_name` varchar(255) DEFAULT NULL COMMENT '设备名称',
  `manufacturer` varchar(32) DEFAULT NULL COMMENT '设备厂商',
  `period` int(10) unsigned DEFAULT NULL COMMENT '设备上报周期（秒）',
  `picture_url` varchar(150) DEFAULT NULL COMMENT '图片选择',
  `device_url` varchar(150) DEFAULT NULL COMMENT '设备URL',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`),
  KEY `type_id_3` (`category_id`) USING BTREE,
  CONSTRAINT `dev_type_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `dev_category` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dev_type
-- ----------------------------
INSERT INTO `dev_type` VALUES ('1', '1', '1', '集群固定基站', 'sunkaisens', '0', null, null, '2021-15-02 16:19:58');
INSERT INTO `dev_type` VALUES ('2', '1', '2', '集群车载基站', 'sunkaisens', '0', null, null, '2021-15-02 16:19:58');
INSERT INTO `dev_type` VALUES ('3', '2', '3', '区域交换中心', 'sunkaisens', '0', null, null, '2021-15-02 16:19:58');
INSERT INTO `dev_type` VALUES ('4', '3', '4', '移动交换机', 'sunkaisens', '0', null, null, '2021-15-02 16:19:58');
INSERT INTO `dev_type` VALUES ('5', '2', '5', '电路域接口单元', 'sunkaisens', '1', 'static/nodeImg/dianluyu.png', 'static/nodeImg/dianluyu.png', '2021-15-02 16:19:58');
INSERT INTO `dev_type` VALUES ('6', '2', '6', '综合网管单元', 'sunkaisens', '1', 'static/nodeImg/zonghewangguan.png', 'static/nodeImg/zonghewangguan.png', '2021-15-02 16:19:58');
INSERT INTO `dev_type` VALUES ('7', '2', '7', '指挥调度单元', 'sunkaisens', '1', 'static/nodeImg/zhihuidiaodu.png', 'static/nodeImg/zhihuidiaodu.png', '2021-15-02 16:19:58');
INSERT INTO `dev_type` VALUES ('8', '2', '8', 'ATCA(核心网)', 'sunkaisens', '1', 'static/nodeImg/yewujiaohuan.png', 'static/nodeImg/yewujiaohuan.png', '2021-15-02 16:19:58');
INSERT INTO `dev_type` VALUES ('9', '5', '9', '军用移动通信系统设备', 'sunkaisens', '0', null, null, '2021-15-02 16:19:58');
INSERT INTO `dev_type` VALUES ('10', '5', '10', '公安PDT交换设备', 'sunkaisens', '0', null, null, '2021-15-02 16:19:58');
INSERT INTO `dev_type` VALUES ('11', '5', '11', '军用PSTN设备', 'sunkaisens', '0', null, null, '2021-15-02 16:19:58');
INSERT INTO `dev_type` VALUES ('12', '4', '12', '网管', 'sunkaisens', '0', null, null, '2021-15-02 16:19:58');

-- ----------------------------
-- Table structure for `entity`
-- ----------------------------
DROP TABLE IF EXISTS `entity`;
CREATE TABLE `entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `instId` int(11) NOT NULL,
  `status` int(11) DEFAULT '0',
  `type` int(11) DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `moduleId` int(11) DEFAULT NULL,
  `cardId` int(11) DEFAULT NULL,
  `device_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `moduleId` (`moduleId`) USING BTREE,
  KEY `cardId` (`cardId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=343 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of entity
-- ----------------------------

-- ----------------------------
-- Table structure for `event_code`
-- ----------------------------
DROP TABLE IF EXISTS `event_code`;
CREATE TABLE `event_code` (
  `event_id` int(50) NOT NULL COMMENT '事件的Id',
  `event_des` varchar(255) DEFAULT NULL COMMENT '事件的描述',
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of event_code
-- ----------------------------
INSERT INTO `event_code` VALUES ('1', 'BBU主控板主备切换');

-- ----------------------------
-- Table structure for `event_info`
-- ----------------------------
DROP TABLE IF EXISTS `event_info`;
CREATE TABLE `event_info` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `event_code` int(50) DEFAULT NULL COMMENT '事件Id',
  `event_des` varchar(255) DEFAULT NULL COMMENT '事件描述',
  `remark` varchar(255) DEFAULT NULL COMMENT '事件的描述',
  `unit` varchar(255) DEFAULT NULL COMMENT '序列号',
  `type_id` int(10) DEFAULT NULL COMMENT '设备类型',
  `updatetime` varchar(200) DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of event_info
-- ----------------------------

-- ----------------------------
-- Table structure for `process_status`
-- ----------------------------
DROP TABLE IF EXISTS `process_status`;
CREATE TABLE `process_status` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `process_name` varchar(255) DEFAULT NULL COMMENT '进程名',
  `instance_id` varchar(255) DEFAULT NULL COMMENT '进程实例号',
  `process_status` int(10) DEFAULT NULL COMMENT '0：已启动， 1：未启动',
  `process_des` varchar(255) DEFAULT NULL COMMENT '进程描述',
  `device_id` varchar(255) DEFAULT NULL COMMENT '设备唯一标识符',
  `unit` int(10) DEFAULT NULL COMMENT '单元序号（如板卡号或通道号），为0时表示设备本身',
  `subnet_id` varchar(255) DEFAULT NULL COMMENT '子网标识',
  `subnet_num` varchar(255) DEFAULT NULL COMMENT '子网序号',
  `sub_system_id` varchar(255) DEFAULT NULL COMMENT '分系统标识',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=568 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of process_status
-- ----------------------------
