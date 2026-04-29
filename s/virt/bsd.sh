ncpu() {
	sysctl hw.ncpu
}

totalmem() {
	# hw.physmem is a 32 bit integer in NetBSD, this might cause issues
	bytes=$(sysctl hw.physmem)
	echo "$bytes / (10^6)" | bc
}

virt9_bhyve() {
	#todo
}

virt9_vmm() {
	#todo
}

virt9() {
	uname=$(uname)
	if [ $uname = FreeBSD ]
	then
		virt9_bhyve
	elif [ $uname = OpenBSD ]
	then
		virt9_vmm
	else
		echo 'unsupported os' >&2
		return 1
	fi
}
