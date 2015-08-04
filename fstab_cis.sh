#!/bin/bash
# kmonti 15.07.15
# adds nodev,noexec,nosuid options to fstab on /boot partition, for CIS benchmark
# dodanie opcji montowania do /boot
# example run: ansible hosts -m script -a "./scrfstab.sh " -s -K
# exit code 34 - rollback 
# exit code 19 - zmiana byla juz wykonywana (already changed)

unset rollback
#rollback=1

#[[ $rollback ]] && rm -f  /tmp/fstabbezboot || exit 34
#[[ $rollback ]] && cp -f /tmp/fstab /etc/fstab && exit 0
[[ -f /tmp/fstabbezboot ]] && exit 19
  [[ -f /etc/fstab ]] && cp -f /etc/fstab /tmp/fstab.orig # backup
   grep boot /etc/fstab | awk 'BEGIN { $2 ~ /boot/ && $4 ~ /^defaults/ } END { print $1" "$2 "\t" $3" " "defaults,nodev,noexec,nosuid" "\t" "1 2" } ' >/tmp/boot
   grep -v "/boot" /etc/fstab >/tmp/fstabbezboot
   cat /tmp/boot >>/tmp/fstabbezboot
   cp -f /tmp/fstabbezboot /etc/fstab || exit 1
   grep boot /etc/fstab | grep nosuid || exit 2
   mount -o remount,rw /boot ||exit 3
exit 0

