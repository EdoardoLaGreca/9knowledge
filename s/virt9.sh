#! /bin/sh

# Start a 9front virtual machine using QEMU on GNU/Linux. Specify the path to
# the internal disk image to use as first argument. An ISO disk image may be
# specified as first argument.
# To create a disk image, use:
# 	qemu-img create -f qcow2 <name>.img <size>G

# You may want to assign these two variables below to known paths in your file
# system, to save some time and effort.
disk=$1
iso=$2

# Values for QEMU's respective '-display' and '-vga' options, with an additional
# option for '-spice' if display=none.
# Suggested values:
# 	Local use  -> vga=std display=gtk spice=
# 	Remote use -> vga=qxl display=none spice=...
vga=std
display=gtk
spice=

# ---- end of customisation variables ----

# check existence of programs
ckprogs() {
	not_found=0
	for u
	do
		if ! which $u
		then
			echo "$u not found, make sure it is installed" >&2
			not_found=1
		fi
	done
	test $not_found -eq 1 && return 1
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
	-m 2048M \
	-accel kvm \
	-device intel-iommu \
	-vga $vga \
	-display $display \
	${spice:+-spice $spice} \
	-k en-us \
	-drive file=$disk,if=virtio \
	${iso:+-cdrom $iso -boot order=dc} \
	-nic user,model=virtio-net-pci

