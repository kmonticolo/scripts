#!/bin/sh
ssh -t poldpsbackend01   "sudo su - dps -c ' /opt/dps/bin/startjob -a tcp://127.0.0.1:5432 -b GET -p 428550 -r LUKA'"
ssh -t poldpsbackend01 "sudo su -c 'ls -t /opt/dps/var/hceout/|head -1;chmod 0644 /opt/dps/var/hceout/*'"
scp poldpsbackend01:/opt/dps/var/hceout/* ~/hce
echo podaj haslo;ssh -t poldpsbackend01 "sudo su -c 'ls -t /opt/dps/var/hceout/|head -1'" |grep GET >x
a=~/hce/`cat x`
a="${a%\\n}" # usuwa nowa linie na koncu
export a="${a%\\n}"
#a=`echo $a|tr -d '\n'`
a=`echo -n $a|sed 's/.$//'`
#echo $a >ee
#ssh -t polftp02 "mkdir /tmp/hce; rm /tmp/hce/*"
scp "$a" polftp02:/tmp/hce
ssh -t polftp02  "sudo su  -c 'mv /tmp/hce/GET*gpg /home/get/hce/out; chown get:get /home/get/hce/out/*; chmod 644 /home/get/hce/out/*;ls -l  /home/get/hce/out/*'"|grep `date +%y%m%d` || echo BLAD!!! COS POSZLO NIE TAK,CHYBA PLIK NIE JEST DZISIEJSZY

