FROM ubuntu:latest

ENV ASTERISK_VERSION 16

# Disable possible prompt (like tzdata)
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies (minimal required)
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y make g++ patch libedit-dev uuid-dev libjansson-dev libxml2-dev libsqlite3-dev libssl-dev wget

# Download Asterisk (LTS)
WORKDIR /tmp
RUN wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-${ASTERISK_VERSION}-current.tar.gz \
    && mkdir asterisk \
    && tar -zxvf asterisk-${ASTERISK_VERSION}-current.tar.gz -C asterisk --strip 1

# Configure modules
WORKDIR /tmp/asterisk
RUN ./configure --libdir=/usr/lib64
RUN make menuselect.makeopts \
    && menuselect/menuselect --disable-all \
    --enable app_dial \
    --enable app_echo \
    --enable app_senddtmf \
    --enable chan_pjsip \
    --enable codec_alaw \
    --enable func_channel \
    --enable MOH-OPSOUND-ALAW \
    --enable pbx_config \
    --enable res_hep \
    --enable res_hep_pjsip \
    --enable res_hep_rtcp \
    --enable res_musiconhold \
    --enable res_pjproject \
    --enable res_pjsip \
    --enable res_pjsip_authenticator_digest \
    --enable res_pjsip_endpoint_identifier_user \
    --enable res_pjsip_registrar \
    --enable res_pjsip_sdp_rtp \
    --enable res_rtp_asterisk \
    --enable res_statsd \
    menuselect.makeopts

# Compile and install Asterisk
RUN make \
    && make install

# Configure Asterisk
VOLUME /etc/asterisk
RUN mkdir /usr/local/etc/asterisk
# Set Ownership
RUN groupadd asterisk
RUN useradd -r -d /var/lib/asterisk -g asterisk asterisk
RUN chown -R asterisk:asterisk /var/lib/asterisk \
    && chown -R asterisk:asterisk /var/spool/asterisk \
    && chown -R asterisk:asterisk /var/log/asterisk \
    && chown -R asterisk:asterisk /var/run/asterisk \
    && chown -R asterisk:asterisk /var/log/asterisk \
    && chown asterisk:asterisk /usr/sbin/asterisk

# Cleanup
RUN rm -rf /tmp/*
RUN apt-get -y autoremove \
    && apt-get clean

EXPOSE 5060/udp
EXPOSE 10000-10600/udp

COPY ./shared/entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "asterisk", "-f", "-p" ]
