FROM fedora:latest

# Install dependencies (minimal required)
RUN dnf upgrade -y \
    && dnf install -y --setopt=install_weak_deps=False libedit sqlite speex speexdsp xmlstarlet libcurl \
    && dnf install -y --setopt=install_weak_deps=False make gcc-c++ patch libedit-devel libuuid-devel libxml2-devel sqlite-devel \
    openssl-devel speex-devel speexdsp-devel wget bzip2 findutils diffutils file

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
RUN dnf remove -y make gcc-c++ patch libedit-devel libuuid-devel libxml2-devel sqlite-devel openssl-devel wget bzip2 findutils diffutils file \
    speex-devel speexdsp-devel \
    && dnf -y autoremove \
    && dnf clean all \
    && rm -rf /var/cache/dnf/* \
    && rm -rf /tmp/*

EXPOSE 5060/udp
EXPOSE 10000-11000/udp

COPY ./shared/entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "asterisk", "-f", "-p" ]
