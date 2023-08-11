#!/bin/bash

echo "Welcome to the Number Guesser!"

echo "I am thinking of a number between 1 and 100... can you guess what it is?"

while true; do
	read guess

	num=$(( RANDOM % 100 +1 ))

	echo "$num, $guess"
	
	if (( guess == num )); then
		echo "correct!! the number i'm thinking of is $num"
		break
	else
		echo "Unlucky, try again."
	fi
done

