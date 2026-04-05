#! /bin/sh

# Download the latest 9front release torrent file using Curl.

. $(dirname $0)/shr.sh

# Path where the download page is
ppath='/releases'

# Path for direct download
dpath='/iso'

ckcurl

echo "searching for the file's url... (might take a while)"

# latest download page url
patt="http://${dom}${ppath}/[[:digit:]/]*"
purl=$(match "https://$dom" "$patt" | http2s)
if [ -z "$purl" ]
then
	echo 'cannot find the download page' >&2
	exit 1
fi

# let the user choose a variant
patt="http://${dom}${dpath}/9front-[[:digit:]]*\.[[:alnum:]]*\.[[:alnum:]]*\.gz\.torrent"
variants=$(matchall "$purl" "href=\"$patt\"" | sed 's/^href="//;s/"$//;' | xargs -I % basename % | joinlns)
prompt_variant "$variants"
echo "you chose: $ans"
patt="http://${dom}${dpath}/${ans}"

# display variant's checksum
varfile=$(basename $patt | sed 's/\.torrent$//')
cksumpatt='[0-9a-f]{64}'
line=$(match "$purl" "^[[:space:]]*$cksumpatt[[:space:]]*$varfile")
cksum=$(echo "$line" | xtract "$cksumpatt")
printf "checksum for $varfile:\n\t$cksum\n"

# direct download url
durl=$(match "$purl" "$patt" | http2s)
if [ -z "$durl" ]
then
	echo 'cannot find the download url' >&2
	exit 1
fi

ckow $(basename $durl) || exit 0
curldl "$durl"

