
#删除核心网服务器
set foreign_key_checks=0;


use lz;
truncate table `test`;
truncate table wave_path;


use CSCF_DB;
truncate table scscf_ue;

use hss;
truncate table AUC;
truncate table HLR;
truncate table csHLRGroupData;
truncate table csHLRGroupInfo;
truncate table csHLRGroupMember;
truncate table HLRps;
truncate table GroupInfo;
truncate table MSService;
truncate table TerminalInfo;


set foreign_key_checks=1;
