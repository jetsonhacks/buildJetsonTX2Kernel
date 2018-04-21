#!/bin/bash
apt-add-repository universe
apt-get update
apt-get install pkg-config -y
cd /usr/src
wget -N http://developer.download.nvidia.com/embedded/L4T/r28_Release_v2.0/GA/BSP/tx2_sources.tbz2
sudo tar -xvf tx2_sources.tbz2 public_release/kernel_src.tbz2
tar -xvf public_release/kernel_src.tbz2
# Space is tight; get rid of the compressed kernel source
rm -r public_release
cd kernel/kernel-4.4
# Go get the default config file; this becomes the new system configuration
zcat /proc/config.gz > .config

