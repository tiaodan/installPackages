/*
插入数据
*/

SET autocommit=0;
SET unique_checks=0;
SET foreign_key_checks=0;



use data_dispatch;
source data_dispatch.sql;
use dispatcher;
source dispatcher.sql;
use `group`;
source group_new.sql;
use imserver;
source imserver.sql;
use presence;
source presence.sql;

/*
*/

SET autocommit=1;
SET unique_checks=1;
SET foreign_key_checks=1;
