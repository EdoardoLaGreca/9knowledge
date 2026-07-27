#! /bin/sh

# usage: ./virt9.sh
# Start a 9front virtual machine.
#
# This script provides some degree of customisation through a set of environment
# variables. It is suggested to pass them to the script using the prefix syntax,
# i.e.:
#	[ name=value ... ] ./virt9.sh
# The variables in use are:
# - `disk`: path to main bootable disk storage, like a file or block device
# - `diskfmt`: main bootable disk format (qcow2 or raw)
# - `ro`: boolean value (yes/no) to make the main disk read-only
# - `iso`: optional installation ISO image
# - `smp`: the amount of CPUs assigned in multi-core environments
# - `mem`: the amount of volatile memory allocated
# Almost all variables have a default value, so they can be omitted. The only
# two that don't are `disk` and `iso`, of which at least one should always be
# defined
#
# Once everything is set up and just before launching the hypervisor, all the
# variables above are printed to standard output with their respective
# values in a familiar syntax.

uname=$(uname)
if [ $uname = Linux ]
then
	os=linux
elif echo $uname | grep '[a-zA-Z0-9]*BSD'
then
	os=bsd
else
	echo "$0: unsupported os" >&2
	exit 1
fi
. $(dirname $0)/$os.sh
test $? -eq 0 || exit 1

if [ ! $disk ] && [ ! $iso ]
then
	echo "$0: neither disk nor iso image specified" >&2
	exit 1
fi

printvar() {
	for v
	do
		printf "$v=%b " $(eval echo '$'$v)
	done
	echo
}

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

# disk format
if [ ! $diskfmt ]
then
	case $disk in
	(/dev/*)	diskfmt=raw ;;
	(*.qcow2)	diskfmt=qcow2 ;;
	(*)		diskfmt=qcow2 ;;
	esac
fi

printvar os disk diskfmt ro iso smp mem

echo "$0: starting hypervisor..." >&2
virt9

