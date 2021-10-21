# Exercise 1
Create a new bridge/nat network called lemoncode
```
docker network create lemoncode
docker network ls
```

| NETWORK ID  | NAME | DRIVER| SCOPED|
| ------------- | ------------- |--|--|
| 622f7a6c670b  | bridge  |bridge|local|
| 46e44b47f7d8  | host  |host|local|
| ec87ccad4c95  | lemoncode  |bridge|local|
| 237f8b6c0686  | none  |null|local|

Create two containers within the newly network created as follows:
1. First one called nginx-container with the nginx image
```
docker run -d --name nginx-container --network lemoncode nginx
```
2. Second one called ubuntu-container with ubuntu image
```
docker run -dit --name ubuntu-container --network lemoncode ubuntu bash
```

Try to access to the web served by the container running the nginx server from ubuntu-container.
Note that on ubuntu-container you need to install cURL: apt update && apt upgrade && apt -y install curl

```
# With cURL and the name of the container request the web that is running with Nginx 

docker attach ubuntu-container
apt update && apt upgrade && apt -y install curl
```
```
root@7e909208187b:/# curl http://nginx-container
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

```
root@7e909208187b:/# exit
```