#!/usr/local/bin/bash

wyniki=/var/www/owncloud/real.txt
cd /home/kmonti/real
a=/home/kmonti/real
date=`date +%F-%H:%M `
echo -n $date >> $wyniki
xargs -n 1 /usr/local/bin/curl -sO < $a/url.txt
miejsce=`grep span.*class.*title.* $a/search*filter* |grep -n Realpolitiks | cut -d ":" -f1`
#echo $miejsce
#echo $b

lg=`curl -s -o - http://steamcharts.com/app/553260| grep -E -B1  '\<abbr\ class="timeago"'| head -1|sed -e 's/^.*">//g' -e 's/<.*$//g'`
echo -n " "$miejsce >> $wyniki
echo " "$lg >> $wyniki
mkdir -p $a/$date
mv  search*filter* $a/$date
