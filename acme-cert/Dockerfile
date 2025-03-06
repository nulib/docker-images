FROM ubuntu:24.04

RUN apt-get update -qq \
 && apt-get install -y curl git jq openssl unzip

RUN curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o /tmp/awscliv2.zip \
 && unzip -qo /tmp/awscliv2.zip -d /tmp \
 && /tmp/aws/install \
 && rm -rf /tmp/aws \
 && aws configure set default.region us-east-1

RUN git clone https://github.com/acmesh-official/acme.sh.git \
 && cd acme.sh \
 && ./acme.sh --install --no-cron \
 && cd .. \
 && rm -rf ./acme.sh

WORKDIR /root/.acme.sh

RUN mkdir certs \
 && ./acme.sh --set-default-ca --server letsencrypt

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["--renew"]
