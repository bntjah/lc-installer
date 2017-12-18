#!/bin/bash
## Check if Unbound is installed and if its not installing it
if [ ! -d "$/etc/unbound" ]; then
        echo Installing Unbound as its not yet installed
        sudo apt-get install -y unbound>/dev/null
                if [ "$?"=="0" ]; then
                        echo_success
                else
                        echo_failure
        fi
fi

## Preparing configuration for unbound
echo "Making Changes to Unbound with the IPs"
sed -i 's|lc-host-ip|'$lc_ip'|g' $curdir/files/unbound/unbound.conf
sed -i 's|lc-host-proxybind|'$lc_ip'|g' $curdir/files/unbound/unbound.conf
sed -i 's|lc-host-arena|'$lc_ip_arena'|g' $curdir/files/unbound/unbound.conf
sed -i 's|lc-host-apple|'$lc_ip_apple'|g' $curdir/files/unbound/unbound.conf
sed -i 's|lc-host-blizzard|'$lc_ip_blizzard'|g' $curdir/files/unbound/unbound.conf
sed -i 's|lc-host-hirez|'$lc_ip_hirez'|g' $curdir/files/unbound/unbound.conf
sed -i 's|lc-host-gog|'$lc_ip_gog'|g' $curdir/files/unbound/unbound.conf
sed -i 's|lc-host-glyph|'$lc_ip_glyph'|g' $curdir/files/unbound/unbound.conf
sed -i 's|lc-host-microsoft|'$lc_ip_microsoft'|g' $curdir/files/unbound/unbound.conf
sed -i 's|lc-host-origin|'$lc_ip_origin'|g' $curdir/files/unbound/unbound.conf
sed -i 's|lc-host-riot|'$lc_ip_riot'|g' $curdir/files/unbound/unbound.conf
sed -i 's|lc-host-steam|'$lc_ip_steam'|g' $curdir/files/unbound/unbound.conf
sed -i 's|lc-host-sony|'$lc_ip_sony'|g' $curdir/files/unbound/unbound.conf
sed -i 's|lc-host-tera|'$lc_ip_tera'|g' $curdir/files/unbound/unbound.conf
sed -i 's|lc-host-wargaming|'$lc_ip_wargaming'|g' $curdir/files/unbound/unbound.conf
sed -i 's|lc-host-uplay|'$lc_ip_uplay'|g' $curdir/files/unbound/unbound.conf

## Copy Changes Made to Unbound Folder
echo "Copying Made Changes to the Unbound installation"
cp  $curdir/files/unbound/unbound.conf /etc/unbound/unbound.conf

if [ "$?"=="0" ]; then
        echo_success
else
        echo_failure
fi
