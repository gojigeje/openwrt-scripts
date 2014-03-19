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

case "$1" in
  "1" )
    bash speak.time.sh
  ;;

  "2" )
    bash speak.gmail.sh
  ;;

  *)
    echo "?"
  ;;
esac
