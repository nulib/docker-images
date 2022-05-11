#!/bin/sh

if aws s3 ls $ACME_DATA_STORE > /dev/null; then
  aws s3 cp $ACME_DATA_STORE - | tar xz
fi

ls -la

args="-d $CERT_DOMAIN -d "*.$CERT_DOMAIN" \
  --fullchain-file ./$CERT_DOMAIN.wildcard.fullchain.pem --key-file ./$CERT_DOMAIN.wildcard.key.pem \
  --dns dns_aws"

./acme.sh $@ $args

payload=$(jq \
  --arg cert "$(cat ./$CERT_DOMAIN.wildcard.fullchain.pem)" \
  --arg key "$(cat ./$CERT_DOMAIN.wildcard.key.pem)" \
  '{"certificate": $cert, "key": $key}' <<< '{}'
)

aws secretsmanager put-secret-value --secret-id "$SECRET_PATH" --secret-string "$payload"

tar czf $(basename $ACME_DATA_STORE) account.conf ca $CERT_DOMAIN
aws s3 cp acme.ca.conf.tar.gz $ACME_DATA_STORE
