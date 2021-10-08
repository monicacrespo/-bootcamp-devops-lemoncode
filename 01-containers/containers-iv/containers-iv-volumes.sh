# Part 4: Volumes #
#https://docs.docker.com/storage/volumes/
cd 01-containers/containers-iv

#Remove all local volumes not used by at least one container
docker volume prune

#Create a volume
docker volume create data

#List the volumes in the host
docker volume ls
#DRIVER    VOLUME NAME
#local     data

#Start a container with a volume
#If you start a container with a volume that does not yet exist, Docker creates the volume for you. 
#--mount: Consists of multiple key-value pairs, separated by commas and each consisting of a <key>=<value> tuple. 
#The --mount syntax is more verbose than -v or --volume, but the order of the keys is not significant.
#The source of the mount. For named volumes, this is the name of the volume. For anonymous volumes, this field is omitted. 
#May be specified as source or src.
#The destination takes as its value the path where the file or directory is mounted in the container. 
#May be specified as destination, dst, or target.
#The following example mounts the volume my-data into /vol/ in the container.
# --mount example
docker container run -dit --name my-container -d --mount source=my-data,target=/vol nginx
# -v example
docker container run -dit --name my-container -v my-data:/vol nginx

#To verify that the volume was created and mounted correctly
docker volume ls
#DRIVER    VOLUME NAME
#local     data
#local     my-data

#Inspect the volume
docker volume inspect my-data
#[
#    {
#        "CreatedAt": "2021-10-07T11:15:50Z",
#        "Driver": "local",
#        "Labels": null,
#        "Mountpoint": "/var/lib/docker/volumes/my-data/_data",
#        "Name": "my-data",
#        "Options": null,
#        "Scope": "local"
#    }
#]

#You can have same data volume attached to multiple containers at the same time
docker container run -dit --name my-container2 -d --mount source=my-data,target=/vol2 nginx

#How to determine what containers use the docker volume
docker ps --filter volume=my-data --format "table {{.Names}}\t{{.Mounts}}"
#NAMES           MOUNTS
#my-container2   my-data
#my-container    my-data

#Add some data to our volume
docker container exec -it my-container sh
echo "Hola Lemoncoders!" > /vol/file1
ls -l /vol
cat /vol/file1
exit

#Remove the containers
docker rm -f $(docker ps -aq)

#But the volume still exists
docker volume ls

#So I will create a new container and attach the volume I have (my-data)
docker container run -dit --name another-container --mount source=my-data,target=/vol alpine

#Verify that your file1 does exist
docker container exec -it another-container sh
ls -l /vol
cat /vol/file1
exit

#On Mac and Windows you can not see the path's content where the volumes are stored
#You won’t find the volumes in folders on Windows/Mac filesystem
#On Linux we could:
vagrant up
vagrant ssh (ssh vagrant@192.168.50.4)

#Create the volumes on VM running Ubuntu
sudo docker container run -dit --name my-container \
    --mount source=my-data,target=/vol \
    alpine
docker ps
#CONTAINER ID   IMAGE     COMMAND     CREATED          STATUS          PORTS     NAMES
#8c3d9e8ea271   alpine    "/bin/sh"   12 seconds ago   Up 10 seconds             my-container

sudo docker volume create data

#Volumes are stored in a part of the host filesystem which is managed by Docker 
# ( /var/lib/docker/volumes/ on Linux)
sudo docker volume inspect my-data
#[
#    {
#        "CreatedAt": "2021-10-07T10:13:57Z",
#        "Driver": "local",
#        "Labels": null,
#        "Mountpoint": "/var/lib/docker/volumes/my-data/_data",
#        "Name": "my-data",
#        "Options": null,
#        "Scope": "local"
#    }
#]

sudo ls -l /var/lib/docker/volumes
#total 32
#brw------- 1 root root 253, 0 Oct  7 10:11 backingFsBlockDev
#drwx-----x 3 root root   4096 Oct  7 10:14 data
#-rw------- 1 root root  32768 Oct  7 10:14 metadata.db
#drwx-----x 3 root root   4096 Oct  7 10:13 my-data

exit