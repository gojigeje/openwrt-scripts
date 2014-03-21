#!/bin/bash
# ----------------------------------------------------------------------------------
# @name    : control.lighty.sh
# @version : 0.1
# @date    : 2014/03/21 09:42 WIB
#
# ABOUT
# ----------------------------------------------------------------------------------
# Simple script to reload lighttpd with style :)
#
# AUTHOR
# ----------------------------------------------------------------------------------
# Ghozy Arif Fajri <http://github.com/gojigeje>
#

cd /root/script/
. volume.madplay

madplay mp3/control.lighty.reload.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
/etc/init.d/lighttpd reload
sleep 1
madplay mp3/control.lighty.reloaded.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
