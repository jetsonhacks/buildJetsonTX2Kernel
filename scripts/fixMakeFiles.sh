#!/bin/bash
# Fix the Makefiles so that they compile on the device
patch /usr/src/kernel/kernel-4.4/drivers/devfreq/Makefile ./diffs/devfreq/devfreq.patch
patch /usr/src/kernel/nvgpu/drivers/gpu/nvgpu/Makefile ./diffs/nvgpu/nvgpu.patch
patch /usr/src/kernel/kernel-4.4/sound/soc/tegra-alt/Makefile ./diffs/tegra-alt/tegra-alt.patch
# vmipi is in a sub directory without a Makefile, there was an include problem
cp /usr/src/kernel/kernel-4.4/drivers/media/platform/tegra/mipical/mipi_cal.h /usr/src/kernel/kernel-4.4/drivers/media/platform/tegra/mipical/vmipi/mipi_cal.h
 

