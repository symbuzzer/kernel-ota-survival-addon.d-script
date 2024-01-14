#!/sbin/sh
#
# ADDOND_VERSION=2
#
# /system/addon.d/98-kernel.sh
# v1.0.1 by symbuzzer
# Based on LineageOS' addon.d script, modified by Simon1511@XDA and symbuzzer@XDA
#

. /tmp/backuptool.functions &

Date=$(date '+%Y%m%d')

# This file only exists if the user is rooted with Magisk
# We don't want Magisk to override Kernel
if [ -f /tmp/addon.d/99-magisk.sh ]; then
    chmod -x /tmp/addon.d/99-magisk.sh
fi

case "$1" in
  backup)
    dd if=/dev/block/bootdevice/by-name/boot of=/tmp/kernel_backup-"$Date".img
    dd if=/dev/block/bootdevice/by-name/boot_a of=/tmp/kernel_backup-a-"$Date".img
    dd if=/dev/block/bootdevice/by-name/boot_b of=/tmp/kernel_backup-b-"$Date".img

  ;;
  restore)
    sleep 5 && dd if=/tmp/kernel_backup-"$Date".img of=/dev/block/bootdevice/by-name/boot &
    sleep 5 && dd if=/tmp/kernel_backup-a-"$Date".img of=/dev/block/bootdevice/by-name/boot_a &
    sleep 5 && dd if=/tmp/kernel_backup-b-"$Date".img of=/dev/block/bootdevice/by-name/boot_b &
  ;;
esac
