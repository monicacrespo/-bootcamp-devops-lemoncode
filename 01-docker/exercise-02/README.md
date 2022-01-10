
### Project structure 

```
├── exercise-02
│   ├── backend
│   ├── frontend
│   ├── docker-compose.yml
│   ├── README.md
│   ├── topics.json
```

# Steps:
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
        ports:
        - "27017:27017"
        restart: always
        networks: 
            - lemoncode-challenge
    topics-api:
        depends_on:
        - some-mongo
        build: 
        context: ./backend
        dockerfile: Dockerfile
        ports:
        - "5000:5000"
        restart: always
        environment:
        - ASPNETCORE_ENVIRONMENT=Development
        - "TopicstoreDatabaseSettings:ConnectionString=mongodb://some-mongo:27017"
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
        API_URI: http://topics-api:5000/api/topics      
        networks: 
        - lemoncode-challenge
    volumes:
        topics-data:
    networks:
        lemoncode-challenge:
    ```

2. Run below command on top of project folder which include docker-compose.yml files to launch the containers and run the app(s).

    ```
    docker-compose --project-name lemoncode-challenge-docker up --build -d
    ```
   
    - `--build` Build is used to build all of the containers using their individual DOCKERFILEs 
    - `-d` Detached mode: Run containers in the background

    Open up a browser and type http://localhost:8080 to get the topics. 8080 is our external port remember that maps to the internal port 3000 (-p [external port]:[internal port]).

2. Make sure our containers are up
    ```
    docker-compose -p lemoncode-challenge-docker ps
    ```
3. To stop the containers run the following command
    ```
    docker-compose -p lemoncode-challenge-docker stop
    ```
4. To remove the containesrs once stopped
    ```
    docker-compose -p lemoncode-challenge-docker rm
    ```
5. Stops containers and removes containers, networks, volumes, and images created by up.
  
    ```
    docker-compose -p lemoncode-challenge-docker down
    ```
