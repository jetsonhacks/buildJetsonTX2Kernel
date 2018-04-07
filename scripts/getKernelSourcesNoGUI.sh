#!/bin/bash
apt-add-repository universe
apt-get update
pkg-config -y
cd /usr/src
wget -N http://developer.download.nvidia.com/embedded/L4T/r28_Release_v2.0/BSP/source_release.tbz2
echo 'Extracting kernel_src.tbz2 from source release'
tar -xvf source_release.tbz2 public_release/kernel_src.tbz2
echo 'Expanding kernel_src.tbz2'
tar -xvf public_release/kernel_src.tbz2
rm -r public_release
cd kernel/kernel-4.4
# Go get the default config file; this becomes the new system configuration
zcat /proc/config.gz > .config

