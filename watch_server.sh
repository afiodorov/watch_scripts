FILE_TO_WATCH=/tmp/appServer_${USER}_restart
SERVER_CMD="node ~/cplus/stratego/server.js"

function start_server {
	eval "$SERVER_CMD &"
	pid=$! 
}

function restart_server {
	echo "Killing $pid"
	echo "---------------"
	kill $pid 2>/dev/null
	echo "Starting the server"
	echo "---------------"
	start_server
}

start_server
while true; do
	inotifywait -e modify $FILE_TO_WATCH && restart_server
done
