#!/bin/bash

cd /root/script
. volume.madplay

madplay mp3/gojimini2.incomingmessage.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/gojimini2.systemwillreboot.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/gojimini2.cctvshutdown.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
