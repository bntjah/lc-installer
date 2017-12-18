#!/bin/bash
curdir=/home/gvw/lc-installer
if [ ! -d "$curdir/files/" ]; then
        echo "Downloading the Config Files from bntjah's GITHUB"
        git clone https://github.com/bntjah/lancache $curdir/files/>/dev/null
        # exit code check fancy
fi

echo
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
