# buildJetsonTX2Kernel
Scripts to help build the kernel and modules onboard the Jetson TX2

As of this writing, the "official" way to compile the Jetson TX2 is to use a cross compiler on a Linux PC. These scripts will down load the kernel source to the Jetson TX2, wrangle some of the Makefiles to make them work on the Jetson, and then compile the kernel and selected modules. The newly compiled kernel can then be installed.

These scripts are for building the 64-bit L4T 27.1 (Ubuntu 16.04 based) operating system on the NVIDIA Jetson TX2. The scripts should be run directly after flashing the Jetson with L4T 27.1 from a host PC. There are three scripts:

<strong>getKernelSources.sh</strong>

Downloads the kernel sources for L4T 27.1 from the NVIDIA website, decompresses them and opens a graphical editor on the .config file. 

<strong>makeKernel.sh</strong>

This script applies a few patches to makefiles in the kernel source, and then compiles the kernel and modules using make.

<strong>copyImage.sh</strong>

Copies the Image and zImage files created by compiling the kernel to the /boot directory

<strong>Note:</strong> The kernel source files are downloaded in a .tgz2 format. After compilation you may want to remove those files. The files are in /usr/src You will need to use sudo to remove the files, as they are in a system area.

<strong>Note:</strong> that you may want to save the newly built Image, zImage and modules to external media so that can be used to flash a Jetson image, or clone the disk image.


