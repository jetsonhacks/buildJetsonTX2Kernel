#!/bin/bash
# Builds the kernel and modules
# Assumes that the .config file is available
cd /usr/src/kernel/kernel-4.4
make prepare
make modules_prepare
make -j6
make modules
make modules_install

