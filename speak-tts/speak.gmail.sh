#!/bin/bash
# ----------------------------------------------------------------------------------
# @name    : speak.gmail.sh
# @version : 0.1
# @date    : 2014/03/19 04:31 WIB
#
# ABOUT
# ----------------------------------------------------------------------------------
# Simple bash script to get new email count from gmail.
#
# AUTHOR
# ----------------------------------------------------------------------------------
# Ghozy Arif Fajri <http://github.com/gojigeje>
#

. /etc/profile
cd /root/script/
. volume.madplay

if [ -z "$1" ]
  then
    echo "non-quiet mode" > /dev/null
  else
    if [ "$1" = "-q" ]; then
      QUIET="-q"
    fi
fi

TMPDIR="/root/script"
# TMPDIR="$HOME/Desktop"
curl -s -u <EMAIL>:<PASSWORD> --silent "https://mail.google.com/mail/feed/atom" | grep fullcount | sed 's/<[^>]\+>//g' > "$TMPDIR/inbox"

if [ -s "$TMPDIR/inbox" ]; then
  new=$(cat "$TMPDIR/inbox")
  if [ $new = "0" ]; then
    #echo "You have no new message"
    madplay mp3/speak.gmail.nonew.mp3 -A "$VOLUMEMADPLAY"
  else
    bash speak.sh "Hi Goji!. You have, $new, new email. in your gmail inbox" $QUIET
  fi
else
  #echo "kosong"
  madplay mp3/speak.gmail.cannot.mp3 -A "$VOLUMEMADPLAY"
fi
