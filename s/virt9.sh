#! /bin/sh

# you may want to assign these two variables below to known paths in your
# filesystem, to save some time and effort
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
	-net nic,model=virtio,macaddr=00:20:91:37:33:77 -net user \
	-net user,hostfwd=tcp::17019-:17019 \
	-vga virtio \
