FROM elixir:1.10-alpine
RUN  apk add --update --repository https://dl-3.alpinelinux.org/alpine/edge/testing/ curl git libstdc++ \
  && mix local.hex --force \
  && mix local.rebar --force
ENV NODE_VERSION 13.8.0
ENV YARN_VERSION 1.22.0
ENV ARCH x64
RUN curl -fsSLO --compressed "https://unofficial-builds.nodejs.org/download/release/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH-musl.tar.xz"; \
    tar -xJf "node-v$NODE_VERSION-linux-$ARCH-musl.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
      && ln -s /usr/local/bin/node /usr/local/bin/nodejs; \
    rm -f "node-v$NODE_VERSION-linux-$ARCH-musl.tar.xz"
RUN curl -fsSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
  && mkdir -p /opt \
  && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
  && ln -s /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
  && ln -s /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
  && rm yarn-v$YARN_VERSION.tar.gz
CMD /bin/ash