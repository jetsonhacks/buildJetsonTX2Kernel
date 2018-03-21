#!/bin/bash
apt-add-repository universe
apt-get update
apt-get install qt5-default pkg-config -y
cd /usr/src
wget http://developer.download.nvidia.com/embedded/L4T/r28_Release_v2.0/BSP/source_release.tbz2
echo 'Extracting kernel_src.tbz2 from source release'
tar -xvf source_release.tbz2 public_release/kernel_src.tbz2
echo 'Expanding kernel_src.tbz2'
tar -xvf public_release/kernel_src.tbz2
cd kernel/kernel-4.4
zcat /proc/config.gz > .config
# Ready to configure kernel
make xconfig

