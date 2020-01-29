#!/bin/ash

if [ ! -e /var/lib/samba/private/idmap.ldb ]; then 
  echo "No AD domain provisioned. Creating ${DOMAIN}"
  samba-tool domain provision --use-rfc2307 --realm="${DOMAIN}" --domain="${DOMAIN%%.*}" --dns-backend=SAMBA_INTERNAL --adminpass="${DOMAINPASS}"
  cp /var/lib/samba/private/krb5.conf /etc/krb5.conf
fi
exec /usr/bin/supervisord
