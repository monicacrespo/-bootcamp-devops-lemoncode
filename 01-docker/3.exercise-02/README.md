# Exercise 2. Use Docker Compose to improve Developer Experience
Now that you have the exercise-01's application dockerized, use Docker Compose to launch all the components. 

You need to use the network, MongoDB's volume, environment variables and ports exposed by the web and API.

You also need to describe the commands you would use to bring up the environment, stop and delete it.

### exercise-02 solution structure 

```
├── 3.exercise-02
├── backend
│   	├── Dockerfile
│   	├── appsettings.json
│   ├── frontend
│   	├── Dockerfile
│   ├── docker-compose.yml (new)
│   ├── README.md (new)
```

### Steps:

1. Create the docker-compose.yml file

    Docker-compose.yml is a command-line file used during development and testing, where necessary definitions are made for multi-container running applications.

    Docker-compose.yml
    ```
    version: '3.4'

    services:
    some-mongo:
        image: mongo:latest
        volumes:
        - topics-data:/data/db   
        restart: always
        networks:
            - lemoncode-challenge
    topics-api:
        depends_on:
        - some-mongo
        build: 
        context: ./backend
        dockerfile: Dockerfile
        restart: always
        networks: 
        - lemoncode-challenge
    frontend-web:
        depends_on:
        - topics-api
        build: 
        context: ./frontend
        dockerfile: Dockerfile
        ports:
        - "8080:3000"
        restart: always
        environment:
        - API_URI=http://topics-api:5000/api/topics
        networks: 
        - lemoncode-challenge
    volumes:
        topics-data:
    networks:
        lemoncode-challenge:
    ```

2. Bringup the containers
   Run below command on top of project folder which include docker-compose.yml files to launch the containers and run the app(s)

    ```
    docker-compose --project-name lemoncode-challenge-docker up --build -d
    ```
   
    - `--build` Build is used to build all of the containers using their individual DOCKERFILEs 
    - `-d` Detached mode: Run containers in the background

    
3. Checking container status
    ```
    docker-compose -p lemoncode-challenge-docker ps
    ```

    |NAME            |                            COMMAND         |         SERVICE    |         STATUS  |            PORTS|
     | ------------- | ------------------|-------------------|--------|-------|
    |lemoncode-challenge-docker-frontend-web-1  | "docker-entrypoint.s…"  | frontend-web   |     running  |           0.0.0.0:8080->3000/tcp |
    |lemoncode-challenge-docker-some-mongo-1 | "docker-entrypoint.s…"  | some-mongo |        running   |          27017/tcp|
    |lemoncode-challenge-docker-topics-api-1 |    "dotnet backend.dll" |    topics-api   |       running    |         5000/tcp|    

    Open up a browser and type http://localhost:8080 to get the topics


4. Stop and remove containers and networks created by up
  
    ```
    docker-compose -p lemoncode-challenge-docker down
    ```
    By default, the only things removed are:
     - Containers for services defined in the Compose file
     - Networks defined in the networks section of the Compose file

5. Down and remove images
   To remove the base images that are used by the services use the flag `--rmi 'all'`

    ```
    docker-compose -p lemoncode-challenge-docker down --rmi 'all'
    ```

    Now the images have been cleaned up as well as the containers and network

    ```
    - Container lemoncode-challenge-docker-frontend-web-1     Removed              12.1s 
    - Container lemoncode-challenge-docker-topics-api-1       Removed               0.8s
    - Container lemoncode-challenge-docker-some-mongo-1       Removed               1.8s 
    - Image lemoncode-challenge-docker_topics-api             Removed               2.6s 
    - Image mongo:latest                                      Removed               2.6s 
    - Image lemoncode-challenge-docker_frontend-web           Removed               2.6s 
    - Network lemoncode-challenge-docker_lemoncode-challenge  Removed               0.2s
    ```
6. Down and remove volumes
   To remove named volumes declared in the volumes section of the Compose file use the flag `--volumes` or `-v`

    ```
    docker-compose -p lemoncode-challenge-docker down --volumes
    ```

7. Stop and remove containers, networks + Remove volumes, images 

    ```
    docker-compose -p lemoncode-challenge-docker down --volumes --rmi 'all'
    ```

8. Stop containers 
    ```
    docker-compose -p lemoncode-challenge-docker stop
    ```
    
9. Remove containers once stopped 
    ```
    docker-compose -p lemoncode-challenge-docker rm
    ```
