# 1. Crea mediante comandos de bash la siguiente jerarquía de ficheros y directorios.
vagrant@ubuntu-client:~$ ls
vagrant@ubuntu-client:~$ mkdir -p foo/dummy
vagrant@ubuntu-client:~$ ls
foo
vagrant@ubuntu-client:~$ cd foo/dummy
vagrant@ubuntu-client:~/foo/dummy$ touch file1.txt
vagrant@ubuntu-client:~/foo/dummy$ ls
file1.txt
vagrant@ubuntu-client:~/foo/dummy$ cp file1.txt file2.txt
vagrant@ubuntu-client:~/foo/dummy$ ls
file1.txt  file2.txt
vagrant@ubuntu-client:~/foo/dummy$ cat <<EOF >file1.txt
> Me encanta la bash!!
> EOF
vagrant@ubuntu-client:~/foo/dummy$ cat file1.txt
Me encanta la bash!!
vagrant@ubuntu-client:~/foo/dummy$ cat file2.txt
vagrant@ubuntu-client:~/foo/dummy$ cd ..
vagrant@ubuntu-client:~/foo$ mkdir empty
vagrant@ubuntu-client:~/foo$ ls
dummy  empty
vagrant@ubuntu-client:~/foo$


# 2. Mediante comandos de bash, vuelca el contenido de file1.txt a file2.txt y mueve file2.txt a la carpeta empty.
vagrant@ubuntu-client:~/foo$ cd dummy
vagrant@ubuntu-client:~/foo/dummy$ ls
file1.txt  file2.txt
vagrant@ubuntu-client:~/foo/dummy$ cat file1.txt
Me encanta la bash!!
vagrant@ubuntu-client:~/foo/dummy$ cat file2.txt
vagrant@ubuntu-client:~/foo/dummy$ cp file1.txt file2.txt
vagrant@ubuntu-client:~/foo/dummy$ cat file2.txt
Me encanta la bash!!
vagrant@ubuntu-client:~/foo/dummy$ mv file2.txt ../empty/
vagrant@ubuntu-client:~/foo/dummy$ ls
file1.txt
vagrant@ubuntu-client:~/foo/dummy$ cd ..
vagrant@ubuntu-client:~/foo$ ls empty/
file2.txt


# 3. Crear un script de bash que agrupe los pasos de los ejercicios anteriores y además permita establecer el texto de file1.txt alimentándose como parámetro al invocarlo.

# 3.1. Create a bash script called simple-bash-script.sh using vim. See below
# 3.2. Add the execute permission for everyone  =>  chmod +x simple-bash-script.sh 
# 3.3. How to test:
# $ ./simple-bash-script.sh
# Que me gusta la bash!!!!
# Que me gusta la bash!!!!
# Que me gusta la bash!!!!
# Que me gusta la bash!!!!

# $ ./simple-bash-script.sh ""
# Que me gusta la bash!!!!
# Que me gusta la bash!!!!
# Que me gusta la bash!!!!
# Que me gusta la bash!!!!

# $ ./simple-bash-script.sh "Hi, this is awesome!!!"
# This is awesome!
# This is awesome!
# This is awesome!
# This is awesome!

# -------- Start of "simple-bash-script.sh" file -------- #
#! /bin/bash

DIR="./foo/"
if [ -d "$DIR" ]; then
    # Take action if $DIR exists #
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

# -------- End of "simple-bash-script.sh" file  ------ #

# 4. Opcional - Crea un script de bash que descargue el conetenido de una página web a un fichero. Una vez descargado el fichero, que busque en el mismo una palabra dada (esta se pasará por parametro) y muestre por pantalla el número de linea donde aparece.

# 4.1. Create a bash script called simple-curl-grep-bash-script.sh using vim. See below
# 4.2. Add the execute permission for everyone  =>  chmod +x simple-curl-grep-bash-script.sh 
# 4.3. How to test:
# $ ./simple-curl-grep-bash-script.sh "meta"
# 5:    <meta charset="utf-8" />
# 8:    <meta name="viewport" content="width=device-width, initial-scale=1" />
# $ ./simple-curl-grep-bash-script.sh
# The pattern is empty!

# -------- Start End of "simple-curl-grep-bash-script.sh" file  ------ #
#! /bin/bash

curl --silent -o ./lemoncode-response.txt https://campus.lemoncode.net/

# $1 is the first commandline argument
if [ "$1" = "" ]; then   
    echo "The pattern is empty!"
else
    # The -n option tells grep to show the line number of the lines containing a string that matches a pattern
    grep -i -n "$1" ./lemoncode-response.txt
fi

# -------- End of "simple-curl-grep-bash-script.sh" file  ------ #

