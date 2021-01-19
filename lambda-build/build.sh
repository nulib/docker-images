#!/bin/bash

for d in $@; do
  mkdir -p /tmp/$d
  rsync -arz --exclude node_modules/* /src/$d/* /tmp/$d/
  cd /tmp/$d
  yarn install
  zip -ur /dest/$d.zip .
  cd -
done