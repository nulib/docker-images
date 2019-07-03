FROM alpine:3.6
RUN apk -v --update add bash curl groff jq less py-pip python && \
  pip install --upgrade --no-cache-dir awscli && \
  apk -v --purge del py-pip && \
  rm /var/cache/apk/*
ADD ./deploy /deploy
ENTRYPOINT ["/bin/bash"]
CMD ["/deploy"]
