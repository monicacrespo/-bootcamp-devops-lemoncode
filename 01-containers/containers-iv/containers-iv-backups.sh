# Part 4: Backups #

#It is used when a file or directory on the host machine is mounted into a container
cd 01-containers/containers-iv

#Create a container with a volume called dbdata. Here, I will use -v instead of --mount
docker run -dit -v dbdata:/dbdata --name dbstore ubuntu /bin/bash

#Verify that the dbdata volume exists
docker volume ls
#DRIVER    VOLUME NAME
#local     data
#local     dbdata
#local     my-data

#Now I copy some files within the volume
docker cp some-files/. dbstore:/dbdata

#Verify the files are there
#docker exec dbstore ls /dbdata
#file1.txt
#file2.txt
#file3.txt

#Create a new container and mount the volume/s of dbstore container
#Run the tar command that compresses the content
#--volumes-from		Mount volumes from the specified container(s)
#--volume , -v		Bind mount a volume
#--rm		        Automatically remove the container when it exits
docker run --rm --volumes-from dbstore -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /dbdata

#Remove a volume 
docker volume rm data

#You can not remove a volume if is used by a container
docker volume rm my-data

#Remove all volume that are not attached to any container
docker volume prune -f