#!/bin/bash

# kmonti 04.08.15
# script changes process counts in NRPE Nagios configuration
# skrypt zmienia (dodaje lub odejmuje o zadany parametr) liczbe procesow w konfiguracji procs nrpe
# ansible hosts -m script -a "./scrprocnrpe.sh 30" -s -K

nrpe=/etc/nagios/nrpe.cfg
unset rollback
# ustaw zmienna rollback ponizej, jak chcesz wrocic
#rollback=1
[[ -z $1 ]] && {
  echo $0: set parameter, eg. 30
  exit 1
}
mod=$1
[[ $rollback ]] && {
  mv -f ${nrpe}.old  $nrpe
  /etc/init.d/nrpe restart || exit 3
  exit 0
}
[[ -f $nrpe ]] || exit 2
[[ -f ${nrpe}.old ]] && exit 4 # zmiana juz byla robiona
warn=$(grep PROCS $nrpe|awk -F "-w" '{print $2}'|cut -f2 -d " ")
crit=$(grep PROCS $nrpe|awk -F "-c" '{print $2}'|cut -f2 -d " ")
[[ $warn ]] && nwarn=$(($warn + $mod))
[[ $crit ]] && ncrit=$(($crit + $mod))
sed -i.old -e "s/\-w\ ${warn}/\-w\ ${nwarn}/" -e "s/\-c\ ${crit}/\-c\ ${ncrit}/" $nrpe || exit 2
/etc/init.d/nrpe restart || exit 3
exit 0
