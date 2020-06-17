#!/bin/sh -x

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")">/dev/null 2>&1 && pwd)"

docker network create loadlab

ID=$(id -u)

docker pull influxdb:1.8

docker run --name=influxdb \
  --network=loadlab --user $ID -p 8086:8086 -p 2003:2003 -p 2004:2004 \
  -v "$DIR/influxdb.conf":/etc/influxdb/influxdb.conf:ro \
  -v "$DIR/var/lib/influxdb":/var/lib/influxdb \
  -v "$DIR/.influx_history":/.influx_history:rw \
  influxdb:1.8 -config /etc/influxdb/influxdb.conf
