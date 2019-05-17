FROM balenalib/raspberrypi3-alpine:latest
MAINTAINER github -at- abstruse -dot- systems

ENV DATA_DIR=/data \
	IPv4=1 \
	IPv6=1 \
	INT=eth0 \
	DHCP_PORTv4=67 \
	DHCP_PORTv6=547

RUN apk add --no-cache dhcp

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 67/udp 67/tcp

VOLUME ["${DATA_DIR}"]

ENTRYPOINT ["/sbin/entrypoint.sh"]
