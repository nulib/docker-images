FROM hexpm/elixir:1.12.1-erlang-24.0.2-alpine-3.13.3
RUN  apk add --update --repository https://dl-3.alpinelinux.org/alpine/edge/testing/ curl git libstdc++ \
  && mix local.hex --force \
  && mix local.rebar --force
ENV NODE_VERSION 14.17.0
ENV ARCH x64
RUN curl -fsSLO --compressed "https://unofficial-builds.nodejs.org/download/release/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH-musl.tar.xz"; \
    tar -xJf "node-v$NODE_VERSION-linux-$ARCH-musl.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
      && ln -s /usr/local/bin/node /usr/local/bin/nodejs; \
    rm -f "node-v$NODE_VERSION-linux-$ARCH-musl.tar.xz"
CMD /bin/ash