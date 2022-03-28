#!/bin/sh

WAIT_SECONDS=${WAIT_SECONDS:-120}
WAITED=1

for s in ${WAIT_SERVERS}; do
  host $s
  while [[ $? != 0 && $WAITED -lt $WAIT_SECONDS ]]; do
    sleep 1
    WAITED=$((WAITED+1))
    host $s
  done
done

