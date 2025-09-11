#!/bin/bash

NGINX_CONTAINER="nginx-proxy"
CONF_PATH="/etc/nginx/conf.d/default.conf"

HOST_IP=$(docker exec $NGINX_CONTAINER sh -c "ip route | grep default | awk '{print \$3}'")

echo "[INFO] Host IP detected: $HOST_IP"

docker exec $NGINX_CONTAINER sh -c \
    "sed -i 's/server [0-9.]*:8000;/server ${HOST_IP}:8000;/g' $CONF_PATH"

echo "[INFO] Updated upstream server to $HOST_IP"

docker exec $NGINX_CONTAINER nginx -s reload

echo "[INFO] Nginx reloaded successfully!"
