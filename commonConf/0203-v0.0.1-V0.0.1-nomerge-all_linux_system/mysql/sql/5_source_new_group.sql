/*
插入数据
*/

SET autocommit=0;
SET unique_checks=0;
SET foreign_key_checks=0;

drop database if exists `group`;
create database if not exists `group` default character set utf8 collate utf8_general_ci;

#select sleep(2);

use `group`;
source group_new.sql;



SET autocommit=1;
SET unique_checks=1;
SET foreign_key_checks=1;
