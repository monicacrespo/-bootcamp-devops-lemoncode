# 1. Create a container with MongoDB, authenticated by user and password, add a collection, create a couple of docs and access them via MongoDB Compass
    # Steps:
    # - Locate the image in Docker Hub to create a MongoDB
docker search mongo
https://hub.docker.com/_/mongo
    # - Check what are the parameters needed to create it

# Mac #
docker run -d --name some-mongo \
    -p 27017:27017 \
    -e MONGO_INITDB_ROOT_USERNAME=mongoadmin \
    -e MONGO_INITDB_ROOT_PASSWORD=secret \
    mongo

# From Compass connect to your new MongoDB. Click on Fill option in connection fields individually:
# hostname: localhost
# port: 27017
# Authentication: Username and Password
# And do click on Connect button

# Create a database called Library and a collection called Books 
# Access it and import the file called books.json that is under the folder of this exercise
# - Check the logs
docker logs some-mongo

#├── lemoncoders-web
#│   ├── index.html
#│   └── styles.css
#│──books.json
# 2. Nginx server
#    - Create a Nginx server called lemoncoders-web and copy the content of the lemoncoders-web folder in the path that serves this web server 
#    - Run within the container the action ls, to check that the files have been copied ok
#    - The web server needs to be accesible from 9999 port of your local machine
docker run --name lemoncoders-web -d -p 9999:80 nginx 
docker cp lemoncoders-web/. lemoncoders-web:/usr/share/nginx/html/
docker exec lemoncoders-web ls /usr/share/nginx/html/

# 3. Remove all the containers that are running in your machine 
docker rm -f $(docker ps -aq)