#! /bin/sh

iso=$1
disk=$2

qemu-system-x86_64 \
	-m 1024M \
	-hda $disk \
	-cdrom $iso \
	-k en-us \
	-boot dc \
	-usb \
	-netdev user,id=net0 -device e1000,netdev=net0,mac=52:54:98:76:54:32 \
	-nic user,model=e1000,mac=52:54:98:76:54:32 \
	-vga virtio \
