#!/bin/bash
# Builds the kernel and modules
# Assumes that the .config file is available
cd /usr/src/kernel/kernel-4.4
make prepare
make modules_prepare
# Make alone will build the dts files too
# make -j6
make -j6 Image
make modules
make modules_install

