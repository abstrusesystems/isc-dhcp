#!/bin/sh

# stop on error
set -e

# initialize data directory
init_data() {
	# create root directory
	mkdir -p ${DATA}
	
	# if not directory /etc then create
	if [[ ! -d ${DATA}/etc ]];
	then
		mv /etc/dhcp ${DATA}/etc
	fi

	# delete old location
	rm -rf /etc/dhcp
	
	# link old location to new directory
	ln -sf ${DATA}/etc /etc/dhcp


	# if not directory /lib then create
	if [[ ! -d ${DATA}/lib ]];
	then
		${DATA}/lib/dhcpd.leases
		${DATA}/lib/dhcpd6.leases
	fi
	
	# delete old location
	rm -rf /var/lib/dhcp
	
	# link old location to new directory
	ln -sf ${DATA}/lib /var/lib/dhcp
}

init_data

#check for dhcpd configuration in default location
if [[ ! -f ${DATA}/etc/dhcpd.conf ]];
then
	echo "Please place your dhcpd configuration in ${DATA}/etc/dhcpd.conf"
fi

if [[ ! -f ${DATA}/etc/dhcpd6.conf ]];
then
	echo "Please place your dhcpd6 configuration in ${DATA}/etc/dhcpd6.conf"
fi

# run CMD
echo "Running '$@'"
exec "$@"
