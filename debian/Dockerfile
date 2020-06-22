FROM debian:latest

# Disable possible prompt (like tzdata)
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies (minimal required)
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends libedit2 sqlite3 libxml2 libssl1.1 speex xmlstarlet libcurl4 \
    && apt-get install -y --no-install-recommends make g++ patch libedit-dev uuid-dev libxml2-dev libsqlite3-dev libssl-dev \
    libspeex-dev libspeexdsp-dev wget bzip2 ca-certificates

WORKDIR /tmp
# Download Asterisk
COPY ./shared/download.sh ./
RUN ./download.sh
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
RUN mkdir /usr/local/etc/asterisk
# Set Ownership
COPY ./shared/set_ownership.sh /tmp/
RUN /tmp/set_ownership.sh

# Cleanup
RUN apt-get remove -y make g++ patch libedit-dev uuid-dev libxml2-dev libsqlite3-dev libspeex-dev libspeexdsp-dev wget bzip2 ca-certificates \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    rm -rf /tmp/*

EXPOSE 5060/udp
EXPOSE 10000-11000/udp

COPY ./shared/entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "asterisk", "-f", "-p" ]
