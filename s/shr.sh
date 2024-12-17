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

