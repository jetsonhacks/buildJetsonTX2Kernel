# buildJetsonTX2Kernel
Scripts to help build the 4.4.38 kernel and modules onboard the Jetson TX2 (L4T 28.2, JetPack 3.2). For previous versions, visit the 'tags' section.

<em><strong>Note:</strong> The kernel source version must match the version of firmware flashed on the Jetson. For example, the source for the 4.4.38 kernel here is matched with L4T 28.2. This kernel compiled using this source tree will not work with newer versions or older versions of L4T, only 28.2.</em>

As of this writing, the "official" way to build the Jetson TX2 kernel is to use a cross compiler on a Linux PC. This is an alternative which builds the kernel onboard the Jetson itself. These scripts will download the kernel source to the Jetson TX2, and then compile the kernel and selected modules. The newly compiled kernel can then be installed.

These scripts are for building the kernel for the 64-bit L4T 28.2 (Ubuntu 16.04 based) operating system on the NVIDIA Jetson TX2. The scripts should be run directly after flashing the Jetson with L4T 28.2 from a host PC. There are three scripts:

<strong>getKernelSources.sh</strong>

Downloads the kernel sources for L4T 28.2 from the NVIDIA website, decompresses them and opens a graphical editor on the .config file. 

<strong>makeKernel.sh</strong>

Compiles the kernel and modules using make. The script commands make the kernel Image file, makes the module files, and installs the module files. Installing the Image file on to the system is a separate step. Note that the make is limited to the Image and modules; the rest of the kernel build (such as compiling the dts files) must be done separately. Doing "sudo make" in the kernel source directory will build the entirety.

<strong>copyImage.sh</strong>

Copies the Image file created by compiling the kernel to the /boot directory

<strong>Notes:</strong> 

The kernel source files are downloaded in a .tgz2 format. After compilation you may want to remove those files. The files are located in /usr/src You will need to use sudo to remove the files, as they are in a system area. The work directory 'public_release' contains kernel_src.tbz2, you can remove that directory. The file 'source_release.tbz2' is a much larger file that holds the kernel sources as well as many other TX2 specific source packages. You can make a backup of source_release.tbz2 before deleting it.

You may want to save the newly built Image and modules to external media so that can be used to flash a Jetson image, or clone the disk image.

The copyImage.sh script copies the Image to the current device. If you are building the kernel on an external device, for example a SSD, you will want to copy the Image file over to the eMMC in the eMMC /boot directory if you are booting from the eMMC and using external storage as your root directory. 

###Release Notes
March, 2018
* L4T 28.2 (JetPack 3.2)
* Removed patches for make file cleanup

July, 2017
* L4T 28.1 (JetPack 3.1)

March, 2017
* L4T 27.1 (JetPack 3.0)
* Developers Preview


## License
MIT License

Copyright (c) 2017-2018 Jetsonhacks

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
