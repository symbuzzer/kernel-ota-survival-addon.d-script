#!/sbin/sh
#
# ADDOND_VERSION=2
#
# /system/addon.d/98-kernel.sh
# During an OTA upgrade, this script backs up /dev/block/bootdevice/by-name/boot,
# /system is formatted and reinstalled, then the file is restored.
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
    # Backup of the actual kernel
    if grep -qs "/data" /proc/mounts; then
        umount /data
    fi
    mount /data
    dd if=/dev/block/bootdevice/by-name/boot of=/data/kernel_backup-"$Date".img
  ;;
  restore)
    # Restore Kernel
    if grep -qs "/data" /proc/mounts; then
        umount /data
    fi
    mount /data
    sleep 5 && dd if=/data/kernel_backup-"$Date".img of=/dev/block/bootdevice/by-name/boot &
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    # Stub
  ;;
esac
