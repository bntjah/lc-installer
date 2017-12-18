#!/bin/bash
curdir=/home/gvw/lc-installer
source /home/gvw/lc-installer/Files/ethernet.sh

echo "Do you want to use Multi IP or Single IP? [M]ulti/[S]ingle?: "
read TYPE
echo
if [[ $TYPE =~ ^[Mm]$ ]]
 then
        echo
        echo "You Choose for Multi are you sure you want to continue? (Yy/Nn): "
        read REPLY
                if [[ $REPLY =~ ^[Nn]$ ]]
                then
                        echo
                        echo "Quiting the install..."
                        exit
                else
                        source Files/Multi.sh
                fi
fi

if [[ $TYPE =~ ^[Ss]$ ]]
 then
        echo
        echo "You Choose for Single are you sure you want to continue? (Yy/Nn): "
        read REPLY
                if [[ $REPLY =~ ^[Nn]$ ]]
                then
                        echo
                        echo "Quiting the install..."
                        exit
                else
                        source Files/Single.sh
                fi
fi

# Set Variables for IPS
lc_ip_steam=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_steam
lc_ip_riot=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_riot
lc_ip_blizzard=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_blizzard
lc_ip_hirez=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_hirez
lc_ip_origin=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_origin
lc_ip_sony=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_sony
lc_ip_microsoft=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_microsoft
lc_ip_tera=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_tera
lc_ip_gog=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_gog
lc_ip_arena=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_arena
lc_ip_wargaming=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_wargaming
lc_ip_uplay=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_uplay
lc_ip_apple=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_apple
lc_ip_glyph=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_glyph

# Display in Console Configured IP's
echo "##################################"
echo "Showing Currently Configured IPs:"
echo
echo "Steam: $lc_ip_steam"
echo "Riot: $lc_ip_riot"
echo "Blizzard: $lc_ip_blizzard"
echo "Hirez: $lc_ip_hirez"
echo "Origin: $lc_ip_origin"
echo "Sony: $lc_ip_sony"
echo "Microsoft: $lc_ip_microsoft"
echo "Tera: $lc_ip_tera"
echo "GOG: $lc_ip_gog"
echo "Arena: $lc_ip_arena"
echo "Wargaming: $lc_ip_wargaming"
echo "Ubisoft: $lc_ip_uplay"
echo "Apple: $lc_ip_apple"
echo "Glyph: $lc_ip_glyph"
echo
echo "Interface: $lc_eth_int"
echo "Gateway: $lc_ip_gw"
echo "Subnet: $lc_eth_netmask"
echo "##################################"
echo
echo

if [ ! -d "/srv/lancache" ]; then
        echo "Creating The Lancache Folders"
        echo
        if [ ! -d "/srv/lancache/data" ]; then
                echo "Creating Data"
                mkdir -p /srv/lancache/data/
                # Fancy Exit Code Check
        fi
        if [ ! -d "/srv/lancache/logs/Errors" ]; then
                echo "Creating Logs folder for Errors"
                mkdir -p /srv/lancache/logs/Errors
                # Fancy Exit Code Check
        fi
        if [ ! -d "/srv/lancache/logs/Keys" ]; then
                echo "Creating Logs folder for Keys"
                mkdir -p /srv/lancache/logs/Keys
                # Fancy Exit Code Check
        fi
        if [ ! -d "/srv/lancache/logs/Access" ]; then
                echo "Creating Logs folder for Access"
                mkdir -p /srv/lancache/logs/Access
                # Fancy Exit Code Check
        fi
        else
        echo "It seems as if the Lancache folders already exist... Sweet less work for me"
fi

if [ -d "/usr/local/nginx" ]; then
        cp -R $curdir/lancache/conf /usr/local/nginx/
else
        echo "Please make sure your NGINX is picking its configs up from /usr/local/nginx/"
        echo "For this to work; otherwise I can't write the correct configs for it to work..."
fi
