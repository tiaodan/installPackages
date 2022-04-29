/*
drop 数据库 -icss
*/

drop database if exists data_dispatch;
drop database if exists dispatcher;
drop database if exists `group`;
drop database if exists imserver;
drop database if exists presence;


create database if not exists data_dispatch default character set utf8 collate utf8_general_ci;
create database if not exists dispatcher default character set utf8 collate utf8_general_ci;
create database if not exists `group` default character set utf8 collate utf8_general_ci;
create database if not exists imserver default character set utf8 collate utf8_general_ci;
create database if not exists presence default character set utf8 collate utf8_general_ci;


