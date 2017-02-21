#!/usr/local/bin/bash

gra="Realpolitiks"
wyniki=/var/www/owncloud/real.txt
cd /home/kmonti/real
a=/home/kmonti/real
date=`date +%F-%H:%M `
echo -n $date >> $wyniki
xargs -n 1 /usr/local/bin/curl -sO < $a/url.txt
miejsce=`grep span.*class.*title.* $a/search*filter* |grep -n $gra | cut -d ":" -f1`
#echo $miejsce
#echo $b

echo  " "$miejsce >> $wyniki
mkdir -p $a/$date
mv  search*filter* $a/$date
