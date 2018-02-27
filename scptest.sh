#!/bin/bash
TMP=$(mktemp)
FILE=/tmp/100m
TARGET=seachange@192.168.113.49
#date
[[ -r "$FILE" ]] || dd if=/dev/zero of="$FILE" bs=1M count=100
time (scp "$FILE"  "$TARGET":/tmp/ ) 2>"$TMP" 1>/dev/null
TIME=`awk -F'[ ms]+' '/^real/ {print "copy time: "$2"s"}' "$TMP"`
SPEED=`awk -F'[ ms]+' '/^real/ {print "avg speed: "100/$2"MBps"}' "$TMP"`
echo $(date +%F-%H:%M) "$TIME" "$SPEED"
rm "$TMP"
