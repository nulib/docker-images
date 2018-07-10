FROM        jetty
MAINTAINER  Michael B. Klein <michael.klein@northwestern.edu>
ARG         FEDORA_VERSION=4.7.5
ARG         FEDORA_LOCATION=https://github.com/fcrepo4/fcrepo4/releases/download/fcrepo-${FEDORA_VERSION}/fcrepo-webapp-${FEDORA_VERSION}.war
ADD         ${FEDORA_LOCATION} ${JETTY_BASE}/fedora/fedora.war
ADD         fedora.xml ${JETTY_BASE}/webapps/fedora.xml
USER        root
RUN         mkdir -p /data
RUN         /bin/chown -R jetty:jetty ${JETTY_BASE}/fedora/
EXPOSE      8080 61613 61616
ADD         fedora-entrypoint.sh /
ENTRYPOINT  "/fedora-entrypoint.sh"
HEALTHCHECK --interval=30s --timeout=5s \
  CMD curl -X OPTIONS -f http://localhost:8080/rest || exit 1
