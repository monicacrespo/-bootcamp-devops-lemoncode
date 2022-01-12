# Exercise 1. Dockerize an existing Node.js Express app

The existing application is located under lemoncode-challenge folder.

Acceptance Criteria:

1. The three components must be within the same network called lemoncode-challenge.
2. The backend must connect to the mongodb via this URL mongodb://some-mongo:27017
3. The front-end must connect to the api through http://topics-api:5000/api/topics
4. The front-end is mapped to port 8080 of the localhost.
5. The MongoDB must store the data that is generating in one volume, mounted into the /data/db directory.
6. The MongoDB must have a database called TopicstoreDb with a collection called Topics. 


### exercise-01 solution structure 

```
├── 2.exercise-01
│   ├── backend
│   	├── Dockerfile
│   ├── frontend
│   	├── Dockerfile
│   ├── README.md
```

### Steps in the following order
1. [NETWORK] Create a new bridge/nat network called lemoncode-challenge

    ```
    docker network create lemoncode-challenge
    ```

2. [DATABASE] Create a container named `some-mongo` with a volume called `lemoncode-topics` and using the mongo image.

    ```
    docker run --name some-mongo --network lemoncode-challenge `
        --mount source=topics-data,target=/data/db `
        -p 27017:27017 `
        -d mongo
    ```

    To check what are the parameters needed to create a MongoDB image you could go to Docker Hub https://hub.docker.com/_/mongo

    Make sure some-mongo container has been created properly.
    
    ![some-mongo-container](https://github.com/monicacrespo/bootcamp-devops-student/blob/main/01-docker/2.exercise-01/images/some-mongo-container.jpg)


    * From MongoDB Compass connect to your new MongoDB and enter the following connection string:
       
        ```
        mongodb://localhost:27017
        ```

        Create a database called `TopicstoreDb` and a collection called `Topics`. Access it and import the file called `topics.json` that is under the root folder.

    * Run the following command to ensure some-mongo container connect to the lemoncode-challenge network: `docker network inspect lemoncode-challenge`
        ```
        [
            {
                "Name": "lemoncode-challenge",
                "Id": "40461a95adc8da9760236add0adf18fcb3017a289b2112337e9fc465c4ff47aa",
                "Created": "2022-01-10T13:04:48.0595596Z",
                "Scope": "local",
                "Driver": "bridge",
                "EnableIPv6": false,
                "IPAM": {
                    "Driver": "default",
                    "Options": {},
                    "Config": [
                        {
                            "Subnet": "172.20.0.0/16",
                            "Gateway": "172.20.0.1"
                        }
                    ]
                },
                "Internal": false,
                "Attachable": false,
                "Ingress": false,
                "ConfigFrom": {
                    "Network": ""
                },
                "ConfigOnly": false,
                "Containers": {
                    "209df87c1eea791e1ae85f92992807e9f2ff0a9ae113ce9711d1c6628773f4fe": {
                        "Name": "some-mongo",
                        "EndpointID": "56f703474edd31cadd908d0db065bf91be424662c14a5a757fd119855f0bc040",
                        "MacAddress": "02:42:ac:14:00:02",
                        "IPv4Address": "172.20.0.2/16",
                        "IPv6Address": ""
                    }
                },
                "Options": {},
                "Labels": {}
            }
        ]
        ```

3. [BACKEND] Add the `Dockerfile` file within the backend directory containing the .csproj. 
    
    The Dockerfile file doesn't have an extension and is used by the `docker build` command to create a container image.
    

    In visual Studio Code you can add Docker files to your workspace by opening the Command Palette (Ctrl+Shift+P) and using `Docker: Add Docker Files to Workspace` command. The command will generate `Dockerfile` and `.dockerignore` files and add them to your workspace. For that you need to install the extension, open the Extensions view (Ctrl+Shift+X), search for docker to filter results and select Docker extension authored by Microsoft.


	Dockerfile

	```
	FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
	WORKDIR /app
	EXPOSE 5000

	ENV ASPNETCORE_URLS=http://+:5000

	FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
    WORKDIR /src
	COPY ["backend.csproj", "./"]
	RUN dotnet restore "backend.csproj"
	COPY . .
	WORKDIR "/src/."
	RUN dotnet build "backend.csproj" -c Release -o /app/build

	FROM build AS publish
	RUN dotnet publish "backend.csproj" -c Release -o /app/publish

	FROM base AS final
	WORKDIR /app
	COPY --from=publish /app/publish .
	ENTRYPOINT ["dotnet", "backend.dll"]
	```

    - `FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base` The backend app use .NET Core 3.1 so to build the image I am using the ASP.NET Core runtime image (which contains the .NET Core runtime image)
    - `EXPOSE 5000` Metadata to signal that the container uses the port 5000
   

4. [BACKEND] Build the Docker image named `backend-topics-image` from the Dockerfile that contains the backend app

    ```
    docker build -t backend-topics-image .
    ```

    After this command finishes, run `docker images` to see a list of images installed.

5. [BACKEND] Create a docker container named `backend-topics`

    ```
    docker run -d --name backend-topics `
    --network lemoncode-challenge `
    -p 5000:5000 `
    --env "TopicstoreDatabaseSettings:ConnectionString=mongodb://some-mongo:27017" `
    backend-topics-image
    ```

    - `-p 5000:5000` The backend api needs to be accesible from 5000 port of your local machine 
    - `--env "TopicstoreDatabaseSettings:ConnectionString=mongodb://some-mongo:27017"` We override the MongoDB's connection string directly on the `Models/TopicstoreDatabaseSettings.cs` class
    
    
    To use an environment variable, e.g. MONGO_URI, you need two things:
    
    1. Change line 14 of `Service/TopicService.cs` class as follows:

        ```
        --var client = new MongoClient(settings.ConnectionString);
        var client = new MongoClient(Environment.GetEnvironmentVariable("MONGO_URI"));
        ```
    2.  Create the `backend-topics` container
   
        ```
        docker run -d --name backend-topics `
        --network lemoncode-challenge `
        -p 5000:5000 `
        --env MONGO_URI=mongodb://some-mongo:27017 `
        backend-topics-image
        ```    

    Run the following command to ensure backend-topics container connect to the lemoncode-challenge network: `docker network inspect lemoncode-challenge`

    ```
    [
        {
            "Name": "lemoncode-challenge",
            "Id": "40461a95adc8da9760236add0adf18fcb3017a289b2112337e9fc465c4ff47aa",
            "Created": "2022-01-10T13:04:48.0595596Z",
            "Scope": "local",
            "Driver": "bridge",
            "EnableIPv6": false,
            "IPAM": {
                "Driver": "default",
                "Options": {},
                "Config": [
                    {
                        "Subnet": "172.20.0.0/16",
                        "Gateway": "172.20.0.1"
                    }
                ]
            },
            "Internal": false,
            "Attachable": false,
            "Ingress": false,
            "ConfigFrom": {
                "Network": ""
            },
            "ConfigOnly": false,
            "Containers": {
                "209df87c1eea791e1ae85f92992807e9f2ff0a9ae113ce9711d1c6628773f4fe": {
                    "Name": "some-mongo",
                    "EndpointID": "56f703474edd31cadd908d0db065bf91be424662c14a5a757fd119855f0bc040",
                    "MacAddress": "02:42:ac:14:00:02",
                    "IPv4Address": "172.20.0.2/16",
                    "IPv6Address": ""
                },
                "751e8a860835c7c85044606bae78b3627f93bbe3d2b9ad573859ac8beaebb0ff": {
                    "Name": "backend-topics",
                    "EndpointID": "22339edf1a24a7dc38c319efb3b4fde717d99d7aa856be371c6887deee20cf85",
                    "MacAddress": "02:42:ac:14:00:03",
                    "IPv4Address": "172.20.0.3/16",
                    "IPv6Address": ""
                }
            },
            "Options": {},
            "Labels": {}
        }
    ]
    ```

    We should be able to browse the topics using the backend api directly `http://localhost:5000/api/topics`


