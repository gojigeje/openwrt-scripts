#!/bin/bash
# ----------------------------------------------------------------------------------
# @name    : control.reboot.sh
# @version : 0.1
# @date    : 2014/03/20 13:31 WIB
#
# ABOUT
# ----------------------------------------------------------------------------------
# Simple script to reboot your router with style :)
#
# AUTHOR
# ----------------------------------------------------------------------------------
# Ghozy Arif Fajri <http://github.com/gojigeje>
#

cd /root/script
. volume.madplay

echo "$$" > reboot.pid

madplay mp3/reboot.cron.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/reboot.7.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/reboot.6.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/reboot.5.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/reboot.4.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/reboot.3.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/reboot.2.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/reboot.1.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/reboot.0.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/reboot.goodbye.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1

rm reboot.pid
reboot