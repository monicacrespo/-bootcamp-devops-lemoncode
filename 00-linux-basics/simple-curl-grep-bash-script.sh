#! /bin/bash

if [ $# != 1 ]; then 
  echo "Usage: $0 text_that_you_are_looking_for"
  exit 1
fi

# $1 is the first commandline argument
if [ "$1" == "" ]; then
	echo "Error: the parameter passed in is empty!"
	exit 1
fi

GREP_PATTERN=$1

# Download the web page content to a file
curl --silent https://campus.lemoncode.net/ --output lemoncode-output.txt 

# Get the first line where the grep pattern appears
grep -n $GREP_PATTERN lemoncode-output.txt  | head -1 | cut -d':' -f 1
# The -n option tells grep to display the line number of the lines containing a string that matches a pattern
# The -f option tells cut to display only first field of each lines from lemoncode-output.txt file. In this case, the 1st field is the line number
# And the option -d specifies what is the field delimiter. In this case, is : (colon)