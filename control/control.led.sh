#!/bin/bash
# ----------------------------------------------------------------------------------
# @name    : control.led.sh
# @version : 0.1
# @date    : 2014/03/21 14:45 WIB
#
# ABOUT
# ----------------------------------------------------------------------------------
# Script to control my router led.. blink.. blink..
#
# AUTHOR
# ----------------------------------------------------------------------------------
# Ghozy Arif Fajri <http://github.com/gojigeje>
#

cd /root/script

case "$1" in
  "on" ) # 1s
    echo default-on > /sys/class/leds/tp-link\:green\:wlan/trigger
    echo default-on > /sys/class/leds/tp-link\:green\:3g/trigger
  ;;

  "blink" ) # 3s
    echo timer > /sys/class/leds/tp-link\:green\:wlan/trigger
    echo timer > /sys/class/leds/tp-link\:green\:3g/trigger
  ;;

  "off" ) # 5s
    echo none > /sys/class/leds/tp-link\:green\:wlan/trigger
    echo none > /sys/class/leds/tp-link\:green\:3g/trigger
  ;;

  *)
    echo "?"
  ;;
esac