# Linux CLI Exercises

### 1. Create a directory structure with folders and files like below using Bash commands.

```
foo/
├─ dummy/
│  ├─ file1.txt
│  ├─ file2.txt
├─ empty/
```

Where `file1.txt` contains the following text "Me encanta la bash!!"

And `file2.txt` is empty.

```bash
mkdir -p foo/dummy foo/empty
cd foo/dummy
echo 'Me encanta la bash!!' > file1.txt
touch file2.txt
cat file{1,2}.txt
```

### 2. Copy the content of file1.txt to file2.txt and move file2.txt to empty directory, so that we've got the directory structure like below:


```
foo/
├─ dummy/
│  ├─ file1.txt
├─ empty/
│  ├─ file2.txt
```

Where `file1.txt` and `file2.txt` contain the following text: "Me encanta la bash!!"

```bash
cp file1.txt file2.txt
mv file2.txt ../empty/
cat file1.txt
cat ../empty/file2.txt
```

### 3. Create a bash script that groups the steps from exercises 1 and 2 and set file1.txt content as the first command line argument passed in. If the first command line argument passed in is empty, the default text should be "Que me gusta la bash!!!!"

1. Create the script `simple-bash-script.sh`
```bash
#! /bin/bash

DIR="./foo/"
if [ -d "$DIR" ]; then
	  # Take action if $DIR exists
	    rm -r ${DIR}
fi

TEXT='Que me gusta la bash!!!!'

# $1 is the first commandline argument
if [ $# -gt 1 ]; then
  echo "Error: the number of passed parameters is greater than one!"
  exit 1
fi

if [[ $# == 1 && "$1" != '' ]]; then
	   # Variables must be double quoted to be expanded when comparing strings
	   # Take action if "$1" is not empty
	   TEXT=$1
fi

# commands from exercise 1 & 2
mkdir -p foo/dummy foo/empty
cd foo/dummy
echo $TEXT > file1.txt
touch file2.txt
cp file1.txt file2.txt
mv file2.txt ../empty/
cat file1.txt
cat ../empty/file2.txt
```

2. Add the execute permission for everyone 
```bash
chmod +x simple-bash-script.sh
```

3. Execute the script to test different scenarios
   1. Test without any parameter
      ```bash
      ./simple-bash-script.sh
      ```
      Result:
      ```
      Que me gusta la bash!!!!
      Que me gusta la bash!!!!
      ```
    2. Test with an empty parameter
        ```bash
        ./simple-bash-script.sh ''
        ```
        Result:
        ```
        Que me gusta la bash!!!!
        Que me gusta la bash!!!!
        ```

    3. Test with a non empty parameter
        ```bash
        ./simple-bash-script.sh 'Hi, this is awesome!!!'
        ```
        Result:
        ```
        Hi, this is awesome!!!
        Hi, this is awesome!!!
        ```
    4. Test with two parameters
        ```bash
        ./simple-bash-script.sh 'Hi, this is not awesome!!!' 'Exit'
        ```
        Result:
        ```
        Error: the number of passed parameters is greater than one!
        ```


### 4. Optional - Create a bash script to download the web page content to a file. Once downloaded to a file, search it for a given string (text passed in as a command line argument) and display the first line number containing that string.

1. Create the script `simple-curl-grep-bash-script.sh`
```bash
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
grep -n $GREP_PATTERN lemoncode-output.txt | head -1 | cut -d':' -f 1
# The -n option tells grep to display the line number of the lines containing a string that matches a pattern
# The -f option tells cut to display only first field of each lines from lemoncode-output.txt file. In this case, the 1st field is the line number
# And the option -d specifies what is the field delimiter. In this case, is : (colon)
```

2. Add the execute permission for everyone 
```bash
chmod +x simple-curl-grep-bash-script.sh
```

3. Execute the script to test different scenarios
   1. Test without any parameter
      ```bash
      ./simple-curl-grep-bash-script.sh
      ```
      Result:
      ```
      Error: the parameter passed in is empty!
      ```
   2. Test with an empty parameter
      ```bash
      ./simple-curl-grep-bash-script.sh ''
      ```
      Result:
      ```
      Usage: ./simple-curl-grep-bash-script.sh text_that_you_are_looking_for
      ```
   3. Test with three parameters
      ```bash
       ./simple-curl-grep-bash-script.sh non happy scenario
      ```
      Result:
      ```
      Usage: ./simple-curl-grep-bash-script.sh text_that_you_are_looking_for
      ```
   4. Test with a non empty parameter
      ```bash
      ./simple-curl-grep-bash-script.sh 'meta'
      ```
      Result:
      ```
      5
      ```