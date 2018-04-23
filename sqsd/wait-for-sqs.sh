#!/bin/bash

cmd="$@"
IFS='/' read -r -a s <<< $SQSD_QUEUE_URL
endpoint_url="${s[0]}//${s[2]}"
queue_name=${s[4]}
sleep 10
until curl -o /dev/null -s -f "${endpoint_url}?Action=ListQueues"; do
  >&2 echo "Waiting for ${endpoint_url}"
  sleep 5
done
if [[ ! $(curl -o /dev/null -s -f "${endpoint_url}?Action=ListQueues" | grep $queue_name) ]]; then
  >&2 echo "Creating queue '${queue_name}'"
  curl -o /dev/null -s -f "${endpoint_url}?Action=CreateQueue&QueueName=${queue_name}"
fi
>&2 echo "Starting SQSD"
exec $cmd
