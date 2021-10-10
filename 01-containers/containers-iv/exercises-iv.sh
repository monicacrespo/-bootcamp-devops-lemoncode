#Exercises:
#1. Create a container with a volume called images and uses the 0gis0/galleryapp image
#1.1 The volume must be mounted into the images directory within WORKDIR in the container 
docker build gallery-app/. -t galleryapp
docker run  -p 9000:8080 --mount source=images,target=/usr/src/app/images galleryapp

#Copy some images using docker cp command
docker ps
#CONTAINER ID   IMAGE        COMMAND                  CREATED          STATUS          PORTS                    NAMES
#46c6eaf87e4b   galleryapp   "docker-entrypoint.s…"   24 minutes ago   Up 24 minutes   0.0.0.0:9000->8080/tcp   epic_johnson
docker cp some-images/. epic_johnson:/usr/src/app/images

# 2. Remove the previous container and verify that your volume is still available
docker rm -f epic_johnson
#You can see the volume is still available with the following command
docker volume ls
#DRIVER    VOLUME NAME
#local     data       
#local     dbdata     
#local     images     
#local     my-data 

# Or via Visual Studio Code's Docker section on the left most pane
# You can see the content of the volume by 
# a. Using the option *Explore in Development Container* when you are on the volume and right click
# b. Creating another container as follows:
# 3. Map a local folder to a container. Modify the content of that folder and verify that you see the changes within the container
docker run  -p 9000:8080 --mount type=bind,source=some-images,target=/usr/src/app/images galleryapp
#: Error response from daemon: invalid mount config for type "bind": invalid mount path: 'some-images' mount path must be absolute
#The following commands work and will map the local folder $(pwd)/some-images to a container
docker run  -p 9000:8080 --mount type=bind,source=/c/Temporary/Training_IT_DevOps/BootCampDevOps/bootcamp-devops-student/01-containers/containers-iv/some-images,target=/usr/src/app/images galleryapp

docker run  -p 9000:8080 --mount type=bind,source=$(pwd)/some-images,target=/usr/src/app/images galleryapp