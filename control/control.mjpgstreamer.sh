#!/bin/bash
# ----------------------------------------------------------------------------------
# @name    : control.mjpgstreamer.sh
# @version : 0.1
# @date    : 2014/03/24 23:06 WIB
#
# ABOUT
# ----------------------------------------------------------------------------------
# Script to control mjpg_streamer
#
# AUTHOR
# ----------------------------------------------------------------------------------
# Ghozy Arif Fajri <http://github.com/gojigeje>
#

# startup
#   cek last shutdown
# cek tiap 30 menit
#   pake wget?
#   pake -o file

WEBFOLDER="/website/arsip"
TAHUNBULAN=$(date +'%Y-%m')
TANGGAL=$(date +'%d')
ARSIPFOLDER="$WEBFOLDER/$TAHUNBULAN/$TANGGAL"
mkdir -p "$ARSIPFOLDER"

getDate() {
  DATE=$(date +'%Y%m%d-%H%M')
}

startup() {
  mjpg_streamer -i "input_uvc.so --fps "5" -d /dev/video0 -y" -o "output_http.so -w /www/webcam/"  -o "output_file.so -f $ARSIPFOLDER -d 900000" -b > /dev/null 2>&1
}

cek_wget() {
  cd /root/script
  getDate
  wget -q "http://localhost/?action=stream" -O snapshot.jpg &
  PID=$!
  sleep 10
  if [ `ps | grep $PID]` -ne '' ; then
    # macet
    kill $PID
    CEKWGET="KO"
    rm snapshot.jpg
  else
    CEKWGET="OK"
    rm snapshot.jpg
  fi
}

cek_file() {
  cd "$ARSIPFOLDER"
  echo ":)" > .tes

  if [ -f ".tes"]; then
    CEKFILE="OK"
    rm .tes
  else
    CEKFILE="KO"
  fi
}

cek_running() {
  stat_mjpg=$(ps | grep -v grep | grep -v control.mjpgstreamer.sh | grep -c mjpg_streamer)
  if [ "$stat_mjpg" -gt "0" ]
     then
        smjpg="ON"
     else
        smjpg="OFF"
  fi
}

case "$1" in
  "1" ) # 1s
    
  ;;

  "2" ) # 3s
    
  ;;

  "3" ) # 5s
    
  ;;

  "4" ) # 7s
    
  ;;

  "5" ) # 10s
    
  ;; 

  *)
    echo "?"
  ;;
esac
