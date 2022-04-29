/*
插入数据
*/

SET autocommit=0;
SET unique_checks=0;
SET foreign_key_checks=0;


use CSCF_DB;
source CSCF_DB.sql;
use data_dispatch;
source data_dispatch.sql;
use dispatcher;
source dispatcher.sql;
use `group`;
source group_new.sql;
#use hss;
#source hss.sql;
#use HSS_Reduancy;
#source HSS_Reduancy.sql;
#use hss_total;
#source hss_total.sql;
#use hss1;
#source hss1.sql;
#use hss2;
#source hss2.sql;
#use hss3;
#source hss3.sql;
#use hss4;
#source hss4.sql;
use imserver;
source imserver.sql;
#use myomc;
#source myomc.sql;

use presence;
source presence.sql;

use 2011_alarm_service;
source 2011_alarm_service.sql;

use 2011_devconfig_service;
source 2011_devconfig_service.sql;
use 2011_organization_service;
source 2011_organization_service.sql;
use 2011_resource_service;
source 2011_resource_service.sql;
use 2011_security_service;
source 2011_security_service.sql;
use 2011_statistic_service;
source 2011_statistic_service.sql;
use 2011_user_service;
source 2011_user_service.sql;
use hss_proxy_service;
source hss_proxy_service.sql;
use 2011_north_service;
source 2011_north_service.sql;
/*
*/

SET autocommit=1;
SET unique_checks=1;
SET foreign_key_checks=1;
