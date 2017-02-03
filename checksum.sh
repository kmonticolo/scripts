#!/bin/bash
# kmonticolo 1-04-2010
# poor man aide/tripwire replacement, using only system's binaries.
# calculate md5 hashes of all files in specified folders and shows differencies between last and previous executions.
# should be run from crontab daily.

# 02.10.2012 change path from /opt/jp to /opt/jp*, it will catch also jp and jp511
# 14.10.13 path changed to  /opt

dzisiaj=`/bin/date +%F`
wczoraj=`/bin/date -d yesterday +%F`
przedwczoraj=`/bin/date -d "2 days ago" +%F`
sciezka="/opt/*"
log=/root/checksum/${dzisiaj}.log

mkdir -p /root/checksum/ /var/log/checksum 2>/dev/null
/usr/bin/find ${sciezka} -type f -exec md5sum {} \; >/var/log/checksum/checksum-${dzisiaj}.log
# tutaj bzipuje historie, czasem przydatne zeby zrobic bzgrep, przekierowanie wyjscia, bo czasem odpalam z reki zeby sprawdzic szybciej
/usr//bin/bzip2 /var/log/checksum/checksum-${przedwczoraj}.log >/dev/null 2>&1

echo "=== roznice w plikach w ${sciezka} pomiedzy ${wczoraj} a ${dzisiaj} ==="  >$log
/usr/bin/diff \
/var/log/checksum/checksum-${wczoraj}.log \
/var/log/checksum/checksum-${dzisiaj}.log | \
/usr/bin/awk '{print $3}'|/usr/bin/sort | /usr/bin/uniq \
| grep -v "/log/" \
| grep -v "/logs/usemon" \
| grep -v "/tmp/" \
| grep -v "/work/" \
| grep -v "/opt/flopsar/pjpor1.PortalPBC.log" \
| grep -v "/data/" >> $log
