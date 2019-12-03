#!/bin/bash
apt-add-repository universe
apt-get update
apt-get install pkg-config -y
cd /usr/src
wget -N https://developer.nvidia.com/embedded/r32-2-3_Release_v1.0/Sources/T186/public_sources.tbz2
sudo tar -xvf public_sources.tbz2 public_sources/kernel_src.tbz2
tar -xvf public_sources/kernel_src.tbz2
# Space is tight; get rid of the compressed kernel source
rm -r public_sources
cd kernel/kernel-4.9
# Go get the default config file; this becomes the new system configuration
zcat /proc/config.gz > .config

