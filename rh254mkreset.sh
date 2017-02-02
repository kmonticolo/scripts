#!/bin/bash
# kmonticolo 16.01.17
num=`hostname -s|grep -o '.$'`
#if [ -z ${num} ]; then
#  echo "please provide number of your workstation."
#  exit 1
#fi
re='^[0-9]$'
if [[ ! $num =~ $re ]] ; then
  echo "please provide number of your workstation."
  exit 1
fi
export num=$1
mkdir -p ~/bin
cat > ~/bin/reset.sh <<EOT
#!/bin/sh
echo "Reset desktop and server, wait 30 s."
flag=""
echo y|rht-vmctl reset desktop >/dev/null 2>&1 || flag="desktop"
echo y|rht-vmctl reset server  >/dev/null 2>&1 || flag="server"
if [ ! -z \${flag} ]; then
  echo "ERROR: cannot restart \${flag}, exiting"
  exit 1
fi

~/bin/keys.sh
#ssh root@d${num} "rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm; yum install -y facter"
exit 0
EOT
cat > ~/bin/keys.sh <<EOT
#!/bin/sh
rpm --quiet -q epel-release || sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
which sshpass >/dev/null || sudo yum install -y sshpass
sshpass -p 'redhat' ssh-copy-id root@s${num} >/dev/null 2>&1 && echo "type \"s\" to login to server${num}"
sshpass -p 'redhat' ssh-copy-id root@d${num} >/dev/null 2>&1 && echo "type \"d to login to desktop${num}"
EOT
chmod +x ~/bin/*sh
f=~/.bashrc
touch ~/.bashrc
grep -q ^.*PATH=.*~/bin ~/.bashrc || echo "export PATH=$PATH:~/bin" >> $f
grep -qw "alias s${num}=" ${f} || echo "alias s${num}=\"ssh root@s${num}\"" >> ${f}
grep -qw "alias d${num}=" ${f} || echo "alias d${num}=\"ssh root@d${num}\"" >> ${f}
grep -qw "alias s=" ${f} || echo "alias s=\"ssh root@s${num}\"" >> ${f}
grep -qw "alias d=" ${f} || echo "alias d=\"ssh root@d${num}\"" >> ${f}
grep -qw "alias c=" ${f} || echo "alias c=\"ssh root@d${num}\"" >> ${f}
echo "type: source $f"
echo "then type reset.sh to reset both server${num} and desktop${num}"
echo "type \"s\" to login to server\${num}, or \"d\" to login to desktop\${num} without using passwords."

