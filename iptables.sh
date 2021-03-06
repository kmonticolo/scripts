#!/bin/sh


a=./iptables-wynik
>$a

cat >$a <<EOF
# Generated by kmonticolo
*filter
:INPUT ACCEPT [433241:108472946]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [399135:382430708]
:LOGGING - [0:0]
-A INPUT -i lo -j ACCEPT
-A OUTPUT -o lo -j ACCEPT

EOF

for i in `cat /tmp/x`;do
echo " -A INPUT -s $i -p tcp -m tcp --dport 21 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT" >>$a
done
echo >>$a

for i in `cat /tmp/x`;do
echo " -A INPUT -s $i -p tcp -m tcp --dport 20 -m conntrack --ctstate ESTABLISHED -j ACCEPT" >>$a
done
echo >>$a

for i in `cat /tmp/x`;do
echo " -A INPUT -s $i -p tcp -m tcp --sport 1024: --dport 1024: -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT" >>$a
done
echo >>$a

for i in `cat /tmp/x`;do
echo " -A OUTPUT -d $i -p tcp -m tcp --sport 21 -m conntrack --ctstate ESTABLISHED -j ACCEPT" >>$a
done
echo >>$a

for i in `cat /tmp/x`;do
echo " -A OUTPUT -d $i -p tcp -m tcp --sport 20 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT" >>$a
done
echo >>$a

for i in `cat /tmp/x`;do
echo " -A OUTPUT -d $i -p tcp -m tcp --sport 1024:65535 --dport 1024:65535 -m conntrack --ctstate ESTABLISHED -j ACCEPT" >>$a
done
echo >>$a

cat >>$a <<EOF

-A INPUT -p tcp -m tcp --dport 21 -m state --state NEW,ESTABLISHED -j LOGGING
-A LOGGING -p tcp -m tcp --dport 21 -j LOG --log-prefix "FTP iptables RST"

-A INPUT -p tcp -m tcp --dport 21 -j REJECT --reject-with icmp-port-unreachable

COMMIT
# Completed on `date`

EOF

