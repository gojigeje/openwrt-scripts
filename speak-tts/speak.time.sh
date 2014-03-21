#!/bin/bash
# ----------------------------------------------------------------------------------
# @name    : speak.time.sh
# @version : 0.1
# @date    : 2014/03/19 04:29 WIB
#
# ABOUT
# ----------------------------------------------------------------------------------
# Simple script to get current time, and speak it for us.
#
# AUTHOR
# ----------------------------------------------------------------------------------
# Ghozy Arif Fajri <http://github.com/gojigeje>
#

cd /root/script/

if [ -z "$1" ]
  then
    echo "non-quiet mode" > /dev/null
  else
    if [ "$1" = "-q" ]; then
      QUIET="-q"
    fi
fi

jam=$(date +%I)
menit=$(date +%M)
ampm=$(date +%p)

if [[ $jam < 10 ]]; then
  jam=$(echo $jam | sed 's/^[0]*//')
fi
if [[ $menit = "00" ]]; then
  menit="o'clock"
fi
if [[ $ampm = "AM" ]]; then
  ampm="A.M."
else
  ampm="P.M."
fi

bash speak.sh "Hi Goji!. The time now, is, $jam, $menit, $ampm" $QUIET
