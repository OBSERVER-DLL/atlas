#!/bin/sh
# Make sure to use all our CPUs, because Consul can block a scheduler thread
export GOMAXPROCS=`nproc`

exec /usr/bin/consul agent \
    -server \
    -data-dir="/tmp/consul" \
    -atlas={{ atlas_username }}/{{ atlas_environment }} \
    -atlas-join \
    -atlas-token="{{ atlas_token }}" \
    -bootstrap-expect {{ count }} \
    -config-dir="/etc/consul.d" \
    ${CONSUL_FLAGS} \
    >>/var/log/consul.log 2>&1
