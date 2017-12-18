#!/bin/bash
## Finding the ethernet connected to internet
lc_ip=$( ip route get 8.8.8.8 | awk 'NR==1 {print $NF}')
lc_eth_int=$( ip route get 8.8.8.8 | awk '{print $5}' )
lc_ip_gw=$( ip route get 8.8.8.8 | awk '{print $3}' )


## Dividing the found IP in multiple variables
lc_ip_p1=$(echo ${lc_ip} | tr "." " " | awk '{ print $1 }')
lc_ip_p2=$(echo ${lc_ip} | tr "." " " | awk '{ print $2 }')
lc_ip_p3=$(echo ${lc_ip} | tr "." " " | awk '{ print $3 }')
lc_ip_p4=$(echo ${lc_ip} | tr "." " " | awk '{ print $4 }')

lc_eth_mask=$(ip -o -f inet addr show | awk '/scope global/ {print $4}' | grep $lc_ip | awk -F'/' '{print $2}')

# Subnets
if [ "$lc_eth_mask"=="8" ]; then
lc_eth_netmask=255.0.0.0
fi
if [ "$lc_eth_mask"=="9" ]; then
lc_eth_netmask=255.128.0.0
fi
if [ "$lc_eth_mask"=="10" ]; then
lc_eth_netmask=255.192.0.0
fi
if [ "$lc_eth_mask"=="11" ]; then
lc_eth_netmask=255.224.0.0
fi
if [ "$lc_eth_mask"=="12" ]; then
lc_eth_netmask=255.240.0.0
fi
if [ "$lc_eth_mask"=="13" ]; then
lc_eth_netmask=255.248.0.0
fi
if [ "$lc_eth_mask"=="14" ]; then
lc_eth_netmask=255.252.0.0
fi
if [ "$lc_eth_mask"=="15" ]; then
lc_eth_netmask=255.254.0.0
fi
if [ "$lc_eth_mask"=="16" ]; then
lc_eth_netmask=255.255.0.0
fi
if [ "$lc_eth_mask"=="17" ]; then
lc_eth_netmask=255.255.128.0
fi
if [ "$lc_eth_mask"=="18" ]; then
lc_eth_netmask=255.255.192.0
fi
if [ "$lc_eth_mask"=="19" ]; then
lc_eth_netmask=255.255.224.0
fi
if [ "$lc_eth_mask"=="20" ]; then
lc_eth_netmask=255.255.240.0
fi
if [ "$lc_eth_mask"=="21" ]; then
lc_eth_netmask=255.255.248.0
fi
if [ "$lc_eth_mask"=="22" ]; then
lc_eth_netmask=255.255.252.0
fi
if [ "$lc_eth_mask"=="23" ]; then
lc_eth_netmask=255.255.254.0
fi
if [ "$lc_eth_mask"=="24" ]; then
lc_eth_netmask=255.255.255.0
fi
if [ "$lc_eth_mask"=="25" ]; then
lc_eth_netmask=255.255.255.128
fi
if [ "$lc_eth_mask"=="26" ]; then
lc_eth_netmask=255.255.255.192
fi
if [ "$lc_eth_mask"=="27" ]; then
lc_eth_netmask=255.255.255.224
fi
if [ "$lc_eth_mask"=="28" ]; then
lc_eth_netmask=255.255.255.240
fi
if [ "$lc_eth_mask"=="29" ]; then
lc_eth_netmask=255.255.255.248
fi
if [ "$lc_eth_mask"=="30" ]; then
lc_eth_netmask=255.255.255.252
fi
if [ "$lc_eth_mask"=="31" ]; then
lc_eth_netmask=255.255.255.252
fi
