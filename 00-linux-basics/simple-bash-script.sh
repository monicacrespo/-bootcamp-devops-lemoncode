#! /bin/bash

DIR="./foo/"
if [ -d "$DIR" ]; then
	  # Take action if $DIR exists. #
	    rm -r ${DIR}
fi


# $1 is the first commandline argument
TEXT=$1
if [ "$1" = "" ]; then
	 # Take action if $TEXT is empty #
	   TEXT="Que me gusta la bash!!!!"       
fi

# exercise 1 commands 
mkdir -p foo/dummy
cd foo/dummy
touch file1.txt
cp file1.txt file2.txt
echo "$TEXT" > file1.txt
cat file2.txt
cat file1.txt
cd ..
mkdir empty

# exercise 2 commands
cd dummy
cat file{1,2}.txt
cp file1.txt file2.txt
cat file2.txt
mv file2.txt ../empty/
cat ../empty/file2.txt

