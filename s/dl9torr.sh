#! /bin/sh

# Download the latest 9front release torrent file using Curl.

. $(dirname $0)/shr.sh

ckcurl

echo "searching for the file's url... (might take a while)"

# latest download page link
plink=$(match "https://$dom" "http://$dom/releases/[[:digit:]/]*" | sed 's/^http:/https:/')
if [ -z "$plink" ]
then
	echo 'cannot find the download page' >&2
	exit 1
fi

# direct download link
dlink=$(match "$plink" "http://$dldom/release/9front-[[:digit:]]*\.amd64\.iso\.gz\.torrent" | sed 's/^http:/https:/')
if [ -z "$dlink" ]
then
	echo 'cannot find the download url' >&2
	exit 1
fi

curldl "$dlink"

