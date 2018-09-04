#!/bin/sh

config_file="cantaloupe.properties"
if [ -n "${TIFF_BUCKET}" ]; then
  echo "extends cantaloupe_s3_defaults.properties" > /etc/cantaloupe/cantaloupe_s3.properties
  echo "S3Source.BasicLookupStrategy.bucket.name = ${TIFF_BUCKET}" >> /etc/cantaloupe/cantaloupe_s3.properties

  if [ -z "${S3_ENDPOINT}" && -n "${AWS_REGION}" ]; then
    S3_ENDPOINT="s3.dualstack.${AWS_REGION}.amazonaws.com"
  fi

  if [ -n "${S3_ENDPOINT}" ]; then
    echo "S3Source.endpoint = ${S3_ENDPOINT}" >> /etc/cantaloupe/cantaloupe_s3.properties
  fi

  if [ -n "${AWS_ACCESS_KEY_ID}" ]; then
    echo "S3Source.access_key_id = ${AWS_ACCESS_KEY_ID}" >> /etc/cantaloupe/cantaloupe_s3.properties
    echo "S3Source.secret_key = ${AWS_SECRET_KEY}" >> /etc/cantaloupe/cantaloupe_s3.properties
  fi
  config_file="cantaloupe_s3.properties"
fi

jarfile=$(ls /usr/local/cantaloupe/[Cc]antaloupe-$CANTALOUPE_VERSION.war)
su -c "exec java -Dcantaloupe.config=/etc/cantaloupe/${config_file} -Xmx2g -jar ${jarfile}" cantaloupe
