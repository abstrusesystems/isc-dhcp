#!/bin/sh

# stop on error
set -e

# initialize data directory
init_data() {
	# create root directory
	mkdir -p ${DATA}
	
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
