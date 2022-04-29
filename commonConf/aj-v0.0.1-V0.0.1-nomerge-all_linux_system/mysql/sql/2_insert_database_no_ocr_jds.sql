/*
插入数据
*/

SET autocommit=0;
SET unique_checks=0;
SET foreign_key_checks=0;


use aj03_north_service;
source aj03_north_service.sql;
use CSCF_DB;
source CSCF_DB.sql;
use hss;
source hss.sql;
use HSS_Reduancy;
source HSS_Reduancy.sql;
use ocr;
source ocr.sql;


/*
*/

SET autocommit=1;
SET unique_checks=1;
SET foreign_key_checks=1;
