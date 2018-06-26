#!/bin/bash
# Install the kernel source for L4T
source scripts/jetson_variables.sh
#Print Jetson version
echo "$JETSON_DESCRIPTION"
#Print Jetpack version
echo "Jetpack $JETSON_JETPACK [L4T $JETSON_L4T]"


# Set kernel tag to to the version of L4T in system. Reference: http://nv-tegra.nvidia.com/gitweb/?p=linux-t18x.git;a=summary
# Possible kernel tags for TX2:
# 	tegra-l4t-r28.2.1
#   tegra-l4t-r28.2
#   tegra-l4t-r28.2-rc
#   tegra-l4t-r28.1
#   tegra-l4t-r27.1
KERNEL_TAG=0

if [ "$JETSON_BOARD" = "TX2i" ] ; then
    case $JETSON_L4T in
        "28.2.1")
           KERNEL_TAG="tegra-l4t-r28.2.1" ;;
        "28.2")
           KERNEL_TAG="tegra-l4t-r28.2" ;;
        *)
           KERNEL_TAG="UNKNOWN" ;;
    esac
elif [ "$JETSON_BOARD" = "TX2" ] ; then
    case $JETSON_L4T in
        "28.2.1")
                KERNEL_TAG="tegra-l4t-r28.2.1" ;;
        "28.2")
                KERNEL_TAG="tegra-l4t-r28.2" ;;
        "28.1")
                KERNEL_TAG="tegra-l4t-r28.1" ;;
        "27.1")
                KERNEL_TAG="tegra-l4t-r27.1" ;;
        *)
           JETSON_JETPACK="UNKNOWN" ;;
    esac
else
    # Unknown board
    JETSON_JETPACK="UNKNOWN"
fi

if [ $JETSON_JETPACK == "UNKNOWN" ] ; then
   echo "An unsupported version of the board or L4T detected! "
   sudo ./scripts/getKernelSources.sh
else
  echo "Setting the kernel URL for L4T $L4TTarget"
  echo "Getting kernel sources"
  sudo ./scripts/getKernelSources.sh
fi


