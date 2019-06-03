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
		mv /etc/bind ${DATA}/etc
	fi

	# delete old location
	rm -rf /etc/bind
	
	# link old location to new directory
	ln -sf ${DATA}/etc /etc/bind
}

init_data

#check for bind configuration in default location
if [[ ! -f ${DATA}/etc/dhcpd.conf ]]
then
	echo "Please place your dhcpd configuration in ${DATA}/etc/dhcp.conf"
fi

# run CMD
echo "Running '$@'"
exec "$@"
