#!/bin/bash

# https://hub.docker.com/r/evild/alpine-nginx/

TAG="1.10.1-openssl"
IMAGE="evild/alpine-nginx:$TAG"

OPTS=$(cat << EOS
-p 80:80
-p 443:443
-v $(pwd)/etc/nginx:/etc/nginx
-v $(pwd)/log:/var/log/nginx
--add-host myproxy:10.0.2.15
--name nginx
$IMAGE
EOS
)

case $1 in
  exec)
    docker exec -it nginx /bin/sh
    ;;
  *)
    node lib/server.js &
    docker run $OPTS
    docker kill nginx
    docker rm -v nginx
    ps | grep node | cut -f2 -d " " | xargs kill -9
    ;;
esac
