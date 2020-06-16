#!/bin/sh -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ID=$(id -u)

docker network create loadlab

docker pull grafana/grafana

docker run --name=grafana \
 --network=loadlab --user $ID -p 3000:3000 \
 -v "$DIR/grafana.ini":/etc/grafana/grafana.ini \
 -v "$DIR/plugins":/var/lib/grafana/plugins \
 -v "$DIR/provisioning":/etc/grafana/provisioning \
 -v "$DIR/var/lib/grafana":/var/lib/grafana \
 -v "$DIR/usr/share/grafana":/var/usr/share/grafana \
 -v "$DIR/var/log/grafana":/var/log/grafana \
 grafana/grafana