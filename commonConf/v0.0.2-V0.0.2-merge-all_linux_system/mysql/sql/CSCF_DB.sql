/*
Navicat MySQL Data Transfer

Source Server         : 192.1.1.60
Source Server Version : 50726
Source Host           : 192.1.1.60:3306
Source Database       : CSCF_DB

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2021-09-22 17:07:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `scscf_ue`
-- ----------------------------
DROP TABLE IF EXISTS `scscf_ue`;
CREATE TABLE `scscf_ue` (
  `ueUri` varchar(128) NOT NULL DEFAULT '',
  `ueName` varchar(128) NOT NULL DEFAULT '',
  `ueScscfDomain` varchar(256) NOT NULL DEFAULT '',
  `ueScscfAddr` varchar(128) NOT NULL DEFAULT '0.0.0.0:0',
  `uePcscfDomain` varchar(256) NOT NULL DEFAULT '',
  `uePcscfAddr` varchar(128) NOT NULL DEFAULT '0.0.0.0:0',
  `ueAddr` varchar(128) NOT NULL DEFAULT '0.0.0.0:0',
  `ueStatus` int(11) NOT NULL DEFAULT '0',
  `ueUpdateType` int(11) NOT NULL DEFAULT '0',
  `ueUpdateTstamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ueHomeScscfDomain` varchar(256) NOT NULL DEFAULT '',
  `ueHomeScscfAddr` varchar(128) NOT NULL DEFAULT '0.0.0.0:0',
  `uePassword` varchar(128) NOT NULL DEFAULT 'password',
  PRIMARY KEY (`ueUri`),
  KEY `ueName` (`ueName`),
  KEY `ueUri` (`ueUri`) USING HASH,
  KEY `ueName_2` (`ueName`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of scscf_ue
-- ----------------------------


-- ----------------------------
-- Procedure structure for `addUe`
-- ----------------------------
DROP PROCEDURE IF EXISTS `addUe`;
DELIMITER ;;
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `addUe`(count int,mdn bigint,domain varchar(128),password varchar(128))
begin
	declare i int default 0;
	declare err int default 0;
	declare continue handler FOR 1062 set err=-1;
	while i < count do
		insert into scscf_ue (ueUri,ueName,uePassword)values(concat(concat(concat('sip:',mdn),'@'),domain),concat(mdn),password);
		set mdn = mdn + 1;
		set i=i+1;
	end while;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `deleteUe`
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteUe`;
DELIMITER ;;
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `deleteUe`(count int,mdn bigint)
begin
	declare i int default 0;
	declare err int default 0;
	declare endMdn bigint default 0;
	declare continue handler FOR 1062 set err=-1;
	set endMdn = mdn+count-1;
	delete from scscf_ue where ueName>=concat(mdn) and ueName<=concat(endMdn);
end
;;
DELIMITER ;
