ncpu() {
	nproc
}

totalmem() {
	bytes=$(vmstat -s -S k | grep 'total memory$' | awk '{ print $1 }')
	echo "$bytes / (10^3)" | bc
}

virt9() {

	test $ro = 'yes' && roqemu=on || roqemu=off
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
	#	-display
	#		display output
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
		-cpu host \
		-smp $smp \
		-m $mem \
		-machine q35 \
		-accel kvm \
		-blockdev driver=$diskfmt,file=$disk,read-only=$roqemu,node-name=maindisk \
		-device virtio-blk,drive=maindisk
		${iso:+-cdrom $iso -boot order=dc} \
		-nic user,model=virtio-net-pci \
		-vga std \
		-display sdl \
		-k en-us
}
