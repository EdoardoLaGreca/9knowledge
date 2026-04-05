#! /bin/sh

# Download the latest 9front nightly build.

# Domain for direct download of nightly builds
nitedom='iso.only9fans.com'

# Path for direct download
dpath='/9front'

# Download page URL for nightly builds
purl="https://$nitedom/"

. $(dirname $0)/shr.sh

ckcurl

echo "searching for the file's url... (might take a while)"

# let the user choose a variant
patt="${dpath}/9front-[[:digit:]]*\.[[:alnum:]]*\.[[:alnum:]]*\.gz"
variants=$(matchall "$purl" "$patt" | xargs -I % basename % | joinlns)
prompt_variant "$variants"
echo "you chose: $ans"
patt="${dpath}/${ans}"

# direct download url
url=$(match "$purl" "$patt" | sed "s|^|https://$nitedom|")
if [ -z "$url" ]
then
	echo 'cannot find download url' >&2
	exit 1
fi

ckow $(basename $url) || exit 0
curldl "$url"

