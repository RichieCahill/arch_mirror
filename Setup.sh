#!/bin/bash

source_url='rsync://arch.mirror.constant.com/archlinux/'
lastupdate_url='https://arch.mirror.constant.com/lastupdate'

hour=$((RANDOM%2))
min=$((RANDOM%60))

echo "#Archrepo" >> /etc/crontab

if [ $hour -eq 0 ]; then

echo "	$min 0,2,4,6,8,10,12,14,16,18,20,22 * * * root /config/syncrepo-template.sh $source_url $lastupdate_url" >> /etc/crontab

else
echo "	$min 1,3,5,7,9,11,13,15,17,19,21,23 * * * root /config/syncrepo-template.sh $source_url $lastupdate_url" >> /etc/crontab
fi

