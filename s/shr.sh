# Shared functions and variables.

dom='9front.org'
dldom='iso.only9fans.com'

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
	wstring='download completed!\n\thost: %{urle.host}\n\tpath: %{urle.path}\n\ttime: %{time_total} seconds\n\tavg speed: %{speed_download} B/s\n\texit status: %{exitcode}\n\terror msg: %{errormsg}\n'
	args="-O"
	curl $args -w "$wstring" "$@"
}

# like grep -o but posix-compliant
xtract() {
	patt="$1"
	while read line
	do
		echo "$line" | grep -q "$patt" || continue
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

