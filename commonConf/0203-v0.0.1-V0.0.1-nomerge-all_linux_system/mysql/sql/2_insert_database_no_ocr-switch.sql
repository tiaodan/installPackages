/*
插入数据
*/

SET autocommit=0;
SET unique_checks=0;
SET foreign_key_checks=0;

use CSCF_DB;
source CSCF_DB.sql;
use hss;
source hss.sql;
use HSS_Reduancy;
source HSS_Reduancy.sql;
use lz;
source lz.sql;


/*
*/

SET autocommit=1;
SET unique_checks=1;
SET foreign_key_checks=1;
