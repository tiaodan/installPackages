
use `group`;
set foreign_key_checks=0;

truncate table ext_contact;
truncate table ext_contact_entry;
truncate table `group`;
truncate table group_entry;
truncate table linkman;

set foreign_key_checks=1;
