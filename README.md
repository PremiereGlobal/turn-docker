[![Build Status](https://travis-ci.org/ReadyTalk/turn-docker.svg?branch=master)](https://travis-ci.org/ReadyTalk/turn-docker)

# Turn Docker

A Docker container for running coturn.  This can run coturn as a turn or stun service.  It makes management/configuration of the coturn server simple by using environment variables that get substituted into the turnserver.conf file automatically.

This image and its latest version will constantly rebuild.  This is to make sure the underlying Distro/libs have the latest patches.

Every now and then We will tag an extensively tested and stable version.  This docker version will never change or be patched, this should be used with caution, and ideally updated when the next stable version is posted.

## Example

Here is an example of how to launch a stun only service with this container using docker:

```bash

docker run --network host -e COTURN_LISTENING_PORT=3478 -e COTURN_ALT_LISTENING_PORT=3479 -e COTURN_STUN_ONLY=true readytalk/turn-docker:latest

```

## Configuration Basics

Coturn is a simple key=value configuration.  So knowing that we basically just translate any env variable that starts with `COTURN_` into the key=value and put it into the turnserver.conf.

See: [turnserver.conf man page](https://github.com/coturn/coturn/blob/master/examples/etc/turnserver.conf)

Here is the default configuration:

```bash
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
```

True and False have special meaning.  Basically when a value has `=true` or `=false` then it means that its key either ends up in the config or not, and does not have a value.  So  `COTURN_VERBOSE=true` means `verbose` ends up in the config.  If you where to set the environment to `COTURN_VERBOSE=false` then verbose would not be in the config file at all.


