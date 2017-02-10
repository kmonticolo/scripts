#!/bin/sh
# for munin stats

log=/var/log/mail.info
plik=/home/birkoff/public_html/pop3.txt
date > $plik

echo === statystyki amavis === >> $plik
 grep -i amavis /var/log/mail.info|awk '{print $8'}|sort|uniq -c |sort -rn >>$plik
echo === statystyki amavis bez CLEAN === >> $plik
grep -i amavis /var/log/mail.info|grep -v CLEAN| awk '{print $8" "$9" "$10'}|sort|uniq -c |sort -rn >>$plik


echo === brak uzytkownika lokalnego dzisiaj=== >> $plik
grep "User unknown in local recipient table" /var/log/mail.log|awk '{print $13}'|sort|uniq -c|sort -rn >>$plik

echo === brak uzytkownika lokalnego wszystkie logi === >> $plik
zgrep "User unknown in local recipient table" /var/log/mail.log*|awk '{print $13}'|sort|uniq -c|sort -rn >>$plik

echo === statystyki polaczen \"max connection rate\" === >> $plik
zgrep "max connection rate " /var/log/mail.log*|sort -rn -k 10  |awk -F\: '{print $6" "$7":"$8":"$9}' |head -20 >>$plik

echo === odbitka gmail typu \""unsolicited mail originating from your IP address"\" === >> $plik
for i in /var/log/mail.log*; do echo -n `zgrep -c "unsolicited mail originating from your IP address. To protect our" $i`"   "; ls -l $i|awk '{print $6" "$7 " "$8}';done >> $plik

echo === ilosc rejectowanych maili === >> $plik
#zgrep -c reject /var/log/mail.log* >> $plik
#ls -l /var/log/mail.log* >> $plik
for i in /var/log/mail.log*; do echo -n `zgrep -c reject $i`"   "; ls -l $i|awk '{print $6" "$7 " "$8}';done >> $plik

echo === ilosc refused to talk to me === >> $plik
for i in /var/log/mail.log*; do echo -n `zgrep -c "refused to talk to me" $i`"   "; ls -l $i|awk '{print $6" "$7 " "$8}';done >> $plik

echo === najwiecej rejectowanych dzisiaj maili w/g antyspamow RBL === >> $plik
grep  "blocked using" /var/log/mail.log|sed 's/^.*blocked\ using//g'|sed 's/\;.*$//g'|sort |uniq -c|sort -rn>> $plik

echo === ilosc maili typu \"not owned by\", wtedy poczta nie dochodzi === >> $plik
for i in /var/log/mail.log*; do echo -n `zgrep -c "not owned by" $i`"   "; ls -l $i|awk '{print $6" "$7 " "$8}';done >> $plik

echo === najwiecej NIEUDANYCH logowan z hostow === >> $plik
grep "LOGIN FAILED" $log |awk '{print $9}'|sort |uniq -c|sort -rn >> $plik

echo === najwiecej NIEUDANYCH prob logowania dzisiaj na userow === >> $plik
grep "LOGIN FAILED" $log |awk '{print $8}'|sort |uniq -c|sort -rn >> $plik

echo === najwiecej UDANYCH prob logowania po imap dzisiaj na userow ===  >> $plik
grep "imapd: LOGIN, user=" $log |awk '{print $7}'|sort |uniq -c|sort -rn >> $plik
