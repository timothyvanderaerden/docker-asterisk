#!/bin/sh
set -e

cd /tmp/asterisk/
make \
    && make install \
    && make dist-clean
