#!/bin/sh
set -e

# Set the IP of the Heplify-server for hep.conf
HEPLIFY_IP=`getent hosts heplify-server | awk '{ print $1 }'`
echo capture_address=$HEPLIFY_IP:9060 > /usr/local/etc/asterisk/hep.conf
chown -R asterisk:asterisk /usr/local/etc/asterisk

if [ "$1" = "" ]; then
  COMMAND="/usr/sbin/asterisk -f -p"
else
  COMMAND="$@"
fi

exec ${COMMAND}
