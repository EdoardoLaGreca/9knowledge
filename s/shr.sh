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
	patt="$1"
	while read line
	do
		echo "$line" | grep -Eq "$patt" || continue
		befaft=$(echo "$line" | sed "s|$patt|\n|")
		bef=$(echo "$befaft" | head -n 1)
		aft=$(echo "$befaft" | tail -n 1)
		echo "$line" | sed "s|^$bef||;s|$aft\$||"
	done
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

