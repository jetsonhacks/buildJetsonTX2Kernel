#!/bin/bash
# Install the kernel source for L4T
source scripts/jetson_variables.sh
#Print Jetson version
echo "$JETSON_DESCRIPTION"
#Print Jetpack version
echo "Jetpack $JETSON_JETPACK [L4T $JETSON_L4T]"

# Check to make sure we're installing the correct kernel sources
L4TTarget="32.1.0"
if [ $JETSON_L4T == $L4TTarget ] ; then
   echo "Getting kernel sources"
   sudo ./scripts/getKernelSourcesNoGUI.sh
else
   echo ""
   tput setaf 1
   echo "==== L4T Kernel Version Mismatch! ============="
   tput sgr0
   echo ""
   echo "This repository branch is for installing the kernel sources for L4T "$L4TTarget 
   echo "You are attempting to use these kernel sources on a L4T "$JETSON_L4T "system."
   echo "The kernel sources do not match their L4T release.!"
   echo ""
   echo "Please git checkout the appropriate kernel sources for your release"
   echo " "
   echo "You can list the tagged versions."
   echo "$ git tag -l"
   echo "And then checkout the latest version: "
   echo "For example"
   echo "$ git checkout v1.0-L4T"$JETSON_L4T
   echo ""
fi

