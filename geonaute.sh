#!/bin/bash
# insert date and time into filename @kmonticolo 16.11.16

rm *thm *THM 2>/dev/null
for file in FILE[0-9][0-9][0-9][0-9].mp4; do
  mc=`ls -l |grep $file|awk {'print $7'}`
  day=`ls -l |grep $file|awk {'print $8'}`
  time=`ls -l |grep $file|awk {'print $9'}|sed 's/:/./'`
  oldname=`echo $file|sed 's/.mp4//g'`
  newname=${oldname}-${mc}-${day}-${time}.mp4
  #echo $newname
  mv $file $newname
done
