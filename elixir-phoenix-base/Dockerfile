FROM hexpm/elixir:1.14.1-erlang-25.1.2-alpine-3.16.2
RUN  apk add --update --repository https://dl-3.alpinelinux.org/alpine/edge/testing/ curl git libstdc++ \
  && mix local.hex --force \
  && mix local.rebar --force
ENV NODE_VERSION 16.18.0
ENV ARCH x64
RUN curl -fsSLO --compressed "https://unofficial-builds.nodejs.org/download/release/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH-musl.tar.xz"; \
    tar -xJf "node-v$NODE_VERSION-linux-$ARCH-musl.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
      && ln -s /usr/local/bin/node /usr/local/bin/nodejs; \
    rm -f "node-v$NODE_VERSION-linux-$ARCH-musl.tar.xz"
CMD /bin/ash