# Exercise 1
Create a container with a volume called images and uses the 0gis0/galleryapp image

```
docker build gallery-app/. -t galleryapp
```

The volume must be mounted into the images directory within WORKDIR in the container 

```
docker run  -p 9000:8080 --mount source=images,target=/usr/src/app/images galleryapp
```

```
docker ps
```

| CONTAINER ID  | IMAGE | COMMAND| CREATED|STATUS|PORTS|NAMES|
| ------------- | ------------- |--|--|--|--|--|
| 46c6eaf87e4b  | galleryapp | "docker-entrypoint.s…"| 24 minutes ago|Up 24 minutes|0.0.0.0:9000->8080/tcp|epic_johnson|

Copy some images using docker cp command

```
docker cp some-images/. epic_johnson:/usr/src/app/images
```
# Exercise 2
Remove the previous container and verify that your volume is still available
```
docker rm -f epic_johnson
```

You can see the "images" volume is still available with the following command
```
docker volume ls
```
| DRIVER  | VOLUME NAME |
| ------------- | ----- |
| local |data |
| local |dbdata |
| local |images |
| local |my-data |

Or via Visual Studio Code's Docker section on the left most pane, you can see the content of the volume by using the option *Explore in Development Container* when you are on the volume and right click

# Exercise 3
Create a container that uses "galleryapp" image and uses bind mount on a local folder where you have images. It must be mounted on the WORKDIR's images folder into the container.

```
docker run  -p 9000:8080 --mount type=bind,source=some-images,target=/usr/src/app/images galleryapp

#: Error response from daemon: invalid mount config for type "bind": invalid mount path: 'some-images' mount path must be absolute
```

The following commands will map the local folder $(pwd)/some-images to a container
```
docker run  -p 9000:8080 --mount type=bind,source=/c/Temporary/Training_IT_DevOps/BootCampDevOps/bootcamp-devops-student/01-containers/containers-iv/some-images,target=/usr/src/app/images galleryapp
```
Or
```
docker run  -p 9000:8080 --mount type=bind,source=$(pwd)/some-images,target=/usr/src/app/images galleryapp
```

Then, modify the content of that folder and verify that you see the changes within the container.
When you use a bind mount, a file or directory on the host machine is mounted into a container.
