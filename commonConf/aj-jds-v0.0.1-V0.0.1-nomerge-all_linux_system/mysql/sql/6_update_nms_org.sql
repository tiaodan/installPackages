/*
插入数据
*/

SET autocommit=0;
SET unique_checks=0;
SET foreign_key_checks=0;

use 2011_organization_service;
# 修改军队的id
update t_arms set arms_id = 0 where arms_name = "全军";

# 根据脚本配置的id，插入默认的组织机构
INSERT INTO `t_unit` VALUES ('unitid', '?级网管', '0', '1', '0', '', '200', now(), now(), '0', '0', '0') on duplicate key update unit_id="unitid",unit_name="?级网管",parent_id=0,theater_city_id=1,arms_id=0,auth="",group_max=200,create_time=now(),modify_time=now(),station=0,type=0,syn_data_center=0;

SET autocommit=1;
SET unique_checks=1;
SET foreign_key_checks=1;
