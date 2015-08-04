
cp /etc/shadow /etc/shadow.orig.oid.$(date +'%s')
cp /etc/passwd /etc/passwd.orig.oid.$(date +'%s')
cp /etc/group /etc/group.orig.oid.$(date +'%s')
userdel mliszka
groupdel mliszka
find /  ! -path '/root/*' ! -path '/sys/*' ! -path '/dev/*' ! -path '/proc/*' ! -path '/selinux/*' -uid 513 | while read line;do echo $line;chown 11002 $line;done
find /  ! -path '/root/*' ! -path '/sys/*' ! -path '/dev/*' ! -path '/proc/*' ! -path '/selinux/*' ! -path '/var/run/*' -gid 513 | while read line;do echo $line;chgrp 11002 $line;done
userdel mkalbarczyk
groupdel mkalbarczyk
find /  ! -path '/root/*' ! -path '/sys/*' ! -path '/dev/*' ! -path '/proc/*' ! -path '/selinux/*' -uid 514 | while read line;do echo $line;chown 11004 $line;done
find /  ! -path '/root/*' ! -path '/sys/*' ! -path '/dev/*' ! -path '/proc/*' ! -path '/selinux/*' ! -path '/var/run/*' -gid 514 | while read line;do echo $line;chgrp 11004 $line;done
userdel pzegarlicki
groupdel pzegarlicki
find /  ! -path '/root/*' ! -path '/sys/*' ! -path '/dev/*' ! -path '/proc/*' ! -path '/selinux/*' -uid 501 | while read line;do echo $line;chown 11001 $line;done
find /  ! -path '/root/*' ! -path '/sys/*' ! -path '/dev/*' ! -path '/proc/*' ! -path '/selinux/*' ! -path '/var/run/*' -gid 501 | while read line;do echo $line;chgrp 11001 $line;done
userdel appadm
groupdel appadm
userdel tlaskowski
groupdel tlaskowski
find /  ! -path '/root/*' ! -path '/sys/*' ! -path '/dev/*' ! -path '/proc/*' ! -path '/selinux/*' -uid 511 | while read line;do echo $line;chown 11007 $line;done
find /  ! -path '/root/*' ! -path '/sys/*' ! -path '/dev/*' ! -path '/proc/*' ! -path '/selinux/*' ! -path '/var/run/*' -gid 511 | while read line;do echo $line;chgrp 11007 $line;done
userdel apielasa
groupdel apielasa
find /  ! -path '/root/*' ! -path '/sys/*' ! -path '/dev/*' ! -path '/proc/*' ! -path '/selinux/*' -uid 504 | while read line;do echo $line;chown 11003 $line;done
find /  ! -path '/root/*' ! -path '/sys/*' ! -path '/dev/*' ! -path '/proc/*' ! -path '/selinux/*' ! -path '/var/run/*' -gid 504 | while read line;do echo $line;chgrp 11003 $line;done
userdel mwisniewski
groupdel mwisniewski
find /  ! -path '/root/*' ! -path '/sys/*' ! -path '/dev/*' ! -path '/proc/*' ! -path '/selinux/*' -uid 512 | while read line;do echo $line;chown 11005 $line;done
find /  ! -path '/root/*' ! -path '/sys/*' ! -path '/dev/*' ! -path '/proc/*' ! -path '/selinux/*' ! -path '/var/run/*' -gid 512 | while read line;do echo $line;chgrp 11005 $line;done

cp /etc/ldap.conf /etc/ldap.conf.old.$(date +'%s')

cp /etc/openldap/ldap.conf /etc/openldap/ldap.conf.old.$(date +'%s')

rm /etc/ldap.conf


ln -s /etc/openldap/ldap.conf /etc/ldap.conf

chmod 644 /etc/openldap/ldap.conf



