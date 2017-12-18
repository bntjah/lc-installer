#!/bin/bash
# Root Check
source Files/Root_Check.sh

# Pre Requisites
source Files/Prereq.sh

## Set variables
source Files/Variables.sh
source Files/ExitCode.sh

## Find Primary ETH
source Files/ethernet.sh
clear

## IPV6
echo "###"
echo "IPV6"
echo "###"
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
echo "Add Different DNS to this host? (Yy/Nn): "
read REPLY
        if [[ $REPLY =~ ^[Yy]$ ]]
                then
                        source Files/DNS.sh
        fi
echo
echo "###"
echo "System Limits"
echo "###"
echo "Change the limits.conf on this host? (Yy/Nn): "
read REPLY
        if [[ $REPLY =~ ^[Yy]$ ]]
                then
                        source Files/Limits.sh
        fi
echo
echo "###"
echo "User"
echo "###"
echo "Create Seperate Lancache User? (Yy/Nn): "
read REPLY
        if [[ $REPLY =~ ^[Yy]$ ]]
                then
                        source Files/Userprofile.sh
        fi

echo
echo "###"
echo "NGINX"
echo "###"
echo "Install NGINX Through This Script? (Yy/Nn): "
read REPLY
        if [[ $REPLY =~ ^[Yy]$ ]]
                then
                        source Files/Nginx.sh
        fi

### Git Clone Lancache
### Correct to the right folders so rest works


echo
echo "###"
echo "Unbound"
echo "###"
echo "Install Unbound Through This Script and Configure? (Yy/Nn):"
read REPLY
        if [[ $REPLY =~ ^[Yy]$ ]]
                then
                        source Files/Unbound.sh
        fi

echo
echo "###"
echo "Sniproxy"
echo "###"
echo "Install SniProxy Through This Script and Configure? (Yy/Nn):"
read REPLY
        if [[ $REPLY =~ ^[Yy]$ ]]
                then
                        source Files/Sniproxy.sh
        fi

echo
echo "###"
echo "Init.D Script"
echo "###"
echo "Install The Premade Init.D Script? (Yy/Nn):"
read REPLY
        if [[ $REPLY =~ ^[Yy]$ ]]
                then
                        source Files/InitD.sh
        fi

echo
echo "###"
echo "Monitoring"
echo "###"
echo "Install Monitoring Tools (Nload/IFtop)? (Yy/Nn):"
read REPLY
        if [[ $REPLY =~ ^[Yy]$ ]]
                then
                        source Files/monitoring.sh
        fi
