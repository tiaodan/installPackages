/*
drop 数据库
*/
drop database if exists CSCF_DB;
drop database if exists data_dispatch;
drop database if exists dispatcher;
drop database if exists `group`;
#drop database if exists hss;
#drop database if exists HSS_Reduancy;
#drop database if exists hss_total;
#drop database if exists hss1;
#drop database if exists hss2;
#drop database if exists hss3;
#drop database if exists hss4;
drop database if exists imserver;
#drop database if exists myomc;
drop database if exists ocr;
drop database if exists presence;
drop database if exists 2011_alarm_service;

drop database if exists 2011_devconfig_service;
drop database if exists 2011_organization_service;
drop database if exists 2011_resource_service;
drop database if exists 2011_security_service;
drop database if exists 2011_statistic_service;
drop database if exists 2011_user_service;
drop database if exists hss_proxy_service;

#drop database if exists 2011_atopology_service;
#drop database if exists 2011_topology_service;
drop database if exists 2011_north_service;


create database if not exists CSCF_DB default character set utf8 collate utf8_general_ci;
create database if not exists data_dispatch default character set utf8 collate utf8_general_ci;
create database if not exists dispatcher default character set utf8 collate utf8_general_ci;
create database if not exists `group` default character set utf8 collate utf8_general_ci;
#create database if not exists hss default character set utf8 collate utf8_general_ci;
#create database if not exists HSS_Reduancy default character set utf8 collate utf8_general_ci;
#create database if not exists hss_total default character set utf8 collate utf8_general_ci;
#create database if not exists hss1 default character set utf8 collate utf8_general_ci;
#create database if not exists hss2 default character set utf8 collate utf8_general_ci;
#create database if not exists hss3 default character set utf8 collate utf8_general_ci;
#create database if not exists hss4 default character set utf8 collate utf8_general_ci;
create database if not exists imserver default character set utf8 collate utf8_general_ci;
#create database if not exists myomc default character set utf8 collate utf8_general_ci;
create database if not exists ocr default character set utf8 collate utf8_general_ci;
create database if not exists presence default character set utf8 collate utf8_general_ci;
create database if not exists 2011_alarm_service default character set utf8 collate utf8_general_ci;

create database if not exists 2011_devconfig_service default character set utf8 collate utf8_general_ci;
create database if not exists 2011_organization_service default character set utf8 collate utf8_general_ci;
create database if not exists 2011_resource_service default character set utf8 collate utf8_general_ci;
create database if not exists 2011_security_service default character set utf8 collate utf8_general_ci;
create database if not exists 2011_statistic_service default character set utf8 collate utf8_general_ci;
create database if not exists 2011_user_service default character set utf8 collate utf8_general_ci;
create database if not exists hss_proxy_service default character set utf8 collate utf8_general_ci;

#create database if not exists 2011_atopology_service default character set utf8 collate utf8_general_ci;
#create database if not exists 2011_topology_service default character set utf8 collate utf8_general_ci;

create database if not exists 2011_north_service default character set utf8 collate utf8_general_ci;