echo 'jA0EAwMC1zvFJ+DgMWNgycDA6zN03qwHZPbduzkau7xCWJ1i/AL5ka3eSLhLtwpCOeVYCSUKzCMm
nsgi6fNo6wpXlld/jbzmYO97Xe63w6qYzfONwdK14eWcBAdIiX8IznvHR/nrXGs6PaKtG0UAonSD
OrebmzMr7ul/ZZvQ0EtmmkPwJslPIOcSzd5hPrxD2RtHawzpnmciMDpusDAq5sUDXN7bIg0SDA91
eXEDUCv3hN9tKHCnMejQxzWLOLqGH4KxAND2ro7BhL1pYSggpBBhlmRbHehbVDW5gLqgOfzio8W4
dFvXoTUHq1zYwmzNAWKvRbtLJLYxfD/4TpMtqZ/rmhYephefR2VyQPFH2UOF55o60y4Edo2rAAzU
tDD9Vkg7aWDDll2ieZr/vboR0dOhb3AwfzOI/ywTgjP195wuxXzd+gP3mJbf4axWC/7pGaolWreB
lUGd+ogS5UGX/AGcGxkY+9PYYePyYb7c+xE7czj14bVodROeisZLJ8IN7Ujts0CDnk3vngfDn4pV
+lpn
'| base64 -d -i  | gpg -d >/etc/openldap/ldap.conf


echo ' -----BEGIN CERTIFICATE-----
MIIDRzCCAwWgAwIBAgIETw7JDTALBgcqhkjOOAQDBQAwgYYxCzAJBgNVBAYTAlBM
MRQwEgYDVQQIEwtNYXpvd2llY2tpZTERMA8GA1UEBxMIV2Fyc3phd2ExHzAdBgNV
BAoTFkZpcnN0IERhdGEgUG9sc2thIFMuQS4xDTALBgNVBAsTBFBFU0kxHjAcBgNV
BAMTFXBvbG9pZC5wb2xjYXJkLmNvbS5wbDAeFw0xMjAxMTIxMTUwMzdaFw0xNDAx
MTExMTUwMzdaMIGGMQswCQYDVQQGEwJQTDEUMBIGA1UECBMLTWF6b3dpZWNraWUx
ETAPBgNVBAcTCFdhcnN6YXdhMR8wHQYDVQQKExZGaXJzdCBEYXRhIFBvbHNrYSBT
LkEuMQ0wCwYDVQQLEwRQRVNJMR4wHAYDVQQDExVwb2xvaWQucG9sY2FyZC5jb20u
cGwwggG3MIIBLAYHKoZIzjgEATCCAR8CgYEA/X9TgR11EilS30qcLuzk5/YRt1I8
70QAwx4/gLZRJmlFXUAiUftZPY1Y+r/F9bow9subVWzXgTuAHTRv8mZgt2uZUKWk
n5/oBHsQIsJPu6nX/rfGG/g7V+fGqKYVDwT7g/bTxR7DAjVUE1oWkTL2dfOuK2HX
Ku/yIgMZndFIAccCFQCXYFCPFSMLzLKSuYKi64QL8Fgc9QKBgQD34aCF1ps93su8
q1w2uFe5eZSvu/o66oL5V0wLPQeCZ1FZV4661FlP5nEHEIGAtEkWcSPoTCgWE7fP
CTKMyKbhPBZ6i1R8jSjgo64eK7OmdZFuo38L+iE1YvH7YnoBJDvMpPG+qFGQiaiD
3+Fa5Z8GkotmXoB7VSVkAUw7/s9JKgOBhAACgYApI8VAIANp9PJc92s9vIPeQgHR
02fICvBN9fmJISHA3glIpzdJ/zhTEZ+sG6C2IqL7CT31og9EgRvGUP4mOxr9CPlJ
Y9hNxPPcj2+JSpOWDePuqBI5TAzw6UbqE11E7rXnwzak0dzmCl5EbhoMF3Ibv7aS
UlRbpl7LDYqKcTmsOzALBgcqhkjOOAQDBQADLwAwLAIUDq958KSBz3PBiHcQZ4f0
8qVvrDMCFGZdJ14PgpT2QnZzkZuSc6oK4ko2
-----END CERTIFICATE-----
' >/etc/openldap/cacerts/oidvirt

cp /etc/pam.d/system-auth /etc/pam.d/system-auth.orig.oid.$(date +'%s')

cp /etc/pam.d/sshd /etc/pam.d/sshd.orig.oid.$(date +'%s')

echo '
#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authconfig is run.
auth        required      pam_env.so
auth        sufficient    pam_unix.so nullok try_first_pass
auth        requisite     pam_succeed_if.so uid >= 500 quiet
auth        sufficient    pam_ldap.so use_first_pass 
auth        required      pam_deny.so


