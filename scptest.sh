#!/bin/bash
TMP=$(mktemp)
date
[[ -r /tmp/100m ]] || dd if=/dev/zero of=/tmp/100m bs=1M count=100
time (scp /tmp/100m  user@192.168.113.49:/tmp/ ) 2>$TMP 1>/dev/null
awk -F'[ ms]+' '/^real/ {print "copy time: "$2"s"}' $TMP
awk -F'[ ms]+' '/^real/ {print "avg speed: "100/$2"MBps"}' $TMP
rm $TMP
