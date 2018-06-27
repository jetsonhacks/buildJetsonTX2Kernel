#!/bin/bash
# Install the kernel source for L4T
source scripts/jetson_variables.sh
#Print Jetson version
echo "$JETSON_DESCRIPTION"
#Print Jetpack version
echo "Jetpack $JETSON_JETPACK [L4T $JETSON_L4T]"



sudo ./scripts/getKernelSources.sh
