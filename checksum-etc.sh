#!/bin/bash
# kmonticolo 1-04-2010
# robi md5 wszystkich plikow w katalogach etc i pokazuje ktore pliki
# sie zmienily od ostatniego sprawdzenia. Do wykonywania z crona raz dziennie
# na dole grep robi liste excludow
# przydatne do sprawdzania podmianek stron, skryptow przy kierowaniu na malware
# wykrywanie defacow, etc

dzisiaj=`/bin/date +%F`
wczoraj=`/bin/date -d yesterday +%F`
przedwczoraj=`/bin/date -d "2 days ago" +%F`

/usr/bin/find /etc -type f -exec md5sum {} \; >/var/log/checksum/checksum-etc${dzisiaj}.log
# tutaj bzipuje historie, czasem przydatne zeby zrobic bzgrep, przekierowanie wyjscia, bo czasem odpalam z reki zeby sprawdzic szybciej
/bin/bzip2 /var/log/checksum/checksum-etc${przedwczoraj}.log >/dev/null 2>&1

echo "=== roznice w plikach w /etc pomiedzy ${wczoraj} a ${dzisiaj} ===" >/home/birkoff/public_html/etc_diff.txt
/usr/bin/diff \
/var/log/checksum/checksum-etc${wczoraj}.log \
/var/log/checksum/checksum-etc${dzisiaj}.log | \
/usr/bin/awk '{print $3}'|/usr/bin/sort | /usr/bin/uniq \
| grep -v "/home/birkoff/public_html/diff" \
| grep -v "/home/birkoff/public_html/pop3.txt" \
| grep -v "/home/birkoff/public_html/ftp.txt" \
| grep -v "/home/birkoff/public_html/lasty.txt" \
| grep -v "/home/piotrekk/public_html/sorkwity/data/users" \
| grep -v "/home/piotrekk/public_html/sorkwity/goscie" \
| grep -v "/home/wbeskidy/public_html/ip.txt" \
| grep -v "/home/wbeskidy/public_html/stat/count_data.txt" \
| grep -v "/home/birkoff/public_html/wwwlog.txt" \
| grep -v "/home/munin/public_html/" \
| grep -v "/home/kmonticolo/public_html/x/tmp/logs" \
| grep -v "/home/kmonticolo/public_html/x/tmp/cache" \
>> /home/birkoff/public_html/etc_diff.txt
/bin/cp /home/birkoff/public_html/etc_diff.txt /home/birkoff/public_html/etc_diff/etc_diff${dzisiaj}.txt

#tworzenie archiwum
/bin/cat /home/birkoff/public_html/etc_diff.txt| /bin/sed 's/^===.*===$//g' >/tmp/etclista && \
umask 077
/bin/tar zcphf /home/birkoff/checksum-etc-archiwum/checksum-etc-archiwum_`date +%F`.tgz -T /tmp/etclista >/dev/null 2>&1
/bin/rm -f /tmp/etclista
# koniec tworzenia archiwum
