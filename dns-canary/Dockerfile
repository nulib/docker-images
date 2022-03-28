FROM alpine

RUN apk add bind
COPY dns-canary.sh /
ENTRYPOINT ["/dns-canary.sh"]
