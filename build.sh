#!/bin/bash

docker build -t portnumber53/rpi-nginx .

docker push portnumber53/rpi-nginx
