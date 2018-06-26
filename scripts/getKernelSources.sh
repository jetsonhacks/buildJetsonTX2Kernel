#!/bin/bash
apt-add-repository universe
apt-get update
apt-get install qt5-default pkg-config -y
cd /usr/src


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


  # Note: New Method for getting kernel source.
  # For older method, following can be used, but decided to come up with more efficient mode:
  # wget -N "https://developer.download.nvidia.com/embedded/L4T/r28_Release_v2.1/public_sources.tbz2?YoszKxkjC1hGlemo-Y1ErDXXvPUeDepDcd8KBvWL29Re9YNC8HZyClKNEEqvIB2r_pxl7GJyusN7ucO-DhysxFqkqLUOyPRpB2qvvefsf7CcJpOnrb0imN2Lkpa8C3K_ItZ0cl3yneR7VQb9L-_wmw"
  # Getting from Git via cloning takes way too long, so we download the "snapshots" generated by gitweb. Inspired by source_sync.sh script.
  # The snapshot option can be seen here: http://nv-tegra.nvidia.com/gitweb/?p=linux-4.4.git;a=commit;h=d259faa6df3f513591e4246a782f51bb940d09ad


  SOURCE_INFO="
  kernel/kernel-4.4:linux-4.4.git
  kernel/t18x:linux-t18x.git
  kernel/nvgpu:linux-nvgpu.git
  kernel/nvhost:linux-nvhost.git
  kernel/nvmap:linux-nvmap.git
  kernel/nvmap-t18x:linux-nvmap-t18x.git
  kernel/display:linux-display.git
  hardware/nvidia/soc/t18x:device/hardware/nvidia/soc/t18x.git
  hardware/nvidia/platform/tegra/common:device/hardware/nvidia/platform/tegra/common.git
  hardware/nvidia/platform/t18x/common:device/hardware/nvidia/platform/t18x/common.git
  hardware/nvidia/platform/t18x/quill:device/hardware/nvidia/platform/t18x/quill.git
  hardware/nvidia/soc/t210:device/hardware/nvidia/soc/t210.git
  hardware/nvidia/platform/t210/common:device/hardware/nvidia/platform/t210/common.git
  hardware/nvidia/platform/t210/jetson:device/hardware/nvidia/platform/t210/jetson.git
  hardware/nvidia/soc/tegra:device/hardware/nvidia/soc/tegra.git
  "
  NSOURCES=0
  declare -a SOURCE_INFO_PROCESSED
  SOURCE_INFO_PROCESSED=($(echo "$SOURCE_INFO"))
  NSOURCES=${#SOURCE_INFO_PROCESSED[*]}

  for ((i=0; i < NSOURCES; i++)); do
    FOLDER_NAME=$(echo "${SOURCE_INFO_PROCESSED[i]}" | cut -f 1 -d ':')
  	REPO_URL=$(echo "${SOURCE_INFO_PROCESSED[i]}" | cut -f 2 -d ':')
  	REPO_NAME=$(echo "${REPO_URL}" | cut -f 1 -d '.')

  	mkdir -p "$FOLDER_NAME"
  	wget -O "$REPO_NAME.tgz" -vr "http://nv-tegra.nvidia.com/gitweb/?p=$REPO_URL;a=snapshot;h=$KERNEL_TAG;sf=tgz"

  	tar -xvf "$REPO_NAME.tgz" -C "$FOLDER_NAME" --strip-components 1
  	rm "$REPO_NAME.tgz"

  done


  cd kernel/kernel-4.4

  # Go get the default config file; this becomes the new system configuration
  zcat /proc/config.gz > .config
  # Ready to configure kernel
  make xconfig
fi

