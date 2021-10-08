# Part 4: Bind mounts #
#https://docs.docker.com/storage/bind-mounts/



### Monitoring ###

# Docker Events 
docker events

#Como los eventos son en tiempo real, necesitamos crear/modificar/eliminar algo que nos permita generar dichos eventos.
#Abre otro terminal y ejecuta estos comando:
docker run --name prueba -d ubuntu sleep 100
docker volume create prueba
docker pull busybox

#Métricas de un contenedor

#Puedes ver las métricas de un contenedor con docker stats. Este comando muestra CPU, memoria en uso, límite de memoria y red
docker run --name ping-service -d alpine ping docker.com 

docker stats ping-service

#Otro comando que puede ser útil es el que nos dice cuánto espacio estamos usando del disco por "culpa" de Docker
docker system df

#Recolectar métricas de Docker con Prometheus
#Docker Desktop for Mac / Docker Desktop for Windows: Click en el icono de Docker en la barra de Mac/Window, selecciona Preferencias > Docker Engine. Pega la siguiente configuración:  
{
  "metrics-addr" : "127.0.0.1:9323",
  "experimental" : true
}

#Con esta configuración Docker expondrá las metricas por el puerto 9323.
#Lo siguiente que necesitamos es ejecutar un servidor de Prometheus. El archivo prometheus-config.yml tiene la configuración de este.
docker run --name prometheus-srv --mount type=bind,source="$(pwd)"/prometheus-config.yml,target=/etc/prometheus/prometheus.yml -p 9090:9090 prom/prometheus

#Ahora puedes acceder a tu servidor de Prometheus a través de http://localhost:9090. Verás que aparece en Targets pero no podrás acceder a los endpoints si utilizas Docker for Mac/Windows
#Para comprobar que las gráficas funcionan correctamente, genera N contenedores que estén haciendo continuamente ping
docker run -d alpine ping docker.com 

#Verás que la gráfica con la métrica engine_daemon_network_actions_seconds_count genera picos. Después de haberlo probado elimina los contenedores

#Ver esta información en un Dashboard de Grafana
docker run -d -p 3000:3000 grafana/grafana

#Cómo ver los logs de un contenedor
docker logs devtest

#docker logs en fluentd

#Archivo de configuración de fluentd
cat fluentd/in_docker.conf

#Inicia fluentd en un contenedor. Utilizo bind mount para montar el contenido de in_docker.conf en el archivo fluentd/etc/fluent.conf
#asegurate de que estás en 01-contenedores/contenedores-v
docker run -it -p 24224:24224 -v "$(pwd)"/fluentd/in_docker.conf:/fluentd/etc/test.conf -e FLUENTD_CONF=test.conf fluent/fluentd:latest

#Arranca un contenedor y lanza algunos mensajes a la salida estándar
docker run --rm -p 3030:80 --log-driver=fluentd nginx

#UI para ver los logs de Fluentd
docker run -d -p 9292:9292 -p 24224:24224 dvladnik/fluentd-ui #copia el contenido del archivo de configuración en 