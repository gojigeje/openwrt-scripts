#!/bin/bash
# ----------------------------------------------------------------------------------
# @name    : control.reboot0.sh
# @version : 0.1
# @date    : 2014/03/21 10:32 WIB
#
# ABOUT
# ----------------------------------------------------------------------------------
# Cancel the reboot :)
#
# AUTHOR
# ----------------------------------------------------------------------------------
# Ghozy Arif Fajri <http://github.com/gojigeje>
#

cd /root/script/
. volume.madplay

PIDNYA=$(cat reboot.pid)

kill "$PIDNYA"
sleep 1
madplay mp3/reboot.cancel.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
rm reboot.pid
