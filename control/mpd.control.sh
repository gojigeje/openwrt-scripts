#!/bin/bash
# ----------------------------------------------------------------------------------
# @name    : mpd.control.sh
# @version : 0.1
# @date    : 2014/03/20 13:31 WIB
#
# ABOUT
# ----------------------------------------------------------------------------------
# Simple script to control music player daemon (ON/OFF)
#
# AUTHOR
# ----------------------------------------------------------------------------------
# Ghozy Arif Fajri <http://github.com/gojigeje>
#

cd /root/script/

getStatus() {
  stat_mpd=$(ps | grep -v grep | grep -v control.mpd.sh | grep -c mpd)
   if [ "$stat_mpd" -gt "0" ]
      then
         smpd="ON"
      else
         smpd="OFF"
   fi
}

control() {
  if [ "$smpd" = "OFF" ]; then
    echo "starting mpd"
    mpd
    sleep 1
    getStatus
    confirmSTART
  else
    echo "stopping mpd"
    killall mpd
    sleep 1
    getStatus
    confirmKILL
  fi
}

confirmSTART() {
  if [ "$smpd" = "OFF" ]; then
    echo "starting mpd again"
    mpd
    getStatus
    confirmSTART
  else
    echo "mpd started"
    madplay control.mpd.started.mp3 -A -20 > /dev/null 2>&1
  fi
}

confirmKILL() {
  if [ "$smpd" = "ON" ]; then
    echo "stopping mpd again"
    killall mpd
    getStatus
    confirmKILL
  else
    echo "mpd stopped"
    madplay control.mpd.stopped.mp3 -A -20 > /dev/null 2>&1
  fi
}

getStatus
control