/*
插入数据
*/

SET autocommit=0;
SET unique_checks=0;
SET foreign_key_checks=0;

use 2011_user_service;
# hss代理的ip和port，更新插入

# 示例： insert into user_omc_addr values (1, "192.1.1.66", 9523, "?级网管") on duplicate key update id=1, host="192.1.1.60", port=7335, name="?级网管";
insert into user_omc_addr values (1, "nmsIp", hssProxyPort, "?级网管") on duplicate key update id=1, host="nmsIp", port=hssProxyPort, name="?级网管";


SET autocommit=1;
SET unique_checks=1;
SET foreign_key_checks=1;
