FROM balenalib/raspberrypi3-debian:latest
MAINTAINER github@abstruse.systems

ENV DATA_DIR=/data

RUN echo exit 0 > /usr/sbin/policy-rc.d

RUN rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes \
	&& apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y isc-dhcp-server \
	&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 67/udp 67/tcp

VOLUME ["${DATA_DIR}"]

#ENTRYPOINT ["/sbin/entrypoint.sh"]

#CMD ["/usr/sbin/named"]
