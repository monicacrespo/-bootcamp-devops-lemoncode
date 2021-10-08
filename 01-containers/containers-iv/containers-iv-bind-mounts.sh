# Part 4: Bind mounts #
#https://docs.docker.com/storage/bind-mounts/

#It is used when a file or directory on the host machine is mounted into a container
cd 01-containers/containers-iv

#"$(pwd)"/dev-folder is the full path to the directory on the Docker daemon host. It must be absolute path, not a relative path
# pwd gets the current folder
pwd
# nginx will serve the content of the directory, so we need to found this info in Docker Hub
docker run -d --name devtest --mount type=bind,source="$(pwd)"/dev-folder,target=/usr/share/nginx/html/ -p 8080:80 nginx
docker inspect devtest
#"Mounts": [
#            {
#                "Type": "bind",
#                "Source": "/run/desktop/mnt/host/c/Temporary/Training_IT_DevOps/BootCampDevOps/bootcamp-devops-student/01-containers/containers-iv/dev-folder",
#                "Destination": "/usr/share/nginx/html",
#                "Mode": "",
#                "RW": true,
#                "Propagation": "rprivate"
#            }
#        ],
#This shows that the mount is a bind mount, it shows the correct source and destination, 
#it shows that the mount is read-write. 
# Browse localhost:8080
# Now change on the host the content of the directory dev-folder
# Browse localhost:8080 and you will see the changes
# For some development applications, the container needs to write into the bind mount, so changes are propagated back to the Docker host
# Go to Visual Studio Code, Docker, Containers, locate on nginx devtest container, Right click, Attach shell>
#> Executing task: docker exec -it 0da9494381bd9cbcd7ecee3d12838ff5ea0dd4fb642217e24e53e3270d59f277 bash <
#root@0da9494381bd:/# touch /usr/share/nginx/html/file1
#root@0da9494381bd:/#

#How to use bind mount as read-only
docker rm -f devtest
docker run -d --name devtest --mount type=bind,source="$(pwd)"/dev-folder,target=/usr/share/nginx/html/,readonly -p 8080:80 nginx
docker inspect devtest

#Because is in read-only mode, you can not create any file within the directory where it is mounted 
docker container exec -it devtest sh
ls /usr/share/nginx/html
touch /usr/share/nginx/html/index2.html #It will give you an error
exit