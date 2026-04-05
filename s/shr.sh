# Shared functions and variables.

dom='9front.org'

ckcurl() {
	curl -V >/dev/null 2>&1
	if [ $? -ne 0 ]
	then
		echo 'no curl :(' >&2
		exit 1
	fi
}

# silent curl wrapper
curls() {
	args='-Ss'
	curl $args "$@"
}

# explicit curl wrapper, for final downloads
curldl() {
	wstring='download completed!\n  size: %{size_download} B\n  time: %{time_total} seconds\n  avg speed: %{speed_download} B/s\n  exit status: %{exitcode}\n  error msg (none if blank): %{errormsg}\n'
	args="--remove-on-error -O"
	for url
	do
		echo "url: $url"
		curl $args -w "$wstring" "$url"
	done
}

# like grep -o but posix-compliant
xtract() {
	patt=$(echo "$1" | sed 's|/|\\/|g')
	awkprog='{
		while(match($0,/'"$patt"'/)){
			print substr($0,RSTART,RLENGTH)
			$0=substr($0,RSTART+RLENGTH)
		}
	}'
	awk "$awkprog"
}

# find all matches in a web page
matchall() {
	p="$1"
	m="$2"
	curls "$p" | xtract "$m"
}

# find the first match in a web page
match() {
	p="$1"
	m="$2"
	matchall "$p" "$m" | head -n 1
}

# check whether a file (path) already exists, prompt for overwrite
ckow() {
	p="$1"
	while test -f $p && read -p "!! file already exists, overwrite? [y/n] " r
	do
		case $r in
		Y*|y*) return 0 ;;
		N*|n*) return 1 ;;
		*) continue ;;
		esac
	done
}

# replace 'http:' with 'https:' in all lines that start with the former in stdin
http2s() {
	while read line
	do
		echo "$line" | sed 's/^http:/https:/'
	done
}

# enumerate lines
# the `paste` command would be perfect, but with that I need to either create
# temporary files (ugly) or use process substitution (non-posix)
enumlns() {
	i=1
	while read line
	do
		echo "$i) $line"
		i=$(( $i+1 ))
	done
}

# prompt for the selection of a line from those received on stdin and set the
# `ans` variable to the selected option
prompt_seln() {
	max="$1"
	msg=${2:-"choose an option by index: "}
	while read -p "$msg" ans
	do
		test "$ans" -ge 1 -a "$ans" -le "$max" && break
	done
}

# prompt for the selection of a variant and set the `ans` variable to the
# selected option's text
prompt_variant() {
	purl="$1"
	patt="$2"
	variants=$(matchall "$purl" "$patt" | xargs -I % basename %)
	echo "available variants below:"
	echo "$variants" | enumlns | sed 's/^/  /'
	prompt_seln $(echo "$variants" | wc -l) "choose a variant by index: "
	ans=$(echo "$variants" | head -n $ans | tail -n -1)
}
