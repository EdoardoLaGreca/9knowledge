ncpu() {
	sysctl hw.ncpu
}

totalmem() {
	# hw.physmem is a 32 bit integer in NetBSD, this might cause issues
	bytes=$(sysctl hw.physmem)
	echo "$bytes / (10^6)" | bc
}

