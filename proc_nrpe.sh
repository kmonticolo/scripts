#!/bin/bash

# kmonti 04.08.15
# get the list of toptalkers from nagios server:
# root@nagios archives]# export LC_LANG=C;grep -i "kmonticolo.*notify-by-email;PROCS" /usr/local/nagios/var/archives/nagios-07-*2015*|cut -d\; -f 2|sort |uniq -c|sort -rn|head
# script changes process counts in NRPE Nagios configuration
# skrypt zmienia (dodaje lub odejmuje o zadany parametr) liczbe procesow w konfiguracji procs nrpe
# example check: ansible hosts -m script -a "./scrprocnrpe.sh spr" -s -K
# example run: ansible hosts -m script -a "./scrprocnrpe.sh 30" -s -K
#
# sprawdzenie ile jest procesow:
# ansible hosty -m script -a "./scrprocnrpe.sh spr" -s -K
# zmiana konfiguracji
# ansible hosty -m script -a "./scrprocnrpe.sh 30" -s -K

nrpe=/etc/nagios/nrpe.cfg
unset rollback
# ustaw zmienna rollback ponizej, jak chcesz wrocic
#rollback=1
[[ -z $1 ]] && {
  echo $0: ustaw parametr np. "30" lub "spr" dla sprawdzenia ilosci procesow
  exit 1
}
# wyciagniecie wartosci crit i warn z configu nrpe
warn=$(grep PROCS $nrpe|awk -F "-w" '{print $2}'|cut -f2 -d " ")
crit=$(grep PROCS $nrpe|awk -F "-c" '{print $2}'|cut -f2 -d " ")
mod=$1
# spradzenie czy zmienna jest numerem
re='^[0-9]+$' 
if ! [[ $mod =~ $re ]] ; then
   if [[ $mod == "spr" ]]; then
[[ ! $warn ]] && warn=null
[[ ! $crit ]] && crit=null
      echo -n "aktualne: `ps aux|wc -l`, warning: $warn, critical: $crit"
      exit 0
   fi
   echo "error: Not a number, user a number or spr" >&2; exit 2
fi
[[ $rollback ]] && { 
  mv -f ${nrpe}.old  $nrpe
  /etc/init.d/nrpe restart || exit 3
  exit 0
}
[[ -f $nrpe ]] || exit 4
[[ -f ${nrpe}.old ]] && exit 5 # zmiana juz byla robiona
[[ $warn ]] && nwarn=$(($warn + $mod))
[[ $crit ]] && ncrit=$(($crit + $mod))
sed -i.old -e "s/\-w\ ${warn}/\-w\ ${nwarn}/" -e "s/\-c\ ${crit}/\-c\ ${ncrit}/" $nrpe || exit 6
/etc/init.d/nrpe restart || exit 7
exit 0
