#!/bin/bash
# ----------------------------------------------------------------------------------
# @name    : button.sh
# @version : 0.1
# @date    : 2014/03/18 23:27 WIB
#
# ABOUT
# ----------------------------------------------------------------------------------
# A simple script to handle button press/release action on my OpenWRT router.
#
# AUTHOR
# ----------------------------------------------------------------------------------
# Ghozy Arif Fajri <http://github.com/gojigeje>
#

cd /root/script
filenya="reboot.pid"

case "$1" in
  "1" ) # 1s
    if [ -f "$filenya" ]; then
      bash control.reboot0.sh
    else
      bash speak.time.sh
    fi
  ;;

  "2" ) # 3s
    bash speak.gmail.sh
  ;;

  "3" ) # 5s
    bash control.mpd.sh
  ;;

  "4" ) # 7s
    bash control.lighty.sh
  ;;

  "5" ) # 10s
    bash control.reboot.sh
  ;; 

  *)
    echo "?"
  ;;
esac
