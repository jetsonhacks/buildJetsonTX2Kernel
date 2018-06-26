#!/bin/bash
# Install the kernel source for L4T
source scripts/jetson_variables.sh
#Print Jetson version
echo "$JETSON_DESCRIPTION"
#Print Jetpack version
echo "Jetpack $JETSON_JETPACK [L4T $JETSON_L4T]"


echo "Setting the kernel URL for L4T $KERNEL_TAG"
echo "Getting kernel sources"
sudo ./scripts/getKernelSources.sh
