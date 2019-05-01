#!/bin/bash

# stop on error
set -e

#copy default config files if not exist in data directory
[ ! -f $DATA_DIR/dhcpd.conf ] && cp -v /etc/dhcp/dhcpd.conf $DATA_DIR
[ ! -f $DATA_DIR/dhcpd6.conf ] && cp -v /etc/dhcp/dhcpd6.conf $DATA_DIR

#create default lease files if not exist in data directory
[ ! -f $DATA_DIR/dhcpd.leases ] && touch $DATA_DIR/dhcpd.leases
[ ! -f $DATA_DIR/dhcpd6.leases ] && touch $DATA_DIR/dhcpd6.leases

if [ ! -z $IPv6 ]
then
	dhcpd -6 -cf $DATA_DIR/dhcpd6.conf -lf $DATA_DIR/dhcpd6.leases -pf $DATA_DIR/dhcpd6.pid -p $DHCP_PORT $INT
else
	echo "IPv6 Disabled"
fi

if [ ! -z $IPv4 ]
then
	dhcpd -4 -cf $DATA_DIR/dhcpd.conf -lf $DATA_DIR/dhcpd.leases -pf $DATA_DIR/dhcpd.pid -p $DHCP_PORT $INT
else
	echo "IPv4 Disabled"
fi

tail -f /dev/null
