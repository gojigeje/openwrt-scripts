#!/bin/bash

cd /root/script/

jam=$(date +%I)
menit=$(date +%M)
ampm=$(date +%p)

if [[ $menit = "00" ]]; then
  menit="o'clock"
fi
if [[ $ampm = "AM" ]]; then
  ampm="A.M."
else
  ampm="P.M."
fi

bash speak.sh "Hi Goji!. The time now, is, $jam, $menit, $ampm"
# echo "Hi Goji!. The time now, is, $jam, $menit, $ampm"