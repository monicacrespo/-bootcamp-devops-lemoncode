
#! /bin/bash

curl --silent -o ./lemoncode-response.txt https://campus.lemoncode.net/

# $1 is the first commandline argument
if [ "$1" = "" ]; then
	echo "The pattern is empty!"
else
	# The -n option tells grep to show the line number of the lines containing a string that matches a pattern
	grep -i -n "$1" ./lemoncode-response.txt
fi
