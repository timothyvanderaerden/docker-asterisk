FROM alpine:latest

ARG CONFIGURE_ARGS="--enable-permanent-dlopen --without-pjproject-bundled"

# Install dependencies (minimal required)
RUN apk update \
    && apk upgrade \
    && apk add --no-cache libedit libuuid sqlite sqlite-libs pjproject libxml2 openssl speex \
    && apk add --no-cache --virtual build-deps \
    make gcc g++ patch libedit-dev util-linux-dev libxml2-dev sqlite-dev pjproject-dev \
    openssl-dev speex-dev speexdsp-dev wget bzip2 bsd-compat-headers

WORKDIR /tmp
# Download Asterisk
COPY ./shared/download.sh ./
RUN ./download.sh
# Apply patches
COPY ./alpine/*patch ./
RUN patch -d/tmp/asterisk -p1 -i /tmp/musl-mutex-init.patch
RUN patch -d/tmp/asterisk -p1 -i /tmp/musl-astmm-fix.patch
RUN patch -d/tmp/asterisk -p1 -i /tmp/asterisk-cdefs.patch
# Configure Asterisk
COPY ./shared/configure.sh ./
RUN ./configure.sh
# Configure modules
COPY ./shared/menuselect.sh ./
RUN ./menuselect.sh
# Compile and install Asterisk
COPY ./shared/build.sh ./
RUN ./build.sh

# Configure Asterisk
VOLUME /etc/asterisk
RUN mkdir -p /usr/local/etc/asterisk
# Set Ownership
COPY ./shared/set_ownership.sh /tmp/
RUN /tmp/set_ownership.sh

# Cleanup
RUN rm -rf /tmp/*
RUN apk del build-deps

EXPOSE 5060/udp
EXPOSE 10000-11000/udp

COPY ./shared/entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "asterisk", "-f", "-p" ]
