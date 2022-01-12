# Exercise 2. Use Docker Compose to improve Developer Experience
Now that you have the exercise-01's application dockerized, use Docker Compose to launch all the components. 
You need to use the network, MongoDB's volume, environment variables and ports exposed by the web and API.
You also need to describe the commands you would use to bring up the environment, stop and delete it.

### exercise-02 solution structure 

```
├── 3.exercise-02
├── backend
│   	├── Dockerfile
│   ├── frontend
│   	├── Dockerfile
│   ├── docker-compose.yml
│   ├── README.md
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
        - MONGO_URI=mongodb://some-mongo:27017
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

2. Run below command on top of project folder which include docker-compose.yml files to launch the containers and run the app(s)

    ```
    docker-compose --project-name lemoncode-challenge-docker up --build -d
    ```
   
    - `--build` Build is used to build all of the containers using their individual DOCKERFILEs 
    - `-d` Detached mode: Run containers in the background

    
    Make sure our containers are up
    ```
    docker-compose -p lemoncode-challenge-docker ps
    ```

    Open up a browser and type http://localhost:8080 to get the topics

3. To stop the containers run the following command
    ```
    docker-compose -p lemoncode-challenge-docker stop
    ```
4. To remove the containesrs once stopped run the following command
    ```
    docker-compose -p lemoncode-challenge-docker rm
    ```
5. To stop containers and remove containers, networks, volumes, and images created by up, run the following command
  
    ```
    docker-compose -p lemoncode-challenge-docker down
    ```
