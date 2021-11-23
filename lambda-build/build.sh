#!/bin/bash

mkdir -p /tmp/$1
rsync -arz --exclude node_modules/* /src/$1/* /tmp/$1/
cd /tmp/$1
yarn install --prod
zip -ur /dest/$1-deploy-$2.zip .
cd -
