#!/bin/bash

#! /bin/sh
set -x

if [ -z OPTIONS ]
then
    OPTIONS="-v --no-cli --no-udp -l stdout -f"
fi

export OPTIONS

# Discover public and private IP for this instance (AWS Only)
export PUBLIC_IPV4="$(curl --fail -qs http://169.254.169.254/2014-11-05/meta-data/public-ipv4)"
export PRIVATE_IPV4="$(curl --fail -qs http://169.254.169.254/2014-11-05/meta-data/local-ipv4)"

if [ -z $PORT ]
then
    PORT=3478
fi
echo "" > /etc/turnserver.conf
echo external-ip=$PUBLIC_IPV4 >> /etc/turnserver.conf
echo listening-port=$PORT >> /etc/turnserver.conf
echo tls-listening-port=$PORT >> /etc/turnserver.conf
echo listening-ip=$PRIVATE_IPV4 >> /etc/turnserver.conf
echo realm=${TURN_REALM} >> /etc/turnserver.conf
echo fingerprint >> /etc/turnserver.conf
echo lt-cred-mech >> /etc/turnserver.conf

echo min-port=$MIN_PORT >> /etc/turnserver.conf
echo max-port=$MAX_PORT >> /etc/turnserver.conf

sh -c "turnadmin -a -u user -p pass -r ${TURN_REALM}"

set +x

exec /usr/bin/turnserver ${OPTIONS} 
