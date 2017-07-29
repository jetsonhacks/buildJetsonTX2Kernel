#!/bin/bash
cd /usr/src/kernel/kernel-4.4
# On the stock Jetson TX2 install, there is no zImage in the boot directory
# So we just copy the Image file over
# If the zImage is needed, you must either
# $ make zImage
# or
# $ make
# Both of these commands must be executed in /usr/src/kernel/kernel-4.4
# sudo cp arch/arm64/boot/zImage /boot/zImage
# Note that if you are compiling on an external device, like a SSD, you should probably
# copy this over to the internal eMMC if that is where the Jetson boots
sudo cp arch/arm64/boot/Image /boot/Image


