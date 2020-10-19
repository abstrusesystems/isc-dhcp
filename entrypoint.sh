#!/bin/sh

# stop on error
set -e

# initialize data directory
init_data() {
	# create root directory
	mkdir -p ${DATA}
	
	# if not directory /etc then create
	if [[ ! -d ${DATA}/etc/dhcp ]];
	then
		mkdir -p ${DATA}/etc/dhcp/
		cp /etc/dhcp/* ${DATA}/etc/dhcp/
	fi

	# delete old location
	rm -rf /etc/dhcp
	
	# link old location to new directory
	ln -sf ${DATA}/etc/dhcp /etc/dhcp
	
	# ensure files exist
	touch ${DATA}/etc/dhcp/dhcpd.conf
	touch ${DATA}/etc/dhcp/dhcpd6.conf

	# if not directory /var then create
	if [[ ! -d ${DATA}/var/lib/dhcp ]];
	then
		mkdir -p ${DATA}/var/lib/dhcp/
	fi
	
	if [[ ! -d ${DATA}/var/run/dhcp ]];
	then
		mkdir -p ${DATA}/var/run/dhcp/
	fi
	
	# delete old location
	rm -rf /var/lib/dhcp
	
	# link old location to new directory
	ln -sf ${DATA}/var/lib/dhcp /var/lib/dhcp
	ln -sf ${DATA}/var/run/dhcp /var/run/dhcp

	# ensure files exist
	touch ${DATA}/var/lib/dhcp/dhcpd.leases
	touch ${DATA}/var/lib/dhcp/dhcpd6.leases
}

init_data

#check for dhcpd configuration in default location
if [[ ! -f ${DATA}/etc/dhcp/dhcpd.conf ]];
then
	echo "Please place your dhcpd configuration in ${DATA}/etc/dhcp/dhcpd.conf"
fi

if [[ ! -f ${DATA}/etc/dhcp/dhcpd6.conf ]];
then
	echo "Please place your dhcpd6 configuration in ${DATA}/etc/dhcp/dhcpd6.conf"
fi

# run CMD
echo "Running '$@'"
exec "$@"
