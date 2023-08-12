# Raspberry Pi Server Deployment

Note: This has been tested with Ubuntu 22.04 on MacOS with Raspberry Pi 4 Only

## Overview

This script will retrieve and deploy an Ubuntu OS to an SD card for booting a
Raspberry Pi 4. It will download the image from Ubuntu and cache it for future
use.

The script should be run as a standard user and will prompt for a password when
required. This is to ensure that cached artifacts are owned by the user rather
than root.

## Usage

1. Update user-data and network-config with the correct values in files
2. Run `./create_disk.sh` as a standard user
3. When prompted for Disk enter only the device identifier (ex. disk4)

``` bash
> ./create_disk.sh
/dev/disk0 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *4.0 TB     disk0
   1:             Apple_APFS_ISC Container disk1         524.3 MB   disk0s1
   2:                 Apple_APFS Container disk3         4.0 TB     disk0s2
   3:        Apple_APFS_Recovery Container disk2         5.4 GB     disk0s3

/dev/disk3 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +4.0 TB     disk3
                                 Physical Store disk0s2
   1:                APFS Volume Macintosh HD            9.1 GB     disk3s1
   2:              APFS Snapshot com.apple.os.update-... 9.1 GB     disk3s1s1
   3:                APFS Volume Preboot                 4.8 GB     disk3s2
   4:                APFS Volume Recovery                804.4 MB   disk3s3
   5:                APFS Volume Data                    648.4 GB   disk3s5
   6:                APFS Volume VM                      20.5 KB    disk3s6

/dev/disk4 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *128.2 GB   disk4
   1:             Windows_FAT_32 system-boot             268.4 MB   disk4s1
   2:                      Linux                         127.9 GB   disk4s2

Disk (ex. disk4): disk4
.cache/ubuntu-22.04.3-preinstalled-server-arm64+raspi.img.xz: OK
Confirm writing disk (y/N): y
Unmounting Disk
Password:
Unmount of all volumes on disk4 was successful
Decompressing img file
.cache/ubuntu-22.04.3-preinstalled-server-arm64+raspi.img.xz: OK
Writing img to /dev/rdisk4
  4243587072 bytes (4244 MB, 4047 MiB) transferred 64.024s, 66 MB/s
4079+0 records in
4079+0 records out
4277141504 bytes transferred in 64.544772 secs (66266273 bytes/sec)
Creating TEMP directory
Mounting disk to /var/folders/5d/jt9tp78j0s3dtkg_prp5v_wh0000gn/T/tmp.Gi5rithf
Unmount of all volumes on disk4 was successful
Volume system-boot on /dev/disk4s1 mounted
Copying files to disk
files/network-config -> /var/folders/5d/jt9tp78j0s3dtkg_prp5v_wh0000gn/T/tmp.Gi5rithf/network-config
files/user-data -> /var/folders/5d/jt9tp78j0s3dtkg_prp5v_wh0000gn/T/tmp.Gi5rithf/user-data
Unmounting disk4
Volume system-boot on disk4s1 unmounted
Remove TEMP directory
```

## Change the Image

The script has only been tested with Ubuntu 22.04 but should be usable for
other versions.

1. Find the URL and Hash of the Ubuntu RPI image: https://ubuntu.com/download/raspberry-pi
2. Update the HASH and URL variables
