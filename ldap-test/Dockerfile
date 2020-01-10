FROM ubuntu:xenial
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq \
 && apt-get install -y pkg-config attr acl samba smbclient ldap-utils winbind libnss-winbind libpam-winbind krb5-user krb5-kdc supervisor
ADD init.sh /init.sh
RUN chmod 755 /init.sh \
 && mkdir /etc/samba/external
CMD /init.sh setup
