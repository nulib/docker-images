FROM mbabineau/zookeeper-exhibitor
RUN apt-get update && apt-get install -y curl && apt-get purge -y
ADD wrapper.sh /opt/exhibitor/wrapper.sh
EXPOSE 8181 2181 2888 3888
