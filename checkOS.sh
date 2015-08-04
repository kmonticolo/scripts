#!/bin/bash
function check_ () {
#a=$1;
a=`echo $1| tr '[:upper:]' '[:lower:]'`;
b=`echo $2| tr '[:upper:]' '[:lower:]'`;
c=$3;
if [[ `echo "$a" | grep "$b" |wc   -l` > 0 ]];then
echo ' ok';
return 0;
else 
echo 
echo "Error connected with $b";
echo $c;
return 1; 
fi

}
####
function check_pam () {
a=`cat /etc/pam.d/system-auth | sed 's/[ \t][ \t]*/\ /g'`;
echo -n "Start checking system-auth";
ilosc=0;
if [[ $? == 0 ]];then 
check_ "$a" "remember=10" "should be: password    requisite     pam_unix.so remember=10"; let ilosc=$ilosc+$?;
check_ "$a" "minlen=8" "should be: password    requisite     pam_cracklib.so try_first_pass retry=3 minlen=10 lcredit=1 ucredit=1 ocredit=1"; let ilosc=$ilosc+$?;
check_ "$a" "lcredit=1" "should be: password    requisite     pam_cracklib.so try_first_pass retry=3 minlen=10 lcredit=1 ucredit=1 ocredit=1"; let ilosc=$ilosc+$?;
check_ "$a" "ocredit=1" "should be: password    requisite     pam_cracklib.so try_first_pass retry=3 minlen=10 lcredit=1 ucredit=1 ocredit=1"; let ilosc=$ilosc+$?;
check_ "$a" "ucredit=1" "should be: password    requisite     pam_cracklib.so try_first_pass retry=3 minlen=10 lcredit=1 ucredit=1 ocredit=1"; let ilosc=$ilosc+$?;


echo "Number of errors: ${ilosc}";
else
echo "ERROR checking pam configuration";
fi
}


####
function check_pass () {
a=`cat /etc/login.defs | sed 's/[ \t][ \t]*/\ /g'`;
echo -n "Start checking login.defs";
ilosc=0;
if [[ $? == 0 ]];then 
check_ "$a" "PASS_MAX_DAYS 90" "should be: PASS_MAX_DAYS 90"; let ilosc=$ilosc+$?;


echo "Number of errors: ${ilosc}";
else
echo "ERROR checking pam configuration";
fi
}

##############
function check_pass2 () {
echo 'List of users with passdate';
for i in `cat /etc/passwd | sed 's/:.*//g'`;do echo -n "$i  ";chage -l $i| grep "Maximum number of days between password change"|sed 's/Maximum number of days between password change//g';done

}
####
function check_ntp () {
a=`cat /etc/ntp.conf | sed 's/[ \t][ \t]*/\ /g'`;
echo -n "Start checking ntp";
ilosc=0;
if [[ $? == 0 ]];then 
check_ "$a" "server 193.109.115.2" "should be: server 193.109.115.2"; let ilosc=$ilosc+$?;
check_ "$a" "server 193.109.115.3" "should be: server 193.109.115.3"; let ilosc=$ilosc+$?;


echo "Number of errors: ${ilosc}";
else
echo "ERROR checking pam configuration";
fi
}

##############
####
function check_envision () {
a=`cat /etc/syslog.conf | sed 's/[ \t][ \t]*/\ /g'`;
echo -n "Start checking ntp";
ilosc=0;
if [[ $? == 0 ]];then 
check_ "$a" "192.168.20.97" 'should be: \*\.* @192.168.20.97'; let ilosc=$ilosc+$?;


echo "Number of errors: ${ilosc}";
else
echo "ERROR checking pam configuration";
fi
}

####
function check_fstab () {
a=`cat /etc/fstab | sed 's/[ \t][ \t]*/\ /g'`;
echo -n "Start checking fstab";
ilosc=0;
if [[ $? == 0 ]];then 
check_ "$a" "noexec" 'should be: noexec; let ilosc=$ilosc+$?;
check_ "$a" "nodev" 'should be: nodev; let ilosc=$ilosc+$?;
check_ "$a" "nosuid" 'should be: nosuid; let ilosc=$ilosc+$?;
check_ "$a" "nouser" 'should be: nouser; let ilosc=$ilosc+$?;


echo "Number of errors: ${ilosc}";
else
echo "ERROR checking pam configuration";
fi
}
##############
####
function check_ssh () {
a=`cat /etc/ssh/sshd_config | sed 's/[ \t][ \t]*/\ /g'`;
echo -n "Start checking ssh";
ilosc=0;
if [[ $? == 0 ]];then 
check_ "$a" "LogLevel debug" 'should be: LogLevel debug'; let ilosc=$ilosc+$?;
check_ "$a" "permitrootlogin no" 'should be: Permitrootlogin no'; let ilosc=$ilosc+$?;
check_ "$a" "rhostsrsaauthenctication no" 'should be: rhostsrsaauthenctication no'; let ilosc=$ilosc+$?;
check_ "$a" "hostbasedauthentication no" 'should be: hostbasedauthentication no'; let ilosc=$ilosc+$?;
check_ "$a" "ignorerhosts no" 'should be: ignorerhosts no'; let ilosc=$ilosc+$?;
check_ "$a" "permitemptypasswords no" 'should be: permitemptypasswords no'; let ilosc=$ilosc+$?;


echo "Number of errors: ${ilosc}";
else
echo "ERROR checking pam configuration";
fi
}

####
function check_banner () {
a=`cat /etc/issue.net | sed 's/[ \t][ \t]*/\ /g'`;
echo -n "Start checking fstab";
ilosc=0;
if [[ $? == 0 ]];then 
check_ "$a" "redhat" 'should be: clear version in /etc/issue.net redhat'; let ilosc=$ilosc+$?;
echo "Number of errors: ${ilosc}";
else
echo "ERROR checking pam configuration";
fi

}
################
function check_xinetd () {
for i in `find /etc/xinetd.d/ -type f`;do echo $i;cat $i |sed 's/[\t ][\t ]*//g' | tr '[:upper:]' '[:lower:]'| grep disable=yes;done 

}
################
function check_ossec () {
if [[ -e /etc/init.d/ossec ]]; then 
echo 'Ossec OK';
else
echo 'ERRor ossec not installed';
fi


}

function check_initd () {
echo 'Error initd';
chkconfig --list | grep on | grep -v crond | grep -v firstboot | grep -v irqbalance | grep -v messagebus | grep -v nfs | grep -v ntpd | grep -v restorecond | grep -v ssh | grep -v syslog | grep -v sysstat  | grep -v yum-updatesd

}
####################################################################################################
check_pam;
check_pass;
check_pass2;
check_ntp;
check_envision;
check_fstab;
if [[ `selinuxenabled`==0 ]];then echo 'selinux ok'; else echo 'ERRor set selinux';fi 
check_ssh;
check_banner;
check_xinetd;
check_ossec;
check_initd;


exit 0;
