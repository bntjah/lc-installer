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
                        source Multi.sh
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
                        source Single.sh
                fi
fi
