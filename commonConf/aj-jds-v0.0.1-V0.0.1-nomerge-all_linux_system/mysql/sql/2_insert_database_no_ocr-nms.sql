/*
插入数据
*/

SET autocommit=0;
SET unique_checks=0;
SET foreign_key_checks=0;

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
