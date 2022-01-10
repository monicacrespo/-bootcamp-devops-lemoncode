# Docker Exercises

### Application structure 

The application consists of three parts:

* A front-end in Node.js
* A backend API in .NET that uses a MongoDB to store the data
* A MongoDB database

### Solution structure 

```
├── exercise-01
├── exercise-02
├── lemoncode-challege
├── README.md
```

In more detail:

```
├── exercise-01
│   ├── backend
│   	├── Dockerfile
│   ├── frontend
│   	├── Dockerfile
│   ├── README.md
│   ├── topics.json
├── exercise-02
│   ├── backend
│   	├── Dockerfile
│   ├── frontend
│   	├── Dockerfile
│   ├── docker-compose.yml
│   ├── README.md
│   ├── topics.json
├── lemoncode-challege
│   ├── backend
│   ├── frontend
│   ├── topics.json
│   ├── README.md
├── README.md
```

### exercise-01. Dockerize the application within lemoncode-challenge folder with the following Acceptance Criteria:

1. The three components must be within the same network called lemoncode-challenge.
2. The backend must connect to the mongodb via this URL mongodb://some-mongo:27017
3. The front-end must connect to the api through http://topics-api:5000/api/topics
4. The front-end is mapped to port 8080 of the localhost.
5. The MongoDB must store the data that is generating in one volume, mounted into the /data/db directory.
6. The MongoDB must have a database called TopicstoreDb with a collection called Topics. 

### exercise-02. Now that you have the exercise-01's application dockerized, use Docker Compose to launch all the components. You need to use: the network, MongoDB's volume, environment variables and ports exposed by the web and API.
You also need to describe the commands you would use to bring up the envirsonment, stop and delete it.

### lemoncode-challege. This folder contains the application's code AS IS, without any changes.