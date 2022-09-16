#!/bin/bash

time=$(date +%s)
URL="tmmworkshop"

# One liner for fun
# curl https://archlinux.org/mirrors/status/json/ | jq '.urls|sort_by(.score)' | jq -c '.[] | select( .country_code | contains("US"))' | sed '/"score":null/d' | grep -n "$URL" | cut -f1 -d":" >> US.csv
data=$(curl https://archlinux.org/mirrors/status/json/ | jq '.urls|sort_by(.score)')

country=$(echo "$data" | jq -c '.[] | select( .country_code | contains("US"))' | sed '/"score":null/d' | grep -n "$URL" | cut -f1 -d":")
world=$(echo "$data" | jq -c '.[] | select( .active | contains(true))' | sed '/"score":null/d' | grep -n "$URL" | cut -f1 -d":")
echo "$country","$world","$time" >> /config/Rank.csv