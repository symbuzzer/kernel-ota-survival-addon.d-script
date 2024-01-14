# kernel OTA-survival addon.d script  

It was developed to backup the existing kernel during the OTA update in ROMs with addon.d feature (usually custom ROMs) and restore it after the update is completed.  

Its purpose is APatch, KernelSU etc. is to ensure that systems operate continuously after OTA updates. However, it will also be useful if kernel developers use it.  

It supports both old boot-only devices and new boot_a, boot_b devices.  

## How to install
*Note: Its purpose is APatch, KernelSU etc. is to ensure that systems operate continuously after OTA updates. However, it will also be useful if kernel developers use it. So under normal conditions; developers, not end users, should use this script. However, if you are an end user and want to install it yourself, you can follow the steps below:*
- Mount system RW from TWRP's mount section
- Copy script file to system_root/system/addon.d folder at set chmod 755
