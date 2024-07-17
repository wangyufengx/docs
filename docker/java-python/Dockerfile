FROM docker.io/library/alpine:3.19

LABEL maintainer="wangyufengx"  

RUN	 set -eux; \
    apk update \
    &&  apk upgrade \
    &&  apk add build-base zlib-dev bzip2-dev openssl-dev ncurses-dev libffi-dev readline-dev gdbm-dev sqlite-dev; \
    apk add python3 \
    && apk add py3-pip \
    && pip install --upgrade pip \
    && python --version \
    && pip --version; \
    apk add openjdk8 \
    && java -version;
