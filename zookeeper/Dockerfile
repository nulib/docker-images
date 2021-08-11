FROM zookeeper:3.7.0

RUN apt-get update -qq \
 && apt-get install -y --no-install-recommends bind9-host \
 && apt-get clean

EXPOSE 2181 2888 3888 8080
COPY wait-for-dns.sh /
ENTRYPOINT ["/wait-for-dns.sh"]
CMD ["zkServer.sh", "start-foreground"]
