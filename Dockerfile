# shadowsocks-libev for Dockerfile
FROM alpine:latest
MAINTAINER cnDocker

ENV SS_URL=https://github.com/shadowsocks/shadowsocks-libev/archive/v2.5.2.tar.gz \
    SS_DIR=shadowsocks-libev-2.5.2 \
    CONF_DIR="/usr/local/conf"

RUN set -ex && \
    apk add --no-cache pcre bash && \
    apk add --no-cache  --virtual TMP autoconf build-base curl libtool linux-headers openssl-dev pcre-dev && \
    curl -sSL $SS_URL | tar xz && \
    cd $SS_DIR && \
    ./configure --disable-documentation && \
    make install && \
    cd .. && \
    rm -rf $SS_DIR && \
    [ ! -d ${CONF_DIR} ] && mkdir -p ${CONF_DIR} && \
    apk --no-cache del --virtual TMP && \
    apk --no-cache del build-base autoconf && \
    rm -rf /var/cache/apk/* ~/.cache

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

