#!/bin/bash
vgchange -ay

DEVICE_FS=`blkid -o value -s TYPE ${DEVICE}` #these going to retur the FS of DEVICE
if ["`echo -n $DEVICE_FS`"==""];then #if it dosen't contient a file system
        pvcreate ${DEVICE}
        vgcreate data ${DEVICE} #create volume group data
        lvcreate --name volume1 -l -100%FREE data  #create logical volume volume1
        mkfs.ext4 /dev/data/volume1 #create file system ext4
fi
mkdir -p /data #create data directory, -p if exist don't create
echo '/dev/data/volume1 /data ext4 defaults 0 0' >> /etc/fastab
mount /data