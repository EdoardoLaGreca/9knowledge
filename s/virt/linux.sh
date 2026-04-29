ncpu() {
	nproc
}

totalmem() {
	bytes=$(vmstat -s -S k | grep 'total memory$' | awk '{ print $1 }')
	echo "$bytes / (10^3)" | bc
}

virt9() {
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
		-machine q35 \
		-cpu host \
		-smp $smp \
		-m $mem \
		-accel kvm \
		-device intel-iommu \
		-vga std \
		-display $display \
		-k en-us \
		-drive file=$disk,if=virtio \
		${iso:+-cdrom $iso -boot order=dc} \
		-nic user,model=virtio-net-pci
}
