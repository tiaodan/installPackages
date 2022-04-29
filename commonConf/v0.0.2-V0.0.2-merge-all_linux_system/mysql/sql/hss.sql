/*
Navicat MySQL Data Transfer

Source Server         : 192.1.1.156
Source Server Version : 50728
Source Host           : 192.1.1.156:3306
Source Database       : hss

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2021-05-21 14:51:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `alarm_record`
-- ----------------------------
DROP TABLE IF EXISTS `alarm_record`;
CREATE TABLE `alarm_record` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `devId` bigint(11) NOT NULL,
  `devType` bigint(11) NOT NULL,
  `alarmCode` bigint(11) NOT NULL,
  `alarmPriority` bigint(11) NOT NULL,
  `identifyCode` varchar(50) NOT NULL,
  `isClear` int(11) NOT NULL,
  `isAlarmUp` int(11) NOT NULL,
  `isAlarmClearUp` int(11) NOT NULL,
  `warningTime` varchar(50) NOT NULL,
  `warningClearTime` varchar(50) NOT NULL,
  `updateTime` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4724 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of alarm_record
-- ----------------------------

-- ----------------------------
-- Table structure for `AUC`
-- ----------------------------
DROP TABLE IF EXISTS `AUC`;
CREATE TABLE `AUC` (
  `IMSI` varchar(32) NOT NULL DEFAULT 'NULL',
  `K` varchar(48) NOT NULL DEFAULT 'FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF',
  `OP` varchar(48) NOT NULL DEFAULT 'FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF',
  `OPc` varchar(48) NOT NULL DEFAULT 'FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF',
  `AMF` varchar(6) NOT NULL DEFAULT 'F2 4C',
  `SQN` varchar(18) NOT NULL DEFAULT '00 00 00 00 00 00',
  `RAND` varchar(48) NOT NULL DEFAULT '00 00 00 00 00 00',
  `tstamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `START` time NOT NULL DEFAULT '00:00:00',
  `STOP` time NOT NULL DEFAULT '23:59:59',
  `BelongHss` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`IMSI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of AUC
-- ----------------------------

-- ----------------------------
-- Table structure for `brustTask_record`
-- ----------------------------
DROP TABLE IF EXISTS `brustTask_record`;
CREATE TABLE `brustTask_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskId` bigint(20) DEFAULT NULL,
  `taskName` varchar(32) DEFAULT NULL,
  `taskPriority` int(11) DEFAULT NULL,
  `versinId` varchar(32) DEFAULT NULL,
  `msNumber` bigint(20) DEFAULT NULL,
  `gwId` int(11) DEFAULT NULL,
  `msList` varchar(100) DEFAULT NULL,
  `assignTime` bigint(20) DEFAULT NULL,
  `endTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of brustTask_record
-- ----------------------------

-- ----------------------------
-- Table structure for `collect_record`
-- ----------------------------
DROP TABLE IF EXISTS `collect_record`;
CREATE TABLE `collect_record` (
  `taskTarget` int(11) NOT NULL DEFAULT '0',
  `taskBeginTime` varchar(100) DEFAULT NULL,
  `taskEndTime` varchar(100) DEFAULT NULL,
  `taskFetchTimeInterval` int(11) DEFAULT NULL,
  `taskOffLineTime` varchar(100) DEFAULT NULL,
  `realCollectorId` int(11) DEFAULT NULL,
  PRIMARY KEY (`taskTarget`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of collect_record
-- ----------------------------

-- ----------------------------
-- Table structure for `EPCSubscriptionData`
-- ----------------------------
DROP TABLE IF EXISTS `EPCSubscriptionData`;
CREATE TABLE `EPCSubscriptionData` (
  `IMSI` varchar(32) NOT NULL DEFAULT '',
  `APN` varchar(64) NOT NULL DEFAULT 'sunkaisens',
  `ErabId` int(11) NOT NULL DEFAULT '5',
  `QCI` int(11) NOT NULL DEFAULT '9',
  `AggregateMaxULBitrate` int(11) NOT NULL DEFAULT '2500000',
  `AggregateMaxDLBitrate` int(11) NOT NULL DEFAULT '3500000',
  `GuaranteedULBitRate` int(11) NOT NULL DEFAULT '0',
  `GuaranteedDLBitRate` int(11) NOT NULL DEFAULT '0',
  `MaxULBitRate` int(11) NOT NULL DEFAULT '0',
  `MaxDLBitRate` int(11) NOT NULL DEFAULT '0',
  `ARPriority` int(11) NOT NULL DEFAULT '3',
  PRIMARY KEY (`IMSI`,`APN`,`ErabId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `SrcPortStart` int(11) NOT NULL DEFAULT '0',
  `SrcPortEnd` int(11) NOT NULL DEFAULT '0',
  `DstPortStart` int(11) NOT NULL DEFAULT '0',
  `DstPortEnd` int(11) NOT NULL DEFAULT '0',
  `DiffServStart` int(11) NOT NULL DEFAULT '0',
  `DiffServEnd` int(11) NOT NULL DEFAULT '0',
  `PktLenMin` int(11) NOT NULL DEFAULT '0',
  `PktLenMax` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`IMSI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of EPCSubscriptionTFT
-- ----------------------------

-- ----------------------------
-- Table structure for `GroupInfo`
-- ----------------------------
DROP TABLE IF EXISTS `GroupInfo`;
CREATE TABLE `GroupInfo` (
  `IMSI` varchar(32) NOT NULL DEFAULT '',
  `GROUP1` varchar(32) NOT NULL DEFAULT '',
  `GROUP2` varchar(32) NOT NULL DEFAULT '',
  `GROUP3` varchar(32) NOT NULL DEFAULT '',
  `GROUP4` varchar(32) NOT NULL DEFAULT '',
  `GROUP5` varchar(32) NOT NULL DEFAULT '',
  `GROUP6` varchar(32) NOT NULL DEFAULT '',
  `GROUP7` varchar(32) NOT NULL DEFAULT '',
  `GROUP8` varchar(32) NOT NULL DEFAULT '',
  `GROUP9` varchar(32) NOT NULL DEFAULT '',
  `GROUP10` varchar(32) NOT NULL DEFAULT '',
  `GROUP11` varchar(32) NOT NULL DEFAULT '',
  `GROUP12` varchar(32) NOT NULL DEFAULT '',
  `GROUP13` varchar(32) NOT NULL DEFAULT '',
  `GROUP14` varchar(32) NOT NULL DEFAULT '',
  `GROUP15` varchar(32) NOT NULL DEFAULT '',
  `GROUP16` varchar(32) NOT NULL DEFAULT '',
  `BelongHss` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`IMSI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `MSprofile` int(11) NOT NULL DEFAULT '0',
  `MSprofile_extra` int(11) NOT NULL DEFAULT '0',
  `MSvocodec` int(11) NOT NULL DEFAULT '0',
  `Acount_num` varchar(32) NOT NULL DEFAULT '',
  `currloc` varchar(128) NOT NULL DEFAULT '@',
  `tstamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `numOfSms` int(11) NOT NULL DEFAULT '0',
  `numOfVM` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `VLRAddr` varchar(128) NOT NULL DEFAULT '@',
  `DeviceType` int(11) NOT NULL DEFAULT '0',
  `BelongHss` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`IMSI`),
  UNIQUE KEY `MDN` (`MDN`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of HLR
-- ----------------------------

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
  `MSprofile` int(11) NOT NULL DEFAULT '0',
  `MSprofile_extra` int(11) NOT NULL DEFAULT '0',
  `MSvocodec` int(11) NOT NULL DEFAULT '0',
  `Acount_num` varchar(32) NOT NULL DEFAULT '',
  `currloc` varchar(128) NOT NULL DEFAULT '@',
  `tstamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `numOfSms` int(11) NOT NULL DEFAULT '0',
  `numOfVM` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `VLRAddr` varchar(128) NOT NULL DEFAULT '@',
  `DeviceType` int(11) NOT NULL DEFAULT '0',
  `BelongHss` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`IMSI`),
  KEY `MDN` (`MDN`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of HLRps
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
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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
  PRIMARY KEY (`IMSI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of MSService
-- ----------------------------

-- ----------------------------
-- Table structure for `TerminalInfo`
-- ----------------------------
DROP TABLE IF EXISTS `TerminalInfo`;
CREATE TABLE `TerminalInfo` (
  `IMSI` varchar(32) NOT NULL,
  `terminalId` varchar(30) NOT NULL DEFAULT '',
  `terminalType` int(11) DEFAULT NULL,
  `powerLevel` int(11) DEFAULT NULL,
  `suportBuss` int(11) DEFAULT NULL,
  `gwId` int(11) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `userType` int(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `userInfo` varchar(255) DEFAULT NULL,
  `servicePriority` int(11) DEFAULT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `BelongHss` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`IMSI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of TerminalInfo
-- ----------------------------

-- ----------------------------
-- Table structure for `terminalType`
-- ----------------------------
DROP TABLE IF EXISTS `terminalType`;
CREATE TABLE `terminalType` (
  `terminalId` int(11) DEFAULT NULL,
  `terminalName` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of terminalType
-- ----------------------------

-- ----------------------------
-- Procedure structure for `addAuc`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addAuc`;
DELIMITER ;;
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `addAuc`(count INT,imsi bigint)
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
-- Procedure structure for `addAucFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addAucFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addAucFK`(imsi bigint,k varchar(50),op varchar(50),opc varchar(50),amf varchar(50),sqn varchar(50),rand varchar(50),tstamp timestamp,start time,stop time,belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('insert into ',belongHss),'.AUC (IMSI,K,OP,OPc,AMF,SQN,RAND,tstamp,START,STOP) values(CONCAT(?),CONCAT(?),CONCAT(?),?,?,?,?,?,?,?);');
	set @imsi=imsi;
	set @k=k;
	set @op=op;
	set @opc=opc;
	set @amf=amf;
	set @sqn=sqn;
	set @rand=rand;
	set @tstamp=tstamp;
	set @start=start;
	set @stop=stop;
	prepare stmt from @sql;
	execute stmt using @imsi,@k,@op,@opc,@amf,@sqn,@rand,@tstamp,@start,@stop;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `addEpc`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addEpc`;
DELIMITER ;;
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `addEpc`(count int,imsi bigint)
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
-- Procedure structure for `addGroupInfo`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addGroupInfo`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addGroupInfo`(count int,imsi bigint,group1 varchar(32),group2 varchar(32),group3 varchar(32),group4 varchar(32),
				group5 varchar(32),group6 varchar(32),group7 varchar(32),group8 varchar(32),group9 varchar(32),group10 varchar(32),
				group11 varchar(32),group12 varchar(32),group13 varchar(32),group14 varchar(32),group15 varchar(32),group16 varchar(32))
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler for 1062 set err=-1;
	while i < count do
		insert into hss.GroupInfo(IMSI,GROUP1,GROUP2,GROUP3,GROUP4,GROUP5,GROUP6,GROUP7,GROUP8,GROUP9,GROUP10,
		GROUP11,GROUP12,GROUP13,GROUP14,GROUP15,GROUP16) values(CONCAT(imsi),group1,group2,group3,group4,group5,group6,group7,group8,group9,group10,
		group11,group12,group13,group14,group15,group16);
		set imsi = imsi + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `addGroupInfoFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addGroupInfoFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addGroupInfoFK`(imsi bigint,group1 varchar(32),group2 varchar(32),group3 varchar(32),group4 varchar(32),
				group5 varchar(32),group6 varchar(32),group7 varchar(32),group8 varchar(32),group9 varchar(32),group10 varchar(32),
				group11 varchar(32),group12 varchar(32),group13 varchar(32),group14 varchar(32),group15 varchar(32),group16 varchar(32),belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('insert into ',belongHss),'.GroupInfo(IMSI,GROUP1,GROUP2,GROUP3,GROUP4,GROUP5,GROUP6,GROUP7,GROUP8,GROUP9,GROUP10,GROUP11,
	GROUP12,GROUP13,GROUP14,GROUP15,GROUP16) 
	values(CONCAT(?),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);');
	set @imsi=imsi;
	set @group1=group1;
	set @group2=group2;
	set @group3=group3;
	set @group4=group4;
	set @group5=group5;
	set @group6=group6;
	set @group7=group7;
	set @group8=group8;
	set @group9=group9;
	set @group10=group10;
	set @group11=group11;
	set @group12=group12;
	set @group13=group13;
	set @group14=group14;
	set @group15=group15;
	set @group16=group16;
	prepare stmt from @sql;
	execute stmt using @imsi,@group1,@group2,@group3,@group4,@group5,@group6,@group7,@group8,@group9,@group10,
	@group11,@group12,@group13,@group14,@group15,@group16;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `addHlr`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addHlr`;
DELIMITER ;;
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `addHlr`(count INT,imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int)
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	while i < count do
		insert into HLR (IMSI,MDN,ESN,MSprofile,DeviceType,MSvocodec,Msprofile_extra)values(CONCAT(imsi),CONCAT(mdn),right(CONCAT('00000000',esn),8),msprofile,deviceType,msvocodec,msprofile_extra);
		set imsi = imsi + 1;
		set mdn = mdn + 1;
		set esn = esn + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `addHlrFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addHlrFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addHlrFK`(imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int,belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('insert into ',belongHss),'.HLR (IMSI,MDN,ESN,MSprofile,DeviceType,MSvocodec,MSprofile_extra) values(CONCAT(?),CONCAT(?),CONCAT(?),?,?,?,?);');
	set @imsi=imsi;
	set @mdn=mdn;
	set @esn=right(CONCAT('00000000',CONV(esn,10,16)),8);
	set @msprofile=msprofile;
	set @deviceType=deviceType;
	set @msvocodec=msvocodec;
	set @msprofile_extra=msprofile_extra;
	prepare stmt from @sql;
	execute stmt using @imsi,@mdn,@esn,@msprofile,@deviceType,@msvocodec,@msprofile_extra;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `addHlrps`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addHlrps`;
DELIMITER ;;
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `addHlrps`(count INT,imsi bigint,mdn bigint,esn varchar(32),msprofile int,deviceType int,msvocodec int,msprofile_extra int)
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	while i < count do
		insert into HLRps (IMSI,MDN,ESN,MSprofile,DeviceType,MSvocodec,Msprofile_extra)values(CONCAT(imsi),CONCAT(mdn),right(CONCAT('00000000',esn),8),msprofile,deviceType,msvocodec,msprofile_extra);
		set imsi = imsi + 1;
		set mdn = mdn + 1;
		set esn = esn + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `addHlrpsFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addHlrpsFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addHlrpsFK`(imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int,belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('insert into ',belongHss),'.HLRps (IMSI,MDN,ESN,MSprofile,DeviceType,MSvocodec,MSprofile_extra) values(CONCAT(?),CONCAT(?),CONCAT(?),?,?,?,?);');
	set @imsi=imsi;
	set @mdn=mdn;
	set @esn=right(CONCAT('00000000',CONV(esn,10,16)),8);
	set @msprofile=msprofile;
	set @deviceType=deviceType;
	set @msvocodec=msvocodec;
	set @msprofile_extra=msprofile_extra;
	prepare stmt from @sql;
	execute stmt using @imsi,@mdn,@esn,@msprofile,@deviceType,@msvocodec,@msprofile_extra;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `addMSService`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addMSService`;
DELIMITER ;;
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `addMSService`(count int,imsi bigint,WireTapAddr varchar(32))
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
-- Procedure structure for `addMSServiceFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addMSServiceFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addMSServiceFK`(imsi bigint,status varchar(32),directFwdNum varchar(32),fwdOnBusyNum varchar(32),fwdNoAnswerNum varchar(32),voicemailNum varchar(32),fwdNANum varchar(32),WireTapAddr varchar(32),belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('insert into ',belongHss),'.MSService (IMSI,Status,directFwdNum,fwdOnBusyNum,fwdNoAnswerNum,voicemailNum,fwdNANum,WireTapAddr) 
	values(CONCAT(?),?,?,?,?,?,?,?);');
	set @imsi=imsi;
	set @status=status;
	set @directFwdNum=directFwdNum;
	set @fwdOnBusyNum=fwdOnBusyNum;
	set @fwdNoAnswerNum=fwdNoAnswerNum;
	set @voicemailNum=voicemailNum;
	set @fwdNANum=fwdNANum;
	set @WireTapAddr=WireTapAddr;
	prepare stmt from @sql;
	execute stmt using @imsi,@status,@directFwdNum,@fwdOnBusyNum,@fwdNoAnswerNum,@voicemailNum,@fwdNANum,@WireTapAddr;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `addTerminalInfo`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addTerminalInfo`;
DELIMITER ;;
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `addTerminalInfo`(count int,imsi bigint,terminalId bigint,terminalType int,powerLevel int,suportBuss int,gwId int,department int,userType int,createTime timestamp,servicePriority int)
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
-- Procedure structure for `addTerminalInfoFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addTerminalInfoFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addTerminalInfoFK`(imsi bigint,terminalId varchar(32),terminalType int,powerLevel int,suportBuss int,gwId int,department varchar(32),userType int,username varchar(32),userInfo varchar(32),servicePriority int,createTime timestamp,belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('insert into ',belongHss),'.TerminalInfo(IMSI,terminalId,terminalType,powerLevel,suportBuss,gwId,department,userType,username,userInfo,servicePriority,createTime) values(CONCAT(?),?,?,?,?,?,?,?,?,?,?,?);');
	set @imsi=imsi;
	set @terminalId=terminalId;
	set @terminalType=terminalType;
	set @powerLevel=powerLevel;
	set @suportBuss=suportBuss;
	set @gwId=gwId;
	set @department=department;
	set @userType=userType;
	set @username=username;
	set @userInfo=userInfo;
	set @servicePriority=servicePriority;
	set @createTime=createTime;
	prepare stmt from @sql;
	execute stmt using @imsi,@terminalId,@terminalType,@powerLevel,@suportBuss,@gwId,@department,@userType,@username,@userInfo,@servicePriority,@createTime;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `addTft`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addTft`;
DELIMITER ;;
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `addTft`(count int,imsi bigint)
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
-- Procedure structure for `batchAddAuc`
-- ----------------------------
DROP PROCEDURE IF EXISTS `batchAddAuc`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `batchAddAuc`(count int,imsi bigint,k varchar(50),op varchar(50),opc varchar(50),amf varchar(50),sqn varchar(50),rand varchar(50),tstamp timestamp,start time,stop time,belongHss varchar(32))
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler for 1062 set err=-1;
	while i < count do
		insert into hss.AUC (IMSI,K,OP,OPc,AMF,SQN,RAND,tstamp,START,STOP,BelongHss) values(CONCAT(imsi),CONCAT(k),CONCAT(op),opc,amf,sqn,rand,tstamp,start,stop,belongHss);
		set imsi = imsi + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `batchAddAucFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `batchAddAucFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `batchAddAucFK`(count int,imsi bigint,k varchar(50),op varchar(50),opc varchar(50),amf varchar(50),sqn varchar(50),rand varchar(50),tstamp timestamp,start time,stop time,belongHss varchar(32))
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler for 1062 set err=-1;
	while i < count do
		set @sql=concat(concat('insert into ',belongHss),'.AUC (IMSI,K,OP,OPc,AMF,SQN,RAND,tstamp,START,STOP) values(CONCAT(?),CONCAT(?),CONCAT(?),?,?,?,?,?,?,?);');
		set @imsi=imsi;
		set @k=k;
		set @op=op;
		set @opc=opc;
		set @amf=amf;
		set @sqn=sqn;
		set @rand=rand;
		set @tstamp=tstamp;
		set @start=start;
		set @stop=stop;
		prepare stmt from @sql;
		execute stmt using @imsi,@k,@op,@opc,@amf,@sqn,@rand,@tstamp,@start,@stop;
		set imsi = imsi + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `batchAddHlr`
-- ----------------------------
DROP PROCEDURE IF EXISTS `batchAddHlr`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `batchAddHlr`(count int,imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int,belongHss varchar(32))
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	while i < count do
		insert into hss.HLR (IMSI,MDN,ESN,MSprofile,DeviceType,MSvocodec,MSprofile_extra,BelongHss) values(CONCAT(imsi),CONCAT(mdn),CONCAT(esn),msprofile,deviceType,msvocodec,msprofile_extra,belongHss);
		set imsi = imsi + 1;
		set mdn = mdn + 1;
		set esn = esn + 1;
		set i = i + 1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `batchAddHlrFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `batchAddHlrFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `batchAddHlrFK`(count int,imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int,belongHss varchar(32))
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	while i < count do
		set @sql=concat(concat('insert into ',belongHss),'.HLR (IMSI,MDN,ESN,MSprofile,DeviceType,MSvocodec,MSprofile_extra) values(CONCAT(?),CONCAT(?),CONCAT(?),?,?,?,?);');
		set @imsi=imsi;
		set @mdn=mdn;
		set @esn=right(CONCAT('00000000',CONV(esn,10,16)),8);
		set @msprofile=msprofile;
		set @deviceType=deviceType;
		set @msvocodec=msvocodec;
		set @msprofile_extra=msprofile_extra;
		prepare stmt from @sql;
		execute stmt using @imsi,@mdn,@esn,@msprofile,@deviceType,@msvocodec,@msprofile_extra;
		set imsi = imsi + 1;
		set mdn = mdn + 1;
		set esn = esn + 1;
		set i = i + 1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `batchAddHlrps`
-- ----------------------------
DROP PROCEDURE IF EXISTS `batchAddHlrps`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `batchAddHlrps`(count int,imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int,belongHss varchar(32))
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	while i < count do
		insert into hss.HLRps (IMSI,MDN,ESN,MSprofile,DeviceType,MSvocodec,MSprofile_extra,BelongHss) values(CONCAT(imsi),CONCAT(mdn),CONCAT(esn),msprofile,deviceType,msvocodec,msprofile_extra,belongHss);
		set imsi = imsi + 1;
		set mdn = mdn + 1;
		set esn = esn + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `batchAddHlrpsFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `batchAddHlrpsFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `batchAddHlrpsFK`(count int,imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int,belongHss varchar(32))
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	while i < count do
		set @sql=concat(concat('insert into ',belongHss),'.HLRps (IMSI,MDN,ESN,MSprofile,DeviceType,MSvocodec,MSprofile_extra) values(CONCAT(?),CONCAT(?),CONCAT(?),?,?,?,?);');
		set @imsi=imsi;
		set @mdn=mdn;
		set @esn=right(CONCAT('00000000',CONV(esn,10,16)),8);
		set @msprofile=msprofile;
		set @deviceType=deviceType;
		set @msvocodec=msvocodec;
		set @msprofile_extra=msprofile_extra;
		prepare stmt from @sql;
		execute stmt using @imsi,@mdn,@esn,@msprofile,@deviceType,@msvocodec,@msprofile_extra;
		set imsi = imsi + 1;
		set mdn = mdn + 1;
		set esn = esn + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `batchAddMSService`
-- ----------------------------
DROP PROCEDURE IF EXISTS `batchAddMSService`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `batchAddMSService`(count int,imsi bigint,WireTapAddr varchar(32),belongHss varchar(32))
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler for 1062 set err=-1;
	while i < count do
		insert into MSService (IMSI,WireTapAddr,BelongHss) values(CONCAT(imsi),WireTapAddr,belongHss);
		set imsi = imsi + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `batchAddMsserviceFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `batchAddMsserviceFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `batchAddMsserviceFK`(count int,imsi bigint,WireTapAddr varchar(32),belongHss varchar(32))
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler for 1062 set err=-1;
	while i < count do
		set @sql=concat(concat('insert into ',belongHss),'.MSService (IMSI,WireTapAddr) values(CONCAT(?),?);');
		set @imsi=imsi;
		set @WireTapAddr=WireTapAddr;
		prepare stmt from @sql;
		execute stmt using @imsi,@WireTapAddr;
		set imsi = imsi + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `batchAddTerminal`
-- ----------------------------
DROP PROCEDURE IF EXISTS `batchAddTerminal`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `batchAddTerminal`(count int,imsi bigint,terminalId bigint,terminalType int,powerLevel int,suportBuss int,gwId int,department int,userType int,createTime timestamp,servicePriority int,belongHss varchar(32))
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler for 1062 set err=-1;
	while i < count do
		insert into hss.TerminalInfo(IMSI,terminalId,terminalType,powerLevel,suportBuss,gwId,department,userType,createTime,servicePriority,BelongHss) 
		values(CONCAT(imsi),CONCAT(terminalId),terminalType,powerLevel,suportBuss,gwId,CONCAT(department),userType,createTime,servicePriority,belongHss);
		set imsi = imsi + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `batchAddTerminalFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `batchAddTerminalFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `batchAddTerminalFK`(count int,imsi bigint,terminalId bigint,terminalType int,powerLevel int,suportBuss int,gwId int,department int,userType int,createTime timestamp,servicePriority int,belongHss varchar(32))
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler for 1062 set err=-1;
	while i < count do
		set @sql=concat(concat('insert into ',belongHss),'.TerminalInfo(IMSI,terminalId,terminalType,powerLevel,suportBuss,gwId,department,userType,servicePriority,createTime) values(CONCAT(?),?,?,?,?,?,?,?,?,?);');
		set @imsi=imsi;
		set @terminalId=terminalId;
		set @terminalType=terminalType;
		set @powerLevel=powerLevel;
		set @suportBuss=suportBuss;
		set @gwId=gwId;
		set @department=department;
		set @userType=userType;
		set @servicePriority=servicePriority;
		set @createTime=createTime;
		prepare stmt from @sql;
		execute stmt using @imsi,@terminalId,@terminalType,@powerLevel,@suportBuss,@gwId,@department,@userType,@servicePriority,@createTime;
		set imsi = imsi + 1;
		set i = i + 1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `deleteAucFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteAucFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAucFK`(imsi bigint,belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('delete from  ',belongHss),'.AUC where IMSI=CONCAT(?);');
	set @imsi=imsi;
	prepare stmt from @sql;
	execute stmt using @imsi;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `deleteGroupInfoFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteGroupInfoFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteGroupInfoFK`(imsi bigint,belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('delete from ',belongHss),'.GroupInfo where IMSI=CONCAT(?);');
	set @imsi=imsi;
	prepare stmt from @sql;
	execute stmt using @imsi;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `deleteHlrFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteHlrFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteHlrFK`(imsi bigint,belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('delete from ',belongHss),'.HLR where IMSI=CONCAT(?);');
	set @imsi=imsi;
	prepare stmt from @sql;
	execute stmt using @imsi;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `deleteHlrpsFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteHlrpsFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteHlrpsFK`(imsi bigint,belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('delete from ',belongHss),'.HLRps where IMSI=CONCAT(?);');
	set @imsi=imsi;
	prepare stmt from @sql;
	execute stmt using @imsi;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `deleteMSServiceFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteMSServiceFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteMSServiceFK`(imsi bigint,belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('delete from ',belongHss),'.MSService where IMSI=CONCAT(?);');
	set @imsi=imsi;
	prepare stmt from @sql;
	execute stmt using @imsi;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `deleteTerminalInfoFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteTerminalInfoFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteTerminalInfoFK`(imsi bigint,belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('delete from ',belongHss),'.TerminalInfo where IMSI=CONCAT(?);');
	set @imsi=imsi;
	prepare stmt from @sql;
	execute stmt using @imsi;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `HlrPsAdd`
-- ----------------------------
DROP PROCEDURE IF EXISTS `HlrPsAdd`;
DELIMITER ;;
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `HlrPsAdd`(count INT,imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int)
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	while i < count do
		insert into HLRps (IMSI,MDN,ESN,MSprofile,DeviceType,MSvocodec,msprofile_extra)values(CONCAT(imsi),CONCAT(mdn),right(CONCAT('00000000',esn),8),msprofile,deviceType,msvocodec,msprofile_extra);
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
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `HlrPsUpdate`(count INT,imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int)
begin
	declare i int default 0;
	while i < count do
		set @sql='update HLRps set MDN=CONCAT(?),ESN=CONCAT(?),MSprofile=?,DeviceType=?,MSvocodec=?,Msprofile_extra=? where IMSI=CONCAT(?);';
		set @imsi=imsi;set @mdn=mdn;set @esn=esn;set @msprofile=msprofile;set @deviceType=deviceType;set @msvocodec=msvocodec;set @msprofile_extra=msprofile_extra;
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
-- Procedure structure for `updateAucFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `updateAucFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAucFK`(imsi bigint,k varchar(100),op varchar(100),opc varchar(100),amf varchar(100),sqn varchar(100),rand varchar(100),tstamp timestamp,start time,stop time,belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('update ',belongHss),'.AUC set K=?,OP=?,OPc=?,AMF=?,SQN=?,RAND=?,tstamp=?,START=?,STOP=? where IMSI=CONCAT(?);');
	set @imsi=imsi;
	set @k=k;
	set @op=op;
	set @opc=opc;
	set @amf=amf;
	set @sqn=sqn;
	set @rand=rand;
	set @tstamp=tstamp;
	set @start=start;
	set @stop=stop;
	prepare stmt from @sql;
	execute stmt using @k,@op,@opc,@amf,@sqn,@rand,@tstamp,@start,@stop,@imsi;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `updateGroupInfoFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `updateGroupInfoFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateGroupInfoFK`(imsi bigint,group1 varchar(32),group2 varchar(32),group3 varchar(32),group4 varchar(32),
				group5 varchar(32),group6 varchar(32),group7 varchar(32),group8 varchar(32),group9 varchar(32),group10 varchar(32),
				group11 varchar(32),group12 varchar(32),group13 varchar(32),group14 varchar(32),group15 varchar(32),group16 varchar(32),belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('update ',belongHss),'.GroupInfo set GROUP1=?,GROUP2=?,GROUP3=?,GROUP4=?,GROUP5=?,GROUP6=?,GROUP7=?,GROUP8=?,GROUP9=?,
	GROUP10=?,GROUP11=?,GROUP12=?,GROUP13=?,GROUP14=?,GROUP15=?,GROUP16=?
	where IMSI=CONCAT(?);');
	set @imsi=imsi;
	set @group1=group1;
	set @group2=group1;
	set @group3=group3;
	set @group4=group4;
	set @group5=group5;
	set @group6=group6;
	set @group7=group7;
	set @group8=group8;
	set @group9=group9;
	set @group10=group10;
	set @group11=group11;
	set @group12=group12;
	set @group13=group13;
	set @group14=group14;
	set @group15=group15;
	set @group16=group16;
	prepare stmt from @sql;
	execute stmt using @group1,@group2,@group3,@group4,@group5,@group6,@group7,@group8,@group9,@group10,
	@group11,@group12,@group13,@group14,@group15,@group16,@imsi;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `updateHlr`
-- ----------------------------
DROP PROCEDURE IF EXISTS `updateHlr`;
DELIMITER ;;
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `updateHlr`(count INT,imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int)
begin
	declare i int default 0;
	while i < count do
		set @sql='update HLR set MDN=CONCAT(?),ESN=CONCAT(?),MSprofile=?,DeviceType=?,MSvocodec=?,Msprofile_extra=? where IMSI=CONCAT(?);';
		set @imsi=imsi;set @mdn=mdn;set @esn=esn;set @msprofile=msprofile;set @deviceType=deviceType;set @msvocodec=msvocodec;set @msprofile_extra=msprofile_extra;
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
-- Procedure structure for `updateHlrFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `updateHlrFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateHlrFK`(imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int,belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('update ',belongHss),'.HLR set MDN=CONCAT(?),ESN=CONCAT(?),MSprofile=?,DeviceType=?,MSvocodec=?,MSprofile_extra=? where IMSI=CONCAT(?);');
	set @imsi=imsi;
	set @mdn=mdn;
	set @esn=right(CONCAT('00000000',CONV(esn,10,16)),8);
	set @msprofile=msprofile;
	set @deviceType=deviceType;
	set @msvocodec=msvocodec;
	set @msprofile_extra=msprofile_extra;
	prepare stmt from @sql;
	execute stmt using @mdn,@esn,@msprofile,@deviceType,@msvocodec,@msprofile_extra,@imsi;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `updateHlrps`
-- ----------------------------
DROP PROCEDURE IF EXISTS `updateHlrps`;
DELIMITER ;;
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `updateHlrps`(count INT,imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int)
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
-- Procedure structure for `updateHlrpsFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `updateHlrpsFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateHlrpsFK`(imsi bigint,mdn bigint,esn bigint,msprofile int,deviceType int,msvocodec int,msprofile_extra int,belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('update ',belongHss),'.HLRps set MDN=CONCAT(?),ESN=CONCAT(?),MSprofile=?,DeviceType=?,MSvocodec=?,MSprofile_extra=? where IMSI=CONCAT(?);');
	set @imsi=imsi;
	set @mdn=mdn;
	set @esn=right(CONCAT('00000000',CONV(esn,10,16)),8);
	set @msprofile=msprofile;
	set @deviceType=deviceType;
	set @msvocodec=msvocodec;
	set @msprofile_extra=msprofile_extra;
	prepare stmt from @sql;
	execute stmt using @mdn,@esn,@msprofile,@deviceType,@msvocodec,@msprofile_extra,@imsi;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `updateMSServiceFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `updateMSServiceFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateMSServiceFK`(imsi bigint,status varchar(32),directFwdNum varchar(32),fwdOnBusyNum varchar(32),fwdNoAnswerNum varchar(32),voicemailNum varchar(32),fwdNANum varchar(32),WireTapAddr varchar(32),belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('update ',belongHss),'.MSService set Status=?,directFwdNum=?,fwdOnBusyNum=?,fwdNoAnswerNum=?,voicemailNum=?,fwdNANum=?,WireTapAddr=? where IMSI=CONCAT(?);');
	set @imsi=imsi;
	set @status=status;
	set @directFwdNum=directFwdNum;
	set @fwdOnBusyNum=fwdOnBusyNum;
	set @fwdNoAnswerNum=fwdNoAnswerNum;
	set @voicemailNum=voicemailNum;
	set @fwdNANum=fwdNANum;
	set @WireTapAddr=WireTapAddr;
	prepare stmt from @sql;
	execute stmt using @status,@directFwdNum,@fwdOnBusyNum,@fwdNoAnswerNum,@voicemailNum,@fwdNANum,@WireTapAddr,@imsi;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `updateTerminalInfoFK`
-- ----------------------------
DROP PROCEDURE IF EXISTS `updateTerminalInfoFK`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateTerminalInfoFK`(imsi bigint,terminalId varchar(32),terminalType int,powerLevel int,suportBuss int,gwId int,department varchar(32),userType int,username varchar(32),userInfo varchar(32),servicePriority int,createTime timestamp,belongHss varchar(32))
begin
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	set @sql=concat(concat('update ',belongHss),'.TerminalInfo set terminalId=?,terminalType=?,powerLevel=?,suportBuss=?,
	gwId=?,department=?,userType=?,username=?,userInfo=?,servicePriority=?,createTime=? where IMSI=CONCAT(?);');
	set @imsi=imsi;
	set @terminalId=terminalId;
	set @terminalType=terminalType;
	set @powerLevel=powerLevel;
	set @suportBuss=suportBuss;
	set @gwId=gwId;
	set @department=department;
	set @userType=userType;
	set @username=username;
	set @userInfo=userInfo;
	set @servicePriority=servicePriority;
	set @createTime=createTime;
	prepare stmt from @sql;
	execute stmt using @terminalId,@terminalType,@powerLevel,@suportBuss,@gwId,@department,@userType,@username,@userInfo,@servicePriority,@createTime,@imsi;
end
;;
DELIMITER ;
