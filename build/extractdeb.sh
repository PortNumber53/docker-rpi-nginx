#!/bin/bash -e

containerID=$(docker run -d portnumber53/buildnginx)
docker cp $containerID:/root/build/nginx_1.11.8-1~jessie_armhf.deb .
sync
sleep 1
docker rm $containerID
