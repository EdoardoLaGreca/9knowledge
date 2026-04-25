#! /bin/sh

# Start a 9front virtual machine using QEMU on GNU/Linux. Specify the path to
# the main disk image as first argument. An ISO image may be specified as second
# argument.
# 	./virt9.sh disk-image.img [ cd-image.iso ]
# To create a disk image, use:
# 	qemu-img create -f qcow2 <name>.img <size>G
# This script intentionally leaves out non-essential features, such as audio,
# and only focuses on the emulation of CPU/motherboard/SoC, basic graphics, and
# networking.

# You may want to assign these two variables below to known paths in your file
# system, to save some time and effort.
disk=$1
iso=$2

# ---- end of customisation variables ----

# check existence of programs
ckprogs() {
	not_found=0
	for u
	do
		if ! which $u >/dev/null
		then
			echo "$u not found, make sure it is installed" >&2
			not_found=1
		fi
	done
	test $not_found -eq 1 && return 1
	return 0
}

printvar() {
	for v
	do
		printf "$v=%b " $(eval echo '$'$v)
	done
	echo
}

ckprogs nproc || exit 1

if [ $# -eq 0 ]
then
	echo 'usage: ./virt9.sh disk-image.img [ cd-image.iso ]' >&2
	exit 1
fi

# cores given to the vm
smp=$(( $(nproc) / 4 ))
test $smp -lt 1 && smp=1

# memory given to the vm
# (1/4 of the available memory floored to the nearest power of 2)
mem_avail=$(free --mega | awk '{ print $7 }' | sed '/^$/ d')
mem=$(echo "scale=4; memlog = l($mem_avail / 4) / l(2); scale=0; memlog /= 1; 2^memlog" | bc -l)
mem=$mem'M'

printvar disk iso vga display spice smp mem

# Options and arguments summed up:
#	-machine
#		hardware type, acceleration, etc.
#	-smp
#		number of cpu cores
#	-m
#		primary memory size
#	-hda, -drive
#		virtual hard drive
#	-cdrom
#		virtual optical drive (typically for ISO disk images)
#	-boot
#		boot order
#	-vga
#		graphics card
#	-k
#		keyboard layout
#	-usb
#		add a uhci controller
#	-nic, -netdev
#		network backend configuration
#	-device
#		configuration for any device
# for more, see:
#	https://www.qemu.org/docs/master/system/index.html
#	https://wiki.archlinux.org/title/QEMU
#	https://wiki.gentoo.org/wiki/QEMU/Options
qemu-system-x86_64 \
	-machine q35 \
	-cpu host \
	-smp $smp \
	-m $mem \
	-accel kvm \
	-device intel-iommu \
	-vga std \
	-display gtk \
	-k en-us \
	-drive file=$disk,if=virtio \
	${iso:+-cdrom $iso -boot order=dc} \
	-nic user,model=virtio-net-pci

