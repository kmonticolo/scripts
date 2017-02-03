#! /bin/bash

DEVLIST=`ls /dev/hd??`
for dev in $DEVLIST; do
result=`mdadm --query $dev | grep mismatch`
if [ -n "$result" ]; then
raid=/dev/`echo $result | awk 'BEGIN {FS="[ .]"} {print $9}'`
echo $raid needs $dev added
mdadm --add $raid $dev
fi
done
