#!/bin/bash 
set -x #echo on

host="http://localhost:8080/hello/world"

function start_server() {
	# execute the server image in a sub-process
	./fresh-graal > /dev/null &
	server_pid=$!

	# give the server a chance to start
	sleep 3

	# return the server PID
	echo $server_pid
}

function start_client() {
	local host="$1"
	echo "Connecting to $host" >&2
	response=$(curl --write-out %{http_code} --silent --output /dev/null --connect-timeout 3 $host)

	if [ $response -eq 200 ]
	then
		echo "Connect OK. Status $response." >&2
		echo 0
	else
		echo "Connect FAIL. Status $response." >&2
		echo 1
	fi
}

# start the server in a sub-process and get its PID 
server_pid=$(start_server)

# start the client and get the exit status
client_status=$(start_client $host)

# send Ctrl+C to server
kill $server_pid

# exit with client status
exit $client_status