6. [FRONTEND] Add the `Dockerfile` document within the frontend directory

    Dockerfile

    ```
    FROM node:lts-alpine
    WORKDIR /usr/src/app
    COPY ["package.json", "package-lock.json*", "./"]
    RUN npm install --silent && mv node_modules ../
    COPY . .
    EXPOSE 3000
    CMD ["npm", "start"]
    ```

    - `WORKDIR /usr/src/app` Set the working directory to a directory inside your container image (/app). It is optional (default is /), but considered a good practice. Subsequent instructions in the Dockerfile, such as RUN, CMD and ENTRYPOINT will operate in this directory. 
    - `COPY . .` The contents of your build context directory will be copied to the /usr/src/app dir inside your docker image.
       - `src` is relative to the build context directory.
       - `dest` is relative to the WORKDIR directory.


7. [FRONTEND] Build the Docker image from the Dockerfile that contains the frontend app

    ```
    docker build -t frontend-topics-image . 
    ```
    
    - Here the current dir (`.`) is the build context directory which is the directory on the host machine where docker will get the files to build the image. It is passed to the docker build command as the last argument. In this case, `docker build` will use `Dockerfile` located in that directory. All files from that dir will be visible to docker build.

        The build context dir is not necessarily where the Dockerfile is located. Dockerfile location defaults to current dir and is otherwise indicated by the -f option. Example:

        `docker build -t myimage -f ./frontend/docker/Dockerfile ./frontend`
        
        Here build context dir is ./frontend, a subdirectory of where you call docker build; the Dokerfile location is indicated by -f.


