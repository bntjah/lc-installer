#!/bin/bash
## Original from https://github.com/zeropingheroes/lancache-dns/blob/master/install.sh#L44
## Used as a base so credits to them for this; I just modified the script a bith here and there
## Where to write the unbound data towards
unbound_loc=/etc/unbound/upstreams-available

# Exit if there is an error
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# If script is executed as an unprivileged user
# Execute it as superuser, preserving environment variables
if [ $EUID != 0 ]; then
    sudo -E "$0" "$@"
    exit $?
fi

# Prepare the upstreams config directory
if [ ! -d "/etc/unbound/upstreams-available" ]; then
	mkdir -p /etc/unbound/upstreams-available
fi

# Create Archive Folder
if [ ! -d "/tmp/old-cache-domains/" ]; then
	mkdir -p /tmp/old-cache-domains/
fi

# If a downloaded version exist move it to the archive folder
if [ -d "/var/git/lancache-domains"]; then
	mv 	/var/git/cache-domains /tmp/old-domains/${TIMESTAMP/}
fi

# Get domains from `uklans/cache-domains` GitHub repo
/usr/bin/git clone https://github.com/uklans/cache-domains.git /var/git/cache-domains/
# Download the extra upstreams from our github
/usr/bin/git clone -b rewrite https://github.com/bntjah/lc-installer /var/git/bntjah-installer/

# Move the extra DNS from our Github into Cache-Domains folder
if [ -d "/var/git/bntjah-installer/dns/"]; then
	mv /var/git/bntjah-installer/dns/* /var/git/cache-domains/
fi

# Set the upstreams we want to create unbound config files from
declare -a UPSTREAMS=(arena apple blizzard hirez gog glyph microsoft origin riot steam sony enmasse wargaming uplay zenimax digitalextremes pearlabyss)

# Loop through each upstream file in turn
for UPSTREAM in "${UPSTREAMS[@]}"
do
    UPSTREAM_CONFIG_FILE="${unbound_loc}/${UPSTREAM}.conf"

    # Add the starting block to the config file
    echo "server:" > ${UPSTREAM_CONFIG_FILE}

    # Read the upstream file line by line
    while read -r LINE;
    do
        # Skip line if it is a comment
        if [[ ${LINE:0:1} == '#' ]]; then
            continue
        fi

        # Check if hostname is a wildcard
        if [[ $LINE == *"*"* ]]; then

            # Remove the asterix and the dot from the start of the hostname
            LINE=${LINE/#\*./}

            # Add a wildcard config line
            echo "local-zone: \"${LINE}.\" redirect" >> ${UPSTREAM_CONFIG_FILE}
        fi

        # Add a standard A record config line
        echo "local-data: \"${LINE}. A $lc-host-${UPSTREAM}\"" >> ${UPSTREAM_CONFIG_FILE}
		
    done < /var/git/cache-domains/${UPSTREAM}.txt
done

## Blacklist
for UPSTREAM in "${UPSTREAMS[@]}"
do
	if [ -f "/var/git/cache-domains/${UPSTREAM}.blacklist" ]; then
    UPSTREAM_CONFIG_FILE="${unbound_loc}/${UPSTREAM}.conf"

    # Read the upstream file line by line
    while read -r LINE;
    do
        # Skip line if it is a comment
        if [[ ${LINE:0:1} == '#' ]]; then
            continue
        fi

        # Check if hostname is a wildcard
        if [[ $LINE == *"*"* ]]; then

            # Remove the asterix and the dot from the start of the hostname
            LINE=${LINE/#\*./}

            # Add a wildcard config line
            echo "local-zone: \"${LINE}.\" refuse" >> ${UPSTREAM_CONFIG_FILE}
        fi
    done < /var/git/cache-domains/${UPSTREAM}.blacklist
done
