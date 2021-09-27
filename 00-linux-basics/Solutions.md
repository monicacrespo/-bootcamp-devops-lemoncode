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

# 4. Opcional - Crea un script de bash que descargue el conetenido de una página web a un fichero.
