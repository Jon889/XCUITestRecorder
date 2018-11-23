simulator_name="iPhone 8"
output_dir="videos"
rm -rf $output_dir

mkdir -p $output_dir
while read i; do
	if [[ "$i" =~ Test\ Case.*\[(.*)\].*started. ]]; then
		test_name=$(echo "${BASH_REMATCH[1]}" | tr " " ".")
		test_output_path="$output_dir/$test_name"
		xcrun simctl io "$simulator_name" recordVideo "$test_output_path.mp4" --type "mp4" &
		pid=$!
		echo "Started to record $test_name to $test_output_path"
	fi
	echo "$i"
	if [[ ! -z "$test_output_path" ]]; then
		echo "$i" >> "$test_output_path.log"
	fi
	if [[ "$i" =~ Test\ Case.*(passed|failed).* ]]; then
		kill -SIGINT $pid
		wait $pid
		echo "Finished recording at $test_output_path"
		if [[ ${BASH_REMATCH[1]} == "passed" ]]; then
			rm "$test_output_path.mp4 $test_output_path.log"
		fi
		test_output_path=""
	fi
done

echo "Finished"