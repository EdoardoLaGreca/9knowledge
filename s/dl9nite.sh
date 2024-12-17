#! /bin/sh

# Download the latest 9front nightly build.

. $(dirname $0)/shr.sh

ckcurl

link=$(match "https://$dldom" "/9front/9front-[[:digit:]]*.amd64.iso.gz")
if [ -z "$link" ]
then
	echo 'cannot find download url' >&2
	exit 1
fi

curl -O "https://$dldom/$link"

