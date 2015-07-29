#!/bin/bash

# This is a program that accepts an sd card and unmounts it

# Checks if root/sudo
myname=`whoami`
if [ $myname = root ]; then
        echo ""
        echo "Running as root/sudo, proceeding to format script."
        echo "Don't forget to verify the device/partition"
else
        echo "You must be root to run this script"
        echo "Also, don't forget to verify the device/partition"
        exit 1
fi

chmod +x sd_card.sh # Saves the shell script
df -h # Views all devices including partitions on this very computer

# All commands that start with echo are to print texts(Texts in double )
echo "Please check for the name of your sd card beside /dev/ with its corresponding disk size."
echo "E.g. for /dev/sda, 'sda' is the disk name."
echo "Warning! Please confirm the name correctly to avoid BUM!!!"

sleep 1 # Slight pause

echo "Type the SD card name : "
read sd_card_name # Reads user input
echo "You typed" $sd_card_name # Prints user input

umount /dev/$sd_card_name # Unmounts sd card
echo "Unmounting...."
sleep 1.5 # Slight pause
echo "SD Card has been unmounted"

echo "Formatting SD Card"
mkfs.vfat /dev/$sd_card_name

export image_destination=/home/mahir/Documents/Gnosis
echo "Initiating Installation of Rapsbian OS."
#cd 
#cd $image_destination
echo "Installing..."
dd bs=4M if=$image_destination/2015-05-05-raspbian-wheezy.img of=/dev/$sd_card_name

sync
umount /dev/$sd_card_name
