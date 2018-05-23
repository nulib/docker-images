#!/bin/sh

if [[ "${TIFF_BUCKET}" != "" ]]; then
  echo <<__EOF__ > /etc/cantaloupe/cantaloupe.properties
extends cantaloupe_s3_defaults.properties
S3Resolver.bucket.name = ${TIFF_BUCKET}
S3Resolver.endpoint = s3.dualstack.${AWS_REGION}.amazonaws.com
S3Resolver.access_key_id = ${AWS_ACCESS_KEY_ID}
S3Resolver.secret_key = ${AWS_SECRET_KEY}
__EOF__
fi

jarfile=$(ls /usr/local/cantaloupe/[Cc]antaloupe-$CANTALOUPE_VERSION.war)
su -c "exec java -Dcantaloupe.config=/etc/cantaloupe/cantaloupe.properties -Xmx2g -jar ${jarfile}" cantaloupe
