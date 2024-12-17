#! /bin/sh

# Download the latest 9front release torrent file using Curl.

. $(dirname $0)/shr.sh

ckcurl

# latest download page link
plink=$(curl "https://$dom" | xtract "http://$dom/releases/[[:digit:]/]*" | sed 's/^http:/https:/')
if [ $? -ne 0 ] || [ -z "$plink" ]
then
	echo 'cannot find the download page' >&2
	exit 1
fi

# direct download link
dlink=$(curl "$plink" | xtract "http://$dldom/release/9front-[[:digit:]]*\.amd64\.iso\.gz\.torrent" | sed 's/^http:/https:/')
if [ $? -ne 0 ] || [ -z "$dlink" ]
then
	echo 'cannot find the download url' >&2
	exit 1
fi

curl -O "$dlink"

