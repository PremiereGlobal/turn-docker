#!/usr/bin/dumb-init /bin/bash

. /env.sh

DEFAULT_COTURN_LISTENING_PORT="3478"
DEFAULT_COTURN_TLS_LISTENING_PORT="5349"
DEFAULT_COTURN_ALT_LISTENING_PORT="0"
DEFAULT_COTURN_ALT_TLS_LISTENING_PORT=0
DEFAULT_COTURN_MIN_PORT=49152
DEFAULT_COTURN_MAX_PORT=65535
DEFAULT_COTURN_VERBOSE="true"
DEFAULT_COTURN_FINGERPRINT="true"
DEFAULT_COTURN_NO_UDP="false"
DEFAULT_COTURN_NO_TCP="false"
DEFAULT_COTURN_NO_TLS="true"
DEFAULT_COTURN_NO_DTLS="true"
DEFAULT_COTURN_MAX_ALLOCATE_LIFETIME=3600
DEFAULT_COTURN_CIPHER_LIST="DEFAULT"
DEFAULT_COTURN_NO_STDOUT_LOG="false"
DEFAULT_COTURN_SYSLOG="false"
DEFAULT_COTURN_STUN_ONLY="false"
DEFAULT_COTURN_NO_STUN="false"
DEFAULT_COTURN_NO_MULTICAST_PEERS="true"
DEFAULT_COTURN_MAX_ALLOCATE_TIMEOUT="60"
DEFAULT_COTURN_PIDFILE="/var/run/turnserver.pid"
DEFAULT_COTURN_SECURE_STUN="false"
DEFAULT_COTURN_MOBILITY="true"
DEFAULT_COTURN_NO_CLI="true"

CONF_FILE="/etc/turnserver.conf"
rm ${CONF_FILE}
touch ${CONF_FILE}

for var in ${!DEFAULT_COTURN*}; do
  t=${var/DEFAULT_/}
  if [ -z ${!t} ]; then
    echo "Using default for ${t}:${!var}"
    eval ${t}=${!var}
    export "${t}"
  else
    echo "Using override value for ${t}"
  fi
done

for var in ${!COTURN_*}; do
  if [[ $var == COTURN_* ]]; then
    var2=${var,,} #lowercase
    var3=${var2//_/-}
    var4=${var3#coturn-*}
    if [[ "${!var}" == "true" ]]; then
      echo ${var4} >> ${CONF_FILE}
      continue
    fi
    if [[ "${!var}" == "false" ]]; then
      continue
    fi
    if [[ ${!var} =~ ^-?[0-9]+$ ]]; then
      echo "${var4}=${!var}" >> ${CONF_FILE}
    else
      echo "${var4}=${!var}" >> ${CONF_FILE}
    fi
  fi
done

echo "${@}"
exec "${@}"
