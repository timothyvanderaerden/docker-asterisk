#!/bin/bash
set -e

if [ "$1" = "" ]; then
  COMMAND="/usr/sbin/asterisk -f -p"
else
  COMMAND="$@"
fi

exec ${COMMAND}
