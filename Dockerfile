FROM debian:buster-slim

RUN apt-get update && apt-get install -y \
      coturn \
      curl \
      netcat \
    && apt-get clean && rm -rf /var/lib/apt/lists

#setup dumb-init
RUN curl -k -L https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 > /usr/bin/dumb-init
RUN chmod 755 /usr/bin/dumb-init

ADD run.sh /run.sh
RUN chmod +x /run.sh
RUN touch /env.sh

ENTRYPOINT ["/run.sh"]
CMD ["/usr/bin/turnserver","-l","stdout","-f","-c","/etc/turnserver.conf"]

