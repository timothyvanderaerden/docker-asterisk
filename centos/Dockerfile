FROM centos:latest

# Install dependencies (minimal required), enable PowerTools to have "libedit-devel" package
RUN dnf upgrade -y
RUN dnf install -y --setopt=install_weak_deps=False epel-release
RUN dnf install -y --setopt=install_weak_deps=False 'dnf-command(config-manager)'
RUN dnf config-manager --set-enabled PowerTools
RUN dnf install -y --setopt=install_weak_deps=False libedit sqlite speex speexdsp xmlstarlet
RUN dnf install -y --setopt=install_weak_deps=False make gcc-c++ patch libedit-devel libuuid-devel libxml2-devel sqlite-devel \
    openssl-devel speex-devel speexdsp-devel wget bzip2

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
WORKDIR /tmp/asterisk/
RUN make \
    && make install

# Configure Asterisk
VOLUME /etc/asterisk
RUN mkdir /usr/local/etc/asterisk
# Set Ownership
RUN groupadd asterisk
RUN useradd -r -d /var/lib/asterisk -g asterisk asterisk
COPY ./shared/set_ownership.sh /tmp/
RUN /tmp/set_ownership.sh

# Cleanup
RUN rm -rf /tmp/*
RUN dnf remove -y make gcc-c++ patch libedit-devel libuuid-devel libxml2-devel sqlite-devel openssl-devel speex-devel speexdsp-devel \
    wget bzip2
RUN dnf -y autoremove \
    && dnf clean all

EXPOSE 5060/udp
EXPOSE 10000-11000/udp

COPY ./shared/entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "asterisk", "-f", "-p" ]
