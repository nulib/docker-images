FROM lambci/lambda:build-nodejs12.x
RUN yum install -y rsync \
 && npm install -g yarn
COPY build.sh /
WORKDIR /dest
ENTRYPOINT ["/build.sh"]
