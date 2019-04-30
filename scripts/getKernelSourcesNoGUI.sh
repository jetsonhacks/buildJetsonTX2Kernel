#!/bin/bash
apt-add-repository universe
apt-get update
apt-get install pkg-config -y
cd /usr/src
wget -N https://developer.download.nvidia.com/embedded/L4T/r32_Release_v1.0/jax-tx2/BSP/JAX-TX2-public_sources.tbz2
sudo tar -xvf JAX-TX2-public_sources.tbz2 public_sources/kernel_src.tbz2
tar -xvf public_sources/kernel_src.tbz2
# Space is tight; get rid of the compressed kernel source
rm -r public_sources
cd kernel/kernel-4.9
# Go get the default config file; this becomes the new system configuration
zcat /proc/config.gz > .config

