Virtualisation
==============

To create a fully virtualised 9front environment, use **virt9.sh**. Look at its description for more info, first comment in the file.

This script intentionally leaves out non-essential features, such as audio, and only focuses on the emulation of CPU, basic graphics, and networking. The idea is that you should have some way to boot 9front and start the rcpu service, but then you should use drawterm for everything else.

Currently supported platforms:

- GNU/Linux with QEMU

Will be added:

- FreeBSD with Bhyve
- OpenBSD with vmm(4)

