#! /bin/sh

# Download the latest 9front release torrent file using Curl.

# Path where the download page is
ppath='/releases'

# Path for direct download
dpath='/iso'

. $(dirname $0)/shr.sh

ckcurl

echo "searching for the file's url... (might take a while)"

# latest download page url
purl=$(match "https://$dom" "http://${dom}${ppath}/[[:digit:]/]*" | sed 's/^http:/https:/')
if [ -z "$purl" ]
then
	echo 'cannot find the download page' >&2
	exit 1
fi

# direct download url
durl=$(match "$purl" "http://${dom}${dpath}/9front-[[:digit:]]*\.amd64\.iso\.gz\.torrent" | sed 's/^http:/https:/')
if [ -z "$durl" ]
then
	echo 'cannot find the download url' >&2
	exit 1
fi

ckow $(basename $durl) || exit 0
curldl "$durl"

