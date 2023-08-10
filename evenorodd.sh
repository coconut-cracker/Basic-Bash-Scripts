#!/bin/bash

echo "Welcome! Please supply a number: "

while true; do

	read number

	echo "processing..."

	sleep 1

	if [ "$number" == "exit" ]; then
		echo "closing..."
		break
	fi

	if (( number%2==0 )); then
		echo "$number is even"

	else
		echo "$number is odd"
	fi

	echo "try another number, or type exit to quit: "
done
