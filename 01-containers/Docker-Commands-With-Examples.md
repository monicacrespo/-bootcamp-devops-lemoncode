# ###### Images ###### #
docker images
# List all the docker images pulled on the system with image details such as #TAG/IMAGE ID/SIZE etc.

docker image ls
# REPOSITORY                      TAG           IMAGE ID       CREATED        SIZE  
# galleryapp                      latest        aeedddacd946   4 days ago     128MB 
# ubuntu                          latest        597ce1600cf4   12 days ago    72.8MB
# simple-apache                   new           9b808d1630a5   13 days ago    138MB 
# nginx                           latest        f8f4ffc8092c   2 weeks ago    133MB 
# mcr.microsoft.com/mssql/server  2019-latest   56beb1db7406   2 months ago   1.54GB

# Filter by reopository's name
docker images nginx

# Filter by reopository's name and tag
docker images mcr.microsoft.com/mssql/server:2019-latest

# Using --filter
docker images --filter="label=maintainer=NGINX Docker Maintainers <docker-maint@nginx.com>"
# REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
# nginx        latest    f8f4ffc8092c   2 weeks ago   133MB


# ###### Downloading image ###### #

# ###### Run ###### # 
# .
# ├── lemoncoders-web
# │   ├── index.html
# │   └── styles.css
# │──books.json
# Run the docker image mentioned in the command. This command will create a docker container (lemoncoders-web) in which the Nginx server will run. The web server needs to be accesible from 9999 port of your local machine.
# Nginx is a Docker Hub image. Docker Hub is Docker's official registry.
docker run --name lemoncoders-web -d -p 9999:80 nginx 

# Copy the content of the lemoncoders-web folder in the path that serves this web server
docker cp lemoncoders-web/. lemoncoders-web:/usr/share/nginx/html/

# Access web server from host browser
# http://localhost:9999

# Run within the container the action ls, to check that the files have been copied ok
docker exec lemoncoders-web ls /usr/share/nginx/html/


# Create multiple containers from the same image
docker run -d --rm -p 7070:80 nginx
docker run -d --rm -p 6060:80 nginx



#### Create your own image ####

# .
# ├── /home/vagrant/
# │   ├── Dockerfile
# │   ├── Vagrantfile
# │   └── public-html
# │       └── index.html

cat Dockerfile
# Apache HTTP web server image that I will use as the starting point
FROM httpd:2.4

# Use the LABEL instruction in a Dockerfile to define image metadata. 
# Labels are similar to environment variables in that they are key value pairs attached to an image or a container. 
# Labels are different from environment variable in that they are not visible to the running application and
# they can also be used for fast look-up of images and containers.
LABEL maintainer="moni.crespo@gmail.com"
LABEL project="lemoncode"

# Metadata to signal that the container uses the port 80
# EXPOSE is often used as a documentation mechanism -- that is, just to signal to the user what port will be providing services
EXPOSE 80

# Updates on the image used as the starting point.
# Copy over the content, which is our HTML and CSS pages, into Apache’s docroot which is /usr/local/apache2/htdocs/
COPY content/ /usr/local/apache2/htdocs/


# Create an Apache web server image using Dockerfile that serves the static content from content folder
docker build . -t simple-apache:new
# or
docker build . --tag simple-apache:new
# or 
docker build containers-ii/ -t simple-apache:new

# Run the new image inside of a container
docker run -d --name myapache -p 5050:80 simple-apache:new
# Access web server from host browser
# http://localhost:5050


# Find out how many layers has the new image
docker inspect simple-apache:new 

# Count in "Layers" section. There are six layers 
docker history simple-apache:new # All actions < 0B are layers

# Dive: tool to explore images. It shows all layers of a image
# How to install it on Ubuntu/Debian?
# wget https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb
# sudo apt install ./dive_0.9.2_linux_amd64.deb
# How to install it on Windows?
# Download the latest release, dive_0.9.2_windows_amd64
# ├── dive_0.9.2_windows_amd64
# │   ├── dive.exe
# │   ├── README.md
# │   ├── LICENSE
# How to use it?
dive simple-apache:new 



# Remove all the containers that are running in your machine 
docker rm -f $(docker ps -aq)