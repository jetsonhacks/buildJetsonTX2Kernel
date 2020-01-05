#!/bin/bash
# Get the kernel source for NVIDIA Jetson Nano Developer Kit, L4T
# Copyright (c) 2016-2020 Jetsonhacks 
# MIT License

JETSON_MODEL="TX2"
L4T_TARGET="32.3.1"
SOURCE_TARGET="/usr/src"
KERNEL_RELEASE="4.9"

#Get the Board Model
JETSON_BOARD="UNKNOWN"

if [ -f /sys/module/tegra_fuse/parameters/tegra_chip_id ]; then
    JETSON_BOARD=$(case $(cat /sys/module/tegra_fuse/parameters/tegra_chip_id) in
        64)
            echo TK1 ;;
        33)
            echo Nano/TX1 ;;
        24)
            echo TX2 ;;
	25)
            echo AGX Xavier ;;
    esac)
    JETSON_DESCRIPTION="NVIDIA Jetson $JETSON_BOARD"
fi
echo "Jetson Model: "$JETSON_BOARD

JETSON_L4T=""

# Starting with L4T 32.2, the recommended way to find the L4T Release Number
# is to use dpkg
# L4T 32.3.1, NVIDIA added back /etc/nv_tegra_release
function check_L4T_version()
{   
        if [ -f /etc/nv_tegra_release ]; then
		JETSON_L4T_STRING=$(head -n 1 /etc/nv_tegra_release)
		JETSON_L4T_RELEASE=$(echo $JETSON_L4T_STRING | cut -f 2 -d ' ' | grep -Po '(?<=R)[^;]+')
		JETSON_L4T_REVISION=$(echo $JETSON_L4T_STRING | cut -f 2 -d ',' | grep -Po '(?<=REVISION: )[^;]+')
                JETSON_L4T_VERSION=$JETSON_L4T_RELEASE.$JETSON_L4T_REVISION

	else
		echo "$LOG Reading L4T version from \"dpkg-query --show nvidia-l4t-core\""

		JETSON_L4T_STRING=$(dpkg-query --showformat='${Version}' --show nvidia-l4t-core)
                # For example: 32.2.1-20190812212815
                JETSON_L4T_VERSION=$(echo $JETSON_L4T_STRING | cut -d '-' -f 1)
                JETSON_L4T_RELEASE=$(echo $JETSON_L4T_VERSION | cut -d '.' -f 1)
                # # operator remove prefix in string operations in bash script. Don't forget . eg "32."
                JETSON_L4T_REVISION=${JETSON_L4T_VERSION#$JETSON_L4T_RELEASE.}
        fi
	echo "$LOG Jetson BSP Version:  L4T R$JETSON_L4T_VERSION"

}

echo "Getting L4T Version"
check_L4T_version
JETSON_L4T="$JETSON_L4T_VERSION"

function usage
{
    echo "usage: ./getKernelSources.sh [[-d directory ] | [-h]]"
    echo "-h | --help  This message"
}

# Iterate through command line inputs
while [ "$1" != "" ]; do
    case $1 in
        -d | --directory )      shift
				SOURCE_TARGET=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
# e.g. echo "${red}The red tail hawk ${green}loves the green grass${reset}"

LAST="${SOURCE_TARGET: -1}"
if [ $LAST != '/' ] ; then
   SOURCE_TARGET="$SOURCE_TARGET""/"
fi

INSTALL_DIR=$PWD

# Error out if something goes wrong
set -e

# Check to make sure we're installing the correct kernel sources
# Determine the correct kernel version
# The KERNEL_BUILD_VERSION is the release tag for the JetsonHacks buildKernel repository
KERNEL_BUILD_VERSION=master
if [ "$JETSON_BOARD" == "$JETSON_MODEL" ] ; then 
  if [ $JETSON_L4T == "$L4T_TARGET" ] ; then
     KERNEL_BUILD_VERSION=$L4T_TARGET
  else
   echo ""
   tput setaf 1
   echo "==== L4T Kernel Version Mismatch! ============="
   tput sgr0
   echo ""
   echo "This repository is for modifying the kernel for a L4T "$L4T_TARGET "system." 
   echo "You are attempting to modify a L4T "$JETSON_MODEL "system with L4T "$JETSON_L4T
   echo "The L4T releases must match!"
   echo ""
   echo "There may be versions in the tag/release sections that meet your needs"
   echo ""
   exit 1
  fi
else 
   tput setaf 1
   echo "==== Jetson Board Mismatch! ============="
   tput sgr0
    echo "Currently this script works for the $JETSON_MODEL."
   echo "This processor appears to be a $JETSON_BOARD, which does not have a corresponding script"
   echo ""
   echo "Exiting"
   exit 1
fi

# Check to see if source tree is already installed
PROPOSED_SRC_PATH="$SOURCE_TARGET""kernel/kernel-"$KERNEL_RELEASE
echo "Proposed source path: ""$PROPOSED_SRC_PATH"
if [ -d "$PROPOSED_SRC_PATH" ]; then
  tput setaf 1
  echo "==== Kernel source appears to already be installed! =============== "
  tput sgr0
  echo "The kernel source appears to already be installed at: "
  echo "   ""$PROPOSED_SRC_PATH"
  echo "If you want to reinstall the source files, first remove the directories: "
  echo "  ""$SOURCE_TARGET""kernel"
  echo "  ""$SOURCE_TARGET""hardware"
  echo "then rerun this script"
  exit 1
fi

export SOURCE_TARGET
# -E preserves environment variables
sudo -E ./scripts/getKernelSources.sh


