#!/bin/sh
set -e

# Set version
ASTERISK_VERSION=16

cd /tmp
wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-${ASTERISK_VERSION}-current.tar.gz \
    && mkdir asterisk \
    && tar -zxvf asterisk-${ASTERISK_VERSION}-current.tar.gz -C asterisk --strip 1
