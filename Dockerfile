FROM alpine

LABEL maintainer="Patrice Ferlet <metal3d@gmail.com>"

ARG VERSION=5.10.0
    
RUN set -xe;\
    echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    apk update; \
    apk add util-linux build-base cmake libuv-static libuv-dev openssl-dev hwloc-dev@testing; \
    wget https://github.com/xmrig/xmrig/archive/v${VERSION}.tar.gz; \
    tar xf v${VERSION}.tar.gz; \
    mkdir -p xmrig-${VERSION}/build; \
    cd xmrig-${VERSION}/build; \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DUV_LIBRARY=/usr/lib/libuv.a;\
    make -j $(nproc); \
    cp xmrig /usr/local/bin/xmrig;\
    rm -rf xmrig* *.tar.gz; \
    apk del build-base; \
    apk del openssl-dev;\ 
    apk del hwloc-dev; \
    apk del cmake; \
    apk add hwloc@testing;

ENV POOL_USER="3FENXZKGR74momzJZ2htqiv3wVkceffArc" \
    POOL_PASS="" \
    POOL_URL="randomxmonero.eu.nicehash.com:3380" \
    DONATE_LEVEL=5 \
    PRIORITY=0 \
    THREADS=0

WORKDIR /tmp
EXPOSE 3000
