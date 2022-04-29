/*
Navicat MySQL Data Transfer

Source Server         : 172.16.0.200（aj好的测试环境）
Source Server Version : 50505
Source Host           : 172.16.0.200:3306
Source Database       : hss

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2022-02-18 17:22:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `AUC`
-- ----------------------------
DROP TABLE IF EXISTS `AUC`;
CREATE TABLE `AUC` (
  `IMSI` varchar(32) NOT NULL DEFAULT 'NULL',
  `K` varchar(48) NOT NULL DEFAULT '00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00',
  `OP` varchar(48) NOT NULL DEFAULT '00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00',
  `OPc` varchar(48) NOT NULL DEFAULT '00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00',
  `AMF` varchar(6) NOT NULL DEFAULT '72 4C',
  `SQN` varchar(18) NOT NULL DEFAULT '00 00 00 00 00 00',
  `RAND` varchar(48) NOT NULL DEFAULT '00 00 00 00 00 00',
  `tstamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `START` time NOT NULL DEFAULT '00:00:00',
  `STOP` time NOT NULL DEFAULT '23:59:59',
  `BelongHss` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`IMSI`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of AUC
-- ----------------------------
INSERT INTO `AUC` VALUES ('444444444444444', 'FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ', 'FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ', 'FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ', '72 4C ', '00 00 00 00 00 00 ', '00 00 00 00 00 00', '2021-04-28 18:03:44', '00:00:00', '23:59:59', 'hss');

-- ----------------------------
-- Table structure for `csHLRGroupData`
-- ----------------------------
DROP TABLE IF EXISTS `csHLRGroupData`;
CREATE TABLE `csHLRGroupData` (
  `groupNum` varchar(32) NOT NULL DEFAULT '',
  `ssCode` int(11) NOT NULL DEFAULT 0,
  `ssStatus` int(11) NOT NULL DEFAULT 0,
  `ssOpt` int(11) NOT NULL DEFAULT 0,
  `ssDetail` varchar(32) NOT NULL DEFAULT '',
  `description` varchar(128) NOT NULL DEFAULT '',
  `lastUpdateTstamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`groupNum`,`ssCode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of csHLRGroupData
-- ----------------------------

-- ----------------------------
-- Table structure for `csHLRGroupInfo`
-- ----------------------------
DROP TABLE IF EXISTS `csHLRGroupInfo`;
CREATE TABLE `csHLRGroupInfo` (
  `groupNum` varchar(32) NOT NULL DEFAULT '',
  `groupTmsi` varchar(32) NOT NULL DEFAULT '',
  `groupCreator` varchar(32) NOT NULL DEFAULT '',
  `groupCallType` int(11) NOT NULL DEFAULT 0,
  `groupCallBear` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) NOT NULL DEFAULT 0,
  `servloc` varchar(128) NOT NULL DEFAULT '@',
  `status` int(11) NOT NULL DEFAULT 0,
  `tstamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `lastUpdateTstamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`groupNum`) USING BTREE,
  UNIQUE KEY `groupNum` (`groupNum`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of csHLRGroupInfo
-- ----------------------------

-- ----------------------------
-- Table structure for `csHLRGroupMember`
-- ----------------------------
DROP TABLE IF EXISTS `csHLRGroupMember`;
CREATE TABLE `csHLRGroupMember` (
  `groupNum` varchar(32) NOT NULL DEFAULT '',
  `groupMember` varchar(32) NOT NULL DEFAULT '',
  `priority` int(11) NOT NULL DEFAULT 0,
  `role` int(11) NOT NULL DEFAULT 0,
  `service` int(11) NOT NULL DEFAULT 0,
  `serviceExtra` int(11) NOT NULL DEFAULT 0,
  `memberHssAddr` varchar(64) NOT NULL DEFAULT '0.0.0.0:0',
  `inServiceFlag` int(11) NOT NULL DEFAULT 0,
  `tstamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `lastUpdateTstamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`groupNum`,`groupMember`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of csHLRGroupMember
-- ----------------------------

-- ----------------------------
-- Table structure for `EPCSubscriptionData`
-- ----------------------------
DROP TABLE IF EXISTS `EPCSubscriptionData`;
CREATE TABLE `EPCSubscriptionData` (
  `IMSI` varchar(32) NOT NULL DEFAULT '',
  `APN` varchar(64) NOT NULL DEFAULT 'sunkaisens',
  `Type` int(11) NOT NULL DEFAULT 0,
  `QCI` int(11) NOT NULL DEFAULT 9,
  `AggregateMaxULBitrate` int(11) NOT NULL DEFAULT 25000,
  `AggregateMaxDLBitrate` int(11) NOT NULL DEFAULT 35000,
  `GuaranteedULBitRate` int(11) NOT NULL DEFAULT 0,
  `GuaranteedDLBitRate` int(11) NOT NULL DEFAULT 0,
  `MaxULBitRate` int(11) NOT NULL DEFAULT 0,
  `MaxDLBitRate` int(11) NOT NULL DEFAULT 0,
  `PDNType` int(11) NOT NULL DEFAULT 0,
  `PriorityLvl` int(11) NOT NULL DEFAULT 1,
  `PreEmptionCap` int(11) NOT NULL DEFAULT 1,
  `PreEmptionVulnerability` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`IMSI`,`APN`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of EPCSubscriptionData
-- ----------------------------

-- ----------------------------
-- Table structure for `EPCSubscriptionTFT`
-- ----------------------------
DROP TABLE IF EXISTS `EPCSubscriptionTFT`;
CREATE TABLE `EPCSubscriptionTFT` (
  `IMSI` varchar(32) NOT NULL DEFAULT '',
  `SrcIP` varchar(64) NOT NULL DEFAULT '0.0.0.0',
  `DstIP` varchar(64) NOT NULL DEFAULT '0.0.0.0',
  `SrcPortStart` int(11) NOT NULL DEFAULT 0,
  `SrcPortEnd` int(11) NOT NULL DEFAULT 0,
  `DstPortStart` int(11) NOT NULL DEFAULT 0,
  `DstPortEnd` int(11) NOT NULL DEFAULT 0,
  `DiffServStart` int(11) NOT NULL DEFAULT 0,
  `DiffServEnd` int(11) NOT NULL DEFAULT 0,
  `PktLenMin` int(11) NOT NULL DEFAULT 0,
  `PktLenMax` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`IMSI`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of EPCSubscriptionTFT
-- ----------------------------

-- ----------------------------
-- Table structure for `GroupInfo`
-- ----------------------------
DROP TABLE IF EXISTS `GroupInfo`;
CREATE TABLE `GroupInfo` (
  `groupIMSI` varchar(32) NOT NULL DEFAULT '',
  `groupNum` varchar(32) NOT NULL DEFAULT '',
  `groupHssAddr` varchar(64) NOT NULL DEFAULT '0.0.0.0:0',
  `groupCallType` int(11) NOT NULL DEFAULT 0,
  `inServiceFlag` int(11) NOT NULL DEFAULT 0,
  `tstamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `lastUpdateTstamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`groupIMSI`,`groupNum`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of GroupInfo
-- ----------------------------

-- ----------------------------
-- Table structure for `HLR`
-- ----------------------------
DROP TABLE IF EXISTS `HLR`;
CREATE TABLE `HLR` (
  `IMSI` varchar(32) NOT NULL DEFAULT '',
  `MDN` varchar(32) NOT NULL DEFAULT '',
  `ESN` varchar(32) NOT NULL DEFAULT '',
  `TMSI` varchar(32) NOT NULL DEFAULT '',
  `RncLoc` varchar(32) NOT NULL DEFAULT '0000-0000',
  `GeoLoc` varchar(32) NOT NULL DEFAULT '0000-0000',
  `MSprofile` int(11) NOT NULL DEFAULT 0,
  `MSprofile_extra` int(11) NOT NULL DEFAULT 0,
  `MSvocodec` int(11) NOT NULL DEFAULT 0,
  `Acount_num` varchar(32) NOT NULL DEFAULT '',
  `currloc` varchar(128) NOT NULL DEFAULT '@',
  `tstamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `numOfSms` int(11) NOT NULL DEFAULT 0,
  `numOfVM` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `VLRAddr` varchar(128) NOT NULL DEFAULT '@',
  `DeviceType` int(11) NOT NULL DEFAULT 0,
  `BelongHss` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`IMSI`) USING BTREE,
  KEY `MDN` (`MDN`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of HLR
-- ----------------------------
INSERT INTO `HLR` VALUES ('444444444444444', '00000123456', '00000000', '', '0000-0000', '0000-0000', '-267973120', '16777216', '40', '', '@', '2021-04-28 18:03:44', '0', '0', '0', '@', '5', 'hss');

-- ----------------------------
-- Table structure for `HLRps`
-- ----------------------------
DROP TABLE IF EXISTS `HLRps`;
CREATE TABLE `HLRps` (
  `IMSI` varchar(32) NOT NULL DEFAULT '',
  `MDN` varchar(32) NOT NULL DEFAULT '',
  `ESN` varchar(32) NOT NULL DEFAULT '',
  `TMSI` varchar(32) NOT NULL DEFAULT '',
  `RncLoc` varchar(32) NOT NULL DEFAULT '0000-0000',
  `GeoLoc` varchar(32) NOT NULL DEFAULT '0000-0000',
  `MSprofile` int(11) NOT NULL DEFAULT 0,
  `MSprofile_extra` int(11) NOT NULL DEFAULT 0,
  `MSvocodec` int(11) NOT NULL DEFAULT 0,
  `Acount_num` varchar(32) NOT NULL DEFAULT '',
  `currloc` varchar(128) NOT NULL DEFAULT '@',
  `tstamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `AggregateMaxULBitrate` int(11) NOT NULL DEFAULT 25000,
  `AggregateMaxDLBitrate` int(11) NOT NULL DEFAULT 35000,
  `status` int(11) NOT NULL DEFAULT 0,
  `VLRAddr` varchar(128) NOT NULL DEFAULT '@',
  `DeviceType` int(11) NOT NULL DEFAULT 0,
  `BelongHss` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`IMSI`) USING BTREE,
  KEY `MDN` (`MDN`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of HLRps
-- ----------------------------
INSERT INTO `HLRps` VALUES ('444444444444444', '00000123456', '00000000', '', '0000-0000', '0000-0000', '786432', '16777216', '40', '', '@', '2021-04-28 18:03:44', '25000', '35000', '0', '@', '5', 'hss');

-- ----------------------------
-- Table structure for `MSService`
-- ----------------------------
DROP TABLE IF EXISTS `MSService`;
CREATE TABLE `MSService` (
  `IMSI` varchar(32) NOT NULL DEFAULT '',
  `Status` varchar(32) NOT NULL DEFAULT 'inactive',
  `directFwdNum` varchar(32) NOT NULL DEFAULT '',
  `fwdOnBusyNum` varchar(32) NOT NULL DEFAULT '',
  `fwdNoAnswerNum` varchar(32) NOT NULL DEFAULT '',
  `voicemailNum` varchar(32) NOT NULL DEFAULT '',
  `fwdNANum` varchar(32) NOT NULL DEFAULT '',
  `WireTapAddr` varchar(32) NOT NULL DEFAULT '',
  `BelongHss` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`IMSI`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of MSService
-- ----------------------------
INSERT INTO `MSService` VALUES ('444444444444444', '', '', '', '', '', '', '', 'hss');

-- ----------------------------
-- Table structure for `TerminalInfo`
-- ----------------------------
DROP TABLE IF EXISTS `TerminalInfo`;
CREATE TABLE `TerminalInfo` (
  `IMSI` varchar(32) NOT NULL,
  `terminalId` varchar(30) DEFAULT NULL,
  `terminalType` int(11) DEFAULT NULL,
  `powerLevel` int(11) DEFAULT NULL,
  `suportBuss` int(11) DEFAULT NULL,
  `gwId` int(11) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `userType` int(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `userInfo` varchar(255) DEFAULT NULL,
  `servicePriority` int(11) DEFAULT NULL,
  `createTime` timestamp NOT NULL DEFAULT current_timestamp(),
  `BelongHss` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`IMSI`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of TerminalInfo
-- ----------------------------
INSERT INTO `TerminalInfo` VALUES ('444444444444444', '', null, null, '-267973120', null, '', '3', '', '3', '5', '2021-04-28 18:03:44', 'hss');

-- ----------------------------
-- Procedure structure for `addAuc`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addAuc`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `addAuc`(count INT,imsi bigint)
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler for 1062 set err=-1;
	while i < count do
		insert into AUC (IMSI)values(CONCAT(imsi));
		set imsi = imsi + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `addEpc`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addEpc`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `addEpc`(count int,imsi bigint)
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler for 1062 set err=-1;
	while i < count do
		insert into EPCSubscriptionData (IMSI)values(CONCAT(imsi));
		set imsi = imsi + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `addHlr`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addHlr`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `addHlr`(count INT,imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int)
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	while i < count do
		insert into HLR (IMSI,MDN,ESN,MSprofile,DeviceType,MSvocodec,Msprofile_extra)values(CONCAT(imsi),CONCAT(mdn),right(CONCAT('00000000',CONV(esn,10,16)),8),msprofile,deviceType,msvocodec,msprofile_extra);
		set imsi = imsi + 1;
		set mdn = mdn + 1;
		set esn = esn + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `addHlrps`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addHlrps`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `addHlrps`(count INT,imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int)
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	while i < count do
		insert into HLRps (IMSI,MDN,ESN,MSprofile,DeviceType,MSvocodec,Msprofile_extra)values(CONCAT(imsi),CONCAT(mdn),right(CONCAT('00000000',CONV(esn,10,16)),8),msprofile,deviceType,msvocodec,msprofile_extra);
		set imsi = imsi + 1;
		set mdn = mdn + 1;
		set esn = esn + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `addMSService`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addMSService`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `addMSService`(count int,imsi bigint,WireTapAddr varchar(32))
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler for 1062 set err=-1;
	while i < count do
		insert into MSService (IMSI,WireTapAddr)values(CONCAT(imsi),WireTapAddr);
		set imsi = imsi + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `addTerminalInfo`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addTerminalInfo`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `addTerminalInfo`(count int,imsi bigint,terminalId bigint,terminalType int,powerLevel int,suportBuss int,gwId int,department int,userType int,createTime timestamp,servicePriority int)
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler for 1062 set err=-1;
	while i < count do
		insert into TerminalInfo(IMSI,terminalId,terminalType,powerLevel,suportBuss,gwId,department,userType,createTime,servicePriority) 
		values(CONCAT(imsi),CONCAT(terminalId),terminalType,powerLevel,suportBuss,gwId,CONCAT(department),userType,createTime,servicePriority);
		set imsi = imsi + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `addTft`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addTft`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `addTft`(count int,imsi bigint)
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler for 1062 set err=-1;
	while i < count do
		insert into EPCSubscriptionTFT (IMSI)values(CONCAT(imsi));
		set imsi = imsi + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `HlrPsAdd`
-- ----------------------------
DROP PROCEDURE IF EXISTS `HlrPsAdd`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `HlrPsAdd`(count INT,imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int,AggregateMaxULBitrate int,AggregateMaxDLBitrate int)
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	while i < count do
		insert into HLRps (IMSI,MDN,ESN,MSprofile,DeviceType,MSvocodec,msprofile_extra,AggregateMaxULBitrate,AggregateMaxDLBitrate)values(CONCAT(imsi),CONCAT(mdn),right(CONCAT('00000000',CONV(esn,10,16)),8),msprofile,deviceType,msvocodec,msprofile_extra,AggregateMaxULBitrate,AggregateMaxDLBitrate);
		set imsi = imsi + 1;
		set mdn = mdn + 1;
		set esn = esn + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `HlrPsUpdate`
-- ----------------------------
DROP PROCEDURE IF EXISTS `HlrPsUpdate`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `HlrPsUpdate`(count INT,imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int)
begin
	declare i int default 0;
	while i < count do
		set @sql='update HLRps set MDN=CONCAT(?),ESN=CONCAT(?),MSprofile=?,DeviceType=?,MSvocodec=?,Msprofile_extra=? where IMSI=CONCAT(?);';
		set @imsi=imsi;set @mdn=mdn;set @esn=right(CONCAT('00000000',esn),8);set @msprofile=msprofile;set @deviceType=deviceType;set @msvocodec=msvocodec;set @msprofile_extra=msprofile_extra;
		prepare stmt from @sql;
		execute stmt using @mdn,@esn,@msprofile,@deviceType,@msvocodec,@msprofile_extra,@imsi;
		set imsi = imsi + 1;
		set mdn = mdn + 1;
		set esn = esn + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `updateHlr`
-- ----------------------------
DROP PROCEDURE IF EXISTS `updateHlr`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updateHlr`(count INT,imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int)
begin
	declare i int default 0;
	while i < count do
		set @sql='update HLR set MDN=CONCAT(?),ESN=CONCAT(?),MSprofile=?,DeviceType=?,MSvocodec=?,Msprofile_extra=? where IMSI=CONCAT(?);';
		set @imsi=imsi;set @mdn=mdn;set @esn=right(CONCAT('00000000',CONV(esn,10,16)),8);set @msprofile=msprofile;set @deviceType=deviceType;set @msvocodec=msvocodec;set @msprofile_extra=msprofile_extra;
		prepare stmt from @sql;
		execute stmt using @mdn,@esn,@msprofile,@deviceType,@msvocodec,@msprofile_extra,@imsi;
		set imsi = imsi + 1;
		set mdn = mdn + 1;
		set esn = esn + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `updateHlrps`
-- ----------------------------
DROP PROCEDURE IF EXISTS `updateHlrps`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updateHlrps`(count INT,imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int)
begin
	declare i int default 0;
	while i < count do
		set @sql='update HLRps set MDN=CONCAT(?),ESN=CONCAT(?),MSprofile=?,DeviceType=?,MSvocodec=?,Msprofile_extra=? where IMSI=CONCAT(?);';
		set @imsi=imsi;set @mdn=mdn;set @esn=right(CONCAT('00000000',esn),8);set @msprofile=msprofile;set @deviceType=deviceType;set @msvocodec=msvocodec;set @msprofile_extra=msprofile_extra;
		prepare stmt from @sql;
		execute stmt using @mdn,@esn,@msprofile,@deviceType,@msvocodec,@msprofile_extra,@imsi;
		set imsi = imsi + 1;
		set mdn = mdn + 1;
		set esn = esn + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;
