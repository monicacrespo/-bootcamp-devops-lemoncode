# AS IS Application structure 

```
├── 1.lemoncode-challenge
│   ├── backend
│   ├── frontend
│   ├── README.md
```

The 1.lemoncode-challenge folder contains the application's code AS IS, without any changes, provided by Lemoncode. 

Note that to run the app locally, ensure you have installed 
`.NET core 3.1`, `mongodb`, `NPM`, `Nodejs` and `Express`.


# Steps to set up and run the three components of the application 

### Steps to set up the MongoDB database

The only component we don't have is the MongoDB. So start creating a Docker container with MongoDB, and use the  MongoDB Compass client to add records.

1. Create a Docker container named `some-mongo` using the mongo image.

    ```
    docker run --name some-mongo -p 27017:27017 -d mongo
    ```

2. Make sure some-mongo container has been created properly. From MongoDB Compass connect to your new MongoDB and enter the following connection string:
    ```
    mongodb://localhost:27017
    ```

3. Create a database called TopicstoreDb and a collection called Topics. This collection has this structure:
    ```
    {"_id":{"$oid":"5fa2ca6abe7a379ec4234883"},"Name":"Docker"} 
    ```
    I have created the file called topics.json for you to get few records. You need to import it.
   
    ![MongoDB Compass topics](https://github.com/monicacrespo/bootcamp-devops-student/blob/main/01-docker/1.lemoncode-challenge/images/MongoDBCompass.JPG)


### Steps to run the backend API

1. Open the backend folder in VS Code and run its code by typing `dotnet run`

2. Browse the topics using the backend api directly `http://localhost:5000/api/topics`

    ![Backend topics](https://github.com/monicacrespo/bootcamp-devops-student/blob/main/01-docker/1.lemoncode-challenge/images/BackEndTopics.JPG)

### Steps to run the frontend

1. Open the fronted folder in VS Code and run first `npm install` 
2. Once installed the dependencies you can run it with `npm start`
3. Browse the topics using the frontend `http://localhost:3000`

    ![Frontend topics](https://github.com/monicacrespo/bootcamp-devops-student/blob/main/01-docker/1.lemoncode-challenge/images/FrontEndTopics.JPG)
