#! /bin/sh

# Start a 9front virtual machine using QEMU. Specify the path to the internal
# disk image to use as first argument. An ISO disk image may be specified as
# first argument.
# To create a disk image, use:
# 	qemu-img create -f qcow2 <name>.img <size>G

# you may want to assign these two variables below to known paths in your
# filesystem, to save some time and effort
disk=$1
iso=$2

if [ $# -eq 0 ]
then
	echo 'usage: ./virt9.sh disk-image.img [ cd-image.iso ]'
	exit 1
fi

if [ -n "$iso" ]
then
	cdrom="-cdrom $iso"
fi


# Options and arguments summed up:
#	-machine
#		hardware type, acceleration, etc.
#	-smp
#		number of cpu cores
#	-m
#		primary memory size
#	-hda
#		internal disk image
#	-cdrom
#		external disk image
#	-boot
#		boot order
#	-vga
#		graphics card
#	-k
#		keyboard layout
#	-usb
#		add a uhci controller
#	-nic, -netdev
#		network configuration
#	-device
#		configuration for any device
# for more, see https://wiki.gentoo.org/wiki/QEMU/Options
qemu-system-x86_64 \
	-machine type=q35 \
	-smp 2 \
	-m 2048M \
	-hda $disk \
	$cdrom \
	-boot dc \
	-vga std \
	-k en-us \
	-netdev user,id=eth0 -device e1000,netdev=eth0 \
#	-device virtio-net,netdev=vmnic -netdev tap,id=vmnic,ifname=vnet0,script=no,downscript=no \
