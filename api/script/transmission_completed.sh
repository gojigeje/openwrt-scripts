#!/bin/bash

cd /root/script
. volume.madplay

madplay mp3/transmission.completed.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1
madplay mp3/transmission.filesaved.mp3 -A $VOLUMEMADPLAY > /dev/null 2>&1