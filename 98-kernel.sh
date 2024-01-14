#!/sbin/sh
#
# ADDOND_VERSION=2
#
# /system/addon.d/98-kernel.sh
# v1.0.2 by symbuzzer
# Based on LineageOS' addon.d script, modified by Simon1511@XDA and symbuzzer@XDA
#

. /tmp/backuptool.functions &

if [ -f /tmp/addon.d/99-magisk.sh ]; then
    chmod -x /tmp/addon.d/99-magisk.sh
fi

is_ab_device() {
local S="$($GETPROP "ro.boot.slot_suffix")"
local U="$($GETPROP "ro.build.ab_update")"
    if [ -n "$S" -a "$U" = "true" ]; then
        echo "1"
    else
        echo "0"
    fi
}

case "$1" in
  backup)
    if [ "$(is_ab_device)" = "1" ]; then
        slot_suffix=$($GETPROP ro.boot.slot_suffix)
        dd if="/dev/block/bootdevice/by-name/boot$slot_suffix" of="/tmp/kernel_backup.img"
    else
        dd if="/dev/block/bootdevice/by-name/boot" of="/tmp/kernel_backup.img"
    fi
  ;;
  restore)
    if [ "$(is_ab_device)" = "1" ]; then
        slot_suffix=$($GETPROP ro.boot.slot_suffix)
        sleep 5 && dd if="/tmp/kernel_backup.img" of="/dev/block/bootdevice/by-name/boot$slot_suffix" &
    else
        sleep 5 && dd if="/tmp/kernel_backup.img" of="/dev/block/bootdevice/by-name/boot" &
    fi
  ;;
esac
