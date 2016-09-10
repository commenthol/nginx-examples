#!/bin/bash

# https://hub.docker.com/r/evild/alpine-nginx/
# ~19MB
IMAGE="evild/alpine-nginx:1.10.1-openssl"
# https://hub.docker.com/_/nginx/
# ~54MB 
#IMAGE="nginx:1.10.1-alpine"

OPTS=$(cat << EOS
-p 80:80
-p 443:443
-v $(pwd)/etc/nginx/conf.d:/etc/nginx/conf.d:ro
-v $(pwd)/etc/nginx/ssl:/etc/nginx/ssl:ro
-v $(pwd)/etc/nginx/html:/etc/nginx/html:ro
-v $(pwd)/log:/var/log/nginx
--add-host myproxy:10.0.2.15
--name nginx
$IMAGE
EOS
)

KILL="docker kill nginx; docker rm -v nginx"

case $1 in
	# attach to the image
  exec)
    docker exec -it nginx /bin/sh
    ;;
	# single run
  run)
    docker run $OPTS
    $KILL
    ;;
  # all together
  *)
    node lib/server.js &
    docker run $OPTS
    $KILL
    ps | grep node | cut -f2 -d " " | xargs kill -9
    ;;
esac
