#!/bin/bash
# ----------------------------------------------------------------------------------
# @name    : speak.startup.sh
# @version : 0.1
# @date    : 2014/03/23 14:56 WIB
#
# ABOUT
# ----------------------------------------------------------------------------------
# Simple script to make your router noisy at startup :)
#
# AUTHOR
# ----------------------------------------------------------------------------------
# Ghozy Arif Fajri <http://github.com/gojigeje>
#

cd /root/script
. volume.madplay

madplay mp3/system.starting.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/system.firewallstart.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/system.dnsstart.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/system.lightystart.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1

# check internet connection
if eval "ping -c 1 8.8.4.4 -w 2 > /dev/null 2>&1"; then
  madplay mp3/system.inetok.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
else
  madplay mp3/system.inetko.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
fi

# pinging my laptop (fixed ip address)
if eval "ping -c 1 192.168.2.2 -w 2 > /dev/null 2>&1"; then
  madplay mp3/system.sambaok.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
  
  # try to mount samba share
  mount -t cifs //192.168.2.2/musik /mnt/mpd -o guest > /dev/null 2>&1
  
  # check if mount success
  if [ -d "/mnt/mpd/RIKZA" ]; then
    madplay mp3/system.sambamount.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
  fi

else
  madplay mp3/system.sambako.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
fi

madplay mp3/system.started.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/system.ready.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1

# madplay mp3/mpd.isnotrunning.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
# madplay mp3/mpd.isrunning.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1