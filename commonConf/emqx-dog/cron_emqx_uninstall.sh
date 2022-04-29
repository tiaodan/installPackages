#!/bin/bash

rm -f /etc/emqx/cron_emqx.sh
rm -f /etc/emqx/cron.log

crontab_file=/var/spool/cron/root
sys_ver=`cat /proc/version`
if [[ $sys_ver =~ "ubuntu" ]]; then
	crontab_file=/var/spool/cron/crontabs/root
fi

[ -e $crontab_file ] && sed -i --follow-symlinks '/cron_emqx.sh/d' $crontab_file
echo "Emqx monitor uninstall successfully."
