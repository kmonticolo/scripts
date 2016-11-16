#!/bin/bash

rm *thm 2>/dev/null
for file in FILE[0-9][0-9][0-9][0-9].mp4; do
  mc=`ls -l |grep $file|awk {'print $7'}\n`
  day=`ls -l |grep $file|awk {'print $8'}\n`
  time=`ls -l |grep $file|awk {'print $9'}\n`
  oldname=`echo $file|sed 's/.mp4//g'`
  newname=${oldname}-${mc}-${day}-${time}.mp4
  #echo $newname
  mv $file $newname
done
