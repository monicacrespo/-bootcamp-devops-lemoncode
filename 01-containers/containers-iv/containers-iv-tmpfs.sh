# Part 4: Tmpfs mounts #
#https://docs.docker.com/storage/tmpfs/

#It is used when a file or directory on the host machine is mounted into a container
cd 01-containers/containers-iv

#Tmpfs mount
docker run -dit --name tmptest --mount type=tmpfs,destination=/usr/share/nginx/html/ nginx:latest
docker container inspect tmptest 

#You can use the parameter --tmpfs
docker run -dit --name tmptest2 --tmpfs /app nginx:latest

docker container inspect tmptest2 | grep "Tmpfs" -A 2