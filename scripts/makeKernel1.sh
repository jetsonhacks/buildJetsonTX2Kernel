#!/bin/bash
# Finishes building the kernel and modules
# Assumes that the .config file is available
cd /usr/src/kernel
make -j4
make modules
make modules_install

