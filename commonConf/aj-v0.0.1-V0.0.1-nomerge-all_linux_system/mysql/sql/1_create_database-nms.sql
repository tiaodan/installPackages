/*
drop 数据库-nms
*/
drop database if exists 2011_alarm_service;
drop database if exists 2011_devconfig_service;
drop database if exists 2011_organization_service;
drop database if exists 2011_resource_service;
drop database if exists 2011_security_service;
drop database if exists 2011_statistic_service;
drop database if exists 2011_user_service;
drop database if exists hss_proxy_service;
drop database if exists ocr;
drop database if exists 2011_north_service;

create database if not exists 2011_alarm_service default character set utf8 collate utf8_general_ci;
create database if not exists 2011_devconfig_service default character set utf8 collate utf8_general_ci;
create database if not exists 2011_organization_service default character set utf8 collate utf8_general_ci;
create database if not exists 2011_resource_service default character set utf8 collate utf8_general_ci;
create database if not exists 2011_security_service default character set utf8 collate utf8_general_ci;
create database if not exists 2011_statistic_service default character set utf8 collate utf8_general_ci;
create database if not exists 2011_user_service default character set utf8 collate utf8_general_ci;
create database if not exists hss_proxy_service default character set utf8 collate utf8_general_ci;
create database if not exists ocr default character set utf8 collate utf8_general_ci;
create database if not exists 2011_north_service default character set utf8 collate utf8_general_ci;

