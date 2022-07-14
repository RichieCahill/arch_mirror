#!/bin/bash


tmmworkshop

# sort_by(.score) sort_by(.urls[].score)
# This can probly improved this if i can get jq to cooperate
raw=$(curl https://archlinux.org/mirrors/status/json/ | cut -d" "  -f10-)
data=$(echo ${raw::-15} | jq 'sort_by(.score)')

echo "$data" | jq -c '.[] | select( .country_code | contains("US"))' | sed '/"score":null/d' | grep -n "$URL" | cut -f1 -d":" >> US.csv
echo "$data" | jq -c '.[] | select( .active | contains(true))' | sed '/"score":null/d' | grep -n "$URL" | cut -f1 -d":" >> World.csv
