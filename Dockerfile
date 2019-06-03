FROM	balenalib/raspberrypi3-alpine:latest
LABEL	maintainer="github -at- abstruse -dot- systems"

ENV 	DATA=/srv/dhcp \
	IPv4=1 \
	IPv6=1 \
	INT=eth0 \
	DHCPv4_PORT=67 \
	DHCPv6_PORT=547

RUN	apk add --update --no-cache dhcp

COPY	entrypoint.sh /sbin/entrypoint.sh
RUN	chmod 755 /sbin/entrypoint.sh

EXPOSE	${DHCPv4_PORT}/udp ${DHCPv4_PORT}/tcp \
	${DHCPv6_PORT}/udp ${DHCPv6_PORT}/tcp

VOLUME	["${DATA}"]

ENTRYPOINT	["/sbin/entrypoint.sh"]

CMD	["/bin/sh"]
