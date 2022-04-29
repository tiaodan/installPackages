
#删除网管数据

use 2011_user_service;
truncate table auc;
truncate table hlr;
truncate table hlr_groupnum;
truncate table hlrps;
truncate table msservice;
truncate table terminalinfo;

use hss_proxy_service;
truncate hss_relation;