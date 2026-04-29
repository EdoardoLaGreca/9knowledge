#! /bin/sh

# Start a 9front virtual machine. Specify the path to the main QCOW2 disk image
# as first argument. An ISO image may be specified as second argument.
# 	./virt9.sh disk-image.qcow2 [ cd-image.iso ]
# This script provides some degree of customisation through environment
# variables. It is suggested to pass them to the script using the prefix syntax,
# i.e.:
#	name1=value1 [ name2=value2 ... ] ./virt9.sh ...
# The variables are:
# - `disk`: main disk storage in QCOW2 format)
# - `iso`: optional installation ISO image
# - `display`: the kind of window created for graphics (QEMU only)
# - `smp`: the amount of CPUs assigned in multi-core environments
# - `mem`: the amount of volatile memory allocated
# Once everything is set up and just before launching the hypervisor, all
# customisable variables are printed to standard output with their respective
# values in a familiar syntax.

# You may want to assign these two variables below to known paths in your file
# system, to save some time and effort.
disk=$1
iso=$2

uname=$(uname)
if [ $uname = Linux ]
then
	os=linux
elif echo $uname | grep '.*BSD'
then
	os=bsd
else
	echo 'unsupported os' >&2
	exit 1
fi
. $(dirname $0)/$os.sh
test $? -eq 0 || exit 1

# Use 'none' for no display output.
display=${display:-gtk}

printvar() {
	for v
	do
		printf "$v=%b " $(eval echo '$'$v)
	done
	echo
}

if [ $# -eq 0 ]
then
	echo 'usage: ./virt9.sh disk-image.img [ cd-image.iso ]' >&2
	exit 1
fi

# cores given to the vm
if [ ! $smp ]
then
	smp=$(( $(ncpu) / 4 ))
	test $smp -lt 1 && smp=1
fi

# memory given to the vm
if [ ! $mem ]
then
	# 1/4 of total memory floored to the nearest power of 2
	mem=$(echo "scale=4; memlog = l($(totalmem) / 4) / l(2); scale=0; memlog /= 1; 2^memlog" | bc -l)
	mem=$mem'M'
fi

printvar uname disk iso display smp mem

virt9

