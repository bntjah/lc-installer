#!/bin/bash
# Root Check
source Files/Root_Check.sh

## Set variables
lc_dl_dir=$( pwd )
lc_nginx_version=1.12.1
lc_nginx_url=http://nginx.org/download/nginx-$lc_nginx_version.tar.gz
lc_base_folder=/usr/local/lancache
lc_nginx_loc=/usr/local/nginx
lc_sniproxy_bin=/usr/local/sbin/sniproxy
lc_srv_loc=/srv/lancache
lc_unbound_loc=/etc/unbound
lc_date=$( date +"%m-%d-%y %T" )
lc_hn=$( hostname )

## Functions for Fancy Colors
source Files/functions.sh

## Find Primary ETH
source Files/Find_Internet_IP.sh
clear

## IPV6
echo "###"
echo "IPV6"
echo "###"
echo
echo "Disable IPV6? (Yy/Nn): "
read REPLY
        if [[ $REPLY =~ ^[Yy]$ ]]
                then
        source Files/IPV6.sh
        fi
echo
echo "###"
echo "Adding DNS Resolvers for this host"
echo "###"
echo
echo "Please Enter The First DNS (IPv4) You Want To Use:"
read lc_ip_dns1
source Files/DNSRes.sh $lc_ip_dns1
echo "Please Enter The Secondary DNS (IPv4) You Want To Use:"
read lc_ip_dns2
source Files/DNSRes.sh $lc_ip_dns2
