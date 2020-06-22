#!/bin/sh
set -e

cd /tmp/asterisk/
./configure --with-jansson-bundled $CONFIGURE_ARGS \
