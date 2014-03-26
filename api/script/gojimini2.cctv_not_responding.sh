#!/bin/bash

cd /root/script
. volume.madplay

madplay mp3/gojimini2.incomingmessage.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/gojimini2.cctvnotresponding.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/gojimini2.willrestart.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
#madplay mp3/gojimini2.isrestart.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1