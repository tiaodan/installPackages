#!/bin/bash

mkdir -p /etc/emqx/
cp ./cron_emqx /etc/emqx/cron_emqx.sh
chmod +x /etc/emqx/cron_emqx.sh

crontab_file=/var/spool/cron/root

sys_ver=`cat /proc/version`
if [[ $sys_ver =~ "ubuntu" ]]; then
	crontab_file=/var/spool/cron/crontabs/root
fi

[ -e $crontab_file ] && sed -i --follow-symlinks '/cron_emqx.sh/d' $crontab_file
echo "* * * * * /etc/emqx/cron_emqx.sh" >> $crontab_file
echo "Emqx monitor install successfully."