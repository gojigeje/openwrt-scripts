#!/bin/bash

curl -s "http://192.168.2.10/api/?code=gojimini2.reboot_maintenance" > /dev/null 2>&1

sleep 3
reboot