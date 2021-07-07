#!/bin/sh

# Make config file from template
HOST_IP=$(dig +short host.docker.internal)
echo "${HOST_IP}    devbox.library.northwestern.edu" >> /etc/hosts
[ -z "$AVALON_DOMAIN" ] && AVALON_DOMAIN="https://devbox.library.northwestern.edu:3000"
[ -z "$AVALON_STREAMING_PORT" ] && AVALON_STREAMING_PORT=80
export AVALON_DOMAIN
export AVALON_STREAMING_PORT
envsubst '$AVALON_DOMAIN,$AVALON_STREAMING_PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

exec /usr/local/nginx/sbin/nginx
