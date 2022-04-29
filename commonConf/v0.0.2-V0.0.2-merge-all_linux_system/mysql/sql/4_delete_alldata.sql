set foreign_key_checks=0;

# nms
use 2011_alarm_service;
truncate table alarm_history;
truncate table alarm_now;

use 2011_devconfig_service;
truncate table bts_base_config_info;
truncate table bts_channel_info;
truncate table bts_fre_info;
truncate table bts_network_config_info;
truncate table bts_position_info;
truncate table switch_master_slaver_info;
truncate table switch_running_info;
truncate table switch_system_info;
truncate table switch_timer_info;

use 2011_resource_service;
truncate table bbu_neighbor;
truncate table dev;
truncate table dev_attr;
truncate table dev_card_info;
truncate table dev_link;
truncate table dev_monitor;
truncate table entity;
truncate table event_info;
truncate table process_status;

use 2011_security_service;
truncate table t_log;
truncate table t_login_log;

use 2011_user_service;
truncate table auc;
truncate table epc_data;
truncate table epc_tft;
truncate table hlr;
truncate table hlr_groupnum;
truncate table hlrps;
truncate table hss_user_net_policy;
truncate table msservice;
truncate table terminalinfo;
truncate table tt_bear_qos_profile;

use hss_proxy_service;
truncate table hss_relation;


# disp
use data_dispatch;
truncate table gps_track_line;
truncate table gps_track_point;
truncate table plot_relation;
truncate table plot_user_off;
truncate table push_gps_point;

use dispatcher;
truncate table historyCall;
truncate table historyMessage;
truncate table phone_book;

use `group`;
truncate table ext_contact_entry;
truncate table `group`;
truncate table group_entry;
truncate table linkman;

use imserver;
truncate table cpim_expandheads;

use presence;
truncate table register_record;

# switch
use CSCF_DB;
truncate table scscf_ue;


set foreign_key_checks=1;