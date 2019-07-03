FROM alpine:3.6
RUN apk -v --update add \
        curl \
        groff \
        less \
        py-pip \
        python \
        && \
    pip install --upgrade --no-cache-dir awscli && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*
ENTRYPOINT ["aws"]
