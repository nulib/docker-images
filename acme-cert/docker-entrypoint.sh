#!/bin/bash

set -e

if aws s3 ls $ACME_DATA_STORE > /dev/null; then
  echo -n "Retrieving saved state..."
  aws s3 cp $ACME_DATA_STORE - | tar xzv
  echo "Done."
fi

args="-d $CERT_DOMAIN -d *.$CERT_DOMAIN --dns dns_aws"

echo -n "Renewing and installing certificate..."
./acme.sh $@ $args
mkdir -p ./certs
./acme.sh --install-cert -d $CERT_DOMAIN --fullchain-file ./certs/$CERT_DOMAIN.wildcard.fullchain.pem --key-file ./certs/$CERT_DOMAIN.wildcard.key.pem
echo "Done."

echo -n "Reading new certificate and key..."
payload=$(jq \
  --arg cert "$(cat ./certs/$CERT_DOMAIN.wildcard.fullchain.pem)" \
  --arg key "$(cat ./certs/$CERT_DOMAIN.wildcard.key.pem)" \
  '{"certificate": $cert, "key": $key}' <<< '{}'
)
echo "Done."

echo -n "Uploading new value to $SECRET_PATH"
aws secretsmanager put-secret-value --secret-id "$SECRET_PATH" --secret-string "$payload"
echo "Done."

echo -n "Updating saved state..."
tar czf $(basename $ACME_DATA_STORE) account.conf ca $CERT_DOMAIN
aws s3 cp $(basename $ACME_DATA_STORE) $ACME_DATA_STORE
echo "Done."
