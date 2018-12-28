#!/bin/bash
## The Original Code can be found @ https://github.com/zeropingheroes/lancache-dns/blob/master/install.sh#L44
## Used as a base so credits to them for this; I just modified the script a bith here and there as you can see below
## So all credits go to them for the work!

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
if [ ! -d "${unbound_loc}" ]; then
	mkdir -p ${unbound_loc}
fi

# Delete Any Currently stored DNS Txt files
if [  -d "/var/git/*" ]; then
	rm -rf /var/git/*
fi


# Get domains from `uklans/cache-domains` GitHub repo
/usr/bin/git clone https://github.com/uklans/cache-domains.git /var/git/cache-domains/
# Download the extra upstreams from our own github
/usr/bin/git clone -b rewrite https://github.com/bntjah/lc-installer /var/git/bntjah-installer/

# Move the extra DNS from our Github into Cache-Domains folder
if [ -d "/var/git/bntjah-installer/dns/" ]; then
	mv /var/git/bntjah-installer/dns/* /var/git/cache-domains/
fi

# Set the upstreams we want to create unbound config files from
declare -a UPSTREAMS=(arenanet apple blizzard hirez gog glyph windowsupdates origin riot steam sony tera wargaming.net uplay zenimax digitalextremes pearlabyss xboxlive rockstar)

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
        fi

        # Add a wildcard config line
        echo "local-zone: \"${LINE}.\" redirect" >> ${UPSTREAM_CONFIG_FILE}
        
        # Add a standard A record config line
        echo "local-data: \"${LINE}. A lc-host-${UPSTREAM}\"" >> ${UPSTREAM_CONFIG_FILE}

    done < /var/git/cache-domains/${UPSTREAM}.txt
done

## The Following is for blacklisting CDN's we noticed
## That need to be blacklisted
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
        fi
        # Add a wildcard config line
        echo "local-zone: \"${LINE}.\" refuse" >> ${UPSTREAM_CONFIG_FILE}
        
    done < /var/git/cache-domains/${UPSTREAM}.blacklist
done
