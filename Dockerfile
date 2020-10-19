#FROM	alpine:latest
FROM	debian:buster-slim
LABEL	maintainer="github -at- abstruse -dot- systems"

ENV 	DATA=/srv/dhcp \
	IPv4=1 \
	IPv6=1 \
	INT=eth0 \
	DHCPv4_PORT=67 \
	DHCPv6_PORT=547

#RUN	apk add --update --no-cache dhcp
RUN	apt update
RUN	apt install dhcp

COPY	entrypoint.sh /sbin/entrypoint.sh
RUN	chmod 755 /sbin/entrypoint.sh

#EXPOSE	${DHCPv4_PORT}/udp \
#	${DHCPv6_PORT}/udp

VOLUME	["${DATA}"]

ENTRYPOINT	["/sbin/entrypoint.sh"]

CMD	["/bin/sh"]
