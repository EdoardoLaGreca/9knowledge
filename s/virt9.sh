#! /bin/sh

disk=$1
iso=$2

if [ -n "$iso" ]
then
	isoargs="-cdrom $iso -boot cd"
fi

qemu-system-x86_64 \
	-m 1024M \
	-hda $disk \
	$isoargs \
	-k en-us \
	-usb \
	-netdev user,id=net0 -device e1000,netdev=net0,mac=52:54:98:76:54:32 \
	-nic user,model=e1000,mac=52:54:98:76:54:32 \
	-vga virtio \
