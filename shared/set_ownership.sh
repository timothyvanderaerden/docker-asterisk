#!/bin/sh
set -e

if [[ -f "/etc/alpine-release" ]]; then
    addgroup -S asterisk
    adduser -S -D -h /var/lib/asterisk -s /sbin/nologin -G asterisk -g asterisk asterisk

else
    groupadd -r asterisk
    useradd -r -d /var/lib/asterisk -g asterisk asterisk
fi

chown -R asterisk:asterisk /var/lib/asterisk \
    && chown -R asterisk:asterisk /var/spool/asterisk \
    && chown -R asterisk:asterisk /var/log/asterisk \
    && chown -R asterisk:asterisk /var/run/asterisk \
    && chown asterisk:asterisk /usr/sbin/asterisk