8. [FRONTEND] Create a docker container named `frontend-topics`


    ```
    docker run --name frontend-topics `
    --network lemoncode-challenge `
    -p 8080:3000 `
    -e API_URI=http://backend-topics:5000/api/topics `
    frontend-topics-image
    ```

    - `-p 8080:3000` The frontend needs to be accesible from 8080 port of your local machine. 8080 is our external port remember that maps to the internal port 3000 (-p [external port]:[internal port]).
    - `-e API_URI=http://backend-topics:5000/api/topics` We override the API URL path that allows to access the backend API.

    
    Run the following command to ensure frontend-topics container connect to the lemoncode-challenge network: `docker network inspect lemoncode-challenge`

    ```
    [
        {
            "Name": "lemoncode-challenge",
            "Id": "40461a95adc8da9760236add0adf18fcb3017a289b2112337e9fc465c4ff47aa",
            "Created": "2022-01-10T13:04:48.0595596Z",
            "Scope": "local",
            "Driver": "bridge",
            "EnableIPv6": false,
            "IPAM": {
                "Driver": "default",
                "Options": {},
                "Config": [
                    {
                        "Subnet": "172.20.0.0/16",
                        "Gateway": "172.20.0.1"
                    }
                ]
            },
            "Internal": false,
            "Attachable": false,
            "Ingress": false,
            "ConfigFrom": {
                "Network": ""
            },
            "ConfigOnly": false,
            "Containers": {
                "209df87c1eea791e1ae85f92992807e9f2ff0a9ae113ce9711d1c6628773f4fe": {
                    "Name": "some-mongo",
                    "EndpointID": "56f703474edd31cadd908d0db065bf91be424662c14a5a757fd119855f0bc040",
                    "MacAddress": "02:42:ac:14:00:02",
                    "IPv4Address": "172.20.0.2/16",
                    "IPv6Address": ""
                },
                "751e8a860835c7c85044606bae78b3627f93bbe3d2b9ad573859ac8beaebb0ff": {
                    "Name": "backend-topics",
                    "EndpointID": "22339edf1a24a7dc38c319efb3b4fde717d99d7aa856be371c6887deee20cf85",
                    "MacAddress": "02:42:ac:14:00:03",
                    "IPv4Address": "172.20.0.3/16",
                    "IPv6Address": ""
                },
                "8a2f73017b9ad8963adf91fdb67ecb875cbcd198b57b6b0ef72d787ea194c52c": {
                    "Name": "frontend-topics",
                    "EndpointID": "bb83fbc7a591528aab9536ecd5b408234e164e73ee242b6eebe080b0d23f7b7e",
                    "MacAddress": "02:42:ac:14:00:04",
                    "IPv4Address": "172.20.0.4/16",
                    "IPv6Address": ""
                }
            },
            "Options": {},
            "Labels": {}
        }
    ]
    ```

    We should be able to browse the topics using the frontend connecting to the backend api `http://localhost:8080/api/topics`
