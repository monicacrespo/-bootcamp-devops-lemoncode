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
cat file{1,2}.txt
```

### 3. Create a bash script that groups the steps from exercises 1 and 2 and set file1.txt content as the first command line argument passed in. If the first command line argument passed in is empty, the default text should be "Que me gusta la bash!!!!"

1. Create the script `simple-bash-script.sh` using vim
```bash
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

# commands from exercise 1 & 2 
mkdir -p foo/dummy foo/empty
cd foo/dummy
echo "$TEXT" > file1.txt
touch file2.txt
cp file1.txt file2.txt
mv file2.txt ../empty/
cat file{1,2}.txt
```

2. Add the execute permission for everyone 
```bash
chmod +x simple-bash-script.sh
```

3. How to execute the script
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
        ./simple-bash-script.sh ""
        ```
        Result:
        ```
        Que me gusta la bash!!!!
        Que me gusta la bash!!!!
        ```

    3. Test with a non empty parameter
        ```bash
        ./simple-bash-script.sh "Hi, this is awesome!!!"
        ```
        Result:
        ```
        This is awesome!
        This is awesome!
        ```


### 4. Optional - Create a bash script to download the web page content to a file. Once downloaded to a file, search it for a given string (text passed in as a command line argument) and display the line number of the lines containing that string.

1. Create the script `simple-curl-grep-bash-script.sh` using vim
```bash
#! /bin/bash

curl --silent -o ./lemoncode-response.txt https://campus.lemoncode.net/

# $1 is the first commandline argument
if [ "$1" = "" ]; then
	echo "The pattern is empty!"
else
	# The -n option tells grep to show the line number of the lines containing a string that matches a pattern
	grep -i -n "$1" ./lemoncode-response.txt
fi
```

2. Add the execute permission for everyone 
```bash
chmod +x simple-curl-grep-bash-script.sh
```

3. How to execute the script
   1. Test without any parameter
      ```bash
      ./simple-curl-grep-bash-script.sh
      ```
      Result:
      ```
      The pattern is empty!
      ```
   2. Test with "meta" as parameter
      ```bash
      ./simple-curl-grep-bash-script.sh "meta"
      ```
      Result:
      ```
      5:    <meta charset="utf-8" />
      8:    <meta name="viewport" content="width=device-width, initial-scale=1" />
      ```