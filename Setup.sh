#!/bin/bash

source_url='rsync://arch.mirror.constant.com/archlinux/'
lastupdate_url='https://arch.mirror.constant.com/lastupdate'
Hourly="True"

min=$((RANDOM%60))

echo "#Archrepo" >> /etc/cron.d/sync-cron

if [[ "$Hourly" == True  ]]; then
echo "$min * * * * /config/syncrepo-template.sh $source_url $lastupdate_url \
&& date >> /config/cron_log 2>&1 && echo 'Updated Arch Mirror' >> /config/cron_log
" >> /etc/cron.d/sync-cron
else
if [ $((RANDOM%2)) -eq 0 ]; then
echo "$min 0,2,4,6,8,10,12,14,16,18,20,22 * * * /config/syncrepo-template.sh $source_url $lastupdate_url \
&& date >> /config/cron_log 2>&1 && echo 'Updated Arch Mirror' >> /config/cron_log
" >> /etc/cron.d/sync-cron
else
echo "$min 1,3,5,7,9,11,13,15,17,19,21,23 * * * /config/syncrepo-template.sh $source_url $lastupdate_url \
&& date >> /config/cron_log 2>&1 && && echo 'Updated Arch Mirror' >> /config/cron_log
" >> /etc/cron.d/sync-cron
fi
fi

touch /config/cron_log

chmod 0644 /etc/cron.d/sync-cron

crontab /etc/cron.d/sync-cron

cron

