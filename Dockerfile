FROM alpine:latest AS builder

ARG MCRCON_VERSION="v0.7.1"

RUN apk --no-cache update && \
    apk --no-cache upgrade && \
    apk --no-cache add git && \
    apk --no-cache add musl-dev && \
    apk --no-cache add gcc && \
    apk --no-cache add make

RUN git clone --depth 1 --branch $MCRCON_VERSION https://github.com/Tiiffi/mcrcon.git

WORKDIR mcrcon

RUN make
RUN make install

FROM alpine:latest

ARG MCRCON_VERSION="v0.7.1"

LABEL author="futuralogic@nobody.github.com"
LABEL description="Minecraft RCON + Server backup tools"
LABEL "mcrcon.version"=$MCRCON_VERSION

# Copy MCRCON into this layer
COPY --from=builder /usr/local/bin/mcrcon /usr/local/bin/mcrcon

# Install timezones and base setup of packages
RUN apk --no-cache update && \
    apk --no-cache upgrade && \
    apk --no-cache add tzdata && \
    apk --no-cache add zip

VOLUME ["/data/from", "/data/to"]

COPY ./scripts/docker-entrypoint.sh /
COPY ./scripts/backup.sh /scripts/

ENTRYPOINT ["/docker-entrypoint.sh"]
