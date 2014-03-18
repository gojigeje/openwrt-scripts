#!/bin/bash

cd /root/script/

TMPDIR="/root/script"
# TMPDIR="$HOME/Desktop"
curl -s -u <EMAIL>:<PASSWORD> --silent "https://mail.google.com/mail/feed/atom" | grep fullcount | sed 's/<[^>]\+>//g' > "$TMPDIR/inbox"

if [ -s "$TMPDIR/inbox" ]; then
  new=$(cat "$TMPDIR/inbox")
  if [ $new = "0" ]; then
    echo "You have no new message"
  else
    bash speak.sh "Hi Goji!. You have $new new messages in your gmail inbox"
  fi
else 
  echo  "kosong"
fi
