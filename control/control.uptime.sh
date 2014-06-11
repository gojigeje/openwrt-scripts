#!/bin/bash
# uptime.sh
# get uptime from /proc/uptime
# http://grulos.blogspot.com/2006/01/script-uptimesh-get-uptime-from.html

uptime=$(</proc/uptime)
uptime=${uptime%%.*}

seconds=$(( uptime%60 ))
minutes=$(( uptime/60%60 ))
hours=$(( uptime/60/60%24 ))
days=$(( uptime/60/60/24 ))

# echo "$days days, $hours hours, $minutes minutes, $seconds seconds"

if [ "$days" -gt "0" ]; then
  # reboot
  /root/script/control.reboot_cron.sh > /dev/null 2>&1
else
  echo "days: $days"
fi
