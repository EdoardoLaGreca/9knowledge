#! /bin/sh

# Download the latest 9front nightly build.

. $(dirname $0)/shr.sh

ckcurl

path=$(match "https://$dldom" "/9front/9front-[[:digit:]]*.amd64.iso.gz")
if [ -z "$path" ]
then
	echo 'cannot find download url' >&2
	exit 1
fi

curl -O "https://$dldom""$path"