account     sufficient    pam_ldap.so

account     required      pam_unix.so broken_shadow
account     sufficient    pam_localuser.so
account     sufficient    pam_succeed_if.so uid < 500 quiet
#account     [default=bad success=ok user_unknown=ignore] pam_ldap.so
account     required      pam_permit.so

password    requisite     pam_cracklib.so try_first_pass retry=3 minlen=10 lcredit=1 ucredit=1 ocredit=1 remember=10
password    sufficient    pam_unix.so md5 shadow nullok try_first_pass use_authtok debug
password    sufficient    pam_ldap.so use_authtok debug
password    required      pam_deny.so

session    required    pam_mkhomedir.so skel=/etc/skel/ umask=0022
session     required      pam_limits.so
session     sufficient      pam_ldap.so
session     optional      pam_keyinit.so revoke
session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid
session     required      pam_unix.so
' >/etc/pam.d/system-auth

echo '
#%PAM-1.0
auth required pam_listfile.so onerr=fail item=group sense=allow file=/etc/login.group.allowed
auth       include      system-auth
account    required     pam_nologin.so
account    include      system-auth
password   include      system-auth
session    optional     pam_keyinit.so force revoke
session    include      system-auth
session    required     pam_loginuid.so

' >/etc/pam.d/sshd

echo '
root
wheel
appadm
oraadm
osadm
jboss

' >/etc/login.group.allowed

cp /etc/nsswitch.conf /etc/nsswitch.conf.oid.orig.$(date +'%s')
echo '
#%PAM-1.0
auth required pam_listfile.so onerr=fail item=group sense=allow file=/etc/login.group.allowed
auth       include      system-auth
account    required     pam_nologin.so
account    include      system-auth
password   include      system-auth
session    optional     pam_keyinit.so force revoke
session    include      system-auth
session    required     pam_loginuid.so

' >/etc/pam.d/sshd

echo '
root
wheel
appadm
oraadm
osadm
jboss

' >/etc/login.group.allowed

cp /etc/nsswitch.conf /etc/nsswitch.conf.oid.orig.$(date +'%s')

echo '
#
# /etc/nsswitch.conf
#
# An example Name Service Switch config file. This file should be
# sorted with the most-used services at the beginning.
#
# The entry '[NOTFOUND=return]' means that the search for an
# entry should stop if the search in the previous entry turned
# up nothing. Note that if the search failed due to some other reason
# (like no NIS server responding) then the search continues with the
# next entry.
#
# Legal entries are:
#
#       nisplus or nis+         Use NIS+ (NIS version 3)
#       nis or yp               Use NIS (NIS version 2), also called YP
#       dns                     Use DNS (Domain Name Service)
#       files                   Use the local files
#       db                      Use the local database (.db) files
#       compat                  Use NIS on compat mode
#       hesiod                  Use Hesiod for user lookups
#       [NOTFOUND=return]       Stop searching if not found so far
#

# To use db, put the db in front of files for entries you want to be
# looked up first in the databases
#
# Example:
#passwd:    db files nisplus nis
#shadow:    db files nisplus nis
#group:     db files nisplus nis

passwd:     ldap files
shadow:     ldap files
group:      ldap files
#hosts:     db files nisplus nis dns
hosts:      files dns

# Example - obey only what nisplus tells us...
#services:   nisplus [NOTFOUND=return] files
#networks:   nisplus [NOTFOUND=return] files
#protocols:  nisplus [NOTFOUND=return] files
#rpc:        nisplus [NOTFOUND=return] files
#ethers:     nisplus [NOTFOUND=return] files
#netmasks:   nisplus [NOTFOUND=return] files     

bootparams: nisplus [NOTFOUND=return] files

ethers:     files
netmasks:   files
networks:   files
protocols:  files
rpc:        files
services:   files

netgroup:   nisplus

publickey:  nisplus

automount:  files nisplus
aliases:    files nisplus

'>/etc/nsswitch.conf

cp /etc/sudoers /etc/sudoers.oid.orig.$(date +'%s')

echo '
%osadm  ALL=(ALL)       ALL
%wheel  ALL=(ALL)       ALL
%oraadm ALL=/bin/su - oracle
' >>/etc/sudoers

