#!/bin/sh
set -e

chown -R asterisk:asterisk /usr/local/etc/asterisk

if [ "$1" = "" ]; then
  COMMAND="/usr/sbin/asterisk -f -p"
else
  COMMAND="$@"
fi

exec ${COMMAND}
