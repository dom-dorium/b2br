#!/bin/bash

ARC=$(uname -a)
CPU_P=$(nproc)
CPU_V=$(cat /proc/cpuinfo | grep processor | wc -l)
MEM=$(free -m | awk 'NR==2{printf("%d/%dMB (%.2f%%)", $3, $2, $3/$2*100)}')
DISK=$(df -h | awk 'NR==4{printf("%.2f/%.2fGB (%.2f%%)", $3, $2, $5)}')
CPU_L=$(mpstat | awk 'NR==4{printf("%.2f%%", $4)}')
BOOT=$(who -b | awk 'NR==1{printf("%s %s", $3, $4)}')
TEMP=$(lsblk | grep lvm | wc -l)
LVM=$(if [ "$TEMP" -gt 0 ]; then echo yes; else echo no; fi)
TCP=$(netstat -an | grep ESTABLISHED | wc -l)
USER=$(who | cut -d " " -f 1 | sort -u | wc -l)
IP=$(hostname -I)
MAC=$(awk 'NR==1{printf("%s",$1)}' /sys/class/net/*/address)
SUDO=$(cat /var/log/sudo/sudo.log | grep -a TSID | wc -l)

wall "
Architecture: $ARC
CPU Physical: $CPU_P
vCPU: $CPU_V
Memory Usage: $MEM
Disk Usage: $DISK
CPU Load: $CPU_L
Last Boot: $BOOT
LVM Use: $LVM
Connexions TCP: $TCP ESTABLISHED
User Log: $USER
Network: IP $IP MAC $MAC
Sudo: $SUDO cmd
"
