#!/bin/bash

source_url='rsync://arch.mirror.constant.com/archlinux/'
lastupdate_url='https://arch.mirror.constant.com/lastupdate'
Hourly="True"

LogFile="/config/cron_log"

min=$((RANDOM%60))

echo "#Archrepo" >> /etc/cron.d/sync-cron

if [[ "$Hourly" == True  ]]; then
echo "$min * * * * /scripts/syncrepo-template.sh $source_url $lastupdate_url \
&& date >> $LogFile 2>&1 && echo 'Updated Arch Mirror' >> $LogFile && echo '' >> $LogFile
" >> /etc/cron.d/sync-cron
else
if [ $((RANDOM%2)) -eq 0 ]; then
echo "$min */2 * * * /scripts/syncrepo-template.sh $source_url $lastupdate_url \
&& date >> $LogFile 2>&1 && echo 'Updated Arch Mirror' >> $LogFile && echo '' >> $LogFile
" >> /etc/cron.d/sync-cron
else
echo "$min 1-23/2 * * * /scripts/syncrepo-template.sh $source_url $lastupdate_url \
&& date >> $LogFile 2>&1 && && echo 'Updated Arch Mirror' >> $LogFile && echo '' >> $LogFile
" >> /etc/cron.d/sync-cron
fi
fi

echo "0 5 * * * /scripts/Rank.sh" >> /etc/cron.d/sync-cron

touch "$LogFile"

chmod 0644 /etc/cron.d/sync-cron

crontab /etc/cron.d/sync-cron

cron

