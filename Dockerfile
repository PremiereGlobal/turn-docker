FROM debian:buster-slim

RUN apt-get update && apt-get install -y \
      coturn \
      curl \
    && apt-get clean && rm -rf /var/lib/apt/lists


ENV DESC=coturn
ENV NAME=coturn
ENV PROCNAME=turnserver
ENV DAEMON=/usr/bin/turnserver
ENV DAEMON_ARGS="-c /etc/turnserver.conf -o -v"
ENV PIDFILE_DIR=/var/run
ENV PIDFILE=/var/run/$PROCNAME.pid
ENV SCRIPTNAME=/etc/init.d/$NAME
ENV USER=turnserver
ENV GROUP=turnserver
ENV TURN_REALM="turn.sip.domain.com"
ENV PORT=443
ENV MIN_PORT=16384
ENV MAX_PORT=65535

ADD run.sh /run.sh
RUN chmod +x /run.sh

CMD /run.sh
