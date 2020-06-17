#!/bin/sh
set -e

# Set version
ASTERISK_VERSION=16.1.1

cd /tmp
wget https://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-${ASTERISK_VERSION}.tar.gz \
    && mkdir asterisk \
    && tar -zxvf asterisk-${ASTERISK_VERSION}.tar.gz -C asterisk --strip 1
