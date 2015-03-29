#!/bin/bash

timecheck=$(logread | grep cron | grep 'time disparity')

logger "[cron-check] checking time disparity"
if [[ ! -z "$timecheck" ]]; then
  logger "[cron-check] time disparity detected"

  logger "[cron-check] trying to obtain time from NTP server"
  ntpd -p 0.openwrt.pool.ntp.org
  ntpd -p 1.openwrt.pool.ntp.org
  sleep 3

  logger "[cron-check] reloading cron"
  /etc/init.d/cron reload

else
  logger "[cron-check] time disparity not detected, exit"
fi
