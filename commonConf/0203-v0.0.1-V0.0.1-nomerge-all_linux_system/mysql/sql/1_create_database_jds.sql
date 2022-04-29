/*
drop 数据库
*/
drop database if exists aj03_north_service;
drop database if exists CSCF_DB;
drop database if exists hss;
drop database if exists HSS_Reduancy;
drop database if exists ocr;


create database if not exists aj03_north_service default character set utf8 collate utf8_general_ci;


create database if not exists CSCF_DB default character set utf8 collate utf8_general_ci;

create database if not exists hss default character set utf8 collate utf8_general_ci;
create database if not exists HSS_Reduancy default character set utf8 collate utf8_general_ci;
create database if not exists ocr default character set utf8 collate utf8_general_ci;


