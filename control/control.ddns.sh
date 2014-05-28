#!/bin/bash
# ----------------------------------------------------------------------------------
# @name    : control.ddnsafraid.sh
# @version : 0.1
# @date    : 2014/04/03 23:45 WIB
#
# ABOUT
# ----------------------------------------------------------------------------------
# Script to handle dynamic dns on this router :)
#
# AUTHOR
# ----------------------------------------------------------------------------------
# Ghozy Arif Fajri <http://github.com/gojigeje>
#

start() {
  cd /root/script
  . volume.madplay

  mkdir -p /root/script/ddns
  cd /root/script/ddns
  rm /root/script/ddns/*
  
  domain_mini="mini.sejak.tk"
  domain_goji="keren.sejak.tk"

  cek_koneksi
}

cek_koneksi() {
  if eval "ping -c 1 8.8.4.4 -w 2 > /dev/null"; then
    echo `date +%Y-%m-%d:%H%M`" - Cek koneksi internet.. [OK] "

    ip_mini=$(nslookup $domain_mini | tail -n2 | grep Address | grep -v "192.168.2\|8.8.8.8\|118.98.96.151" | cut -d : -f2 | cut -d " " -f2)
    ip_goji=$(nslookup $domain_goji | tail -n2 | grep Address | grep -v "192.168.2\|8.8.8.8\|118.98.96.151" | cut -d : -f2 | cut -d " " -f2)
    ip_sekarang=$(wget -q -O - http://checkip.dyndns.org | sed s/[^0-9.]//g)

    cek_gojibuntu
  else
    echo `date +%Y-%m-%d:%H%M`" - EXIT: Nggak konek internet :("
    exit
  fi 
}

cek_gojibuntu() {
  if eval "ping -c 1 192.168.2.2 -w 2 > /dev/null"; then
    gojibuntuOnline="1"
  else
    gojibuntuOnline="0"
  fi 
}

update_mini() {
  echo `date +%Y-%m-%d:%H%M`" - Update domain gojimini.. [$ip_sekarang]"
  echo -n "Updating sejak.tk..        : "
  wget http://freedns.afraid.org/dynamic/update.php?{ update token here } -o /dev/null -O sejak.tk
  cat sejak.tk
  echo -n "Updating www.sejak.tk..    : "
  wget http://freedns.afraid.org/dynamic/update.php?{ update token here } -o /dev/null -O www.sejak.tk
  cat www.sejak.tk
  echo -n "Updating luci.sejak.tk..   : "
  wget http://freedns.afraid.org/dynamic/update.php?{ update token here } -o /dev/null -O luci.sejak.tk
  cat luci.sejak.tk
  echo -n "Updating mini.sejak.tk..   : "
  wget http://freedns.afraid.org/dynamic/update.php?{ update token here } -o /dev/null -O mini.sejak.tk
  cat mini.sejak.tk
  echo -n "Updating server.sejak.tk.. : "
  wget http://freedns.afraid.org/dynamic/update.php?{ update token here } -o /dev/null -O server.sejak.tk
  cat server.sejak.tk
}

update_gojibuntu() {
  echo ""
  echo `date +%Y-%m-%d:%H%M`" - Update domain gojibuntu.. [$ip_sekarang]"
  echo -n "Updating keren.sejak.tk..  : "
  wget http://freedns.afraid.org/dynamic/update.php?{ update token here } -o /dev/null -O keren.sejak.tk
  cat keren.sejak.tk
  echo -n "Updating paste.sejak.tk..  : "
  wget http://freedns.afraid.org/dynamic/update.php?{ update token here } -o /dev/null -O paste.sejak.tk
  cat paste.sejak.tk
  echo -n "Updating tomboy.sejak.tk.. : "
  wget http://freedns.afraid.org/dynamic/update.php?{ update token here } -o /dev/null -O tomboy.sejak.tk
  cat tomboy.sejak.tk
  echo -n "Updating tetangga.sejak.tk.. : "
  wget http://freedns.afraid.org/dynamic/update.php?{ update token here } -o /dev/null -O tetangga.sejak.tk
  cat tetangga.sejak.tk
  echo -n "Updating goji.ftp.sh..     : "
  wget http://freedns.afraid.org/dynamic/update.php?{ update token here } -o /dev/null -O goji.ftp.sh
  cat goji.ftp.sh
  echo -n "Updating goji.linuxx.org.. : "
  wget http://freedns.afraid.org/dynamic/update.php?{ update token here } -o /dev/null -O goji.linuxx.org
  cat goji.linuxx.org
}

update_cludns() {
  # bandingkan
  if [ "$ip_cloudns" = "$ip_sekarang" ]
  then
    # ip sama, g perlu update
    echo `date +%Y-%m-%d:%H%M`" - IP domain di Cloud DNS sudah update.. [$ip_sekarang]"
  else
    # ip ganti, update dns
    echo `date +%Y-%m-%d:%H%M`" - Mengupdate IP domain di Cloud DNS [$ip_sekarang]"

    echo  -n " - free.sejak.tk..     "
    # free.sejak.tk
    wget http://ipv4.asia.cloudns.net/api/dynamicURL/?q={ update token here } -o /dev/null -O /dev/stdout
    echo ""

    echo -n " - www.free.sejak.tk.. "
    # www.free.sejak.tk
    wget http://ipv4.asia.cloudns.net/api/dynamicURL/?q={ update token here } -o /dev/null -O /dev/stdout
    echo ""

    echo -n " - *.free.sejak.tk..   "
    # *.free.sejak.tk
    wget http://ipv4.asia.cloudns.net/api/dynamicURL/?q={ update token here } -o /dev/null -O /dev/stdout
    echo ""
    echo ""

  fi
}

start
