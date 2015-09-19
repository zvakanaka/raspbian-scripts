#!/bin/bash
# IMPORTANT: This script is to be ran from a separate computer.
#            Put your important files in the same directory as 
#            this script.
#
# Author: Adam Quinton
# License:
#      Copyright (C) 2015 Raspbian-Scripts - BSD License
# Taken from Author of Slitaz Pi Installation:
#      Christophe Lincoln <pankso@slitaz.org>
#      Copyright (C) 2012-2014 SliTaz ARM - BSD License

dev="$1"
mountpoint="/media/rpi/"

# Only for root
if [ $(id -u) != 0 ]; then
	echo "ERROR: Must be root" && exit 0
fi

# Usage: colorize NB "Message"
colorize() {
	echo -e "\\033[1;${1}m${2}\\033[0;39m"
}

separator() {
	echo "================================================================================"
}

status() {
	if [ "$?" = 0 ]; then
		colorize 32 " OK"
	else
		colorize 31 " ERROR"
	fi
}

umount_sd() {
	umount /dev/${dev}1 2>/dev/null || exit 1
	umount /dev/${dev}2 2>/dev/null || exit 1
}

#
# Let's start
#
clear
cat << EOT

$(colorize 35 "Raspberry Pi Re-Setup")
$(separator)
Before using please read the howto on: 

  http://www.github.com/zvakanaka/raspbian-scripts

EOT

# SD card check
if [ ! "$dev" ]; then
	echo -n "SD card disk name (ex sdc): "; read dev
fi
[ ! "$dev" ] && exit 1
if ! fdisk -l | grep -q "/dev/${dev}2"; then
	echo "Unable to find: /dev/${dev}2"; exit 1
fi

# Mount
if mount | grep -q "^/dev/$dev[1-2]"; then
	umount_sd
fi
echo -n "Mounting: /dev/$dev partition..."
mkdir -p ${mountpoint}
mount /dev/${dev}2 ${mountpoint} || exit 1; status

# Install
echo -n "Copying: wpa supplicant configuration"
cp -a wpa_supplicant.conf ${mountpoint}/etc/wpa_supplicant; status
echo -n "Copying: interfaces configuration"
cp -a interfaces ${mountpoint}/etc/network/interfaces; status

# Unmount
echo -n "Unmounting: RPi sdcard..."
umount_sd; status
separator
echo "Insert the SD card into your Raspberry Pi and boot!"
echo ""
exit 0
