#!/bin/bash
#
# Author: Ghozy Arif Fajri <http://github.com/gojigeje>
# Description:
#   Text to speech engine using google, originally written by Jacer Omri 
#   <https://gist.github.com/JokerHacker/6047812>.
#
#   I modified it to work on my OpenWRT router by piping out to madplay
#   and add function to check internet connection state. If offline, it
#   will simply play the "offline.mp3" file :)
 
offmp3="/root/script/noconnection.mp3"

# cek koneksi
if eval "ping -c 1 8.8.4.4 -w 2 > /dev/null 2>&1"; then
  echo "ok" > /dev/null
else
  madplay "$offmp3" -A -20 > /dev/null 2>&1
  exit 1
fi 

## a function to encode urls
rawurlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
 
  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"
}
 
if [ -z "$1" ]
  then
    echo "No text specified, exiting"
    exit
  else
    TEXT=$( rawurlencode "$1" )
fi
 
if [ -z "$2" ]
  then
    # echo "No language supplied, using en"
    LANG="en"
  else
    LANG="$2"
fi
 
API="http://translate.google.com/translate_tts?ie=UTF-8&tl=$LANG&q=$TEXT"
UA="Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.2 Safari/537.36"
wget -q -U "$UA" -O - "$API" | madplay - -A -20 > /dev/null 2>&1