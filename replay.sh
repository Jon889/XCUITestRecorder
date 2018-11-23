prev_time=0
while read i; do
	if [[ "$i" =~ \ *t\ *=\ *([[:digit:]]+\.[[:digit:]]+)s.* ]]; then
		time=${BASH_REMATCH[1]}
		diff=$(echo "$time - $prev_time" | bc)
		sleep $diff
		echo "$i"
		prev_time=$time
	else
		echo "$i"
	fi
done