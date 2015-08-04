#!/bin/sh
# kopiuje logi z vposow na pollogaccess01
date=`date -r \`expr $(date +%s) - 86400\` +%F`
if [ $1 ] ; then date=$1 ; fi
scp -r polecommapp01:{/var/log/jboss/server.log.${date},/var/log/jboss/server.log.${date}.gz,/var/log/jboss/server.log} vposlogi/node01
scp -r polecommapp02:{/var/log/jboss/server.log.${date},/var/log/jboss/server.log.${date}.gz,/var/log/jboss/server.log} vposlogi/node02
gzip /home/kmonticolo/vposlogi/node*/*
scp -r vposlogi pollogaccess01:
rm -rf vposlogi/node*/*
echo "Jezeli puszczasz skrypt recznie nie zapomnij odpalic skryptu /home/kmonticolo_adm/mvvposlogi.sh  na pollogaccess01!"
