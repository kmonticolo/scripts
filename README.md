# scripts
Just a bunch of scripts:
- audit-evidence.txt - commands used for couple of security test
-  checkOS.sh - functions for variety security check like: check_pam; check_pass; check_pass2; check_ntp; check_envision; check_fstab; if [[ `selinuxenabled`==0 ]];then echo 'selinux ok'; else echo 'ERRor set selinux';fi check_ssh; check_banner; check_xinetd; check_ossec; check_initd;
- copyvposlog.sh - scp logs to logserver
- fstab_cis.sh - adds nodev,noexec,nosuid options to /etc/fstab on /boot partition, for CIS benchmark
- fullbackup.sh - simple TSM backup script
- iptables.sh - quick and dirty script that creates simple iptabes rules 
- openbsd-kernel-vmguest.sh - disables some options in kernel, that OpenBSD runs faster as a vm guest
- proc_nrpe.sh - script manipulates "warn" and "crit" process counts in NRPE Nagios configuration, convenient to run as ansible script
- testcvs.sh - script for test speed of ANONCVS servers response for OpenBSD, an easy way to get the fastest ANONCVS server

