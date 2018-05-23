FROM openjdk:8-jdk

# Cantaloupe docker starter script
# For pyramidal tiffs using JAI processor and filesystem resolver and -cache

# Build and run:
# $ sudo docker build -t cantaloupe .
# $ sudo docker run -d --rm -p 8183:8182 -v ./images:/var/lib/cantaloupe/images --name cantaloupe cantaloupe

ENV CANTALOUPE_VERSION 4.0-SNAPSHOT
EXPOSE 8182

RUN apt-get -qq update && \
    apt-get install -y curl graphicsmagick

# run non priviledged
RUN useradd -r cantaloupe

#
# Cantaloupe
#
WORKDIR /tmp

#
# JAI native medialib (non functional)
#
RUN curl -O -L -H "Cookie: oraclelicense=accept-securebackup-cookie" \
  http://download.oracle.com/otn-pub/java/jai/1.1.2_01-fcs/jai-1_1_2_01-lib-linux-i586.tar.gz \
 && tar xvfz /tmp/jai-1_1_2_01-lib-linux-i586.tar.gz \
 && cp jai-1_1_2_01/lib/*.jar $JAVA_HOME/jre/lib/ext/ \
 && cp jai-1_1_2_01/lib/*.so $JAVA_HOME/jre/lib/amd64/ \
 && rm jai-1_1_2_01-lib-linux-i586.tar.gz \
 && rm -rf jai-1_1_2_01

#RUN curl -L -o /tmp/cantaloupe-$CANTALOUPE_VERSION.zip \
#  https://github.com/medusa-project/cantaloupe/releases/download/v$CANTALOUPE_VERSION/Cantaloupe-$CANTALOUPE_VERSION.zip
COPY cantaloupe-$CANTALOUPE_VERSION.zip /tmp/cantaloupe-$CANTALOUPE_VERSION.zip
RUN mkdir -p /usr/local/ \
 && cd /usr/local/ \
 && unzip /tmp/cantaloupe-$CANTALOUPE_VERSION.zip \
 && ln -s [Cc]antaloupe-$CANTALOUPE_VERSION cantaloupe \
 && rm /tmp/cantaloupe-$CANTALOUPE_VERSION.zip

# upcoming docker releases: use --chown=cantaloupe
COPY cantaloupe.properties /etc/cantaloupe/cantaloupe.properties
COPY cantaloupe_s3_defaults.properties /etc/cantaloupe/cantaloupe_s3_defaults.properties
RUN mkdir -p /var/log/cantaloupe \
 && mkdir -p /var/cache/cantaloupe \
 && chown -R cantaloupe /var/log/cantaloupe \
 && chown -R cantaloupe /var/cache/cantaloupe

COPY cantaloupe-entrypoint.sh /cantaloupe-entrypoint.sh
CMD ["/cantaloupe-entrypoint.sh"]
