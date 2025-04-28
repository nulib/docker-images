#!/bin/ash

set -e

sed -i s/nodaemon=true/nodaemon=false/ /etc/supervisord.conf
/usr/bin/supervisord
while ! nc -z -w 5 localhost 389; do sleep 1; done
for f in $(dirname $0)/*.ldif; do 
  ldapmodify -H "ldap://localhost:389" -D "cn=Administrator,cn=Users,dc=library,dc=northwestern,dc=edu" -w "d0ck3rAdm1n!" -c -f $f;
done
killall supervisord || true
sed -i s/nodaemon=false/nodaemon=true/ /etc/supervisord.conf
