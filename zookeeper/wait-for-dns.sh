#!/bin/bash

for s in ${WAIT_SERVERS}; do
  host $s
  while [[ $? != 0 ]]; do
    sleep 1
    host $s
  done
done
exec /docker-entrypoint.sh $@
