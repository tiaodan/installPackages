/*
插入数据
*/

SET autocommit=0;
SET unique_checks=0;
SET foreign_key_checks=0;


use aj03_alarm_service;
source aj03_alarm_service.sql;
use aj03_north_service;
source aj03_north_service.sql;
use aj03_organization_service;
source aj03_organization_service.sql;
use aj03_resource_service;
source aj03_resource_service.sql;
use aj03_security_service;
source aj03_security_service.sql;
use aj03_statistic_service;
source aj03_statistic_service.sql;
use aj03_user_service;
source aj03_user_service.sql;
use cscf_db;
source cscf_db.sql;
use hss;
source hss.sql;
use HSS_Reduancy;
source HSS_Reduancy.sql;
use imserver;
source imserver.sql;
use ocr;
source ocr.sql;
use presence;
source presence.sql;

/*
*/

SET autocommit=1;
SET unique_checks=1;
SET foreign_key_checks=1;
