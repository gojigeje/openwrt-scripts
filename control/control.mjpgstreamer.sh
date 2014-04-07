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

WEBFOLDER="/website/arsip1"
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

# access main server api
message_started() {
  curl -s "http://192.168.2.10/api/?code=gojimini2.cctv_successfully_started" > /dev/null 2>&1
}
message_not_responding() {
  curl -s "http://192.168.2.10/api/?code=gojimini2.cctv_not_responding" > /dev/null 2>&1
}
message_system_ready() {
  curl -s "http://192.168.2.10/api/?code=gojimini2.system_is_ready" > /dev/null 2>&1
}

cek_wget() {
  cd /root/script
  getDate
  wget -q "http://localhost/?action=stream" -O snapshot.jpg &
  PID=$!
  sleep 10
  PSPID=$(ps | grep $PID | grep -v grep)
  if [ "$PSPID" != "" ]; then
    # macet
    # kill $PID
    echo "kill $PID !!!"
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

  if [ -f ".tes" ]; then
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
  "startup"|"start" )
    echo ""
    echo "$(date +%Y-%m-%d_%H:%M:%S) - Starting mjpg_streamer up.."

    cek_running
    if [ "$smjpg" = "ON" ]; then
      echo "$(date +%Y-%m-%d_%H:%M:%S) - mjpg_streamer is already started!"
      exit 1
    fi

    startup
    sleep 2
    cek_running
    if [ "$smjpg" = "OFF" ]; then
      echo "$(date +%Y-%m-%d_%H:%M:%S) - mjpg_streamer couldn't start? Starting again.. (1)"
      startup
      cek_running
      if [ "$smjpg" = "OFF" ]; then
        echo "$(date +%Y-%m-%d_%H:%M:%S) - mjpg_streamer couldn't start? Starting again.. (2)"
        startup
        cek_running
        if [ "$smjpg" = "OFF" ]; then
          echo "$(date +%Y-%m-%d_%H:%M:%S) - mjpg_streamer couldn't start? Starting again.. (3)"
          echo "$(date +%Y-%m-%d_%H:%M:%S) - Giving up :( -- reboot?"
          # force reboot
          message_not_responding
          reboot -f
        fi
      fi
    else
      # successfully started
      if [ -z "$2" ]
        then
          echo "$(date +%Y-%m-%d_%H:%M:%S) - mjpg_streamer successfully started.."
          message_started
        else
          if [ "$2" = "quiet" ]; then
            echo "$(date +%Y-%m-%d_%H:%M:%S) - mjpg_streamer successfully started.. (quiet)"
          fi
      fi
    fi
  ;;

  "cek" )
    echo ""
    echo "$(date +%Y-%m-%d_%H:%M:%S) - Checking mjpg_streamer health.."
    cek_running
    if [ "$smjpg" = "ON" ]; then
      echo "$(date +%Y-%m-%d_%H:%M:%S) - Checking disk write access.."
      cek_file
      if [ "$CEKFILE" = "OK" ]; then
        echo "$(date +%Y-%m-%d_%H:%M:%S) - Disk write access OK"
        echo "$(date +%Y-%m-%d_%H:%M:%S) - Checking snapshot using wget.."
        cek_wget
        if [ "$CEKWGET" = "OK" ]; then
          echo "$(date +%Y-%m-%d_%H:%M:%S) - Snapshot OK"
          echo "$(date +%Y-%m-%d_%H:%M:%S) - System is normal :)"
        else
          echo "$(date +%Y-%m-%d_%H:%M:%S) - Snapshot FAIL!"
          echo "$(date +%Y-%m-%d_%H:%M:%S) - reboot? (wget_fail)"
          # force reboot
          message_not_responding
          reboot -f
        fi
      else
        echo "$(date +%Y-%m-%d_%H:%M:%S) - Disk write FAIL!"
        echo "$(date +%Y-%m-%d_%H:%M:%S) - reboot? (write_fail)"
        # force reboot
        message_not_responding
        reboot -f
      fi
    else
      echo "$(date +%Y-%m-%d_%H:%M:%S) - mjpg_streamer not running!"
    fi
  ;;

  "reload" )
    cek_running
    if [ "$smjpg" = "OFF" ]; then
      echo "$(date +%Y-%m-%d_%H:%M:%S) - mjpg_streamer is not running!"
      if [ -z "$2" ]
        then
          $0 start
        else
          if [ "$2" = "quiet" ]; then
            $0 start quiet
          fi
      fi
    else
      echo "$(date +%Y-%m-%d_%H:%M:%S) - killing mjpg_streamer.."
      killall mjpg_streamer
      sleep 2
      cek_running
      if [ "$smjpg" = "ON" ]; then
        echo "$(date +%Y-%m-%d_%H:%M:%S) - can't kill mjpg_streamer! killing again (1)"
        killall mjpg_streamer
        cek_running
        if [ "$smjpg" = "ON" ]; then
          echo "$(date +%Y-%m-%d_%H:%M:%S) - can't kill mjpg_streamer! killing again (2)"
          killall mjpg_streamer
          cek_running
          if [ "$smjpg" = "ON" ]; then
            echo "$(date +%Y-%m-%d_%H:%M:%S) - can't kill mjpg_streamer! killing again (3)"
            echo "$(date +%Y-%m-%d_%H:%M:%S) - Giving up :( -- reboot?"
            # force reboot
            message_not_responding
            reboot -f
          fi
        fi
      else
        echo "$(date +%Y-%m-%d_%H:%M:%S) - killed!"
        if [ -z "$2" ]
          then
            $0 start
          else
            if [ "$2" = "quiet" ]; then
              $0 start quiet
            fi
        fi
      fi
    fi

  ;;

  *)
    echo "Wrong parameter!"
  ;;
esac
